//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC CSL COMPILER
//COPYRIGHT (c) 2005, 2006 FastpathLogic Inc

module mengine(clock,
               reset_,
               ir,
               rf_ctrl,
               ctrl);
  input [0:0] clock;
  input [0:0] reset_;
  input [31:0] ir;
  output [25:0] rf_ctrl;
  output [5:0] ctrl;
  mmux mmux( );
  mpc mpc( );
  mrom mrom( );
  mir mir( );
  mdecode mdecode( );
  mctrl mctrl( );
endmodule

module mmux(ir_mux_jmpto,
            ml_start,
            ir_mux_addr,
            mux_pc_next_addr);
  input [5:0] ir_mux_jmpto;
  input [5:0] ml_start;
  input [0:0] ir_mux_addr;
  output [0:0] mux_pc_next_addr;
  //behavior
  assign mux_pc_next_addr = ir_mux_addr ? ml_start : ir_mux_jmpto;
  //end behavior
endmodule

module mpc(clock,
           reset_,
           ldmpc,
           mux_pc_next_addr,
           pc_rom_addr);
  input [0:0] clock;
  input [0:0] reset_;
  input [0:0] ldmpc;
  input [0:0] mux_pc_next_addr;
  output [5:0] pc_rom_addr;
endmodule

module mrom(pc_rom_addr,
            rom_ir_instr);
  input [5:0] pc_rom_addr;
  output [31:0] rom_ir_instr;
  
  reg [31:0] inst_rom[0:63];
  reg [31:0] instr;
  integer i;
  //behavior
  assign rom_ir_instr = inst_rom[pc_rom_addr];
  initial begin
      instr = 0;
       for(i=0; i<=63; i=i+1) begin
           inst_rom[i] = instr;
           instr = instr + 1;
       end
   end
   //end behavior
endmodule

module mir(clock,
           reset_,
           ldmir,
           rom_ir_instr,
           ir_mux_jmpto,
           ir_dec_instr);
  input [0:0] clock;
  input [0:0] reset_;
  input [0:0] ldmir;
  input [31:0] rom_ir_instr;
  output [5:0] ir_mux_jmpto;
  output [24:0] ir_dec_instr;
endmodule

module mdecode(ir_dec_instr,
               dec_ctrl_sgn,
               ctrl);
  input [24:0] ir_dec_instr;
  output [5:0] dec_ctrl_sgn;
  output [5:0] ctrl;
endmodule

module mctrl(clock,
             reset_,
             ldmpc,
             ldmir,
             dec_ctrl_sgn,
             ir_mux_addr);
  input [0:0] clock;
  input [0:0] reset_;
  output [0:0] ldmpc;
  output [0:0] ldmir;
  input [5:0] dec_ctrl_sgn;
  output [0:0] ir_mux_addr;
endmodule
