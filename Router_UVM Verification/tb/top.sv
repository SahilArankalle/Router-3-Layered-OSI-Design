module top;

   		import uvm_pkg::*;

    import router_pkg::*;

	bit clock;
	always #5 clock = !clock;
	
	router_if inf (clock);
	router_if inf0(clock);
	router_if inf1(clock);
	router_if inf2(clock);

	router_top DUT(.clock(clock), .resetn(inf.rstn), .data_in(inf.data_in), .pkt_valid(inf.pkt_vld), .err(inf.error), .busy(inf.busy),
					.read_enb_0(inf0.read_enb), .vld_out_0(inf0.vld_out), .data_out_0(inf0.data_out),
					.read_enb_1(inf1.read_enb), .vld_out_1(inf1.vld_out), .data_out_1(inf1.data_out), 
					.read_enb_2(inf2.read_enb), .vld_out_2(inf2.vld_out), .data_out_2(inf2.data_out));

       	initial
			begin
				uvm_config_db#(virtual router_if)::set(null, "*", "vif", inf);
				uvm_config_db#(virtual router_if)::set(null, "*", "vif0", inf0);
				uvm_config_db#(virtual router_if)::set(null, "*", "vif1", inf1);
				uvm_config_db#(virtual router_if)::set(null, "*", "vif2", inf2);
				run_test();
			end
endmodule
