class dest_xtn extends uvm_sequence_item;

	`uvm_object_utils(dest_xtn)
	
	bit [7:0] header;
	bit [7:0] payload_data[];
	bit [7:0] parity;
	
	rand bit [5:0] no_of_cycles;

	constraint delay {(no_of_cycles < 30) && (no_of_cycles > 0);}
	
	extern function new(string name = "dest_xtn");
	extern function void do_print(uvm_printer printer);
	
endclass: dest_xtn

function dest_xtn::new(string name = "dest_xtn");
	super.new(name);
endfunction: new

function void dest_xtn::do_print(uvm_printer printer);
	super.do_print(printer);
					//string_name	bitstream_value		size	radix_of_printing
	printer.print_field("header", this.header, 8, UVM_DEC);
	
	foreach(payload_data[i])
		printer.print_field($sformatf("payload_data[%0d]", i), this.payload_data[i], 8, UVM_DEC);
		
	printer.print_field("parity", this.parity, 8, UVM_DEC);
	
	printer.print_field("no_of_cycles", this.no_of_cycles, 6, UVM_DEC);
endfunction: do_print