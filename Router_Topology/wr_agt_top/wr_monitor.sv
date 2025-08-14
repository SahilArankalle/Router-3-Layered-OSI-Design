//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

class wr_monitor extends uvm_monitor;

  // Factory Registration
	`uvm_component_utils(wr_monitor)

        wr_agent_config m_cfg;

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
extern function new(string name = "wr_monitor", uvm_component parent);
extern function void build_phase(uvm_phase phase);

endclass 
//-----------------  constructor new method  -------------------//
	function wr_monitor::new(string name = "wr_monitor", uvm_component parent);
		super.new(name,parent);

  	endfunction

//-----------------  build() phase method  -------------------//
 	function void wr_monitor::build_phase(uvm_phase phase);
          super.build_phase(phase);
	  if(!uvm_config_db #(wr_agent_config)::get(this,"","wr_agt_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 
        endfunction

