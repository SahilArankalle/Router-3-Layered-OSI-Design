class dest_mon extends uvm_monitor;

	`uvm_component_utils(dest_mon)
	
	virtual router_if.RD_MON_MP vif;

	dest_config	mon_config;

	uvm_analysis_port#(dest_xtn) mon_port;
	
	extern function new(string name = "dest_mon", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task collect_data();
	extern task run_phase(uvm_phase phase);
	extern function void report_phase(uvm_phase phase);
endclass: dest_mon

function dest_mon::new(string name = "dest_mon", uvm_component parent);
	super.new(name,parent);
	mon_port = new("mon_port", this);
endfunction: new

function void dest_mon::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(dest_config)::get(this, "", "dest_config", mon_config))
		`uvm_fatal(get_full_name(), "Cannot get dest_config, have you set it?")
endfunction: build_phase

function void dest_mon::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	this.vif = mon_config.vif;
endfunction: connect_phase

task dest_mon::collect_data();

	dest_xtn	mon_data;
	mon_data = dest_xtn::type_id::create("mon_data");

	wait(vif.rd_mon_cb.read_enb);
    $display("////////////////////Read enable is high/////////////////////////");

	@(vif.rd_mon_cb);

	mon_data.header = vif.rd_mon_cb.data_out;
	
	mon_data.payload_data = new[mon_data.header[7:2]];
	@(vif.rd_mon_cb);

	for(int i = 0; i < mon_data.header[7:2]; i++)
		begin
			mon_data.payload_data[i] = vif.rd_mon_cb.data_out;
			@(vif.rd_mon_cb);
		end

	mon_data.parity = vif.rd_mon_cb.data_out;

	repeat(2)
		@(vif.rd_mon_cb);	
  //for synchronization with source side as error is sampled after 2 clock cycles and only then is it beeen writen into the tlm fifo

	mon_data.print();
	mon_port.write(mon_data);
	mon_config.mon_data_count++;
	
endtask: collect_data

task dest_mon::run_phase(uvm_phase phase);
	forever
		collect_data();
endtask: run_phase

function void dest_mon::report_phase(uvm_phase phase);
	`uvm_info(get_full_name(), $sformatf("Report: Report collected from Destination Monitor: %0d Transactions", mon_config.mon_data_count), UVM_LOW)
endfunction: report_phase
