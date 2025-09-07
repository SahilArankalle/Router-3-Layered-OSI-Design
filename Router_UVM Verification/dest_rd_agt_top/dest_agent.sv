class dest_agent extends uvm_agent;

	`uvm_component_utils(dest_agent)

	dest_drv	driver;
	dest_mon	monitor;
	dest_seqr	sequencer;
	
	dest_config agt_cfg;

	extern function new(string name = "dest_agent",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
endclass

function dest_agent::new(string name = "dest_agent", uvm_component parent);
	super.new(name, parent);
endfunction: new
 
function void dest_agent::build_phase (uvm_phase phase);
	super.build_phase(phase);
	
	if(!uvm_config_db#(dest_config)::get(this, "", "dest_config", agt_cfg))
		`uvm_fatal(get_full_name(), "Cannot get src_config, have you set it?")
	
	monitor = dest_mon::type_id::create("monitor", this);
	
	if(agt_cfg.is_active == UVM_ACTIVE)
		begin
			driver = dest_drv::type_id::create("driver", this);
			sequencer = dest_seqr::type_id::create("sequencer", this);
		end
endfunction: build_phase

function void dest_agent::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	if(agt_cfg.is_active == UVM_ACTIVE)
		driver.seq_item_port.connect(sequencer.seq_item_export);
endfunction: connect_phase