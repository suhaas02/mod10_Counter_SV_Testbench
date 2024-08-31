class mod_env; 
	virtual mod_if.wr_drv wr_drv_if;
	virtual mod_if.wr_mon wr_mon_if; 
	virtual mod_if.rd_mon rd_mon_if; 
	
	mailbox #(mod_trans) gen2wr = new(); 
	mailbox #(mod_trans) wrmon2rm = new();
	mailbox #(mod_trans) rm2sb = new(); 
	mailbox #(mod_trans) rdmon2sb = new(); 
	
	mod_gen gen_h; 
	mod_wr_drv wr_drv_h; 
	mod_wr_mon wr_mon_h; 
	mod_rd_mon rd_mon_h; 
	mod_model model_h; 
	mod_sb sb_h;
 
	//mod_if if_h; 

	function new(virtual mod_if.wr_drv wr_drv_if,
		     virtual mod_if.wr_mon wr_mon_if, 
	             virtual mod_if.rd_mon rd_mon_if); 
		this.wr_drv_if = wr_drv_if; 	
		this.wr_mon_if = wr_mon_if; 	
		this.rd_mon_if = rd_mon_if; 
	endfunction 

	virtual task build; 
		gen_h = new(gen2wr); 
		wr_drv_h = new(wr_drv_if, gen2wr); 
		wr_mon_h = new(wr_mon_if,wrmon2rm); 
		rd_mon_h = new(rd_mon_if, rdmon2sb); 
		model_h = new(rm2sb, wrmon2rm); 		
		sb_h = new(rm2sb, rdmon2sb); 

		  
	endtask 

	
	virtual task reset_dut(); 
		//wr_drv_if.wr_drv_cb.rst <= 0; 
		//wr_drv_if.wr_drv_cb.load <= 0; 
		//wr_drv_if.wr_drv_cb.mode <= 0;
		//wr_drv_if.wr_drv_cb.data_in <= 0;

		@(wr_drv_if.wr_drv_cb);
			wr_drv_if.wr_drv_cb.rst <= 1; 
		repeat(2) @(wr_drv_if.wr_drv_cb);
			wr_drv_if.wr_drv_cb.rst <= 0; 
	endtask 

	
	virtual task start(); 
		gen_h.start(); 
		wr_drv_h.start();
		wr_mon_h.start();  
		rd_mon_h.start();
		model_h.start(); 
		sb_h.start(); 
	endtask 
	
	virtual task stop(); 
		wait(sb_h.done.triggered); 
	endtask 

	virtual task run(); 
		reset_dut(); 
		start(); 
		stop(); 
		sb_h.report(); 
	endtask 
endclass	
			
