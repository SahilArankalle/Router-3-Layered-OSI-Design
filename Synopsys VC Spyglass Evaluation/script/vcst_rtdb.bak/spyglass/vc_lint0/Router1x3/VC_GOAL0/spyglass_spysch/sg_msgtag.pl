################################################################################
#This is an internally genertaed by SpyGlass for Message Tagging Support
################################################################################


use spyglass;
use SpyGlass;
use SpyGlass::Objects;
spyRebootMsgTagSupport();

spySetMsgTagCount(74,46);
spyParseTextMessageTagFile("/home1/WBRN23/SSArankalle/VLSI_RN/Verilog_labs/Router_Lint/script/vcst_rtdb/spyglass/vc_lint0/Router1x3/VC_GOAL0/spyglass_spysch/sg_msgtag.txt");

if(!defined $::spyInIspy || !$::spyInIspy)
{
    spyDefineReportGroupingOrder("ALL",
(
"BUILTIN"   => [SGTAGTRUE, SGTAGFALSE]
,"TEMPLATE" => "A"
)
);
}
spyMessageTagTestBenchmark(12,"/home1/WBRN23/SSArankalle/VLSI_RN/Verilog_labs/Router_Lint/script/vcst_rtdb/spyglass/vc_lint0/Router1x3/VC_GOAL0/spyglass.vdb");

1;
