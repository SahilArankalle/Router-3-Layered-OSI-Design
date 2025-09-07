class src_agent extends uvm_agent;
	
	`uvm_component_utils(src_agent)
	
	src_drv		driver;
	src_mon		monitor;
	src_seqr	sequencer;
	
	src_config	agt_cfg;
	
	extern function new(string name = "src_agent", uvm_component parent = null);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
endclass: src_agent

function src_agent::new(string name = "src_agent", uvm_component parent = null);
	super.new(name, parent);
endfunction: new

function void src_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
	if(!uvm_config_db #(src_config)::get(this, "", "src_config", agt_cfg))
		`uvm_fatal(get_full_name(), "Cannot get src_config, have you set it?")
	
	monitor = src_mon::type_id::create("monitor", this);
	
	if(agt_cfg.is_active == UVM_ACTIVE)
		begin
			driver 		= src_drv::type_id::create("driver", this);
			sequencer 	= src_seqr::type_id::create("sequencer", this);
		end
endfunction: build_phase

function void src_agent::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	if(agt_cfg.is_active == UVM_ACTIVE)
		driver.seq_item_port.connect(sequencer.seq_item_export);
endfunction: connect_phase