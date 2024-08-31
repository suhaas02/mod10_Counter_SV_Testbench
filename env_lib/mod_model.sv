class mod_model;
	mailbox #(mod_trans) rm2sb; 
	mailbox #(mod_trans) wrmon2rm; 
	mod_trans mon_data1; 
//	mod_trans rm_data; 
	function new(mailbox #(mod_trans) rm2sb, mailbox #(mod_trans) wrmon2rm);
		this.rm2sb = rm2sb; 
		this.wrmon2rm = wrmon2rm; 
	//	rm_data = new();
	endfunction 

	static bit[3:0] count; 
	virtual task mod_10(mod_trans mon_data1);
		if(mon_data1.rst)
			count <= 0; 
		else if(mon_data1.load)
			count <= mon_data1.data_in; 
		else if(mon_data1.mode) 
			begin 
				if(count == 9)
					count <= 0; 
				else 
					count <= count + 1; 
			end 
		else 
			begin 
				if(count == 0)
					count <= 9; 
				else 
					count <= count - 1; 
			end 
	endtask 
	
	virtual task start();	
		fork 
		forever
			begin 
				wrmon2rm.get(mon_data1); 
				mod_10(mon_data1); 
				mon_data1.data_out = count; 
				rm2sb.put(mon_data1); 	
			end 
		join_none
	endtask 
endclass
		
