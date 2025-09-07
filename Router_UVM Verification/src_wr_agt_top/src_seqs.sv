class src_seqs extends uvm_sequence#(src_xtn);
	`uvm_object_utils(src_seqs)
	
	extern function new(string name = "src_seqs");
endclass: src_seqs

function src_seqs::new(string name = "src_seqs");
	super.new(name);
endfunction: new



/*Small sequence*/
class src_small_seqs extends src_seqs;
	`uvm_object_utils(src_small_seqs)
	
	extern function new(string name = "src_small_seqs");
	extern task body();
endclass: src_small_seqs

function src_small_seqs::new(string name = "src_small_seqs");
	super.new(name);
endfunction: new

task src_small_seqs::body();
	req = src_xtn::type_id::create("req");
	
	start_item(req);
	assert(req.randomize() with {header[7:2] inside {[1:15]};});
	finish_item(req);
endtask: body



/*Medium sequence*/
class src_medium_seqs extends src_seqs;
	`uvm_object_utils(src_medium_seqs)
	
	extern function new(string name = "src_medium_seqs");
	extern task body();
endclass: src_medium_seqs

function src_medium_seqs::new(string name = "src_medium_seqs");
	super.new(name);
endfunction: new

task src_medium_seqs::body();
	req = src_xtn::type_id::create("req");
	
	start_item(req);
	assert(req.randomize() with {header[7:2] inside {[16:30]};});
	finish_item(req);
endtask: body



/*Large sequence*/
class src_large_seqs extends src_seqs;
	`uvm_object_utils(src_large_seqs)
	
	extern function new(string name = "src_large_seqs");
	extern task body();
endclass: src_large_seqs

function src_large_seqs::new(string name = "src_large_seqs");
	super.new(name);
endfunction: new

task src_large_seqs::body();
	req = src_xtn::type_id::create("req");
	
	start_item(req);
	assert(req.randomize() with {header[7:2] inside {[31:63]};});
	finish_item(req);
endtask: body