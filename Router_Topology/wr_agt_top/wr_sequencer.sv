//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

	class wr_sequencer extends uvm_sequencer;

	`uvm_component_utils(wr_sequencer)

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
	extern function new(string name = "wr_sequencer",uvm_component parent);
	endclass
//-----------------  constructor new method  -------------------//
	function wr_sequencer::new(string name="wr_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction



