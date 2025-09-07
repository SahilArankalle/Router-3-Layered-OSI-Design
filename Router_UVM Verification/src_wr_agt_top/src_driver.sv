class src_drv extends uvm_driver#(src_xtn);
	`uvm_component_utils(src_drv)
	
	virtual router_if.WR_DRV_MP vif;
	src_config drv_config;
	
	extern function new(string name = "src_drv", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task send_to_dut(src_xtn xtn);
	extern task run_phase(uvm_phase phase);
	extern function void report_phase(uvm_phase phase);
endclass: src_drv

function src_drv::new(string name = "src_drv", uvm_component parent);
	super.new(name, parent);
endfunction: new

function void src_drv::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(src_config)::get(this, "", "src_config", drv_config))
		`uvm_fatal(get_full_name(), "Cannot get src_config, have you set it?")
endfunction: build_phase

function void src_drv::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	this.vif = drv_config.vif;
endfunction: connect_phase


task src_drv::send_to_dut(src_xtn xtn);


	wait(!vif.wr_drv_cb.busy)
	vif.wr_drv_cb.pkt_vld <= 1'b1;

	vif.wr_drv_cb.data_in <= xtn.header;
        
         	@(vif.wr_drv_cb);

	for(int i = 0; i < xtn.header[7:2]; i++)
		begin
			wait(!vif.wr_drv_cb.busy)
			vif.wr_drv_cb.data_in <= xtn.payload_data[i];
			@(vif.wr_drv_cb);
		end

	vif.wr_drv_cb.pkt_vld <= 1'b0;
	vif.wr_drv_cb.data_in <= xtn.parity;

	repeat(2)
	@(vif.wr_drv_cb);
	xtn.error = vif.wr_drv_cb.error;

	`uvm_info("SRC_DRIVER", $sformatf("From Source Driver\n %s", xtn.sprint()), UVM_LOW)
	
	drv_config.drv_data_count++;
	
endtask: send_to_dut

task src_drv::run_phase(uvm_phase phase);
	@(vif.wr_drv_cb)
	vif.wr_drv_cb.rstn	<= 0;
	@(vif.wr_drv_cb)
	vif.wr_drv_cb.rstn	<= 1;
	forever
		begin
			seq_item_port.get_next_item(req);
			send_to_dut(req);
			seq_item_port.item_done();
		end
endtask: run_phase

function void src_drv::report_phase(uvm_phase phase);
	`uvm_info(get_full_name(), $sformatf("Report: Report collected from Source Driver: %0d Transactions", drv_config.drv_data_count), UVM_LOW)
endfunction: report_phase
