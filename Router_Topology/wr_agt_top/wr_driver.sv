//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

	class wr_driver extends uvm_driver;

   // Factory Registration

	`uvm_component_utils(wr_driver)


        wr_agent_config m_cfg;

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
     	
	extern function new(string name ="wr_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);

endclass

//-----------------  constructor new method  -------------------//
 // Define Constructor new() function
	function wr_driver::new(string name ="wr_driver",uvm_component parent);
		super.new(name,parent);
	endfunction

//-----------------  build() phase method  -------------------//
 	function void wr_driver::build_phase(uvm_phase phase);
          super.build_phase(phase);
	  if(!uvm_config_db #(wr_agent_config)::get(this,"","wr_agt_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 
        endfunction

