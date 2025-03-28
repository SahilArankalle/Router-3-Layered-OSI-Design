transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Sahil/Desktop/Maven/Project/Router_1x3_Design {C:/Users/Sahil/Desktop/Maven/Project/Router_1x3_Design/router_fifo_design.v}
vlog -vlog01compat -work work +incdir+C:/Users/Sahil/Desktop/Maven/Project/Router_1x3_Design {C:/Users/Sahil/Desktop/Maven/Project/Router_1x3_Design/Router1x3.v}
vlog -vlog01compat -work work +incdir+C:/Users/Sahil/Desktop/Maven/Project/Router_1x3_Design {C:/Users/Sahil/Desktop/Maven/Project/Router_1x3_Design/router_synchronizer.v}
vlog -vlog01compat -work work +incdir+C:/Users/Sahil/Desktop/Maven/Project/Router_1x3_Design {C:/Users/Sahil/Desktop/Maven/Project/Router_1x3_Design/router_fsm.v}
vlog -vlog01compat -work work +incdir+C:/Users/Sahil/Desktop/Maven/Project/Router_1x3_Design {C:/Users/Sahil/Desktop/Maven/Project/Router_1x3_Design/router_register.v}

vlog -vlog01compat -work work +incdir+C:/Users/Sahil/Desktop/Maven/Project/Router_1x3_Design {C:/Users/Sahil/Desktop/Maven/Project/Router_1x3_Design/Router1x3_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L maxv_ver -L rtl_work -L work -voptargs="+acc"  Router1x3_tb

add wave *
view structure
view signals
run -all
