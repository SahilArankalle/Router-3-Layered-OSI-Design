//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

class rd_agent_config extends uvm_object;


// UVM Factory Registration Macro
`uvm_object_utils(rd_agent_config)


//------------------------------------------
// Data Members
//------------------------------------------
// Declare parameter is_active of type uvm_active_passive_enum and assign it to UVM_ACTIVE
uvm_active_passive_enum is_active = UVM_ACTIVE;



//------------------------------------------
// Methods
//------------------------------------------

// Standard UVM Methods:
extern function new(string name = "rd_agent_config");

endclass: rd_agent_config

function rd_agent_config::new(string name = "rd_agent_config");
  super.new(name);
endfunction


