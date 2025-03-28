#!/bin/csh -f
setenv VCS_HOME /home/cad/eda/SYNOPSYS/VC_SPYGLASS_2022/vc_static/T-2022.06/vcs-mx
setenv VC_STATIC_HOME /home/cad/eda/SYNOPSYS/VC_SPYGLASS_2022/vc_static/T-2022.06
setenv SYNOPSYS_SIM_SETUP /home1/WBRN23/SSArankalle/VLSI_RN/Verilog_labs/Router_Lint/script/vcst_rtdb/.internal/design/synopsys_sim.setup

$VCS_HOME/bin/vlogan  -kdb=common_elab /home1/WBRN23/SSArankalle/VLSI_RN/Verilog_labs/Router_Lint/script/vcst_rtdb/.internal/design/undef_vcs.v -Xvd_opts=-silent,+disable_message+C00373,-ssy,-ssv,-ssz -file /home1/WBRN23/SSArankalle/VLSI_RN/Verilog_labs/Router_Lint/script/vcst_rtdb/.internal/design/analyzeCmd1 -Xufe=parallel:incrdump  -full64 

$VCS_HOME/bin/vcs -file /home1/WBRN23/SSArankalle/VLSI_RN/Verilog_labs/Router_Lint/script/vcst_rtdb/.internal/design/elaborateCmd -Xvcstatic_extns=0x4  -Xvcstatic_extns=0x100  +warn=noSM_CCE  -suppress=SM_BB_LIST  -suppress=SM_UM_LIST  -kdb=common_elab  -Xufe=parallel:incrdump  +warn=noKDB-ELAB-E  -verdi_opts "-logdir /home1/WBRN23/SSArankalle/VLSI_RN/Verilog_labs/Router_Lint/script/vcst_rtdb/verdi/elabcomLog " -Xvd_opts=,-ssy,-ssv,-ssz,-silent,+disable_message+C00373,-rcFile,/home1/WBRN23/SSArankalle/VLSI_RN/Verilog_labs/Router_Lint/script/vcst_rtdb/verdi/elabcom.rc -full64 
