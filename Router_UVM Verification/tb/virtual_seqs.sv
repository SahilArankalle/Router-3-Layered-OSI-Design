class virtual_seqs extends uvm_sequence#(uvm_sequence_item);

    `uvm_object_utils(virtual_seqs)

    virtual_seqr    v_seqr;

    src_seqr        write_seqr[];
    dest_seqr       read_seqr[];

    src_small_seqs  smll_seqs;
    src_medium_seqs mdm_seqs;
    src_large_seqs  lrg_seqs;

    dest_rd_enb_seqs      rd_enb_seqs;
    dest_sft_rst_seqs     sft_rst_seqs;

    env_config      env_cfg;

    extern function new(string name = "virtual_seqs");
    extern task body();
endclass : virtual_seqs  
    
function virtual_seqs::new(string name = "virtual_seqs");
    super.new(name);
endfunction: new

task virtual_seqs::body();
    if(!uvm_config_db #(env_config)::get(null, get_full_name(), "env_config", env_cfg))
        `uvm_fatal(get_full_name(), "cannot get() env_config from uvm_config_db, have you set() it?")

    write_seqr  = new[env_cfg.no_wrgts];
    read_seqr   = new[env_cfg.no_ragts];

    assert($cast(v_seqr, m_sequencer))
        else
            `uvm_error(get_full_name(), "Virtual Sequencer pointer cast failed");
    
    foreach(write_seqr[i])
        write_seqr[i]  = v_seqr.write_seqr[i];
    foreach(read_seqr[i])
        read_seqr[i]   = v_seqr.read_seqr[i];

endtask: body



class smll_seqs_vseqs extends virtual_seqs;

    `uvm_object_utils(smll_seqs_vseqs)

    bit [1:0] addr;

    extern function new(string name = "smll_seqs_vseqs");
    extern task body();
endclass : smll_seqs_vseqs

function smll_seqs_vseqs::new(string name = "smll_seqs_vseqs");
    super.new(name);
endfunction: new

task smll_seqs_vseqs::body();
    super.body();

    if(!uvm_config_db #(bit[1:0])::get(null, get_full_name(), "bit[1:0]", addr))
        `uvm_fatal(get_type_name(), "cannot get() addr from uvm_config_db, have you set() it?")

    if(env_cfg.has_wagent == 1)
        smll_seqs = src_small_seqs::type_id::create("smll_seqs");
    if(env_cfg.has_ragent == 1)
        rd_enb_seqs = dest_rd_enb_seqs::type_id::create("rd_enb_seqs");
    fork
        begin
            smll_seqs.start(write_seqr[0]);
        end
        begin
            if(addr == 2'b00)
                rd_enb_seqs.start(read_seqr[0]);
            if(addr == 2'b01)
                rd_enb_seqs.start(read_seqr[1]);
            if(addr == 2'b10)
                rd_enb_seqs.start(read_seqr[2]);
        end
    join
endtask: body



class mdm_seqs_vseqs extends virtual_seqs;

    `uvm_object_utils(mdm_seqs_vseqs)

    bit [1:0] addr;

    extern function new(string name = "mdm_seqs_vseqs");
    extern task body();
endclass : mdm_seqs_vseqs

function mdm_seqs_vseqs::new(string name = "mdm_seqs_vseqs");
    super.new(name);
endfunction: new

task mdm_seqs_vseqs::body();
    super.body();

    if(!uvm_config_db #(bit[1:0])::get(null, get_full_name(), "bit[1:0]", addr))
        `uvm_fatal(get_type_name(), "cannot get() addr from uvm_config_db, have you set() it?")

    if(env_cfg.has_wagent == 1)
        mdm_seqs = src_medium_seqs::type_id::create("mdm_seqs");
    if(env_cfg.has_ragent == 1)
        rd_enb_seqs = dest_rd_enb_seqs::type_id::create("rd_enb_seqs");
    fork
        begin
            mdm_seqs.start(write_seqr[0]);
        end
        begin
            if(addr == 2'b00)
                rd_enb_seqs.start(read_seqr[0]);
            if(addr == 2'b01)
                rd_enb_seqs.start(read_seqr[1]);
            if(addr == 2'b10)
                rd_enb_seqs.start(read_seqr[2]);
        end
    join
endtask: body



class lrg_seqs_vseqs extends virtual_seqs;

    `uvm_object_utils(lrg_seqs_vseqs)

    bit [1:0] addr;

    extern function new(string name = "lrg_seqs_vseqs");
    extern task body();
endclass : lrg_seqs_vseqs

function lrg_seqs_vseqs::new(string name = "lrg_seqs_vseqs");
    super.new(name);
endfunction: new

task lrg_seqs_vseqs::body();
    super.body();

    if(!uvm_config_db #(bit[1:0])::get(null, get_full_name(), "bit[1:0]", addr))
        `uvm_fatal(get_type_name(), "cannot get() addr from uvm_config_db, have you set() it?")

    if(env_cfg.has_wagent == 1)
        lrg_seqs = src_large_seqs::type_id::create("lrg_seqs");
    if(env_cfg.has_ragent == 1)
        rd_enb_seqs = dest_rd_enb_seqs::type_id::create("rd_enb_seqs");
    fork
        begin
            lrg_seqs.start(write_seqr[0]);
        end
        begin
            if(addr == 2'b00)
                rd_enb_seqs.start(read_seqr[0]);
            if(addr == 2'b01)
                rd_enb_seqs.start(read_seqr[1]);
            if(addr == 2'b10)
                rd_enb_seqs.start(read_seqr[2]);
        end
    join
endtask: body