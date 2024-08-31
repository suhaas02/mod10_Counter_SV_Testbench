class mod_trans; 
	rand bit rst;	
	rand bit mode;
	rand bit load;
	rand bit [3:0] data_in;	
	logic [3:0] data_out; 

//	static int no_of_rst_trans;
/*	static int no_of_mode_trans;
	static int no_of_load_trans; 
*/
	static int transaction_id;

	constraint c1 {rst dist {0:=300, 1:=10};}
	constraint c2 {mode dist {0:=50,1:=50};}
	constraint c3 {load dist {0:=100, 1:=10};};
	constraint c4 {data_in inside {[0:9]};}

	function void post_randomize(); 
		this.display("\tRANDOMIZED DATA");
	endfunction 

virtual function void display(input string message);
     
 $display("=============================================================");
      $display("%s",message);
      if(message=="\tRANDOMIZED DATA")
         begin
            $display("\t_______________________________");
            $display("\tTransaction No. %d",transaction_id);
            $display("\t_______________________________");
         end
      $display("\trst = %d, load=%d, mode=%d",rst, load,mode);
      //$display("\tRead_Address=%d, Write_Address=%d",rd_address, wr_address);
      $display("\tData=%d",data_in);
      $display("\tData_out= %d",data_out);
      $display("=============================================================");
   endfunction: display

endclass

	
