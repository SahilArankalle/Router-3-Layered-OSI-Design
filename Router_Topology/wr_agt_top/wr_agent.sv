

//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

	class wr_agent extends uvm_agent;

   // Factory Registration
	`uvm_component_utils(wr_agent)

   // Declare handle for configuration object
        wr_agent_config wr_agt_cfg;
       

	wr_monitor monh;
	wr_sequencer seqrh;
	wr_driver drvh;

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
  extern function new(string name = "wr_agent", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);

endclass : wr_agent
//-----------------  constructor new method  -------------------//

       function wr_agent::new(string name = "wr_agent", 
                               uvm_component parent = null);
         super.new(name, parent);
       endfunction
     
  
//-----------------  build() phase method  -------------------//

	function void wr_agent::build_phase(uvm_phase phase);
		super.build_phase(phase);
	  if(!uvm_config_db #(wr_agent_config)::get(this,"","wr_agt_config",wr_agt_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 
	        monh=wr_monitor::type_id::create("monh",this);	
		if(wr_agt_cfg.is_active==UVM_ACTIVE)
		begin
		drvh=wr_driver::type_id::create("drvh",this);
		seqrh=wr_sequencer::type_id::create("seqrh",this);
		end
	endfunction

      
   

   


