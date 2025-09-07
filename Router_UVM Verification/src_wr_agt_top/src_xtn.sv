class src_xtn extends uvm_sequence_item;
	`uvm_object_utils(src_xtn)
	
	rand bit [7:0] header;
	rand bit [7:0] payload_data[];
	bit [7:0] parity;
	
	bit error;
	bit busy;
	
	constraint c1 {header [1:0] != 2'b11;}
	constraint c2 {payload_data.size == header[7:2];}
	constraint c3 {payload_data.size != 0;}
	
	extern function new(string name = "src_xtn");
	extern function void post_randomize();
	extern function void do_print(uvm_printer printer);
	
endclass: src_xtn

function src_xtn::new(string name = "src_xtn");
	super.new(name);
endfunction: new

function void src_xtn::post_randomize();
	parity = 0 ^ header;
	foreach (payload_data[i])
		parity = parity ^ payload_data[i];
endfunction: post_randomize

function void src_xtn::do_print(uvm_printer printer);
	super.do_print(printer);
			//string_name	bitstream_value		size	radix_of_printing
					
	printer.print_field("header", this.header, 8, UVM_DEC);
	foreach(payload_data[i])
		printer.print_field($sformatf("payload_data[%0d]", i), this.payload_data[i], 8, UVM_DEC);
	printer.print_field("parity", this.parity, 8, UVM_DEC);
endfunction: do_print
/*
function void write_xtn::do_copy (uvm_object rhs);
    write_xtn rhs_;

    if(!$cast(rhs_,rhs)) begin
    `uvm_fatal("do_copy","cast of the rhs object failed")
    end
    super.do_copy(rhs);
    header = rhs_.header;
    foreach(payload_data[i])	
    payload_data[i] = rhs_.payload_data[i];
    parity = rhs_.parity;
    
  endfunction:do_copy

function bit  write_xtn::do_compare (uvm_object rhs,uvm_comparer comparer);
    write_xtn rhs_;

    if(!$cast(rhs_,rhs)) begin
    `uvm_fatal("do_compare","cast of the rhs object failed")
    return 0;
    end

    return super.do_compare(rhs,comparer) &&
    header == rhs_.header &&
    parity == rhs_.parity;

endfunction:do_compare 
*/