class env_config extends uvm_object;
	
	`uvm_object_utils(env_config)

	bit has_scoreboard			= 1;
	bit has_virtual_sequencer	= 1;
	bit has_wagent				= 1;
  	bit has_ragent				= 1;

	int no_wrgts = 1;
	int no_ragts = 3;

	static int data_verified_count = 0;

	src_config	wr_cfgh[];
	dest_config	rd_cfgh[];

	extern function new(string name = "env_config");

endclass: env_config

function env_config::new(string name = "env_config");
	super.new(name);
endfunction: new