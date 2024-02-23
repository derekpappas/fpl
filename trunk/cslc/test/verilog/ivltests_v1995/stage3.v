
module stage3(cond_bit,clk,IR3,PC3,X3,Y3,MD3,clr,C,Z,N,V,IR4,PC4,Z4,MD4,cond_bit4,Z5,aluxpc4sel,aluxz4sel,aluxz5sel,aluyz4sel,aluypc4sel,aluyz5sel,md4z4sel,md4pc4sel,md4z5sel,nop4);

  parameter width = 32;
  input [width-1:0] IR3;
  input [width-1:0] PC3,X3,Y3,MD3;
  input clk;
  input clr;
  input cond_bit;
  input[31:0] Z5;
  input aluxpc4sel,aluxz4sel,aluxz5sel,aluyz4sel,aluypc4sel,aluyz5sel,md4z4sel,md4pc4sel,md4z5sel,nop4;

  output C,Z,N,V;
  output [width-1:0] IR4;
  output [width-1:0] PC4,MD4; 
  output [width-1:0] Z4;
  output cond_bit4; 

  wire [width:0] ALU_OUT;
  wire [width-1:0] A_IN,B_IN; 
  wire F_ADD,F_SUB,F_AND,F_OR,F_NOT,F_XOR,F_CMP,F_BR,F_JMP,F_JMPL,F_LD,F_LDI,F_LDX,F_ST,F_STX,F_HLT,F_NOP,c_q,z_q,n_q,v_q,c_d,z_d,n_d,v_d;
  wire add_sub_cmp;
  wire clk_or3;
  wire [31:0] xpc4z4out, ypc4z4out, md4_tmp,alux_in,aluy_in,md4_in,nop4_out,ir4_in;

  `define OP3 IR3[31:27]
  `define RDST3 IR3[26:22]
  `define IR316 IR3[16]

  
  assign A_IN = X3;
  assign B_IN = Y3;

// MODULE INSTANTIATIONS

// OPCODE DECODER
// uses opdec_alu.v file  
opdec my_decode(IR3[31:27],F_NOP,F_ADD,F_SUB,F_OR,F_AND,F_NOT,F_XOR,F_CMP,F_BR,F_JMP,F_LD,F_LDI,F_LDX,F_ST,F_STX,F_HLT, ,);
  
// THE ALU
alu my_alu(ALU_OUT,alux_in,aluy_in,F_ADD,F_SUB,F_AND,F_OR,F_NOT,F_XOR,F_CMP,F_BR,F_JMP,F_LD,F_LDI,F_LDX,F_ST,F_STX,IR3[16]);
  
// SETCC MODULE
setcc my_setcc(A_IN,B_IN,ALU_OUT,F_ADD,F_SUB,F_CMP,c_d,z_d,n_d,v_d);  
  
// 2 ip mux for tmp use
mux2 #(32,6) selxpc4z4(aluxpc4sel,xpc4z4out,Z4,PC4);
mux2 #(32,6) selypc4z4(aluypc4sel,ypc4z4out,Z4,PC4);
mux2 #(32,6) selmd4(md4pc4sel,md4_tmp,Z4,PC4);

// some logic for c8a, c10a, c9a
wire c8a,c10a,c9a;

or #(3) (c8a, aluxpc4sel,aluxz4sel);
or #(3) (c9a, aluyz4sel,aluypc4sel);
or #(3) (c10a, md4z4sel,md4pc4sel);

// 4ip mux for alux
mux4 #(32,6) aluxsel(aluxz5sel,c8a,alux_in,X3,Z5,xpc4z4out,xpc4z4out);
//4 ip for aluy
mux4 #(32,6) aluysel(aluyz5sel,c9a,aluy_in,Y3,Z5,ypc4z4out,ypc4z4out);
// 4 ip mux for MD4
mux4 #(32,6) md4sel(md4z5sel,c10a,md4_in,MD3,Z5,md4_tmp,md4_tmp);

// NOP REGISTER
d_reg #(32,8) nop4_reg(clk,nop4_out,0,clr);

// 2ip mux for selecting IR 4 value
mux2 #(32,6) ir4_mux(nop4,ir4_in,IR3,nop4_out);

// 32bit Z4 Register
//parameters are width,prop
d_reg #(32,8) Z4_reg32(clk,Z4,ALU_OUT[31:0],clr);
  
// 32 bit registers
d_reg #(32,8) MD4_reg32(clk,MD4,md4_in,clr);
d_reg #(32,8) PC4_reg32(clk,PC4,PC3,clr);
d_reg #(32,8) IR4_reg32(clk,IR4,ir4_in,clr);
  
// The C, Z, N, V Registers
d_reg #(1,8) C_dreg(clk_or3,C,c_d,clr);
d_reg #(1,8) Z_dreg(clk_or3,Z,z_d,clr);
d_reg #(1,8) N_dreg(clk_or3,N,n_d,clr);
d_reg #(1,8) V_dreg(clk_or3,V,v_d,clr);
// passes condition code bit
d_reg #(1,8) condreg3(clk,cond_bit4,cond_bit,clr);  

// combinational logic to clk C, Z , N , V registers on add, sub and cmp instructions
or #(3) or_addsubcmp(add_sub_cmp, F_ADD, F_SUB, F_CMP);
and #(3) and_or3_clr(clk_or3, add_sub_cmp, clk);


endmodule







 






  








