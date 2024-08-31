
class mod_trans_extnd1 extends mod_trans;
      constraint dout {data_in inside {0,2,3,4};}
	//constraint 

endclass 

   //extend the ram trans if required to cover all the bins

class mod_base_test;

   //Instantiate virtual interface with Write Driver modport,
   //Read Driver modport, Write monitor modport, Read monitor modport
   virtual mod_if.rd_mon rd_mon_if;
   virtual mod_if.wr_drv wr_drv_if; 
   //virtual mod_if.rd_mon RD_MON_MP rd_mon_if; 
   virtual mod_if.wr_mon wr_mon_if;
   
   // Declare a handle for ram_env 
   mod_env env_h;
     
  
	function new(virtual mod_if.rd_mon rd_mon_if,
   		     virtual mod_if.wr_drv wr_drv_if,
		     virtual mod_if.wr_mon wr_mon_if);
		this.rd_mon_if = rd_mon_if; 
		this.wr_drv_if = wr_drv_if;
		this.wr_mon_if = wr_mon_if; 
		
		env_h = new(wr_drv_if, wr_mon_if, rd_mon_if);
	endfunction 

   //Understand and include the virtual task build 
   //which builds the TB environment
   virtual task build();
      env_h.build();
   endtask: build
   
   //Understand and include the virtual task run 
   //which runs the simulation for different testcases
   virtual task run();              
      env_h.run();
   endtask: run   
   
endclass: mod_base_test

class mod_test_extnd1 extends mod_base_test;
      
   //Declare a handle for ram_trans_extnd1
   mod_trans_extnd1 data_h1;
   
   //In constructor
   //pass the Driver interface and monitor interface as arguments
   //create an object for env_h and pass the virtual interfaces 
   //as arguments in new() function
   function new(virtual mod_if.rd_mon rd_mon_if,
   		     virtual mod_if.wr_drv wr_drv_if,
		     virtual mod_if.wr_mon wr_mon_if);
      super.new(rd_mon_if, wr_drv_if, wr_mon_if);      
   endfunction: new

   //Understand and include the virtual task build 
   //which builds the TB environment
   virtual task build();
      super.build();
   endtask: build
   
   //Understand and include the virtual task run 
   //which runs the simulation for different testcases
   virtual task run();  
      data_h1 = new();
      env_h.gen_h.gen_trans = data_h1;
      super.run();
   endtask: run      
   
endclass: mod_test_extnd1


