/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : T-2022.03-SP4
// Date      : Fri Mar 28 13:51:42 2025
/////////////////////////////////////////////////////////////


module Router1x3 ( clk, resetn, read_enb_0, read_enb_1, read_enb_2, pkt_valid, 
        data_in, vld_out_0, vld_out_1, vld_out_2, err, busy, data_out_0, 
        data_out_1, data_out_2 );
  input [7:0] data_in;
  output [7:0] data_out_0;
  output [7:0] data_out_1;
  output [7:0] data_out_2;
  input clk, resetn, read_enb_0, read_enb_1, read_enb_2, pkt_valid;
  output vld_out_0, vld_out_1, vld_out_2, err, busy;

  tri   clk;
  tri   resetn;
  tri   read_enb_0;
  tri   read_enb_1;
  tri   read_enb_2;
  tri   pkt_valid;
  tri   [7:0] data_in;
  tri   vld_out_0;
  tri   vld_out_1;
  tri   vld_out_2;
  tri   err;
  tri   busy;
  tri   [7:0] data_out_0;
  tri   [7:0] data_out_1;
  tri   [7:0] data_out_2;
  tri   [2:0] write_enb;
  tri   soft_reset_0;
  tri   [7:0] d_in;
  tri   lfd_state;
  tri   empty_0;
  tri   full_0;
  tri   soft_reset_1;
  tri   empty_1;
  tri   full_1;
  tri   soft_reset_2;
  tri   empty_2;
  tri   full_2;
  tri   parity_done;
  tri   fifo_full;
  tri   low_pkt_valid;
  tri   detect_addr;
  tri   ld_state;
  tri   laf_state;
  tri   full_state;
  tri   write_enb_reg;
  tri   reset_int_reg;

  router_fifo_design FIFO_0 ( .clk(clk), .resetn(resetn), .write_enb(
        write_enb[0]), .soft_reset(soft_reset_0), .read_enb(read_enb_0), 
        .data_in(d_in), .lfd_state(lfd_state), .empty(empty_0), .full(full_0), 
        .data_out(data_out_0) );
  router_fifo_design FIFO_1 ( .clk(clk), .resetn(resetn), .write_enb(
        write_enb[1]), .soft_reset(soft_reset_1), .read_enb(read_enb_1), 
        .data_in(d_in), .lfd_state(lfd_state), .empty(empty_1), .full(full_1), 
        .data_out(data_out_1) );
  router_fifo_design FIFO_2 ( .clk(clk), .resetn(resetn), .write_enb(
        write_enb[2]), .soft_reset(soft_reset_2), .read_enb(read_enb_2), 
        .data_in(d_in), .lfd_state(lfd_state), .empty(empty_2), .full(full_2), 
        .data_out(data_out_2) );
  router_fsm FSM ( .clk(clk), .resetn(resetn), .pkt_valid(pkt_valid), 
        .parity_done(parity_done), .data_in(data_in[1:0]), .soft_reset_0(
        soft_reset_0), .soft_reset_1(soft_reset_1), .soft_reset_2(soft_reset_2), .fifo_full(fifo_full), .low_pkt_valid(low_pkt_valid), .fifo_empty_0(empty_0), 
        .fifo_empty_1(empty_1), .fifo_empty_2(empty_2), .busy(busy), 
        .detect_addr(detect_addr), .ld_state(ld_state), .laf_state(laf_state), 
        .full_state(full_state), .write_enb_reg(write_enb_reg), .rst_int_reg(
        reset_int_reg), .lfd_state(lfd_state) );
  router_synchronizer SYNCHRONIZER ( .detect_addr(detect_addr), .data_in(
        data_in[1:0]), .write_enb_reg(write_enb_reg), .clk(clk), .resetn(
        resetn), .read_enb_0(read_enb_0), .read_enb_1(read_enb_1), 
        .read_enb_2(read_enb_2), .empty_0(empty_0), .empty_1(empty_1), 
        .empty_2(empty_2), .full_0(full_0), .full_1(full_1), .full_2(full_2), 
        .vld_out_0(vld_out_0), .vld_out_1(vld_out_1), .vld_out_2(vld_out_2), 
        .write_enb(write_enb), .soft_reset_0(soft_reset_0), .soft_reset_1(
        soft_reset_1), .soft_reset_2(soft_reset_2), .fifo_full(fifo_full) );
  router_register REGISTER ( .clk(clk), .resetn(resetn), .pkt_valid(pkt_valid), 
        .data_in(data_in), .fifo_full(fifo_full), .reset_int_reg(reset_int_reg), .detect_addr(detect_addr), .ld_state(ld_state), .laf_state(laf_state), 
        .full_state(full_state), .lfd_state(lfd_state), .parity_done(
        parity_done), .low_pkt_valid(low_pkt_valid), .err(err), .data_out(d_in) );
endmodule

