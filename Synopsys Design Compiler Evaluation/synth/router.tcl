remove_design -all
set search_path {../lib}
set target_library {lsi_10k.db}
set link_library "* lsi_10k.db"

analyze -format verilog {../rtl/Router1x3.v ../rtl/router_fifo_design.v ../rtl/router_fsm.v ../rtl/router_register.v ../rtl/router_synchronizer.v} 

elaborate Router1x3

link 

source ./router.con

check_design

current_design  Router1x3

compile_ultra

report_timing -path full > timing_report_router.txt

write_file -f verilog -hier -output router_netlist.v


 

