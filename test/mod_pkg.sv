package mod_pkg; 
	int number_of_transactions = 1; 	
	`include "mod_trans.sv"
	`include "mod_gen.sv"
	`include "mod_wr_drv.sv"
	`include "mod_wr_mon.sv"
	`include "mod_rd_mon.sv"
	`include "mod_model.sv"
	`include "mod_sb.sv"
	`include "mod_env.sv"
	`include "test.sv"
endpackage 
