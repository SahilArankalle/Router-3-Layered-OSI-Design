class virtual_seqr extends uvm_sequencer#(uvm_sequence_item);

    `uvm_component_utils(virtual_seqr)

    src_seqr    write_seqr[];
    dest_seqr   read_seqr[];

    env_config  m_cfg;

    extern function new(string name = "virtual_seqr", uvm_component parent);
    extern function void build_phase(uvm_phase phase);

endclass: virtual_seqr

function virtual_seqr::new(string name = "virtual_seqr", uvm_component parent);
    super.new(name, parent);
endfunction: new

function void virtual_seqr::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db#(env_config)::get(this, "", "env_config", m_cfg))
        `uvm_fatal(get_full_name(), "cannot get() env_config from uvm_config_db, have you set() it?")

    write_seqr  = new[m_cfg.no_wrgts];
    read_seqr   = new[m_cfg.no_ragts];

endfunction: build_phase