class mod_rd_mon; 
	virtual mod_if.rd_mon rd_mon_if;
	mod_trans data2sb; 
	mod_trans sb; 
	mailbox #(mod_trans) rm2sb;  
	function new (virtual mod_if.rd_mon rd_mon_if, mailbox #(mod_trans) rm2sb); 
		this.rd_mon_if = rd_mon_if; 
		this.rm2sb = rm2sb;
		data2sb = new();  
	endfunction 

	virtual task monitor(); 
		@(rd_mon_if.rd_mon_cb); 
			data2sb.data_out = rd_mon_if.rd_mon_cb.data_out; 
	endtask 

	virtual task start(); 
		fork		
		begin	
			forever 
				begin 
					monitor(); 
					sb = new data2sb;
					rm2sb.put(sb); 
				end
		end	
		join_none
	endtask 
endclass 

