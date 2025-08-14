//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

	class rd_driver extends uvm_driver;

   // Factory Registration

	`uvm_component_utils(rd_driver)

        rd_agent_config m_cfg;



//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
     	
	extern function new(string name ="rd_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
endclass

//-----------------  constructor new method  -------------------//
 
	 function rd_driver::new (string name ="rd_driver", uvm_component parent);
   	   super.new(name, parent);
 	 endfunction : new

//-----------------  build() phase method  -------------------//
 	function void rd_driver::build_phase(uvm_phase phase);
          super.build_phase(phase);
	  if(!uvm_config_db #(rd_agent_config)::get(this,"","rd_agt_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 
        endfunction

