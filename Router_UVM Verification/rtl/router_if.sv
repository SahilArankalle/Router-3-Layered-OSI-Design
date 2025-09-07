interface router_if(input bit clock);
	
	logic [7:0] data_in;
	logic [7:0] data_out;
	logic rstn;
	logic error;
	logic busy;
	logic read_enb;
	logic vld_out;
	logic pkt_vld;
	
	clocking wr_drv_cb @(posedge clock);
		default input #1 output #1;
		output data_in;
		output pkt_vld;
		output rstn;
		input  error;
		input  busy;
	endclocking: wr_drv_cb
	
	clocking rd_drv_cb @(posedge clock);
		default input #1 output #1;
		output read_enb;
		input  vld_out;
	endclocking: rd_drv_cb
	
	modport WR_DRV_MP (clocking wr_drv_cb);
	modport RD_DRV_MP (clocking rd_drv_cb);
	
	clocking wr_mon_cb @(posedge clock);
		default input #1 output #1;
		input data_in;
		input pkt_vld;
		input rstn;
		input error;
		input busy;
	endclocking: wr_mon_cb
	
	clocking rd_mon_cb @(posedge clock);
		default input #1 output #1;
		input data_out;
		input read_enb;
	endclocking: rd_mon_cb
	
	modport WR_MON_MP (clocking wr_mon_cb);
	modport RD_MON_MP (clocking rd_mon_cb);

endinterface: router_if