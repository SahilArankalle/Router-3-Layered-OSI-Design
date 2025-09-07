class src_config extends uvm_object;
	
	`uvm_object_utils(src_config)
	
	virtual router_if vif;
	static int drv_data_count = 0;
	static int mon_data_count = 0;
	uvm_active_passive_enum is_active = UVM_ACTIVE;
	
	extern function new(string name = "src_config");
endclass: src_config

function src_config::new(string name = "src_config");
	super.new(name);
endfunction: new