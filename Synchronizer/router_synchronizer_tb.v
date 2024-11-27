module router_synchronizer_tb();
    reg detect_addr;
    reg [1:0] data_in;
    reg write_enb_reg;
    reg clk;
    reg resetn;
    reg read_enb_0;
    reg read_enb_1;
    reg read_enb_2;
    reg empty_0;
    reg empty_1;
    reg empty_2;
    reg full_0;
    reg full_1;
    reg full_2;
    wire vld_out_0;
    wire vld_out_1;
    wire vld_out_2;
    wire [2:0] write_enb;
    wire soft_reset_0;
    wire soft_reset_1;
    wire soft_reset_2;
    wire fifo_full;
	 
parameter cycle = 10;

router_synchronizer DUT (
     detect_addr,
     data_in,
     write_enb_reg,
     clk,
     resetn,
     read_enb_0,
     read_enb_1,
     read_enb_2,
     empty_0,
     empty_1,
     empty_2,
     full_0,
     full_1,
     full_2,
     vld_out_0,
     vld_out_1,
     vld_out_2,
     write_enb,
     soft_reset_0,
     soft_reset_1,
     soft_reset_2,
     fifo_full
);



initial 
	begin
	clk = 1;
	forever 
	#5 clk=~clk;
	end

task rst_condition;
   begin
   resetn=1'b0;
	#10;
   resetn=1'b1;
   end
  endtask

task operation ();
begin
		detect_addr=1'b1;
		data_in=2'b10;
		read_enb_0=1'b1;
		read_enb_1=1'b1;
		read_enb_2=1'b0;
		write_enb_reg=1'b1;

		full_2=1'b0;
		empty_0=1'b0;
		empty_1=1'b0;
		empty_2=1'b1;
end
endtask

	initial 
		begin
			clk = 0;
			rst_condition;
			#5;
			operation();
			#1000;
			
			
			$finish;
		end
	endmodule
	