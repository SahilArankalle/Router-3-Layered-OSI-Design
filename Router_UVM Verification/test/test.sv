class base_test extends uvm_test;

	`uvm_component_utils(base_test)

	env envh;
	
	env_config	env_cfg;
	src_config	wr_cfgh[];
	dest_config rd_cfgh[];

	bit has_wagent	= 1;
  	bit has_ragent	= 1;

	int no_wrgts = 1;
	int no_ragts = 3;

	bit [1:0] addr;

	extern function new(string name = "base_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void end_of_elaboration_phase(uvm_phase phase);
	extern function void config_router();
	
endclass: base_test

function base_test::new(string name = "base_test" , uvm_component parent);
	super.new(name, parent);
endfunction: new

function void base_test::config_router();

	if (has_wagent == 1) 
		begin
			wr_cfgh = new[no_wrgts];

			foreach(wr_cfgh[i])
			begin
				wr_cfgh[i] = src_config::type_id::create($sformatf("wr_cfgh[%0d]", i));
				
				if (!uvm_config_db#(virtual router_if)::get(this, "", "vif", wr_cfgh[i].vif))
					`uvm_fatal("VIF CONFIG","cannot get() interface vif from uvm_config_db. Have you set() it?") 
				
				wr_cfgh[i].is_active = UVM_ACTIVE;

				env_cfg.wr_cfgh	= wr_cfgh;
			end
        end

    if (has_ragent == 1)
		begin
            rd_cfgh = new[no_ragts];

			foreach(rd_cfgh[i]) 
				begin
					rd_cfgh[i] = dest_config::type_id::create($sformatf("rd_cfgh[%0d]", i));

				    if (!uvm_config_db#(virtual router_if)::get(this, "", $sformatf("vif%0d", i), rd_cfgh[i].vif))
						`uvm_fatal("VIF CONFIG", "cannot get() interface vif from uvm_config_db. Have you set() it?")
					
					rd_cfgh[i].is_active = UVM_ACTIVE;

					env_cfg.rd_cfgh[i] = rd_cfgh[i];
				end
        end

	env_cfg.has_wagent	= has_wagent;
	env_cfg.has_ragent	= has_ragent;
	env_cfg.no_wrgts	= no_wrgts;
	env_cfg.no_ragts	= no_ragts;

endfunction: config_router

function void base_test::build_phase(uvm_phase phase);

	super.build_phase(phase);

	env_cfg = env_config::type_id::create("env_cfg");

	if(has_wagent)
		env_cfg.wr_cfgh	= new[no_wrgts];
	if(has_ragent)
		env_cfg.rd_cfgh	= new[no_ragts];

	config_router();

	uvm_config_db#(env_config)::set(this, "*", "env_config", env_cfg);
	
	envh = env::type_id::create("envh", this);

endfunction: build_phase

function void base_test::end_of_elaboration_phase(uvm_phase phase);
	super.end_of_elaboration_phase(phase);
	uvm_top.print_topology();
endfunction: end_of_elaboration_phase



class smll_seqs_test extends base_test;

	`uvm_component_utils(smll_seqs_test)

	smll_seqs_vseqs	smll_seqs;

	extern function new(string name = "smll_seqs_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass: smll_seqs_test

function smll_seqs_test::new(string name = "smll_seqs_test" , uvm_component parent);
	super.new(name, parent);
endfunction: new

function void smll_seqs_test::build_phase(uvm_phase phase);
	addr = 2'b00;
	uvm_config_db#(bit[1:0])::set(this, "*", "bit[1:0]", addr);

	super.build_phase(phase);
	smll_seqs = smll_seqs_vseqs::type_id::create("smll_seqs");
endfunction: build_phase

task smll_seqs_test::run_phase(uvm_phase phase);
	phase.raise_objection(this);
	
		smll_seqs.start(envh.v_seqr);
		#500;

	phase.drop_objection(this);
endtask: run_phase



class mdm_seqs_test extends base_test;

	`uvm_component_utils(mdm_seqs_test)

	mdm_seqs_vseqs	mdm_seqs;

	extern function new(string name = "mdm_seqs_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass: mdm_seqs_test

function mdm_seqs_test::new(string name = "mdm_seqs_test" , uvm_component parent);
	super.new(name, parent);
endfunction: new

function void mdm_seqs_test::build_phase(uvm_phase phase);
	addr = 2'b01;
	uvm_config_db#(bit[1:0])::set(this, "*", "bit[1:0]", addr);

	super.build_phase(phase);
	mdm_seqs = mdm_seqs_vseqs::type_id::create("mdm_seqs");
endfunction: build_phase

task mdm_seqs_test::run_phase(uvm_phase phase);
	phase.raise_objection(this);

		mdm_seqs.start(envh.v_seqr);
		#500;

	phase.drop_objection(this);
endtask: run_phase



class lrg_seqs_test extends base_test;

	`uvm_component_utils(lrg_seqs_test)

	lrg_seqs_vseqs	lrg_seqs;

	extern function new(string name = "lrg_seqs_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass: lrg_seqs_test

function lrg_seqs_test::new(string name = "lrg_seqs_test" , uvm_component parent);
	super.new(name, parent);
endfunction: new

function void lrg_seqs_test::build_phase(uvm_phase phase);
	addr = 2'b10;
	uvm_config_db#(bit[1:0])::set(this, "*", "bit[1:0]", addr);
	
	super.build_phase(phase);
	lrg_seqs = lrg_seqs_vseqs::type_id::create("lrg_seqs");	
endfunction: build_phase

task lrg_seqs_test::run_phase(uvm_phase phase);
	phase.raise_objection(this);

		lrg_seqs.start(envh.v_seqr);
		#500;

	phase.drop_objection(this);
endtask: run_phase