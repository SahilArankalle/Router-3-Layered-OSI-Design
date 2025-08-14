//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------
	class rd_sequencer extends uvm_sequencer;

	`uvm_component_utils(rd_sequencer)

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
	extern function new(string name = "rd_sequencer",uvm_component parent);
	extern function void build_phase (uvm_phase phase);
	endclass
	
//-----------------  constructor new method  -------------------//
	function rd_sequencer::new(string name="rd_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction

//-----------------  Build Phase  -------------------//

function void rd_sequencer::build_phase (uvm_phase phase);
	super.build_phase(phase);
endfunction



  









