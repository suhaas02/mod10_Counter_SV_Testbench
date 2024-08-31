class mod_wr_drv; 

	virtual mod_if.wr_drv wr_drv_if; 
	mailbox #(mod_trans) gen2wr; 
	mod_trans data2duv;
	function new(virtual mod_if.wr_drv wr_drv_if, mailbox #(mod_trans) gen2wr); 
		this.wr_drv_if = wr_drv_if; 
		this.gen2wr = gen2wr; 
	endfunction 

	virtual task drive(); 

	   @(wr_drv_if.wr_drv_cb); 
		wr_drv_if.wr_drv_cb.rst <= data2duv.rst; 
		wr_drv_if.wr_drv_cb.load <= data2duv.load; 
		wr_drv_if.wr_drv_cb.data_in <= data2duv.data_in; 
		wr_drv_if.wr_drv_cb.mode <= data2duv.mode; 
	
		repeat(2) @(wr_drv_if.wr_drv_cb);
	endtask 


	virtual task start(); 
		fork
		begin 
			forever
			begin
				gen2wr.get(data2duv); 
				drive(); 
			end
		end
		join_none
		
	endtask 
endclass
