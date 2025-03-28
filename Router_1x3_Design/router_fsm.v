module router_fsm (
    input clk,
    input resetn,
    input pkt_valid,
    input parity_done,
    input [1:0] data_in,
    input soft_reset_0,
    input soft_reset_1,
    input soft_reset_2,
    input fifo_full,
    input low_pkt_valid,
    input fifo_empty_0,
    input fifo_empty_1,
    input fifo_empty_2,
    output busy,
    output detect_addr,
    output ld_state,
    output laf_state,
    output full_state,
    output write_enb_reg,
    output rst_int_reg,
    output lfd_state
);

parameter DECODE_ADDRESS    = 3'b000,
          LOAD_FIRST_DATA   = 3'b001,
          WAIT_TILL_EMPTY   = 3'b010,
          LOAD_DATA         = 3'b011,
          LOAD_PARITY       = 3'b100,
          FIFO_FULL_STATE   = 3'b101,
          LOAD_AFTER_FULL   = 3'b110,
          CHECK_PARITY_ERROR = 3'b111;

reg [2:0] present_state;
reg [2:0] next_state;

always @(posedge clk) begin
    if (!resetn)
        present_state <= DECODE_ADDRESS;
    else if (soft_reset_0 || soft_reset_1 || soft_reset_2)
        present_state <= DECODE_ADDRESS;
    else
        present_state <= next_state;
end

always @(*) begin
    next_state <= DECODE_ADDRESS;
    case (present_state)
        DECODE_ADDRESS: begin
            if ((pkt_valid && (data_in[1:0] == 0) && fifo_empty_0) ||
                (pkt_valid && (data_in[1:0] == 1) && fifo_empty_1) ||
                (pkt_valid && (data_in[1:0] == 2) && fifo_empty_2))
                next_state <= LOAD_FIRST_DATA;
            else if ((pkt_valid && (data_in[1:0] == 0) && !fifo_empty_0) ||
                     (pkt_valid && (data_in[1:0] == 1) && !fifo_empty_1) ||
                     (pkt_valid && (data_in[1:0] == 2) && !fifo_empty_2))
                next_state <= WAIT_TILL_EMPTY;
            else
                next_state <= DECODE_ADDRESS;
        end
        LOAD_FIRST_DATA: next_state <= LOAD_DATA;
        WAIT_TILL_EMPTY: begin
            if (fifo_empty_0 || fifo_empty_1 || fifo_empty_2)
                next_state <= LOAD_FIRST_DATA;
            else
                next_state <= WAIT_TILL_EMPTY;
        end
        LOAD_DATA: begin
            if (fifo_full)
                next_state <= FIFO_FULL_STATE;
            else if (!fifo_full && !pkt_valid)
                next_state <= LOAD_PARITY;
            else
                next_state <= LOAD_DATA;
        end
        LOAD_PARITY: next_state <= CHECK_PARITY_ERROR;
        FIFO_FULL_STATE: begin
            if (!fifo_full)
                next_state <= LOAD_AFTER_FULL;
            else
                next_state <= FIFO_FULL_STATE;
        end
        LOAD_AFTER_FULL: begin
            if ((!parity_done) && (!low_pkt_valid))
                next_state <= LOAD_DATA;
            else if ((!parity_done) && (low_pkt_valid))
                next_state <= LOAD_PARITY;
            else if (parity_done)
                next_state <= DECODE_ADDRESS;
        end
        CHECK_PARITY_ERROR: begin
            if (!fifo_full)
                next_state <= DECODE_ADDRESS;
            else
                next_state <= FIFO_FULL_STATE;
        end
    endcase
end

assign detect_addr = (present_state == DECODE_ADDRESS) ? 1 : 0;
assign lfd_state = (present_state == LOAD_FIRST_DATA) ? 1 : 0;
assign ld_state = (present_state == LOAD_DATA) ? 1 : 0;
assign laf_state = (present_state == LOAD_AFTER_FULL) ? 1 : 0;
assign full_stage = (present_state == FIFO_FULL_STATE) ? 1 : 0;
assign write_enb_reg = ((present_state == LOAD_DATA || present_state == LOAD_PARITY || present_state == LOAD_AFTER_FULL) ? 1 : 0);
assign rst_int_reg = (present_state == CHECK_PARITY_ERROR) ? 1 : 0;
assign busy = ((present_state == FIFO_FULL_STATE || present_state == LOAD_AFTER_FULL || present_state == WAIT_TILL_EMPTY || 
               present_state == LOAD_FIRST_DATA || present_state == LOAD_PARITY || present_state == CHECK_PARITY_ERROR) ? 1 : 0);

endmodule
