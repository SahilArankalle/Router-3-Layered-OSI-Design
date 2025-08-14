
//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

class wr_agent_config extends uvm_object;


// UVM Factory Registration Macro
`uvm_object_utils(wr_agent_config)

uvm_active_passive_enum is_active = UVM_ACTIVE;


//------------------------------------------
// Methods
//------------------------------------------
// Standard UVM Methods:
extern function new(string name = "wr_agent_config");

endclass: wr_agent_config
//-----------------  constructor new method  -------------------//

function wr_agent_config::new(string name = "wr_agent_config");
  super.new(name);
endfunction

