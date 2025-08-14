//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

	class rd_agent extends uvm_agent;

   // Factory Registration
	`uvm_component_utils(rd_agent)

   // Declare handle for configuration object
        rd_agent_config rd_agt_cfg;
       
	rd_monitor monh;
	rd_sequencer seqrh;
	rd_driver drvh;

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
  extern function new(string name = "rd_agent", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);

endclass : rd_agent
//-----------------  constructor new method  -------------------//

       function rd_agent::new(string name = "rd_agent", 
                               uvm_component parent = null);
         super.new(name, parent);
       endfunction
     
  
//-----------------  build() phase method  -------------------//
    function void rd_agent::build_phase(uvm_phase phase);
		super.build_phase(phase);
	  if(!uvm_config_db #(rd_agent_config)::get(this,"","rd_agt_config",rd_agt_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")  
                monh=rd_monitor::type_id::create("monh",this);	
		if(rd_agt_cfg.is_active==UVM_ACTIVE)
		begin
		drvh=rd_driver::type_id::create("drvh",this);
		seqrh=rd_sequencer::type_id::create("seqrh",this);
		end
	endfunction

      
   

   


