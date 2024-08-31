module mod10_counter(clock, rst, mode, load, data_in, data_out);
input clock; 
input rst;
		     input mode;
		     input load;
    	 	     input [3:0] data_in;
		     output reg [3:0]data_out;

	always@(posedge clock)
		begin 
			if(rst)
				data_out <= 0;
			else if(load == 1)
				data_out <= data_in;
			else if(mode)
				begin 
					if(data_out == 9)
						data_out <= 0; 
					else 
						data_out <= data_out + 1; 
				end
			else
				begin 
					if(data_out == 0)
						data_out <= 9; 
					else 
						data_out <= data_out - 1; 
				end
		end


endmodule 
