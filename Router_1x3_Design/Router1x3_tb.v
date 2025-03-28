module Router1x3_tb;

reg clk;
reg resetn;
reg pkt_valid;
reg [7:0] data_in;
reg read_enb_0, read_enb_1, read_enb_2;

wire [7:0] data_out_0, data_out_1, data_out_2;
wire vld_out_0, vld_out_1, vld_out_2;
wire busy;
wire err;

parameter T = 10;
integer i;

Router1x3 ROUTER_DUT (
clk,
resetn,
read_enb_0,
read_enb_1,
read_enb_2,
pkt_valid,
data_in,
vld_out_0,
vld_out_1,
vld_out_2,
err,
busy,
data_out_0, 
data_out_1, 
data_out_2
);

always
begin
#(T/2);
clk = 1'b1;
#(T/2);
clk = 1'b0;
end

task initialize;
begin
{pkt_valid, data_in, read_enb_0, read_enb_1, read_enb_2} = 0;
end
endtask

task rst;
begin
@ (negedge clk);
resetn = 1'b0;
@ (negedge clk);
resetn = 1'b1;
end
endtask

//payload of 14 for fifo 0

task pkt_gen_14_fifo0;
reg [7:0] payload_data, parity, header;
reg [5:0] payloadlen;
reg [1:0] addr;
begin
@ (negedge clk);
wait (~busy)

@ (negedge clk);
payloadlen = 14;
addr = 2'b00;
header = {payloadlen, addr};
parity = 0;
data_in = header;
pkt_valid = 1;
parity = parity ^ header;

@ (negedge clk);
wait (~busy)
for (i = 0; i < payloadlen; i = i + 1)
begin
@ (negedge clk);
wait (~busy)
payload_data = {$random} %256;
data_in = payload_data;
parity = parity ^ payload_data;
end
@ (negedge clk)
wait (~busy)
pkt_valid = 0;
data_in = parity;
end
endtask


//payload of 16 for fifo 1

task pkt_gen_16_fifo1;
reg [7:0] payload_data, parity, header;
reg [5:0] payloadlen;
reg [1:0] addr;
begin
@ (negedge clk);
wait (~busy)

@ (negedge clk);
payloadlen = 16;
addr = 2'b01;
header = {payloadlen, addr};
parity = 0;
data_in = header;
pkt_valid = 1;
parity = parity ^ header;

@ (negedge clk);
wait (~busy)
for (i = 0; i < payloadlen; i = i + 1)
begin
@ (negedge clk);
wait (~busy)
payload_data = {$random} %256;
data_in = payload_data;
parity = parity ^ payload_data;
end
@ (negedge clk)
wait (~busy)
pkt_valid = 0;
data_in = parity;
end
endtask


//payload of 5 for fifo 2

task pkt_gen_5_fifo2;
reg [7:0] payload_data, parity, header;
reg [5:0] payloadlen;
reg [1:0] addr;
begin
@ (negedge clk);
wait (~busy)

@ (negedge clk);
payloadlen = 5;
addr = 2'b10;
header = {payloadlen, addr};
parity = 0;
data_in = header;
pkt_valid = 1;
parity = parity ^ header;

@ (negedge clk);
wait (~busy)
for (i = 0; i < payloadlen; i = i + 1)
begin
@ (negedge clk);
wait (~busy)
payload_data = {$random} %256;
data_in = payload_data;
parity = parity ^ payload_data;
end
@ (negedge clk)
wait (~busy)
pkt_valid = 0;
data_in = parity;
end
endtask


initial 
begin
rst;
initialize;

pkt_gen_14_fifo0;

repeat(2)
@ (negedge clk);
read_enb_0 = 1'b1;

wait (ROUTER_DUT.FIFO_0.empty)
@ (negedge clk)
read_enb_0 = 1'b0;


rst;
initialize;

pkt_gen_16_fifo1;

repeat(2)
@ (negedge clk);
read_enb_1 = 1'b1;

wait (ROUTER_DUT.FIFO_1.empty)
@ (negedge clk)
read_enb_1 = 1'b0;


rst;
initialize;

pkt_gen_5_fifo2;

repeat(2)
@ (negedge clk);
read_enb_2 = 1'b1;

wait (ROUTER_DUT.FIFO_2.empty)
@ (negedge clk)
read_enb_2 = 1'b0;


#1000
$finish;
end

endmodule


