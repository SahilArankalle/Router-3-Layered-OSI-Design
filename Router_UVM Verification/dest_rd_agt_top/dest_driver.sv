class dest_drv extends uvm_driver#(dest_xtn);

	`uvm_component_utils(dest_drv)

	virtual router_if.RD_DRV_MP vif;
	
	dest_config drv_config;
	
	extern function new(string name ="dest_drv",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task send_to_dut(dest_xtn xtn);
	extern task run_phase(uvm_phase phase);
	extern function void report_phase(uvm_phase phase);
endclass

function dest_drv::new(string name ="dest_drv",uvm_component parent);
	super.new(name,parent);
endfunction

 function void dest_drv::build_phase(uvm_phase phase);
    super.build_phase(phase);
	if(!uvm_config_db #(dest_config)::get(this, "", "dest_config", drv_config))
		`uvm_fatal(get_full_name(), "Cannot get dest_config, have you set it?");
endfunction

function void dest_drv::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	this.vif = drv_config.vif;
endfunction: connect_phase

task dest_drv::send_to_dut(dest_xtn xtn); 
	wait(vif.rd_drv_cb.vld_out)
	@(vif.rd_drv_cb);
	
	repeat(xtn.no_of_cycles)
	@(vif.rd_drv_cb);
	vif.rd_drv_cb.read_enb <= 1'b1;

	wait(!vif.rd_drv_cb.vld_out)
	@(vif.rd_drv_cb);
	vif.rd_drv_cb.read_enb <= 1'b0;

    drv_config.drv_data_count++;

	`uvm_info("DEST_DRV", $sformatf("From Destination Driver\n %s", xtn.sprint()), UVM_LOW)
endtask: send_to_dut

task dest_drv::run_phase(uvm_phase phase);
	forever
		begin
			seq_item_port.get_next_item(req);
			send_to_dut(req);
			seq_item_port.item_done;
		end
endtask: run_phase

function void dest_drv::report_phase(uvm_phase phase);
	`uvm_info(get_full_name(), $sformatf("Report: Report collected from Destination Driver: %0d Transactions", drv_config.drv_data_count), UVM_LOW)
endfunction: report_phase