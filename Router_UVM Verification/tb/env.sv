class env extends uvm_env;

    `uvm_component_utils(env)

	src_agent_top	wagt_top;
	dest_agent_top	ragt_top;
	scoreboard 		sb;
	virtual_seqr	v_seqr;

	env_config	env_cfg;

	extern function new(string name = "env", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);

endclass: env
	
function env::new(string name = "env", uvm_component parent);
	super.new(name,parent);
endfunction: new

function void env::build_phase(uvm_phase phase);

	super.build_phase(phase);

	if(!uvm_config_db#(env_config)::get(this, "", "env_config", env_cfg))
		`uvm_fatal(get_full_name(), "Cannot get env_config, have you set it?")

	if(env_cfg.has_wagent == 1)
		wagt_top = src_agent_top::type_id::create("wagt_top", this);
	
	if(env_cfg.has_ragent == 1)
		ragt_top = dest_agent_top::type_id::create("ragt_top", this);
	
	if(env_cfg.has_virtual_sequencer == 1)
		v_seqr = virtual_seqr::type_id::create("v_seqr", this);

	if(env_cfg.has_scoreboard == 1)
		sb = scoreboard::type_id::create("sb", this);

endfunction: build_phase

function void env::connect_phase(uvm_phase phase);
	super.connect_phase(phase);

	if(env_cfg.has_virtual_sequencer == 1)
		begin
			if(env_cfg.has_wagent == 1)
				begin
					for(int i = 0; i < env_cfg.no_wrgts; i++)
						v_seqr.write_seqr[i] = wagt_top.wr_agent[i].sequencer;
				end
			if(env_cfg.has_ragent == 1)
				begin
					for(int i = 0; i < env_cfg.no_ragts; i++)
						v_seqr.read_seqr[i] = ragt_top.rd_agent[i].sequencer;
				end
		end

	if(env_cfg.has_scoreboard == 1)
		begin
			if(env_cfg.has_wagent == 1)
				begin
					foreach(env_cfg.wr_cfgh[i])
						wagt_top.wr_agent[i].monitor.mon_port.connect(sb.fifo_src[i].analysis_export);
				end

			if(env_cfg.has_ragent == 1)
				begin
					foreach(env_cfg.rd_cfgh[i])
						ragt_top.rd_agent[i].monitor.mon_port.connect(sb.fifo_dest[i].analysis_export);
				end
		end 

endfunction: connect_phase
