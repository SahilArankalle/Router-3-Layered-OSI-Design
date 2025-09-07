class dest_seqr extends uvm_sequencer#(dest_xtn);

	`uvm_component_utils(dest_seqr)

	extern function new(string name = "dest_seqr",uvm_component parent);
	extern function void build_phase (uvm_phase phase);
endclass

function dest_seqr::new(string name="dest_seqr",uvm_component parent);
	super.new(name,parent);
endfunction

function void dest_seqr::build_phase (uvm_phase phase);
	super.build_phase(phase);
endfunction