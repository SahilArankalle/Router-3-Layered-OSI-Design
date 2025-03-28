#Liberty files are needed for logical and physical netlist designs
set search_path "./"
set link_library " "

set_app_var enable_lint true

configure_lint_setup -goal lint_rtl

analyze -verbose -format verilog "../rtl/Router1x3.v ../rtl/router_fifo_design.v ../rtl/router_fsm.v ../rtl/router_register.v ../rtl/router_synchronizer.v"

elaborate Router1x3

check_lint

waive_lint -tag "STARC05-2.5.1.2" -add router

report_lint -verbose -file report_lint_router.txt

