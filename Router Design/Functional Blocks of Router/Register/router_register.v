module router_register(
input clk,
input resetn,
input pkt_valid,
input [7:0] data_in,
input fifo_full,
input reset_int_reg,
input detect_addr,
input ld_state,
input laf_state,
input full_state,
input lfd_state,
output reg parity_done,
output reg low_pkt_valid,
output reg err,
output reg [7:0] data_out
);


reg [7:0] header_byte, fifo_full_state_byte, packet_parity, internal_parity;


//header 

always @ (posedge clk)
begin

if (!resetn)
header_byte <= 0;

else if (detect_addr && pkt_valid && data_in [1:0] != 2'b11)
header_byte <= data_in;

end


//fifo full state byte 

always @ (posedge clk)
begin

if (!resetn)
fifo_full_state_byte <= 0;

else if (ld_state && fifo_full)
fifo_full_state_byte <= data_in;

end


//data_out logic

always @ (posedge clk)
begin

if (!resetn)
data_out <= 0;

else if (lfd_state)
data_out <= header_byte;

else if (ld_state && !fifo_full)
data_out <= data_in;

else if (laf_state)
data_out <= fifo_full_state_byte;
end


//low packet valid logic

always @ (posedge clk)
begin

if (!resetn)
low_pkt_valid <= 0;

else if(reset_int_reg)
low_pkt_valid<=0;

else if (ld_state && !pkt_valid)
low_pkt_valid <= 1'b1;

end


//internal parity logic

always @ (posedge clk)
begin
if(!resetn)
internal_parity <= 0;

else if (detect_addr)
internal_parity <= 0;

else if (lfd_state && pkt_valid)
internal_parity <= internal_parity^header_byte;

else if (ld_state && pkt_valid && !fifo_full)
internal_parity <=  internal_parity^data_in;

else 
internal_parity <= internal_parity;

end


//external parity logic

always @ (posedge clk)
begin
if (!resetn)
packet_parity <= 0;

else if (detect_addr)
packet_parity <= 0;

else if ((ld_state && !pkt_valid && !fifo_full) ||	 (laf_state && low_pkt_valid && !parity_done))
packet_parity <= data_in;
end

//parity done logic

always @ (posedge clk)
begin
if (!resetn)
parity_done <= 0;

else if (detect_addr)
parity_done <= 0;

else if ((ld_state && !pkt_valid && !fifo_full) ||	 (laf_state && low_pkt_valid && !parity_done))
parity_done <= 1;
end

//error logic

always @ (posedge clk)
begin

if (!resetn)
err <= 0;

else if (parity_done)
begin
if (internal_parity != packet_parity)
err <= 1;
else
err <= 0;
end

else 
err <= 0;
end

endmodule 

