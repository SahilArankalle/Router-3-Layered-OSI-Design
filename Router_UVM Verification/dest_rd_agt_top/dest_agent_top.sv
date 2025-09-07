class dest_agent_top extends uvm_env;

	`uvm_component_utils(dest_agent_top)

	dest_agent rd_agent[];

	env_config	env_cfg;

	extern function new(string name = "dest_agent_top" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
endclass: dest_agent_top

function dest_agent_top::new(string name = "dest_agent_top" , uvm_component parent);
	super.new(name,parent);
endfunction: new

function void dest_agent_top::build_phase(uvm_phase phase);
	super.build_phase(phase);

	if(!uvm_config_db #(env_config)::get(this, "", "env_config", env_cfg))
		`uvm_fatal(get_full_name(), "cannot get() env_config from uvm_config_db, have you set() it?")

	rd_agent = new[env_cfg.no_ragts];

	if(env_cfg.no_ragts)
		foreach(rd_agent[i])
			begin
				rd_agent[i] = dest_agent::type_id::create($sformatf("rd_agent[%0d]", i), this);
				uvm_config_db #(dest_config)::set(this, $sformatf("rd_agent[%0d]*", i), "dest_config", env_cfg.rd_cfgh[i]);
			end
endfunction: build_phase