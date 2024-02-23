module mem_mod(d_out1,d_in1,addr_in1,write1,d_out2,d_in2,addr_in2,write2);
  parameter width = 8, prop = 15, depth = 32;
  output[31:0] d_out1;
  input[31:0] d_in1;
  input[depth-1:0] addr_in1;
  input write1;
  output[31:0] d_out2;
  input[31:0] d_in2;
  input[depth-1:0] addr_in2;
  input write2;
  reg[width-1:0] mem[0:10000000];
  reg [31:0] d_out1;
  reg [31:0] d_out2;  
  reg [31:0] check_data; 
initial
  begin
 	$readmemh("v.out",mem); 
  end


always@(d_in1 or addr_in1 or write1 or d_in2 or addr_in2 or write2  )
     begin
	#(10)
	if(!write1 && !write2)
	begin

	  #(prop-10) 
		  
		   d_out1[31:24] = mem[addr_in1];
	  	   d_out1[23:16] = mem[addr_in1+1];
		   d_out1[15:8] = mem[addr_in1+2];
		   d_out1[7:0] = mem[addr_in1+3];
	  	   d_out2[31:24] = mem[addr_in2];
		   d_out2[23:16] = mem[addr_in2+1];
		   d_out2[15:8] = mem[addr_in2+2];
		   d_out2[7:0] = mem[addr_in2+3];
	  	 
	end

	if(!write1 && write2)
	begin
	  #(prop-10)
		 
		  d_out1[31:24] = mem[addr_in1];
		  d_out1[23:16] = mem[addr_in1+1];
		  d_out1[15:8] = mem[addr_in1+2];
		  d_out1[7:0] = mem[addr_in1+3];
		  mem[addr_in2] = d_in2[31:24];
		  mem[addr_in2+1] = d_in2[23:16];
                  mem[addr_in2+2] = d_in2[15:8];
 		  mem[addr_in2+3] = d_in2[7:0];
	end
	
	if(write1 && !write2)
	   begin
	    #(prop-10)
		    mem[addr_in1] = d_in1[31:24];
		    mem[addr_in1+1] = d_in1[23:16];
                    mem[addr_in1+2] = d_in1[15:8];
 		    mem[addr_in1+3] = d_in1[7:0];
		    d_out2[31:24] = mem[addr_in2];
		    d_out2[23:16] = mem[addr_in2+1];
		    d_out2[15:8] = mem[addr_in2+2];
		    d_out2[7:0] = mem[addr_in2+3];
	   end
	if(write1 && write2)
	   begin
		#(prop-10)
	                mem[addr_in1] = d_in1[31:24];
		    	mem[addr_in1+1] = d_in1[23:16];
                        mem[addr_in1+2] = d_in1[15:8];
 		        mem[addr_in1+3] = d_in1[7:0];
		        mem[addr_in2] = d_in2[31:24];
		        mem[addr_in2+1] = d_in2[23:16];
                        mem[addr_in2+2] = d_in2[15:8];
 		        mem[addr_in2+3] = d_in2[7:0];
	   end
     end

endmodule
