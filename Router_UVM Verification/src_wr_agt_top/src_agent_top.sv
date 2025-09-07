class src_agent_top extends uvm_env;

	`uvm_component_utils(src_agent_top)
	
	src_agent wr_agent[];

	env_config	env_cfg;
	
	extern function new(string name = "src_agent_top", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
endclass: src_agent_top

function src_agent_top::new(string name = "src_agent_top", uvm_component parent);
	super.new(name, parent);
endfunction: new

function void src_agent_top::build_phase(uvm_phase phase);
	super.build_phase(phase);

	if(!uvm_config_db #(env_config)::get(this, "", "env_config", env_cfg))
		`uvm_fatal(get_full_name(), "cannot get() env_config from uvm_config_db, have you set() it?")

	wr_agent = new[env_cfg.no_wrgts];

	if(env_cfg.no_wrgts)
		foreach(wr_agent[i])
			begin
				wr_agent[i] = src_agent::type_id::create($sformatf("wr_agent[%0d]", i), this);
				uvm_config_db #(src_config)::set(this, $sformatf("wr_agent[%0d]*", i), "src_config", env_cfg.wr_cfgh[i]);
			end
endfunction: build_phase