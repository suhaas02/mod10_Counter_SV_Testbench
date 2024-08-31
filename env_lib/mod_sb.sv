class mod_sb; 
	event done; 
	static int data_verified = 0; 
	//int transactions_in_Score_Board = 0; 
	//int up_count = 0; 
	//int down_count = 0; 
	mailbox #(mod_trans) rm2sb; 
	mailbox #(mod_trans) rdmon2sb; 
	mod_trans rm_data; 
	mod_trans rd_data;
	mod_trans cov_data; 
	
 covergroup mem_coverage;
      option.per_instance=1;     

		DATA_IN : coverpoint cov_data.data_in {
					illegal_bins ILLB = {[10:15]};}
		LOAD : coverpoint cov_data.load; 
		MODE : coverpoint cov_data.mode;
		RESET : coverpoint cov_data.rst{
					bins ONE_reset = {1};}
		DATA_OUT : coverpoint cov_data.data_out {
					bins data[] = {[0:9]};
					illegal_bins ILLB2={[10:15]};}
		DATA_OUTxMODExLOAD: cross DATA_OUT,MODE,LOAD;
   
   endgroup : mem_coverage

	function new(mailbox #(mod_trans) rm2sb, mailbox #(mod_trans) rdmon2sb); 
		this.rm2sb = rm2sb; 
		this.rdmon2sb = rdmon2sb; 
		mem_coverage = new;
	endfunction

	virtual task check(mod_trans rm_data, mod_trans rd_data); 
			
			if(rm_data.data_out == rd_data.data_out)
			
				$display("Count matches");
			else
				$display("count mismatches"); 
			
			cov_data = new rm_data;
           		 //Call the sample function on the covergroup 
           		 mem_coverage.sample();

			data_verified++;
			$display("%d, %d", data_verified, number_of_transactions);  
			if(data_verified >= number_of_transactions)
			begin
				->done; 
 			end
	endtask 


	virtual task start(); 
		fork
		begin
		forever 
			begin
				rm2sb.get(rm_data); 
				rdmon2sb.get(rd_data); 
				check(rm_data, rd_data); 			
			end
		end 
		join_none
	endtask 

	
	virtual function void report(); 
		$display("--------------------------------------SCOREBOARD REPORT----------------------------------"); 
		$display("data_verified : %d", data_verified); 
	endfunction 
endclass 
