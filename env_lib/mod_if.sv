interface mod_if(input bit clock); 
	logic rst; 
	logic load; 
	logic mode;
	logic [3:0] data_in; 
	logic [3:0] data_out; 
	
	clocking wr_drv_cb@(posedge clock); 
		default input #1 output #1; 
		output rst; 
		output load; 
		output mode; 
		output data_in; 
	endclocking 


	clocking wr_mon_cb@(posedge clock); 
		default input #1 output #1;
		input rst; 
		input load;
		input mode;
		input data_in;
	endclocking

	clocking rd_mon_cb@(posedge clock);
		default input #1 output #1;
		input data_out; 
	endclocking

	modport wr_drv (clocking wr_drv_cb); 
	modport wr_mon (clocking wr_mon_cb); 
	modport rd_mon (clocking rd_mon_cb);

endinterface 
