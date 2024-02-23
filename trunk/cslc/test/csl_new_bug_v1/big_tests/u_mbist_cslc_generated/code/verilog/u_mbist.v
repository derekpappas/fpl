`include "defines.v"

module u_mbist(ifc_op0_op1,
               ifc_op0_op2,
               ifc_out0_o);
// Location of source csl unit: file name = mbist_datapath.csl line number = 215
  input [15:0] ifc_op0_op1;
  input [15:0] ifc_op0_op2;
  output [15:0] ifc_out0_o;
  wire [16 - 1:0] sham;
  wire compres;
  wire [4 - 1:0] sel;
  wire [8 - 1:0] status;
  wire op;
  wire r;
  wire wr;
  wire rd;
  wire no;
  wire [16 - 1:0] in;
  wire rst;
  wire clk;
  wire en;
  wire [16 - 1:0] data;
  wire clr;
  wire [4 - 1:0] addr;
  wire valid;
  r_pc r_pc(.clock(clk),
            .enable(en),
            .reg_out(data),
            .reset_(rst));
  m_im im();
  u_mux41 mux_mem(.ifc_out0_o(ifc_out0_o),
                  .in0(in),
                  .in1(in),
                  .in2(in),
                  .in3(in),
                  .sel(sel));
  rf rf(.clear(clr),
        .clock(clk),
        .data_in(data),
        .data_out0(data),
        .data_out1(data),
        .rd_addr0(addr),
        .rd_addr1(addr),
        .rd_en0(en),
        .rd_en1(en),
        .reset(rst),
        .valid(valid),
        .wr_addr(addr),
        .wr_en(en));
  u_alu_sh_cmp alusc(.compres(compres),
                     .ifc_op0_op1(ifc_op0_op1),
                     .ifc_op0_op2(ifc_op0_op2),
                     .ifc_out0_o(ifc_out0_o),
                     .sel_op_p_sel(sel),
                     .sham(sham));
  u_control control(.decr(no),
                    .incr(no),
                    .op_instr(op),
                    .r_instr(r),
                    .rd_dm(rd),
                    .rd_im(rd),
                    .rd_ram(rd),
                    .rd_rom(rd),
                    .s_status(status),
                    .wr_crtaddr(wr),
                    .wr_dm(wr),
                    .wr_haddr(wr),
                    .wr_ram(wr));
  `include "u_mbist.logic.v"
endmodule

