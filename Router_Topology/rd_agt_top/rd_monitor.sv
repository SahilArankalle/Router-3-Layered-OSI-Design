//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------
	class rd_monitor extends uvm_monitor;

  // Factory Registration
	`uvm_component_utils(rd_monitor)

  // Declare the rd_agent_config handle as "m_cfg"
        rd_agent_config m_cfg;


//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
extern function new(string name = "rd_monitor", uvm_component parent);
extern function void build_phase(uvm_phase phase);

endclass 

//-----------------  constructor new method  -------------------//
 
 function rd_monitor::new (string name = "rd_monitor", uvm_component parent);
    super.new(name, parent);
  endfunction : new

//-----------------  build() phase method  -------------------//
 
	function void rd_monitor::build_phase(uvm_phase phase);
          super.build_phase(phase);
	  if(!uvm_config_db #(rd_agent_config)::get(this,"","rd_agt_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
        endfunction

