class src_mon extends uvm_monitor;
	`uvm_component_utils(src_mon)
	
	virtual router_if.WR_MON_MP	vif;
	src_config	mon_config;
	uvm_analysis_port#(src_xtn)	mon_port;
	
	extern function new(string name = "src_mon", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task collect_data();
	extern function void report_phase(uvm_phase phase);
endclass: src_mon

function src_mon::new(string name = "src_mon", uvm_component parent);
	super.new(name, parent);
	mon_port = new("mon_port", this);
endfunction: new

function void src_mon::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(src_config)::get(this, "", "src_config", mon_config))
		`uvm_fatal(get_full_name(), "Cannot get src_config, have you set it?");
endfunction: build_phase

function void src_mon::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	this.vif = mon_config.vif;
endfunction: connect_phase

task src_mon::collect_data();

    src_xtn		mon_data;

	`uvm_info("SRC_MONITOR","From Source Monitor", UVM_LOW)
	
	mon_data = src_xtn::type_id::create("mon_data");

	wait((vif.wr_mon_cb.pkt_vld) && (!vif.wr_mon_cb.busy))

	mon_data.header = vif.wr_mon_cb.data_in;

	mon_data.payload_data = new[mon_data.header[7:2]];
	@(vif.wr_mon_cb);
	for(int i = 0; i < mon_data.header[7:2]; i++)
		begin
			wait(!vif.wr_mon_cb.busy)
			mon_data.payload_data[i] = vif.wr_mon_cb.data_in;
			@(vif.wr_mon_cb);
		end

	wait(!vif.wr_mon_cb.pkt_vld)
	mon_data.parity = vif.wr_mon_cb.data_in;
	
	repeat(2) 
		@(vif.wr_mon_cb);
	mon_data.error = vif.wr_mon_cb.error;
	
	mon_data.print();
	mon_port.write(mon_data);
	mon_config.mon_data_count++;

endtask:collect_data

task src_mon::run_phase(uvm_phase phase);
	forever
		collect_data();
endtask: run_phase

function void src_mon::report_phase(uvm_phase phase);
	`uvm_info(get_full_name(), $sformatf("Report: Report collected from Source Monitor: %0d Transactions", mon_config.mon_data_count), UVM_LOW)
endfunction: report_phase
	
