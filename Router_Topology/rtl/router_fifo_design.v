module router_fifo_design(
input clk,
input resetn,
input write_enb,
input soft_reset,
input read_enb,
input [7:0] data_in,
input lfd_state,
output empty,
output full,
output reg [7:0] data_out
);

reg [4:0] rd_ptr, wr_ptr;
reg lfd_state_s;
reg [6:0] count;
reg [8:0] mem [15:0];


//lfd_State from fsm delay by 1clk cycle
always @ (posedge clk)
	begin
		if(!resetn)
			lfd_state_s <= 0;
		else
			lfd_state_s <= lfd_state;
	end
	
//rtl schematic of internal counter for FIFO down counting
   
	
always @ (posedge clk)
	begin
	if(!resetn)
		count <= 7'b0;
	else if(soft_reset)
		count <= 0;
	else if (read_enb && ~empty)
	begin
		if(mem[rd_ptr[3:0]][8] == 1'b1)
			count <= mem[rd_ptr[3:0]][7:2] + 1'b1;
		else if(count != 0)
			count <= count - 1'b1;
	end
	end
	
//rtl schematic - read logic


always @ (posedge clk)
	begin
	if (!resetn)
		data_out <= 8'b0;
	else if (soft_reset)
		data_out <= 8'bz;
	else if(count == 0 && data_out != 0)
		data_out <= 8'bz;
	else if(read_enb && ~empty)
		data_out <= mem[rd_ptr[3:0]];
	end
	
//rtl schematic - write logic


always @ (posedge clk)
	begin
	if(!resetn)
		mem[wr_ptr[3:0]] <= 8'b0;
	else if (soft_reset)
		mem[wr_ptr[3:0]] <= 8'b0;
	else if (write_enb && !full)
		mem[wr_ptr[3:0]] <= {lfd_state,data_in};
	end
	
//rtl schematic for read pointer

	
always @ (posedge clk)
	begin
	if(!resetn)
		rd_ptr <= 5'b0;
	else if (soft_reset)
		rd_ptr <= 5'b0;
	else if (read_enb && !empty)
		rd_ptr <= rd_ptr + 1;
	end
	

//rstl schematic for write pointer
	
always @ (posedge clk)
	begin
	if(!resetn)
		wr_ptr <= 5'b0;
	else if (soft_reset)
		wr_ptr <= 5'b0;
	else if (write_enb && !full)
		wr_ptr <= wr_ptr + 1;
	end
	
//empty logic
assign empty = (rd_ptr == wr_ptr);

//full logic
assign full = (wr_ptr == ({~rd_ptr[4],rd_ptr[3:0]}));

endmodule


	