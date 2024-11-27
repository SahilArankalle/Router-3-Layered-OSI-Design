module router_synchronizer(
    input detect_addr,
    input [1:0] data_in,
    input write_enb_reg,
    input clk,
    input resetn,
    input read_enb_0,
    input read_enb_1,
    input read_enb_2,
    input empty_0,
    input empty_1,
    input empty_2,
    input full_0,
    input full_1,
    input full_2,
    output wire vld_out_0,
    output wire vld_out_1,
    output wire vld_out_2,
    output reg [2:0] write_enb,
    output reg soft_reset_0,
    output reg soft_reset_1,
    output reg soft_reset_2,
    output reg fifo_full
);

reg [1:0] fifo_addr;
reg [4:0] fifo_0_counter_sft;
reg [4:0] fifo_1_counter_sft;
reg [4:0] fifo_2_counter_sft;

// Capturing address
always @(posedge clk) 
begin
    if (!resetn)
        fifo_addr <= 0;
    else if (detect_addr)
        fifo_addr <= data_in;
end

// Write enable logic
always @(*) 
begin
    if (write_enb_reg) 
    begin
        case (fifo_addr)
            2'b00: write_enb = 3'b001;
            2'b01: write_enb = 3'b010;
            2'b10: write_enb = 3'b100;
            default: write_enb = 3'b000;
        endcase
    end 
    else
        write_enb = 3'b000;
end

// FIFO Full Logic
always @(*) 
begin
    case (fifo_addr)
        2'b00: fifo_full = full_0;
        2'b01: fifo_full = full_1;
        2'b10: fifo_full = full_2;
        default: fifo_full = 1'b0;
    endcase
end

// Valid out signal
assign vld_out_0 = ~empty_0;
assign vld_out_1 = ~empty_1;
assign vld_out_2 = ~empty_2;

    // Counter and reset logic for soft_reset_0
    always @(posedge clk) 
	 begin
        if (!resetn) 
            fifo_0_counter_sft <= 5'b0;
        else if (vld_out_0) 
		  begin
            if (!read_enb_0) 
				begin
                if (fifo_0_counter_sft == 5'b11110) 
					 begin
                    soft_reset_0 <= 1'b1;
                    fifo_0_counter_sft <= 5'b0;
                end 
					 else 
					 begin
                    fifo_0_counter_sft <= fifo_0_counter_sft + 1'b1;
                    soft_reset_0 <= 1'b0;
                end
            end 
				else 
                fifo_0_counter_sft <= 5'b0;
        end 
		  else 
            fifo_0_counter_sft <= 5'b0;
    end

    // Counter and reset logic for soft_reset_1
    always @(posedge clk) 
	 begin
        if (!resetn) 
            fifo_1_counter_sft <= 5'b0;
        else if (vld_out_1) 
		  begin
            if (!read_enb_1) 
				begin
                if (fifo_1_counter_sft == 5'b11110) 
					 begin
                    soft_reset_1 <= 1'b1;
                    fifo_1_counter_sft <= 5'b0;
                end 
					 else 
					 begin
                    fifo_1_counter_sft <= fifo_1_counter_sft + 1'b1;
                    soft_reset_1 <= 1'b0;
                end
            end 
				else 
                fifo_1_counter_sft <= 5'b0;
        end 
		  else 
            fifo_1_counter_sft <= 5'b0;
    end

    // Counter and reset logic for soft_reset_2
    always @(posedge clk) 
	 begin
        if (!resetn) 
            fifo_2_counter_sft <= 5'b0;
        else if (vld_out_2) 
		  begin
            if (!read_enb_2) 
				begin
                if (fifo_2_counter_sft == 5'b11110) 
					 begin
                    soft_reset_2 <= 1'b1;
                    fifo_2_counter_sft <= 5'b0;
                end 
					 else 
					 begin
                    fifo_2_counter_sft <= fifo_2_counter_sft + 1'b1;
                    soft_reset_2 <= 1'b0;
                end
            end 
				else 
                fifo_2_counter_sft <= 5'b0;
        end 
		  else 
            fifo_2_counter_sft <= 5'b0;
    end

endmodule
