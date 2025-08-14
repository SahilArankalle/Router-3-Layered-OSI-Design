//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------
	class wr_agt_top extends uvm_env;

   // Factory Registration
	`uvm_component_utils(wr_agt_top)
    
   // Create the agent handle
      	wr_agent agnth;
//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
	extern function new(string name = "wr_agt_top" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
  endclass
//-----------------  constructor new method  -------------------//
   // Define Constructor new() function
   	function wr_agt_top::new(string name = "wr_agt_top" , uvm_component parent);
		super.new(name,parent);
	endfunction

    
//-----------------  build() phase method  -------------------//
       	function void wr_agt_top::build_phase(uvm_phase phase);
     		super.build_phase(phase);
   		agnth=wr_agent::type_id::create("agnth",this);
	endfunction

 


