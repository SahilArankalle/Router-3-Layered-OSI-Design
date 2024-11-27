module router_fifo_design_tb();

  reg clk;
  reg resetn;
  reg write_enb;
  reg soft_reset;
  reg read_enb;
  reg [7:0] data_in;
  reg lfd_state;
  wire empty;
  wire full;
  wire [7:0] data_out;

  parameter period = 10;

  integer i;

  router_fifo_design DUT(clk, resetn, write_enb, soft_reset, read_enb, data_in, lfd_state, empty, full, data_out);

  initial 
  begin
    clk = 1'b0;
    forever #(period / 2) clk = ~clk;
  end

  task rst();
  begin
      @(negedge clk)
      resetn = 1'b0;
      @(negedge clk)
      resetn = 1'b1;
  end
  endtask

  task soft_rst();
  begin
      @(negedge clk)
      soft_reset = 1'b1;
      @(negedge clk)
      soft_reset = 1'b0;
  end
  endtask

  task initialize();
  begin
      write_enb = 1'b0;
      soft_reset = 1'b0;
      read_enb = 1'b0;
      data_in = 8'b0;
      lfd_state = 1'b0;
  end
  endtask

  task write;
    reg [7:0] payload_data, header, parity;
    reg [5:0] payload_len;
    reg [1:0] addr;
  begin
      @(negedge clk);
      payload_len = 6'd14;
      addr = 2'b01;
      header = {payload_len, addr};
      data_in = header;
      lfd_state = 1'b1;
      write_enb = 1;
      for (i = 0; i < payload_len; i = i + 1) 
      begin
        @(negedge clk);
        lfd_state = 1'b0;
        payload_data = {$random} % 256;
        data_in = payload_data;
      end
      @(negedge clk);
      parity = {$random} % 256;
      data_in = parity;
  end
  endtask

  initial 
  begin
    rst();
    soft_rst();
    write();
    repeat (2) @(negedge clk);
    read_enb = 1;
    write_enb = 0;
    @(negedge clk)
    wait(empty)
    @(negedge clk)
    read_enb = 0;
    #100 $finish;
  end

endmodule
