module router_fsm_tb();
    reg clk;
    reg resetn;
    reg pkt_valid;
    reg parity_done;
    reg [1:0] data_in;
    reg soft_reset_0;
    reg soft_reset_1;
    reg soft_reset_2;
    reg fifo_full;
    reg low_pkt_valid;
    reg fifo_empty_0;
    reg fifo_empty_1;
    reg fifo_empty_2;
    wire busy;
    wire detect_addr;
    wire ld_state;
    wire laf_state;
    wire full_state;
    wire write_enb_reg;
    wire rst_int_reg;
    wire lfd_state;
	 
	parameter cycle = 10;
	
	router_fsm DUT (
	 clk,
    resetn,
    pkt_valid,
    parity_done,
    data_in,
    soft_reset_0,
    soft_reset_1,
    soft_reset_2,
    fifo_full,
    low_pkt_valid,
    fifo_empty_0,
    fifo_empty_1,
    fifo_empty_2,
    busy,
    detect_addr,
    ld_state,
    laf_state,
    full_state,
    write_enb_reg,
    rst_int_reg,
    lfd_state
	);
	
	  parameter DECODE_ADDRESS       = 3'b000,
            LOAD_FIRST_DATA 	 = 3'b001,
            LOAD_DATA 		     = 3'b010,
            WAIT_TILL_EMPTY 	 = 3'b011,
            CHECK_PARITY_ERROR   = 3'b100,
            LOAD_PARITY 		 = 3'b101,
            FIFO_FULL_STATE 	 = 3'b110,
            LOAD_AFTER_FULL 	 = 3'b111;
  
  reg [24:0] string_cmd;

  always@(DUT.present_state)
      begin
        case (DUT.present_state)
	    DECODE_ADDRESS     :  string_cmd = "DA";
	    LOAD_FIRST_DATA    :  string_cmd = "LFD";
	    LOAD_DATA    	   :  string_cmd = "LD";
	    WAIT_TILL_EMPTY    :  string_cmd = "WTE";
	    CHECK_PARITY_ERROR :  string_cmd = "CPE";
	    LOAD_PARITY    	   :  string_cmd = "LP";
	    FIFO_FULL_STATE    :  string_cmd = "FFS";
	    LOAD_AFTER_FULL    :  string_cmd = "LAF";
	    endcase
      end
	
	initial 
		begin
		clk = 1;
		forever 
		#5 clk=~clk;
		end
		
	task initialize;
	begin
	pkt_valid = 0;
	fifo_empty_0 = 0;
	fifo_empty_1 = 0;
	fifo_empty_2 = 0;
	fifo_full = 0;
	parity_done = 0;
	low_pkt_valid = 0;
	end
	endtask
	

   task rst;
   begin
   @(negedge clk)
    resetn=1'b0;
   @(negedge clk)
    resetn=1'b1;
   end
   endtask
	
	
	
	task task1;
	begin
	@ (negedge clk)
	begin
	pkt_valid <= 1;
	data_in[1:0] <= 0;
	fifo_empty_0 <= 1;
	end
	//LFD
	@ (negedge clk)
	//LD
	@ (negedge clk)
	begin
	fifo_full <= 0;
	pkt_valid <= 0;
	end
	//LP
	@ (negedge clk)
	//CPE
	@ (negedge clk)
	fifo_full <= 0;
	//DA
	end
	endtask
	
	task task2;
	begin
	@ (negedge clk)
	begin
	pkt_valid <= 1;
	data_in[1:0] <= 0;
	fifo_empty_0 <= 1;
	end
	//LFD
	@ (negedge clk)
	//LD
	@ (negedge clk)
	fifo_full <= 1;
	//FFS
	@ (negedge clk)
	fifo_full <= 0;
	//LAF
	@ (negedge clk)
	begin
	parity_done <= 0;
	low_pkt_valid <= 1;
	end
	//LP
	@ (negedge clk)
	//CPE
	@ (negedge clk)
	fifo_full <= 0;
	//DA
	end
	endtask
	
	task task3;
	begin
	@ (negedge clk)
	begin
	pkt_valid <= 1;
	data_in[1:0] <= 0;
	fifo_empty_0 <= 1;
	end
	//LFD
	@ (negedge clk)
	//LD
	@ (negedge clk)
	fifo_full <= 1;
	//FFS
	@ (negedge clk)
	fifo_full <= 0;
	//LAF
	@ (negedge clk)
	begin
	parity_done <= 0;
	low_pkt_valid <= 0;
	end
	//LD
	@ (negedge clk)
	begin
	fifo_full <= 0;
	pkt_valid <= 0;
	end
	//LP
	@ (negedge clk)
	//CPE
	@ (negedge clk)
	fifo_full <= 0;
	//DA
	end
	endtask
	
	task task4;
	begin
	@ (negedge clk)
	begin
	pkt_valid <= 1;
	data_in[1:0] <= 0;
	fifo_empty_0 <= 1;
	end
	//LFD
	@ (negedge clk)
	//LD
	@ (negedge clk)
	begin
	fifo_full <= 0;
	pkt_valid <= 0;
	end
	//LP
	@ (negedge clk)
	//CPE
	@ (negedge clk)
	fifo_full <= 1;
	//FFS
	@ (negedge clk)
	fifo_full <= 0;
	//LAF
	@ (negedge clk)
	parity_done <= 1;
	//DA
	end
	endtask
	
   initial
   begin
   rst;
   initialize;
  
    task1;
	rst;
	#30
    task2;
	rst;
	#30
	task3;
	rst;
	#30
    task4;
	rst;
   #1000
	$finish;
	
   end
	
	initial 
	$monitor("Reset=%b, State=%s, det_add=%b, write_enb_reg=%b, full_state=%b, lfd_state=%b, busy=%b, ld_state=%b, laf_state=%b, rst_int_reg=%b, low_packet_valid=%b", resetn, string_cmd, detect_addr, write_enb_reg, full_state, lfd_state, busy, ld_state, laf_state, rst_int_reg, low_pkt_valid);
	
	endmodule 
	
	
	
	
	