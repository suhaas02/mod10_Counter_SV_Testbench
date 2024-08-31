class mod_wr_mon; 
	virtual mod_if.wr_mon wr_mon_if; 
	mod_trans wrdata, data2rm; 
	mailbox #(mod_trans) wr2rm; 
	function new(virtual mod_if.wr_mon wr_mon_if, mailbox #(mod_trans) wr2rm); 
		this.wr_mon_if = wr_mon_if; 
		this.wr2rm = wr2rm; 
		wrdata = new(); 
	endfunction 

	virtual task monitor(); 
		@(wr_mon_if.wr_mon_cb);
		begin 
			wrdata.rst = wr_mon_if.wr_mon_cb.rst; 
			wrdata.load = wr_mon_if.wr_mon_cb.load; 
			wrdata.mode = wr_mon_if.wr_mon_cb.mode; 
			wrdata.data_in = wr_mon_if.wr_mon_cb.data_in; 
			wrdata.display("Data from write monitor");
		end 
	endtask 

	virtual task start();
		fork
		begin 
			forever 
				begin 
				monitor();
				data2rm = new wrdata;
				wr2rm.put(data2rm);  
				end
		end
		join_none
	endtask 
endclass 

	
	                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
