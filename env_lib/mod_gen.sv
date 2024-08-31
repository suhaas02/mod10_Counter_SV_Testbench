class mod_gen; 

	mod_trans gen_trans, data2send; 
	mailbox #(mod_trans) gen2wr; 
	
	function new(mailbox #(mod_trans) gen2wr); 
		this.gen2wr = gen2wr; 
		gen_trans = new(); 
	endfunction 

	virtual task start(); 
		fork
		begin 
			for(int i = 0; i < number_of_transactions; i++)
				begin
				 
					gen_trans.transaction_id++; 
					assert(gen_trans.randomize());
					data2send = new gen_trans;
					gen2wr.put(data2send);
				end
		end
		join_none
	endtask 
endclass
