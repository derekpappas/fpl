//Monica
//28 mar 2008
// Verilog code for micro engine with external IM and DM


//opcodes define
`define E_E_OPCODE_READ32REQ 0
`define E_E_OPCODE_WRITE32 1
`define E_E_OPCODE_READ32RESP 2
`define E_E_OPCODE_WRITE64 3
`define E_E_OPCODE_READ64RESP 4
`define E_E_OPCODE_READ32DMAREQ 5
`define E_E_OPCODE_WRITE32DMA 6
`define E_E_OPCODE_READ64DMAREQ 7
`define E_E_OPCODE_WRITE64DMA 8
`define E_E_OPCODE_ADD 9
`define E_E_OPCODE_SUB 10
`define E_E_OPCODE_EQUAL 11
`define E_E_OPCODE_MOVHI 12
`define E_E_OPCODE_MOVI 13
`define E_E_OPCODE_ORI 14
`define E_E_OPCODE_LDW 15
`define E_E_OPCODE_STW 16
`define E_E_OPCODE_BRLT 17
`define E_E_OPCODE_BRGE 18
`define E_E_OPCODE_BRLE 19
`define E_E_OPCODE_BRGT 20
`define E_E_OPCODE_BREQ 21
`define E_E_OPCODE_BRNE 22
`define E_E_OPCODE_BRP 23
`define E_E_OPCODE_BRN 24
`define E_E_OPCODE_BRNN 25
`define E_E_OPCODE_BRZ 26
`define E_E_OPCODE_BRNZ 27
`define E_E_OPCODE_BRC 28
`define E_E_OPCODE_BRNC 29
`define E_E_OPCODE_BRV 30
`define E_E_OPCODE_BRNV 31
//enum_define.v
// widths
`define E_E_B_DATA 32
`define E_E_B_ADDR_IM 10
`define E_E_B_ADDR_RF 5
`define E_E_B_STATUS 4
//alu operations code
`define E_OP_SEL_ADD_OP 0
`define E_OP_SEL_SUB_OP 1
`define E_OP_SEL_EQUAL_OP 2
`define E_OP_SEL_ORI_OP 3
`define E_OP_SEL_STW_OP 4
//branch conditions codes
`define E_BR_LT  0
`define E_BR_GE  1
`define E_BR_LE  2
`define E_BR_GT  3
`define E_BR_EQ  4
`define E_BR_NE  5
`define E_BR_P   6
`define E_BR_N   7
`define E_BR_NN  8
`define E_BR_Z   9
`define E_BR_NZ  10
`define E_BR_C   11
`define E_BR_NC  12
`define E_BR_V   13
`define E_BR_NV  14


//****************************************
//adder block for program counter
module adder(op1,
             op2,
             rez);

  input [9:0] op1;
  input [9:0] op2;
  output [9:0] rez;
  assign   rez = op1 + op2;
 // `include "adder.logic.v"
endmodule

//****************************************
//mux for PC
module mux(in0,
           in1,
           sel,
           mux_out);

  input [9:0] in0;
  input [9:0] in1;
  input sel;
  output [9:0] mux_out;
  assign   mux_out = sel ? in1 : in0;
//  `include "mux.logic.v"
endmodule

//***************************************
// register for PC output
module ff_reg(reset_,
              enable,
              clock,
              reg_out,
              reg_in);

  input reset_;
  input enable;
  input clock;
  input [9:0] reg_in;
  output [9:0] reg_out;
  reg [9:0] st_reg;
  assign   reg_out = st_reg;

  always @( posedge clock or negedge reset_ )  begin 
    if ( ~reset_ )  begin 
      st_reg <= 0;
    end
end         
endmodule

//******************************************
//Program Counter
module pc(reset,
          br_cond,
          br_id4,
          bro,
          id_br_addr,
          pc_im_addr_pc1,
          im_rd_en,
          enable,
          clk);

  input reset;
  input br_cond;   //enabled conditional branch
  input br_id4;    //enabled unconditional branch
  input [9:0] bro;  //conditional branch address
  input [9:0] id_br_addr;  //unconditional branch address
  input enable;
  input clk;
  output [9:0] pc_im_addr_pc1;  //read address for IM
  output im_rd_en;              //IM read enable
  wire [9:0] next_pc_0;
  wire [9:0] add_mux_pc_0;
  wire sel1_0;
  wire [9:0] constant_0;
  
  assign   sel1_0 = br_cond & br_id4;  //and gate between br_cond and br_id4
  assign   pc_im_addr_pc1 = next_pc_0; //next pc represent the IM read address
  assign   constant_0 = 10'b0000000001;    //+1  when there is not branch instr
  assign   im_rd_en=1;                 // IM read enable always is set
  
  
  mux mux1(.in0(constant_0),
           .in1(bro),
           .mux_out(adder.op2),
           .sel(sel1_0));
  mux mux2(.in0(add_mux_pc_0),
           .in1(id_br_addr),
           .mux_out(ff.reg_in),
           .sel(br_id4));
  adder adder(.op1(next_pc_0),
              .op2(mux1.mux_out),
              .rez(add_mux_pc_0));
  ff_reg ff(.clock(clk),
            .enable(enable),
            .reg_in(mux2.mux_out),
            .reg_out(next_pc_0),
            .reset_(reset));
 // `include "pc.logic.v"
endmodule


//**********************************************************
//Instruction Memory
module IM(rd0_en,
          rd0_data,
          rd0_address,
          wr0_en,
          wr0_data,
          wr0_address);

  input rd0_en;
  input [9:0] rd0_address;
  input wr0_en;
  input [31:0] wr0_data;
  input [9:0] wr0_address;
  output reg[31:0] rd0_data;   //reg
  
  reg [31:0] im_mem [9:0];
  
  initial 
  $readmemb("load_im.txt",im_mem);
  
  always @* begin
    if(rd0_en)
    rd0_data<=im_mem[rd0_address];
    else
    if(wr0_en)
    im_mem[wr0_address]<=wr0_data;
  end  
  endmodule

//******************************************************
//Instruction Register
module IR(reset_,
          enable,
          clock,
          reg_out,
          reg_in);

  input reset_;
  input enable;
  input clock;
  input [31:0] reg_in;
  output [31:0] reg_out;
  reg [9:0] st_reg;
  assign   reg_out = st_reg;

  always @( posedge clock or negedge reset_ )  begin 
    if ( ~reset_ )  begin 
      st_reg <= 0;
    end
    else if ( enable )  begin 
        st_reg <= reg_in;
      end
  end
  endmodule

//**********************************************************
// Instruction Decoder
module ID(p_clock,
          p_i,
          p_opcode,
          p_bb,
          p_src,
          p_id,
          p_dst,
          p_br_len,
          p_dstreg,
          p_srcreg1,
          p_srcreg2,
          p_immed);

  input p_clock;
  input [31:0] p_i;      //intruction from IR
  output [5:0] p_opcode; //opcode part from instr
  output p_bb;           //burst bit
  output p_src;          //select the type of register(cl/rf)
  output p_id;
  output p_dst;
  output [3:0] p_br_len;  //burst length
  output [4:0] p_dstreg;  //address of destination register
  output [4:0] p_srcreg1; //address of source register 
  output [4:0] p_srcreg2; //address of source register
  output [15:0] p_immed;  //immediate value
  
  //`include "mE_pipeline.csl" 
  //id_logic.v 
 assign   p_opcode=p_i[5:0],     
          p_bb=p_i[12:12],       
          p_src=p_i[11:11],        
          p_id=p_i[10:10],
          p_dst=p_i[9:9],
          p_br_len=p_i[16:13],   
          p_dstreg=p_i[21:17],  
          p_srcreg1=p_i[31:27], 
          p_srcreg2=p_i[26:22], 
          p_immed=p_i[21:6];    
  endmodule


//******************************************
// Register File
module RF_register_file_memory(clock,
                               reset,
                               data_in,
                               data_out0,
                               data_out1,
                               wr_addr,
                               rd_addr0,
                               rd_addr1,
                               wr_en,
                               rd_en0,
                               rd_en1,
                               valid);
  parameter ADDR_WIDTH = 5;
  parameter DATA_WIDTH = 32;
  parameter NUM_WORDS = (1 <<ADDR_WIDTH);
  input clock;
  input reset;
  input [DATA_WIDTH - 1:0] data_in;
  input [ADDR_WIDTH - 1:0] wr_addr;
  input [ADDR_WIDTH - 1:0] rd_addr0, rd_addr1;
  input wr_en;
  input rd_en0,rd_en1;
  output reg [DATA_WIDTH - 1:0] data_out0, data_out1;
  output reg valid;
  reg [DATA_WIDTH - 1:0] internal_memory[0:NUM_WORDS - 1] ;

  always @( posedge clock or negedge reset )  begin 
    if ( ~reset )  begin 
      valid <= 1;
    end
    else  begin 
      valid <= rd_en0;
      if ( rd_en0 )  begin 
        data_out0 <= internal_memory[rd_addr0];
      end
      if ( wr_en )  begin 
        internal_memory[wr_addr] <= data_in;
      end
    end
  end
  endmodule

module RF(reset,
          clear,
          clock,
          wr_addr,
          rd_addr0,
          rd_addr1,
          data_in,
          data_out0,
          data_out1,
          wr_en,
          rd_en0,
          rd_en1,
          valid);
// Location of source csl unit: file name =  line number = 127
  input reset;
  input clear;
  input clock;
  input [4:0] wr_addr;
  input [4:0] rd_addr0;
  input [4:0] rd_addr1;
  input [31:0] data_in;
  input wr_en;
  input rd_en0;
  input rd_en1;
  output [31:0] data_out0;
  output [31:0] data_out1;
  output valid;
  RF_register_file_memory register_file_memory_instance(.clock(clock),
                                                        .data_in(data_in),
                                                        .data_out0(data_out0),
                                                        .data_out1(data_out1),
                                                        .rd_addr0(rd_addr0),
                                                        .rd_addr1(rd_addr1),
                                                        .rd_en0(rd_en0),
                                                        .rd_en1(rd_en1),
                                                        .reset(reset),
                                                        .valid(valid),
                                                        .wr_addr(wr_addr),
                                                        .wr_en(wr_en));
  endmodule

//***********************************************************
// Mux for ALU input and RF input
module mux_(in0,
            in1,
            sel,
            mux_out);

  input [31:0] in0;
  input [31:0] in1;
  input sel;
  output [31:0] mux_out;
  assign   mux_out = sel ? in1 : in0;
  endmodule

//**********************************************************
// Aritmetico Logic Unit
module ALU(op1,
           op2,
           op_sel,
           ci,
           alu_rez,
           co);

  input [31:0] op1;
  input [31:0] op2;
  input [2:0] op_sel;
  input ci;
  output reg [31:0] alu_rez;
  output reg co;
 // `include "mE_pipeline.csl"
 //alu_logic.v
 always @ (op_sel, op1, op2, ci)
  case (op_sel)
    `E_OP_SEL_ADD_OP: {co,alu_rez} = op1 + op2 + ci;      // add
    `E_OP_SEL_SUB_OP: alu_rez = op1 - op2;                // substract
    `E_OP_SEL_EQUAL_OP: alu_rez=(op1 == op2);             //equal
    `E_OP_SEL_ORI_OP: alu_rez=op1 | op2;                 //ori  
    `E_OP_SEL_STW_OP: alu_rez={op1,op2};                //stw
    
default: co=1'b0;
endcase 
  endmodule

//**********************************************
//Data memory (external)
module DM(rd0_en,
          rd0_data,
          rd0_address,
          wr0_en,
          wr0_data,
          wr0_address);

  input rd0_en;
  input [9:0] rd0_address;
  input wr0_en;
  input [31:0] wr0_data;
  input [9:0] wr0_address;
  output reg [31:0] rd0_data;
  
  reg [31:0] dm_mem [9:0];
  
  always @* begin
      if (rd0_en)
      rd0_data<=dm_mem[rd0_address];
      else
      if(wr0_en)
      dm_mem[wr0_address]<= wr0_data;
  end
  endmodule
 
 //*****************************************
 // Status register: CNZV 
  module r_status(reset_,
                enable,
                clock,
                reg_out,
                reg_in);

  input reset_;
  input enable;
  input clock;
  input [3:0] reg_in;
  output [3:0] reg_out;
  reg [9:0] st_reg;
  assign   reg_out = st_reg;

  always @( posedge clock or negedge reset_ )  begin 
    if ( ~reset_ )  begin 
      st_reg <= 0;
    end
    else if ( enable )  begin 
        st_reg <= reg_in;
      end
  end
  
  endmodule


//*************************************************
// Control Conditions Logic  
  module cc_logic(cc_in,
                  id_br_cond,
                  br_cond,
                  nzv);

  input [3:0] cc_in;    //input from status register ={C,N,Z,V}
  input [3:0] id_br_cond; //branch condition from control unit
  output reg br_cond;         //enabled the conditional branch
  output [2:0] nzv;       //N,Z,V bits for status register update
  
  wire c,n,z,v;
  
  assign   c=cc_in[0], n=cc_in[1], z=cc_in[2], v=cc_in[3];
  assign   nzv=cc_in[2:0];
  
    always @* begin
  case (id_br_cond)
      `E_BR_LT : br_cond=((n &(~v)) | ((~n)&v));
      `E_BR_GE : br_cond=((n & v ) | ((~n)&(~v)));
      `E_BR_LE : br_cond=((n &(~v)) | ((~n)&v) | z);
      `E_BR_GT : br_cond=((n & v ) | ((~n)&(~v))&(~z));
      `E_BR_EQ : br_cond=z;
      `E_BR_NE : br_cond=(~z);
      `E_BR_P  : br_cond=(~n) & (~z);
      `E_BR_N  : br_cond=n;
      `E_BR_NN : br_cond=~n;
      `E_BR_Z  : br_cond=z;
      `E_BR_NZ : br_cond=~z;
      `E_BR_C  : br_cond=c;
      `E_BR_NC : br_cond=~c;
      `E_BR_V  : br_cond=v;
      `E_BR_NV : br_cond=~v;
      default  : br_cond=0; 
  endcase
  end
  
  endmodule
  
//*************************************************
//Control unit
module control(p_opcode,
               p_immed,
               p_op_sel,
               p_dst_sel,
               p_rf_wr_en,
               p_rf_rd0_en,
               p_rf_rd1_en,
               p_dm_wr_en,
               p_dm_rd_en,
               p_op1_sel,
               p_id_br_cond,
            
               p_br_id4,
               p_bb,
               p_src,
               p_id,
               p_dst,
               p_br_length);

  input [5:0] p_opcode;
  input [15:0] p_immed;
  output reg[2:0] p_op_sel;
  output p_dst_sel;
  output p_rf_wr_en;
  output p_rf_rd0_en;
  output p_rf_rd1_en;
  output p_dm_wr_en;
  output p_dm_rd_en;
  output p_op1_sel;
  output[3:0] p_id_br_cond;
  output p_br_id4;
  input p_bb;
  input p_src;
  input p_dst;
  input p_id;
  input [3:0] p_br_length; 
  
  reg s_read32req;
  reg s_write32;
  reg s_read32resp;
  reg s_write64;
  reg s_read64resp;
  reg s_read32DMAreq;
  reg s_write32DMA;
  reg s_read64DMAreq;
  reg s_write64DMA;
  reg s_add;
  reg s_sub;
  reg s_equal;
  reg s_movhi;
  reg s_movi;
  reg s_ori;
  reg s_ldw;
  reg s_stw;
  reg s_brlt;
  reg s_brge;
  reg s_brle;
  reg s_brgt;
  reg s_breq;
  reg s_brne;
  reg s_brp;
  reg s_brn;
  reg s_brnn;
  reg s_brz;
  reg s_brnz;
  reg s_brc;
  reg s_brnc;
  reg s_brv;
  reg s_brnv;
  
  wire s_alu;
  wire s_dma;
  wire s_rd_wr;
  wire s_dst_sel;
  wire [15:0] s_immed;
  wire s_not;
  wire [3:0] s_id_br_cond;
  
  assign   s_alu = s_add | s_sub | s_equal;
  assign   s_dma = s_read32DMAreq | s_write32DMA;
  assign   s_rd_wr = s_read32req | s_write32 | s_read32resp | s_write64 | s_read64resp;
  assign   p_dst_sel = s_dma | s_rd_wr | s_ori | s_movhi | s_movi | s_ldw | ~s_alu;
  assign   s_immed = p_immed;
  assign   p_rf_wr_en = s_alu | s_movi | s_ori | s_movhi | s_ldw | s_rd_wr | s_dma;
  assign   p_rf_rd0_en = s_alu | s_read32req | s_dma | s_ori | s_stw;
  assign   p_rf_rd1_en = s_alu | s_ori | s_stw;
  assign   p_dm_rd_en = s_read32req | s_read32resp | s_read64resp | s_read32DMAreq | s_read64DMAreq;
  assign   p_dm_wr_en = s_write32 | s_write64 | s_write32DMA | s_write64DMA;
  assign   s_not = s_ori | s_movi | s_stw | s_ldw;
  assign   p_op1_sel = s_alu & ~s_not;
  assign   p_id_alu_imm = s_immed;
  //assign   p_br_id4=(s_brlt | s_brge | s_brgt | s_breq | s_brne | s_brp | s_brn | s_brnn |s_brz |s_brnz|s_brc|s_brnc|s_brv|s_brnv);
assign p_br_id4=0;
//  `include "mE_pipeline.csl" 
//   control_logic.v

always @(p_opcode) begin
 
case(p_opcode)

`E_E_OPCODE_READ32REQ : s_read32req=1;   
                     
`E_E_OPCODE_WRITE32 : s_write32=1;
             
`E_E_OPCODE_READ32RESP :s_read32resp=1;
             
`E_E_OPCODE_WRITE64 : s_write64=1;
             
`E_E_OPCODE_READ64RESP : s_read64resp=1;
             
`E_E_OPCODE_READ32DMAREQ  : s_read32DMAreq=1;
             
`E_E_OPCODE_WRITE32DMA :  s_write32DMA=1;
            
`E_E_OPCODE_READ64DMAREQ : s_read64DMAreq=1;
             
`E_E_OPCODE_WRITE64DMA : s_write64DMA=1;
             
`E_E_OPCODE_ADD :s_add=1;
             
`E_E_OPCODE_SUB :  s_sub=1;
             
`E_E_OPCODE_EQUAL : s_equal=1;
              
`E_E_OPCODE_MOVHI : s_movhi=1;
              
`E_E_OPCODE_MOVI :s_movi=1;
            
`E_E_OPCODE_ORI : s_ori=1;
           
`E_E_OPCODE_LDW : s_ldw=1;
              
`E_E_OPCODE_STW : s_stw=1;

`E_E_OPCODE_BRLT : s_brlt=1;

`E_E_OPCODE_BRGE : s_brge=1;
             
`E_E_OPCODE_BRLE : s_brle=1;

`E_E_OPCODE_BRGT : s_brgt=1;
             
`E_E_OPCODE_BREQ : s_breq=1;

`E_E_OPCODE_BRNE : s_brne=1;

`E_E_OPCODE_BRP : s_brp=1;

`E_E_OPCODE_BRN : s_brn=1;

`E_E_OPCODE_BRNN : s_brnn=1;

`E_E_OPCODE_BRZ : s_brz=1;  

`E_E_OPCODE_BRNZ : s_brnz=1;

`E_E_OPCODE_BRC : s_brc=1;
           
`E_E_OPCODE_BRNC : s_brnc=1;

`E_E_OPCODE_BRV : s_brnv=1;

`E_E_OPCODE_BRNV : s_brnv=1;
           
default : begin
              s_read32req=0;              
              s_write32=0;
              s_read32resp=0;
              s_write64=0;
              s_read64resp=0;
              s_read32DMAreq=0;
              s_write32DMA=0;
              s_read64DMAreq=0;
              s_write64DMA=0;
              s_add=0;
              s_sub=0;
              s_equal=0;
              s_movhi=0;
              s_movi=0;
              s_ori=0;
              s_ldw=0;
              s_stw=0; 
              s_brlt=0;
              s_brge=0;
              s_brle=0;
              s_brgt=0;
              s_breq=0;
              s_brne=0;
              s_brp=0;
              s_brn=0;
              s_brnn=0;
              s_brz=0;
              s_brnz=0;
              s_brc=0;
              s_brnc=0;
              s_brv=0;
              s_brnv=0;      
          end
endcase
 end
always @(p_opcode) begin
 
   if(s_add==1)
         p_op_sel= `E_OP_SEL_ADD_OP; //select add operation
      else
         if(s_sub==1)
         p_op_sel=`E_OP_SEL_SUB_OP; //select sub operation
     else
      if(s_equal==1)
       p_op_sel= `E_OP_SEL_EQUAL_OP;  //select equal operation
     else
       if(s_ori==1)
      p_op_sel=`E_OP_SEL_ORI_OP;   //select ori operation
     else
       if(s_stw==1)
      p_op_sel=`E_OP_SEL_STW_OP; //select stw operation
   else
   p_op_sel=3'bxxx;

end

  endmodule

//*********************************************
//Micro engine module
  module microEngine(enable,
                     clk,
                     reset,
                     im_data_in,
                     im_wr_addr,
                     im_rd_addr,
                     im_rd_en,
                     im_wr_en,
                     dm_data_in,
                     dm_data_out,
                     dm_rd_addr,
                     dm_wr_addr,
                     dm_rd_en,
                     dm_wr_en);

  input enable;
  input clk;
  input reset;
  input [31:0] im_data_in;  //data from external IM
  input [31:0] dm_data_in;  //data from external DM
  
  output [9:0] im_wr_addr, im_rd_addr;  //select the IM write or read address
  output [31:0] dm_data_out;            //output data for DM
  output im_rd_en,im_wr_en;             // IM wr and rd enable
  output [9:0] dm_rd_addr,dm_wr_addr;   //select the DM write and read address
  output dm_rd_en,dm_wr_en;             //DM read and write enable
  
 
  wire [31:0] ir_id_instr_ir3;     //signal from IR to ID
  wire [4:0]  id_rf_src0_rf4;      //signal from ID to RF first read adress
  wire [4:0]  id_rf_src1_rf4;      //signal from ID to RF second read address
 
  wire [31:0] alu_rf_alu6;        //signal from ALu to RF input mux
  wire [31:0] rf0_alu_rf4;        //signal from RF first read data 
  wire [31:0] rf1_alu_rf4;        //signal from RF second read data

  wire br_id4;                    //enable branch signal
  wire [31:0] rf_in4;             //wire from rf_mux
  wire [31:0] op1_5;              //wire from alu_mux
  wire [2:0] op1_sel5;            //selection for alu_mux

  wire clear;
  wire valid_4;
 
  wire dst_sel_4;              //selection for rf_mux
  
  wire [31:0]alu_dm_dm7;        //output data from alu
  wire [31:0] cntl_alu_id0;     //first input data for alu_mux
 

 //mE_logic.v 

 assign  cntl_alu_id0={{16{1'b0}},control.p_immed};  // 16b immediate value, concat with zero 
 assign dm_rd_addr=alu_dm_dm7[9:0];                  // 10 bits read address for DM
 assign dm_wr_addr=alu_dm_dm7[9:0];
 assign dm_data_out=rf1_alu_rf4;                    // write data for DM , from RF second output
 //
  pc pc(.br_cond(cc_logic.br_cond),
        .br_id4(control.p_br_id4),
        .bro(id.p_immed[9:0]),                      //branch address = [9:0] bits from immediate value
        .id_br_addr(id.p_immed[9:0]),
        .pc_im_addr_pc1(im_rd_addr),
        .im_rd_en(im_rd_en),
        .reset(reset),
        .clk(clk),
        .enable(enable));

  IR ir(.clock(clk),
        .reg_in(im_data_in),
        .reg_out(ir_id_instr_ir3),
        .reset_(reset),
        .enable(enable));
  ID id(.p_br_len(control.p_br_length),
        .p_clock(clk),
        .p_dstreg(rf.wr_addr),
        .p_i(ir_id_instr_ir3),
        .p_immed(control.p_immed),
        .p_opcode(control.p_opcode),
        .p_bb(control.p_bb),
        .p_src(control.p_src),
        .p_id(control.p_id),
        .p_dst(control.p_dst),
        .p_srcreg1(id_rf_src0_rf4),
        .p_srcreg2(id_rf_src1_rf4));
  RF rf(.clear(clear),
        .clock(clk),
        .data_in(rf_in4),
        .data_out0(rf0_alu_rf4),
        .data_out1(rf1_alu_rf4),
        .wr_addr(id.p_dstreg),
        .rd_addr0(id_rf_src0_rf4),
        .rd_addr1(id_rf_src1_rf4),
        .rd_en0(control.p_rf_rd0_en),
        .rd_en1(control.p_rf_rd1_en),
        .reset(reset),
        .valid(valid_4),
        .wr_en(control.p_rf_wr_en));
  ALU alu(.alu_rez(alu_dm_dm7),
          .ci(status.reg_out[3]),
          .co(status.reg_in[3]),
          .op1(mux_in_alu.mux_out),
          .op2(rf1_alu_rf4),
          .op_sel(control.p_op_sel));
 
  r_status status(.clock(clk),
                  .enable(enable),
                  .reg_in({alu.co,cc_logic.nzv}),
                  .reg_out(cc_logic.cc_in),
                  .reset_(reset));
  cc_logic cc_logic(.br_cond(pc.br_cond),
                    .cc_in(status.reg_out),
                    .id_br_cond(control.p_id_br_cond),
                    .nzv(status.reg_in[2:0]));                
  control control(.p_opcode(id.p_opcode),
                  .p_immed(id.p_immed),
                  .p_op_sel(alu.op_sel),
                  .p_dst_sel(dst_sel_4),
                  .p_rf_wr_en(rf.wr_en),
                  .p_rf_rd0_en(rf.rd_en0),
                  .p_rf_rd1_en(rf.rd_en1),
                  .p_dm_wr_en(dm_wr_en),
                  .p_dm_rd_en(dm_rd_en),
                  .p_op1_sel(op1_sel_5),
                  .p_id_br_cond(cc_logic.id_br_cond),
                  .p_br_id4(pc.br_id4),
                  .p_bb(id.p_bb),
                  .p_src(id.p_src),
                  .p_id(id.p_id),
                  .p_dst(id.p_dst),
                  .p_br_length(id.p_br_len));

  mux_ mux_in_rf(.in0(alu_rf_alu6),
                 .in1(dm_data_in),
                 .mux_out(rf_in4),
                 .sel(dst_sel_4));
  mux_ mux_in_alu(.in0(cntl_alu_id0),
                  .in1(rf1_alu_rf4),
                  .mux_out(op1_5),
                  .sel(op1_sel_5));
 // `include "mE_pipeline.csl" 
  endmodule

//**********************************************
//Processor node module

module pr(load_data_im,
          enable,
          reset,
          clk);
          
  input enable,reset,clk;
  input [31:0] load_data_im;  //load data for IM
 
  IM im(.rd0_address(mE.im_rd_addr),
        .rd0_data(mE.im_data_in),
        .rd0_en(mE.im_rd_en),
        .wr0_address(mE.im_wr_addr),
        .wr0_data(load_data_im),
        .wr0_en(mE.im_wr_en));
  DM dm(.rd0_address(mE.dm_rd_addr),
        .rd0_data(mE.dm_data_in),
        .rd0_en(mE.dm_rd_en),
        .wr0_address(mE.dm_wr_addr),
        .wr0_data(mE.dm_data_out),
        .wr0_en(mE.dm_wr_en));
  microEngine mE(    .enable(enable),
                     .clk(clk),
                     .reset(reset),
                     .im_data_in(im.rd0_data),
                     .im_wr_addr(im.wr0_address),
                     .im_rd_addr(im.rd0_address),
                     .im_rd_en(im.rd0_en),
                     .im_wr_en(im.wr0_en),
                     .dm_data_in(dm.rd0_data),
                     .dm_data_out(dm.wr0_data),
                     .dm_rd_addr(dm.rd0_address),
                     .dm_wr_addr(dm.wr0_address),
                     .dm_rd_en(dm.rd0_en),
                     .dm_wr_en(dm.wr0_en)); 
    endmodule
