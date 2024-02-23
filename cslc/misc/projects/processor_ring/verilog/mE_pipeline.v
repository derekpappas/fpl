//Monica
//26 mar 2008
//verilog code for micro engine (processor ring)


//enum_define.v
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
`define E_E_OPCODE_BRANCH_ 12
`define E_E_OPCODE_MOVHI 13
`define E_E_OPCODE_MOVI 14
`define E_E_OPCODE_ORI 15
`define E_E_OPCODE_LDW 16
`define E_E_OPCODE_STW 17

//enum_define.v

`define E_E_B_DATA 32
`define E_E_B_ADDR_IM 10
`define E_E_B_ADDR_RF 5
`define E_E_B_STATUS 4
`define E_OP_SEL_ADD_OP 0
`define E_OP_SEL_SUB_OP 1
`define E_OP_SEL_EQUAL_OP 2
`define E_OP_SEL_ORI_OP 3
`define E_OP_SEL_STW_OP 4

module adder(op1,
             op2,
             rez);
// Location of source csl unit: file name =  line number = 22
  input [9:0] op1;
  input [9:0] op2;
  output [9:0] rez;
  assign   rez = op1 + op2;
 // `include "adder.logic.v"
endmodule

module mux(in0,
           in1,
           sel,
           mux_out);
// Location of source csl unit: file name =  line number = 28
  input [9:0] in0;
  input [9:0] in1;
  input sel;
  output [9:0] mux_out;
  assign   mux_out = sel ? in1 : in0;
//  `include "mux.logic.v"
endmodule

module ff_reg(reset_,
              enable,
              clock,
              reg_out,
              reg_in);
// Location of source csl unit: file name =  line number = 43
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
end         //missing
endmodule

module pc(reset,
          br_cond,
          br_id4,
          bro,
          id_br_addr,
          pc_im_addr_pc1,
          enable,
          clk);
// Location of source csl unit: file name =  line number = 49
  input reset;
  input br_cond;
  input br_id4;
  input [9:0] bro;
  input [9:0] id_br_addr;
  input enable;
  input clk;
  output [9:0] pc_im_addr_pc1;
  wire [9:0] next_pc_0;
  wire [9:0] add_mux_pc_0;
  wire sel1_0;
  wire [9:0] constant_0;
  assign   sel1_0 = br_cond & br_id4;
  assign   pc_im_addr_pc1 = next_pc_0; //add 0
  assign   constant_0 = 1;
  mux mux1(.in0(constant_0),
           .in1(bro),
           .mux_out(op1),
           .sel(sel1_0));
  mux mux2(.in0(add_mux_pc_0),
           .in1(id_br_addr),
           .mux_out(reg_in),
           .sel(br_id4));
  adder adder(.op1(next_pc_0),
              .op2(mux_out),
              .rez(add_mux_pc_0));
  ff_reg ff(.clock(clk),
            .enable(enable),
            .reg_in(mux_out),
            .reg_out(next_pc_0),
            .reset_(reset));
 // `include "pc.logic.v"
endmodule

module IM(rd0_en,
          rd0_data,
          rd0_address,
          wr0_en,
          wr0_data,
          wr0_address);
// Location of source csl unit: file name =  line number = 87
  input rd0_en;
  input [9:0] rd0_address;
  input wr0_en;
  input [31:0] wr0_data;
  input [9:0] wr0_address;
  output reg[31:0] rd0_data;   //reg
  
  reg [31:0] im_mem [9:0];
  
  always @* begin
    if(rd0_en)
    rd0_data<=im_mem[rd0_address];
    else
    if(wr0_en)
    im_mem[wr0_address]<=wr0_data;
  end  
  endmodule

module IR(reset_,
          enable,
          clock,
          reg_out,
          reg_in);
// Location of source csl unit: file name =  line number = 96
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
// Location of source csl unit: file name =  line number = 103
  input p_clock;
  input [31:0] p_i;
  output [5:0] p_opcode;
  output p_bb;
  output p_src;
  output p_id;
  output p_dst;
  output [3:0] p_br_len;
  output [4:0] p_dstreg;
  output [4:0] p_srcreg1;
  output [4:0] p_srcreg2;
  output [15:0] p_immed;
  //`include "mE_pipeline.csl" 
  //id_logic.v 
 assign   p_opcode=p_i[5:0],     // opcode
          p_bb=p_i[12:12],         //burst bit
          p_src=p_i[11:11],        //
          p_id=p_i[10:10],
          p_dst=p_i[9:9],
          p_br_len=p_i[16:13],   // burst length
          p_dstreg=p_i[21:17],  // address of destination register
          p_srcreg1=p_i[31:27], // address of  operand register
          p_srcreg2=p_i[26:22], // address of second  operand register
          p_immed=p_i[21:6];     //  immediate value (constant)
  endmodule

module RF_register_file_memory(clock,
                               reset,
                               data_in,
                               data_out0,
                               wr_addr,
                               rd_addr0,
                               wr_en,
                               rd_en0,
                               valid);
  parameter ADDR_WIDTH = 6;
  parameter DATA_WIDTH = 32;
  parameter NUM_WORDS = (1 << DATA_WIDTH);
  input clock;
  input reset;
  input [DATA_WIDTH - 1:0] data_in;
  input [ADDR_WIDTH - 1:0] wr_addr;
  input [ADDR_WIDTH - 1:0] rd_addr0;
  input wr_en;
  input rd_en0;
  output reg [DATA_WIDTH - 1:0] data_out0;
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

module mux_(in0,
            in1,
            sel,
            mux_out);
// Location of source csl unit: file name =  line number = 316
  input [31:0] in0;
  input [31:0] in1;
  input sel;
  output [31:0] mux_out;
  assign   mux_out = sel ? in1 : in0;
  endmodule

module ALU(op1,
           op2,
           op_sel,
           ci,
           alu_rez,
           co);
// Location of source csl unit: file name =  line number = 136
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

module control(p_opcode,
               p_status,
               p_immed,
               p_op_sel,
               p_dst_sel,
               p_rf_wr_en,
               p_rf_rd0_en,
               p_rf_rd1_en,
               p_dm_wr_en,
               p_dm_rd_en,
               p_op1_sel,
               p_id_alu_imm,
               p_cc_logic,
               p_id_br_cond);
// Location of source csl unit: file name =  line number = 164
  input [5:0] p_opcode;
  input [3:0] p_status;
  input [15:0] p_immed;
  output reg[2:0] p_op_sel;
  output p_dst_sel;
  output p_rf_wr_en;
  output p_rf_rd0_en;
  output p_rf_rd1_en;
  output p_dm_wr_en;
  output p_dm_rd_en;
  output p_op1_sel;
  output [15:0] p_id_alu_imm;
  output [2:0] p_cc_logic;
  output[3:0] p_id_br_cond;
  
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
  reg s_branch;
  reg s_movhi;
  reg s_movi;
  reg s_ori;
  reg s_ldw;
  reg s_stw;
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
  assign   p_br_cond = p_status == s_id_br_cond;
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
            
`E_E_OPCODE_BRANCH_:s_branch=1;
              
`E_E_OPCODE_MOVHI : s_movhi=1;
              
`E_E_OPCODE_MOVI :s_movi=1;
            
`E_E_OPCODE_ORI : s_ori=1;
           
`E_E_OPCODE_LDW : s_ldw=1;
              
`E_E_OPCODE_STW : s_stw=1;
             
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
              s_branch=0;
              s_movhi=0;
              s_movi=0;
              s_ori=0;
              s_ldw=0;
              s_stw=0;     
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

//assign  p_cc_logic={N,Z,V}; 
  
  endmodule

module DM(rd0_en,
          rd0_data,
          rd0_address,
          wr0_en,
          wr0_data,
          wr0_address);
// Location of source csl unit: file name =  line number = 146
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
  
  module r_status(reset_,
                enable,
                clock,
                reg_out,
                reg_in);
// Location of source csl unit: file name =  line number = 155
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
  
  module cc_logic(cc_in,
                id_br_cond5,
                br_cond);
// Location of source csl unit: file name =  line number = 163
  input [3:0] cc_in;
  input [3:0] id_br_cond5;
  output br_cond;
  assign   br_cond = id_br_cond5 == cc_in;
  endmodule
  
  module microEngine(enable,
                     clk,
                     reset,
                     load_data_im,
                     im_wr_addr);
// Location of source csl unit: file name =  line number = 324
  input enable;
  input clk;
  input reset;
  input [31:0] load_data_im;
  input [9:0] im_wr_addr;
  wire [9:0] pc_im_addr_pc1;
  wire [31:0] im_ir_instr_im2;
  wire [31:0] ir_id_instr_ir3;
  wire [4:0] id_rf_src0_rf4;
  wire [4:0] id_rf_src1_rf4;
  wire [31:0] dm_rf_dst_dm6;
  wire [31:0] alu_rf_alu6;
  wire [31:0] rf0_alu_rf4;
  wire [31:0] rf1_alu_rf4;
  wire [31:0] alu_dm_dm7;
  wire br_cond6;
  wire br_id4;
  wire [31:0] rf_in4;
  wire [31:0] op1_5;
  wire [2:0] op_sel5;
  wire ci;
  wire co;
  wire Z;
  wire N;
  wire V;
  wire [3:0] s_status_in5;
  wire [3:0] s_status6;
  wire im_rd_en0;
  wire im_wr_en0;
  wire clear;
  wire rf_wr_en_4;
  wire rf_rd_en0_4;
  wire rf_rd_en1_4;
  wire valid_4;
  wire dm_rd_en_6;
  wire dm_wr_en_6;
  wire dst_sel_4;
  wire op1_sel_5;
  wire [5:0] opcode_4;
  wire [3:0] br_len_4;
  wire [15:0] immed_value4;
  wire [9:0] alu_dm10_6;
  wire [15:0] cntl_alu_id4;
  wire [31:0] cntl_alu_id0;
  wire [2:0] s_status_cc6;
  assign   br_cond6 = 0;
  assign   br_id4 = 0;
  assign   alu_rf_alu6 = alu_dm_dm7;
 //mE_logic.v 
 assign alu_dm10_6=alu_dm_dm7[9:0];
 assign s_status_in5={co,s_status_cc6};
 assign  cntl_alu_id0={{16{1'b0}},cntl_alu_id4};
 //
  pc pc(.br_cond(p_br_cond),
        .br_id4(br_id4),
        .clk(clk),
        .enable(enable),
        .pc_im_addr_pc1(pc_im_addr_pc1),
        .reset(reset));
  IM im(.rd0_address(pc_im_addr_pc1),
        .rd0_data(im_ir_instr_im2),
        .rd0_en(im_rd_en0),
        .wr0_address(im_wr_addr),
        .wr0_data(load_data_im),
        .wr0_en(im_wr_en0));
  IR ir(.clock(clk),
        .reg_in(im_ir_instr_im2),
        .reg_out(ir_id_instr_ir3),
        .reset_(reset));
  ID id(.p_br_len(br_len_4),
        .p_clock(clk),
        .p_dstreg(wr_addr),
        .p_i(ir_id_instr_ir3),
        .p_immed(immed_value4),
        .p_opcode(opcode_4),
        .p_srcreg1(id_rf_src0_rf4),
        .p_srcreg2(id_rf_src1_rf4));
  RF rf(.clear(clear),
        .clock(clk),
        .data_in(rf_in4),
        .data_out0(rf0_alu_rf4),
        .data_out1(rf1_alu_rf4),
        .rd_addr0(id_rf_src0_rf4),
        .rd_addr1(id_rf_src1_rf4),
        .rd_en0(rf_rd_en0_4),
        .rd_en1(rf_rd_en1_4),
        .reset(reset),
        .valid(valid_4),
        .wr_en(rf_wr_en_4));
  ALU alu(.alu_rez(alu_dm_dm7),
          .ci(ci),
          .co(co),
          .op1(op1_5),
          .op2(rf1_alu_rf4),
          .op_sel(op_sel5));
  DM dm(.rd0_address(alu_dm10_6),
        .rd0_data(dm_rf_dst_dm6),
        .rd0_en(dm_rd_en_6),
        .wr0_address(alu_dm10_6),
        .wr0_data(rf1_alu_rf4),
        .wr0_en(dm_wr_en_6));
  r_status status(.clock(clk),
                  .enable(enable),
                  .reg_in(s_status_in5),
                  .reg_out(s_status6),
                  .reset_(reset));
   cc_logic cc_logic(.br_cond(br_cond),
                    .cc_in(s_status6),
                    .id_br_cond5(p_id_br_cond));                
  control control(.p_id_br_cond(cc_pogic.id_br_cond5),
                  .p_cc_logic(s_status_cc6),
                  .p_dm_rd_en(dm_rd_en_6),
                  .p_dm_wr_en(dm_wr_en_6),
                  .p_dst_sel(dst_sel_4),
                  .p_id_alu_imm(cntl_alu_id4),
                  .p_immed(immed_value4),
                  .p_op1_sel(op1_sel_5),
                  .p_op_sel(op_sel5),
                  .p_opcode(opcode_4),
                  .p_rf_rd0_en(rf_rd_en0_4),
                  .p_rf_rd1_en(rf_rd_en1_4),
                  .p_rf_wr_en(rf_wr_en_4),
                  .p_status(s_status6));
  mux_ mux_in_rf(.in0(alu_rf_alu6),
                 .in1(dm_rf_dst_dm6),
                 .mux_out(rf_in4),
                 .sel(dst_sel_4));
  mux_ mux_in_alu(.in0(cntl_alu_id0),
                  .in1(rf1_alu_rf4),
                  .mux_out(op1_5),
                  .sel(op1_sel_5));
 // `include "mE_pipeline.csl" 
  endmodule

