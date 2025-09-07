class dest_seq extends uvm_sequence#(dest_xtn);

	`uvm_object_utils(dest_seq)
	
	extern function new(string name = "dest_seq");
endclass: dest_seq

function dest_seq::new(string name = "dest_seq");
	super.new(name);
endfunction: new



/*minimun cycles*/
class dest_rd_enb_seqs extends dest_seq;
	`uvm_object_utils(dest_rd_enb_seqs)
	
	extern function new(string name = "dest_rd_enb_seqs");
	extern task body();
endclass: dest_rd_enb_seqs

function dest_rd_enb_seqs::new(string name = "dest_rd_enb_seqs");
	super.new(name);
endfunction: new

task dest_rd_enb_seqs::body();
	req = dest_xtn::type_id::create("req");
	
	start_item(req);
	assert(req.randomize() with {no_of_cycles inside {[0:29]};});
	finish_item(req);
endtask: body



/*maximum cycles for soft-reset*/
class dest_sft_rst_seqs extends dest_seq;
	`uvm_object_utils(dest_sft_rst_seqs)
	
	extern function new(string name = "dest_sft_rst_seqs");
	extern task body();
endclass: dest_sft_rst_seqs

function dest_sft_rst_seqs::new(string name = "dest_sft_rst_seqs");
	super.new(name);
endfunction: new

task dest_sft_rst_seqs::body();
	req = dest_xtn::type_id::create("req");
	
	start_item(req);
	assert(req.randomize() with {no_of_cycles > 30;});
	finish_item(req);
endtask: body