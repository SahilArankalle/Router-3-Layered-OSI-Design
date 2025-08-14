##Makefile for UVM Testbench
#RTL= ../rtl/*
work= work #library name
SVTB1= ../tb/top.sv
INC = +incdir+../tb +incdir+../test +incdir+../wr_agt_top +incdir+../rd_agt_top
SVTB2 = ../test/test_pkg.sv
VSIMOPT= -vopt -voptargs=+acc 
VSIMCOV= -coverage -sva 
VSIMBATCH1= -c -do  " log -r /* ;run -all; exit"

help:
	@echo =============================================================================================================
	@echo "! USAGE   		--  make target                             																			!"
	@echo "! clean   		=>  clean the earlier log and intermediate files.       													!"
	@echo "! sv_cmp    	=>  Create library and compile the code.                   												!"
	@echo "! run_sim    =>  run the simulation in batch mode.                   													!"
	@echo "! run_test		=>  clean, compile & run the simulation for ram_signle_adddr_test in batch mode.	!" 
	@echo "! view_wave1 =>  To view the waveform of ram_signle_addr_test	    														!" 
	@echo ====================================================================================================================

sv_cmp:
	vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(INC) $(SVTB2) $(SVTB1) 	
	
run_test:sv_cmp
	vsim $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave_file1.wlf -l test1.log  -sv_seed random  work.top +UVM_TESTNAME=test

view_wave1:
	vsim -view wave_file1.wlf

clean:
	rm -rf transcript* *log*  vsim.wlf fcover* covhtml* mem_cov* *.wlf modelsim.ini
	clear