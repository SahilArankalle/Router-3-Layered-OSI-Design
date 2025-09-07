package router_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh"

	`include "src_xtn.sv"

	`include "src_config.sv"
	`include "dest_config.sv"
	`include "env_config.sv"
	
	`include "src_driver.sv"
	`include "src_monitor.sv"
	`include "src_seqr.sv"
	`include "src_agent.sv"
	`include "src_agent_top.sv"
	`include "src_seqs.sv"

	`include "dest_xtn.sv"

	`include "dest_monitor.sv"
	`include "dest_seqr.sv"
	`include "dest_seqs.sv"
	`include "dest_driver.sv"
	`include "dest_agent.sv"
	`include "dest_agent_top.sv"

	`include "virtual_seqr.sv"
	`include "virtual_seqs.sv"
	`include "scoreboard.sv"

	`include "env.sv"

	`include "test.sv"
	
endpackage: router_pkg
