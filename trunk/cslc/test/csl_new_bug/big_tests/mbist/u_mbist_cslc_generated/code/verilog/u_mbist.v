`include "defines.v"

module u_mbist(p_clock,
               p_reset,
               p_enable,
               p_sram_addr);
// Location of source csl unit: file name = mbist_datapath.csl line number = 203
  input p_clock;
  input p_reset;
  input p_enable;
  output [15:0] p_sram_addr;
  wire [15:0] s_pc_im;
  wire [4:0] s_opcode;
  wire [3:0] s_reg_dest;
  wire [3:0] s_op1;
  wire [3:0] s_op2;
  wire s_cond;
  wire [10:0] s_branch_addr;
  wire [15:0] s_branch_addr_e;
  wire s_br_sel;
  wire [3:0] s_shift_ammount;
  wire [7:0] s_const_val;
  wire [7:0] s_rom_addr;
  wire s_direction;
  wire [15:0] s_mux_shift;
  wire [15:0] s_mem_mux;
  wire [15:0] s_status;
  wire [15:0] s_status_in;
  wire [15:0] s_rf_mux;
  wire [15:0] s_es_mux;
  wire [15:0] s_alu_mux;
  wire [15:0] s_haddr_cmp;
  wire s_c_f;
  wire [15:0] s_ir_im;
  wire [15:0] s_rf_alu;
  wire [14 - 1:0] s_controls;
  wire s_ld_caddr_sel;
  wire s_caddr_en;
  wire s_caddr_direction;
  m_im im0();
  r_pc r_pc0(.p_addr_out(s_pc_im),
             .p_br_addr(s_branch_addr_e),
             .p_clock(p_clock),
             .p_enable(p_enable),
             .p_reset(p_reset),
             .p_sel(s_br_sel));
  u_ir ir0(.p_braddr(s_branch_addr),
           .p_c(s_cond),
           .p_clock(p_clock),
           .p_const8(s_const_val),
           .p_d(s_direction),
           .p_i(s_ir_im),
           .p_op1(s_op1),
           .p_op2(s_op2),
           .p_opcode(s_opcode),
           .p_rdst(s_reg_dest),
           .p_romaddr(s_rom_addr),
           .p_sha(s_shift_ammount));
  u_alu alu0(.p_cin(s_status[1:1]),
             .p_cout(s_c_f),
             .p_op1(s_mux_shift),
             .p_op2(s_rf_alu),
             .p_opsel(s_opcode[2:0]),
             .p_res(s_alu_mux));
  rf rf0(.clock(p_clock),
         .data_in(s_mem_mux),
         .data_out1(s_rf_mux),
         .data_out2(s_rf_alu),
         .rd_addr1(s_op1),
         .rd_addr2(s_op2),
         .rd_en1(s_controls[11:11]),
         .rd_en2(s_controls[10:10]),
         .reset(p_reset),
         .wr_addr(s_reg_dest),
         .wr_en(s_controls[12:12]));
  m_rom pattern_rom();
  u_es es0(.p_c(s_const_val),
           .p_ec(s_es_mux));
  r_caddr caddr(.p_addr_out(p_sram_addr),
                .p_br_addr(s_rf_alu),
                .p_clock(p_clock),
                .p_direction(s_caddr_direction),
                .p_enable(s_caddr_en),
                .p_reset(p_reset),
                .p_sel(s_ld_caddr_sel));
  r_ha haddr(.clock(p_clock),
             .enable(p_enable),
             .reg_in(s_rf_alu),
             .reg_out(s_haddr_cmp),
             .reset_(p_reset));
  r_status status(.clock(p_clock),
                  .enable(p_enable),
                  .reg_in(s_status_in),
                  .reg_out(s_status),
                  .reset_(p_reset));
  u_control control();
  endmodule

