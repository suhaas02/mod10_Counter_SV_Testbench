//`include "test.sv"
module top(); 
import mod_pkg::*;

	reg clock; 
	mod_if DUV_IF(clock); 
	mod_base_test base_test_h;
	 mod_test_extnd1  ext_test_h1;
	mod10_counter DUV(.clock (clock),
			.rst  (DUV_IF.rst),
			.mode (DUV_IF.mode),
			.load (DUV_IF.load),
			.data_in (DUV_IF.data_in),
			.data_out (DUV_IF.data_out)); 

	
	initial 
		begin 
			clock = 1'b0; 
			forever #5 clock = ~clock; 
		end 
  
   initial
      begin
	 
	`ifdef VCS
         $fsdbDumpvars(0, top);
        `endif

	//Create the objects for different testcases and pass the interface instances as arguments
         //Call the virtual task build and virtual task run       
         if($test$plusargs("TEST1"))
            begin
               base_test_h = new(DUV_IF, DUV_IF, DUV_IF);
               number_of_transactions = 500;
               base_test_h.build();
               base_test_h.run();
               $finish;
            end

         if($test$plusargs("TEST2"))
            begin
               ext_test_h1 = new(DUV_IF, DUV_IF, DUV_IF);
               number_of_transactions = 500;
               ext_test_h1.build();
               ext_test_h1.run(); 
               $finish;
            end
      end
endmodule 
