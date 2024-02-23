module vespa;

/**************************************************************
    This is the top level module for the VeSPA processor.
    This module has the following instantiations

   1. stage1
   2. stage2
   3. stage3
   4. stage4
   5. stage5    
   6. Memory module
   7. Register file
   8. Hazard detection  logic

****************************************************************/
	
parameter  gate_delay = 3;	

// Defining some internal wire connections
	
	
	wire[31:0] ir1, IR2, IR3, IR4, IR5;
	wire[31:0] PC2, PC3, PC4;
	wire[31:0] X3, Y3;
	wire[31:0] Z4, Z5;
	wire[31:0] MD3, MD4;
	wire[31:0] pcout; 
	wire       mp1,clk,cond_bit,COND4,WR,BR4,JMP4,reg_write,cln_n,wire1;
	wire       C,Z,N,V; 
	wire[31:0] R1, R2, R3;
	wire[4:0]  a1, a2, a3;
	wire[31:0] ADDR_IN2, D_IN2, D_OUT2, D_IN1;
	wire hlt5_found;

	// Some registers
	reg write1,clr;


// Instantiation of stage1
stage1 stg1(IR2,PC2,pcout,ir1,Z4,mp1,clk,clr,pause1,pause2,nop2);

// Instantiation of stage 2
stage2 stg2(IR2, PC2, clk, C, Z, N, V, R1, R2, Z5, clr, nop3, pause3, c5a, c6a, c7,  a1, a2, IR3, PC3, X3, Y3, MD3,cond_bit,COND2);

// Insantiation of stage 3
stage3 stg3(cond_bit,clk,IR3,PC3,X3,Y3,MD3,clr,C,Z,N,V,IR4,PC4,Z4,MD4,COND4,Z5,aluxpc4sel,aluxz4sel,aluxz5sel,aluyz4sel,aluypc4sel,aluyz5sel,md4z4sel,md4pc4sel,md4z5sel,nop4);

// Instantiation of stage 4
stage4 stg4(IR5,Z5,WR,BR4,JMP4,ADDR_IN2,D_IN2,clk,clr,IR4,PC4,Z4,MD4,D_OUT2,c11);

// Instantiation of stage 5
stage5 stg5(IR5, Z5, R3, a3, reg_write,hlt5_found,clk,clr);

// Global Hazard detection module
hazard hzdetect(IR2, IR3, IR4, IR5, COND2, cond_bit, COND4,pause3,pause2,pause1,nop4,nop3,nop2,c5a,c6a,c7,aluxz4sel,aluxpc4sel,aluxz5sel,aluyz4sel, aluypc4sel,aluyz5sel,md4z4sel,md4pc4sel,md4z5sel,c11);

// Instantiate the register module
reg_file #(32,8) regfile(a1,a2,a3,R1,R2,R3,clk,reg_write);

//Instantiate Memory Module
mem_mod global_mem(ir1,D_IN1,pcout,write1,D_OUT2,D_IN2,ADDR_IN2,WR);

// Instantiate Oscillator
oscillator osc(clk,clk_n);



// GLOBAL LOGIC to set MP1
and #(gate_delay) (wire1,BR4,COND4);
nor #(gate_delay) (mp1,wire1,JMP4);

// This is to initialize the processor in the reset state
initial
   begin
	clr = 1;
	write1=0;
	#1 clr <= 0;
	
   end

// If there is a halt instruction in stage 5 stop the simulation
always
  @(negedge clk)
    begin
	if(hlt5_found)
	   begin
		$stop;
		$finish;		
           end
    end 

endmodule







