module router_register_tb;
reg clk;
reg resetn;
reg pkt_valid;
reg [7:0] data_in;
reg fifo_full;
reg reset_int_reg;
reg detect_addr;
reg ld_state;
reg laf_state;
reg full_state;
reg lfd_state;
wire parity_done;
wire low_pkt_valid;
wire err;
wire [7:0] data_out;

integer i;
parameter cycle = 10;


router_register DUT (
 clk,
 resetn,
 pkt_valid,
 data_in,
 fifo_full,
 reset_int_reg,
 detect_addr,
 ld_state,
 laf_state,
 full_state,
 lfd_state,
 parity_done,
 low_pkt_valid,
 err,
 data_out
);

initial 
begin
clk = 1'b0;
forever #(cycle/2) clk = ~clk;
end


task rst;
begin
    @(negedge clk)
    resetn=1'b0;
    @(negedge clk)
    resetn=1'b1;
end
endtask


task initialize;
begin
pkt_valid <= 1'b0;
fifo_full <= 1'b0;
detect_addr <= 1'b0;
ld_state <= 1'b0;
laf_state <= 1'b0;
lfd_state <= 1'b0;
full_state <= 1'b0;
reset_int_reg <= 1'b0;
end
endtask


task firstpacket;
reg [7:0] header, payload_data, parity;
reg [5:0] payloadlen;
begin

@ (negedge clk);
payloadlen = 5;
detect_addr = 1;
pkt_valid = 1;

header = {payloadlen, 2'b10};
parity = 0 ^ header;
data_in = header;



@ (negedge clk);
detect_addr = 0;
lfd_state = 1;
 full_state=0;
 fifo_full=0;
 laf_state=0;

for (i = 0; i < payloadlen; i = i + 1)
begin
@ (negedge clk);
lfd_state = 0;
ld_state = 1;

payload_data = {$random} % 256;
data_in = payload_data;
parity = parity ^ data_in;

end

@ (negedge clk);
pkt_valid = 0;
data_in = parity;

@ (negedge clk);
ld_state = 0;
end
endtask


task secondpacket;
reg [7:0] header, payload_data, parity;
reg [5:0] payloadlen;
begin

@ (negedge clk);
payloadlen = 5;
detect_addr = 1;
pkt_valid = 1;

header = {payloadlen, 2'b10};
parity = 0 ^ header;
data_in = header;



@ (negedge clk);
detect_addr = 0;
lfd_state = 1;
 full_state=0;
 fifo_full=0;
 laf_state=0;

for (i = 0; i < payloadlen; i = i + 1)
begin
@ (negedge clk);
lfd_state = 0;
ld_state = 1;

payload_data = {$random} % 256;
data_in = payload_data;
parity = parity ^ data_in;

end

@ (negedge clk);
pkt_valid = 0;
data_in = 46;

@ (negedge clk);
ld_state = 0;
end
endtask


initial
	begin
		rst;
		initialize;
		firstpacket;
		rst;
		secondpacket;
		#20
		$finish;
	end
	
endmodule 

