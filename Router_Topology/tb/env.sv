//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------
	class env extends uvm_env;

        
        // Factory Registration
     	`uvm_component_utils(env)

	
		wr_agt_top wagt_top[];
		rd_agt_top ragt_top[];
	
		//scoreboard sb;

        env_config env_cfg;
//------------------------------------------
// Methods
//------------------------------------------

// Standard UVM Methods:
extern function new(string name = "env", uvm_component parent);
extern function void build_phase(uvm_phase phase);
endclass: env
	
//-----------------  constructor new method  -------------------//
// Define Constructor new() function
	function env::new(string name = "env", uvm_component parent);
		super.new(name,parent);
	endfunction

//-----------------  build phase method  -------------------//

        	function void env::build_phase(uvm_phase phase);
	  if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg))
		`uvm_fatal("CONFIG","cannot get() env_cfg from uvm_config_db. Have you set() it?")

		if(env_cfg.has_wagent)
		begin
		wagt_top = new[env_cfg.no_of_agents];
		foreach(wagt_top[i])
			begin
			uvm_config_db #(wr_agent_config)::set(this,$sformatf("wagt_top[%0d]*", i), "wr_agt_config", env_cfg.wr_agt_cfg[i]);
			wagt_top[i] = wr_agt_top::type_id::create($sformatf("wagt_top[%0d]", i), this);
			end
			end

		if(env_cfg.has_ragent)
		begin
		ragt_top = new[env_cfg.no_of_agents];
		foreach(ragt_top[i])
			begin
			uvm_config_db #(rd_agent_config)::set(this,$sformatf("ragt_top[%0d]*", i), "rd_agt_config", env_cfg.rd_agt_cfg[i]);
			ragt_top[i] = rd_agt_top::type_id::create($sformatf("ragt_top[%0d]", i), this);
			end
			end

	super.build_phase(phase);

	endfunction		

