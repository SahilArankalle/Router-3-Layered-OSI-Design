//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

class env_config extends uvm_object;

//------------------------------------------
// Data Members
//------------------------------------------

bit has_wagent = 1;
bit has_ragent = 1;
bit has_virtual_sequencer = 1;
bit has_scoreboard = 1;
int no_of_agents;
wr_agent_config wr_agt_cfg[];
rd_agent_config rd_agt_cfg[];



`uvm_object_utils(env_config)

//------------------------------------------
// Methods
//------------------------------------------
// Standard UVM Methods:
extern function new(string name = "env_config");

endclass: env_config
//-----------------  constructor new method  -------------------//

function env_config::new(string name = "env_config");
  super.new(name);
endfunction


