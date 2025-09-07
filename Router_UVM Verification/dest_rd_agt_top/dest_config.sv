class dest_config extends uvm_object;

	`uvm_object_utils(dest_config)
	
	virtual router_if vif;
	static int drv_data_count = 0;
	static int mon_data_count = 0;
	uvm_active_passive_enum is_active = UVM_ACTIVE;
	static int no_of_cycles = 0;
	
	extern function new(string name = "dest_config");
endclass: dest_config

function dest_config::new(string name = "dest_config");
	super.new(name);
endfunction: new