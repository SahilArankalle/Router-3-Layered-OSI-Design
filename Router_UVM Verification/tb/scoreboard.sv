class scoreboard extends uvm_scoreboard;

	`uvm_component_utils(scoreboard)
	
	uvm_tlm_analysis_fifo#(src_xtn)		fifo_src[];
	uvm_tlm_analysis_fifo#(dest_xtn)	fifo_dest[];
	
	env_config 	m_cfg;
	
	src_xtn		wr_data;
	dest_xtn	rd_data;
	
	src_xtn		wr_cov_data;
	dest_xtn	rd_cov_data;
	
	covergroup router_cov_src;

		option.per_instance = 1;
		
		ADDRESS: 	coverpoint wr_cov_data.header[1:0]{
						bins low	= {2'b00};
						bins mid1	= {2'b01};
						bins mid2	= {2'b10};}
		
		PAYLOAD_SIZE: coverpoint wr_cov_data.header[7:2]{
						bins small_packet	= {[1:13]};
						bins medium_packet	= {[14:30]};
						bins large_packet	= {[31:63]};}
					
		ERROR_PKT: 	coverpoint wr_cov_data.error {
						bins bad_pkt	= {1};
						bins good_pkt	= {0};}
					
		ADDRESSxPAYLOAD_SIZE: 			cross ADDRESS, PAYLOAD_SIZE;
		ADDRESSxPAYLOAD_SIZExERROR_PKT: cross ADDRESS, PAYLOAD_SIZE, ERROR_PKT;
		
	endgroup: router_cov_src
	
	covergroup router_cov_dest;

		option.per_instance = 1;
		
		ADDRESS		: coverpoint rd_cov_data.header[1:0]{
						bins low	= {2'b00};
						bins mid1	= {2'b01};
						bins mid2	= {2'b10};}
		
		PAYLOAD_SIZE: coverpoint rd_cov_data.header[7:2]{
						bins small_packet	= {[1:13]};
						bins medium_packet	= {[14:30]};
						bins large_packet	= {[31:63]};}
					
		SOFT_RST	: coverpoint rd_cov_data.no_of_cycles {
						bins rst	= {1};
						bins nt_rst = {0};}
					
		ADDRESSxPAYLOAD_SIZE		 : cross ADDRESS, PAYLOAD_SIZE;
		ADDRESSxPAYLOAD_SIZExSOFT_RST: cross ADDRESS, PAYLOAD_SIZE, SOFT_RST;
		
	endgroup: router_cov_dest
	
	extern function new(string name = "scoreboard", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void check_data(src_xtn	wr,dest_xtn rd);
	extern task run_phase(uvm_phase phase);
	extern function void report_phase(uvm_phase phase);
	
endclass

function scoreboard::new(string name = "scoreboard", uvm_component parent);
	super.new(name, parent);
	
	router_cov_src	= new();
	router_cov_dest	= new();
endfunction: new

function void scoreboard::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
	if(!uvm_config_db#(env_config)::get(this, "", "env_config", m_cfg))
		`uvm_fatal(get_full_name(), "Cannot get dest_config, have you set it?")

	fifo_src = new[m_cfg.no_wrgts];
	foreach(fifo_src[i])
		fifo_src[i] = new($sformatf("fifo_src[%0d]", i), this);
	
	fifo_dest = new[m_cfg.no_ragts];
	foreach(fifo_dest[i])
		fifo_dest[i] = new($sformatf("fifo_dest[%0d]", i), this);

endfunction: build_phase

function void scoreboard::check_data(src_xtn wr,dest_xtn rd);
	if(wr.header == rd.header)
		`uvm_info("HEADER", "HEADER matched successfully", UVM_LOW)
	else
		`uvm_error("HEADER", "HEADER, comparision failed")
	
	if(wr.payload_data == rd.payload_data)
		`uvm_info("PAYLOAD_DATA", "PAYLOAD DATA matched successfully", UVM_LOW)
	else
		`uvm_error("PAYLOAD_DATA", "PAYLOAD DATA, comparision failed")
		
	if(wr.parity == rd.parity)
		`uvm_info("PARITY", "PARITY matched successfully", UVM_LOW)
	else
		`uvm_error("PARITY", "PARITY, comparision failed")
		
	m_cfg.data_verified_count++;
	
endfunction: check_data

task scoreboard::run_phase(uvm_phase phase);
	fork
		begin
			forever begin
				fifo_src[0].get(wr_data);
				`uvm_info("WRITE SCOREBOARD", "Write data", UVM_LOW)
				wr_data.print();
				wr_cov_data = wr_data;
				router_cov_src.sample();
			end
		end
		
		begin
			forever begin
				fork: dest
					begin
						
						fifo_dest[0].get(rd_data);
						`uvm_info("READ SB[0]", "Read data", UVM_LOW)
						rd_data.print();
						check_data(wr_data,rd_data);
						rd_cov_data = rd_data;
						router_cov_dest.sample();
					end
					begin
						
						fifo_dest[1].get(rd_data);
						`uvm_info("READ SB[1]", "Read data", UVM_LOW)
						rd_data.print();
						check_data(wr_data,rd_data);
						rd_cov_data = rd_data;
						router_cov_dest.sample();
					end
					begin
						
						fifo_dest[2].get(rd_data);
						`uvm_info("READ SB[2]", "Read data", UVM_LOW)
						rd_data.print();
						check_data(wr_data,rd_data);
						rd_cov_data = rd_data;
						router_cov_dest.sample();
					end
				join_any
				disable dest;
			end
		end
	join 
endtask: run_phase

function void scoreboard::report_phase(uvm_phase phase);
	`uvm_info(get_full_name(), $sformatf("Report: Number of data verified in Scoreboard is %0d", m_cfg.data_verified_count), UVM_LOW)
endfunction: report_phase

