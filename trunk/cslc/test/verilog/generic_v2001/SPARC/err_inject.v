// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T1 Processor File: err_inject.v
// Copyright (c) 2006 Sun Microsystems, Inc.  All Rights Reserved.
// DO NOT ALTER OR REMOVE COPYRIGHT NOTICES.
// 
// The above named program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public
// License version 2 as published by the Free Software Foundation.
// 
// The above named program is distributed in the hope that it will be 
// useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// General Public License for more details.
// 
// You should have received a copy of the GNU General Public
// License along with this work; if not, write to the Free Software
// Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
// 
// ========== Copyright Header End ============================================
`include "cross_module.h"

module err_inject ();

`ifdef GATE_SIM
`else   
   //Just supporting spc0 at the moment
`ifdef RTL_SPARC0

   task chk_ce;
   
   input [63:0] d;
   input [7:0]  p;
   output       ce;

      begin
	ce = d[0]  ^ d[1]  ^ d[2]  ^ d[3]  ^ d[4]  ^ d[5]  ^ d[6]  ^ d[7]
        ^ d[8]  ^ d[9]  ^ d[10] ^ d[11] ^ d[12] ^ d[13] ^ d[14] ^ d[15]
        ^ d[16] ^ d[17] ^ d[18] ^ d[19] ^ d[20] ^ d[21] ^ d[22] ^ d[23]
        ^ d[24] ^ d[25] ^ d[26] ^ d[27] ^ d[28] ^ d[29] ^ d[30] ^ d[31]
        ^ d[32] ^ d[33] ^ d[34] ^ d[35] ^ d[36] ^ d[37] ^ d[38] ^ d[39]
        ^ d[40] ^ d[41] ^ d[42] ^ d[43] ^ d[44] ^ d[45] ^ d[46] ^ d[47]
        ^ d[48] ^ d[49] ^ d[50] ^ d[51] ^ d[52] ^ d[53] ^ d[54] ^ d[55]
        ^ d[56] ^ d[57] ^ d[58] ^ d[59] ^ d[60] ^ d[61] ^ d[62] ^ d[63]
        ^ p[0]  ^ p[1]  ^ p[2]  ^ p[3]  ^ p[4]  ^ p[5]  ^ p[6]  ^ p[7];
      end
   endtask // chk_ce

   task inj_irf_err_hdl;
      
      input [71:0] err_mask_rs1;
      input [71:0] err_mask_rs2;
      input [71:0] err_mask_rs3;
      input err_inj_dbg;
      
      reg [6:0] thr_rs1,thr_rs2,thr_rs3;
      reg [71:0] data_rs1, data_rs2, data_rs3;
      reg rs1_ce, rs2_ce, rs3_ce;
      
      begin

	 if (err_inj_dbg)
	   begin
	      $display ("%d: RS1 = %h: RS2 = %h: RS3 = %h b/e\n", $time,`TOP_DESIGN.sparc0.exu.irf.irf_byp_rs1_data_d_l[71:0],`TOP_DESIGN.sparc0.exu.irf.irf_byp_rs2_data_d_l[71:0],`TOP_DESIGN.sparc0.exu.irf.irf_byp_rs3_data_d_l[71:0]);
	   end

         thr_rs1 = `TOP_DESIGN.sparc0.exu.irf.thr_rs1;
`ifdef FPGA_SYN
	 case(thr_rs1[4:0])
	5'b00000: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00000[thr_rs1[6:5]];
	5'b00001: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00001[thr_rs1[6:5]];
	5'b00010: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00010[thr_rs1[6:5]];
	5'b00011: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00011[thr_rs1[6:5]];
	5'b00100: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00100[thr_rs1[6:5]];
	5'b00101: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00101[thr_rs1[6:5]];
	5'b00110: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00110[thr_rs1[6:5]];
	5'b00111: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00111[thr_rs1[6:5]];
	5'b01000: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01000[thr_rs1[6:5]];
	5'b01001: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01001[thr_rs1[6:5]];
	5'b01010: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01010[thr_rs1[6:5]];
	5'b01011: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01011[thr_rs1[6:5]];
	5'b01100: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01100[thr_rs1[6:5]];
	5'b01101: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01101[thr_rs1[6:5]];
	5'b01110: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01110[thr_rs1[6:5]];
	5'b01111: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01111[thr_rs1[6:5]];
	5'b10000: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10000[thr_rs1[6:5]];
	5'b10001: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10001[thr_rs1[6:5]];
	5'b10010: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10010[thr_rs1[6:5]];
	5'b10011: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10011[thr_rs1[6:5]];
	5'b10100: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10100[thr_rs1[6:5]];
	5'b10101: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10101[thr_rs1[6:5]];
	5'b10110: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10110[thr_rs1[6:5]];
	5'b10111: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10111[thr_rs1[6:5]];
	5'b11000: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11000[thr_rs1[6:5]];
	5'b11001: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11001[thr_rs1[6:5]];
	5'b11010: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11010[thr_rs1[6:5]];
	5'b11011: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11011[thr_rs1[6:5]];
	5'b11100: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11100[thr_rs1[6:5]];
	5'b11101: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11101[thr_rs1[6:5]];
	5'b11110: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11110[thr_rs1[6:5]];
	5'b11111: data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11111[thr_rs1[6:5]];
        endcase
`else
         data_rs1 = `TOP_DESIGN.sparc0.exu.irf.active_window[thr_rs1];	 
`endif

	 chk_ce (data_rs1 [63:0],
		 data_rs1 [71:64],
		 rs1_ce);

         thr_rs2 = `TOP_DESIGN.sparc0.exu.irf.thr_rs2;
`ifdef FPGA_SYN
	 case(thr_rs2[4:0])
	5'b00000: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00000[thr_rs2[6:5]];
	5'b00001: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00001[thr_rs2[6:5]];
	5'b00010: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00010[thr_rs2[6:5]];
	5'b00011: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00011[thr_rs2[6:5]];
	5'b00100: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00100[thr_rs2[6:5]];
	5'b00101: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00101[thr_rs2[6:5]];
	5'b00110: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00110[thr_rs2[6:5]];
	5'b00111: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00111[thr_rs2[6:5]];
	5'b01000: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01000[thr_rs2[6:5]];
	5'b01001: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01001[thr_rs2[6:5]];
	5'b01010: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01010[thr_rs2[6:5]];
	5'b01011: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01011[thr_rs2[6:5]];
	5'b01100: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01100[thr_rs2[6:5]];
	5'b01101: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01101[thr_rs2[6:5]];
	5'b01110: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01110[thr_rs2[6:5]];
	5'b01111: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01111[thr_rs2[6:5]];
	5'b10000: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10000[thr_rs2[6:5]];
	5'b10001: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10001[thr_rs2[6:5]];
	5'b10010: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10010[thr_rs2[6:5]];
	5'b10011: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10011[thr_rs2[6:5]];
	5'b10100: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10100[thr_rs2[6:5]];
	5'b10101: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10101[thr_rs2[6:5]];
	5'b10110: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10110[thr_rs2[6:5]];
	5'b10111: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10111[thr_rs2[6:5]];
	5'b11000: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11000[thr_rs2[6:5]];
	5'b11001: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11001[thr_rs2[6:5]];
	5'b11010: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11010[thr_rs2[6:5]];
	5'b11011: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11011[thr_rs2[6:5]];
	5'b11100: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11100[thr_rs2[6:5]];
	5'b11101: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11101[thr_rs2[6:5]];
	5'b11110: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11110[thr_rs2[6:5]];
	5'b11111: data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11111[thr_rs2[6:5]];
        endcase
`else
         data_rs2 = `TOP_DESIGN.sparc0.exu.irf.active_window[thr_rs2];	 	 
`endif
	 chk_ce (data_rs2 [63:0],
		 data_rs2 [71:64],
		 rs2_ce);

         thr_rs3 = `TOP_DESIGN.sparc0.exu.irf.thr_rs3;
`ifdef FPGA_SYN
	 case(thr_rs3[4:0])
	5'b00000: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00000[thr_rs3[6:5]];
	5'b00001: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00001[thr_rs3[6:5]];
	5'b00010: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00010[thr_rs3[6:5]];
	5'b00011: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00011[thr_rs3[6:5]];
	5'b00100: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00100[thr_rs3[6:5]];
	5'b00101: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00101[thr_rs3[6:5]];
	5'b00110: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00110[thr_rs3[6:5]];
	5'b00111: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00111[thr_rs3[6:5]];
	5'b01000: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01000[thr_rs3[6:5]];
	5'b01001: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01001[thr_rs3[6:5]];
	5'b01010: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01010[thr_rs3[6:5]];
	5'b01011: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01011[thr_rs3[6:5]];
	5'b01100: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01100[thr_rs3[6:5]];
	5'b01101: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01101[thr_rs3[6:5]];
	5'b01110: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01110[thr_rs3[6:5]];
	5'b01111: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01111[thr_rs3[6:5]];
	5'b10000: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10000[thr_rs3[6:5]];
	5'b10001: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10001[thr_rs3[6:5]];
	5'b10010: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10010[thr_rs3[6:5]];
	5'b10011: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10011[thr_rs3[6:5]];
	5'b10100: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10100[thr_rs3[6:5]];
	5'b10101: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10101[thr_rs3[6:5]];
	5'b10110: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10110[thr_rs3[6:5]];
	5'b10111: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10111[thr_rs3[6:5]];
	5'b11000: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11000[thr_rs3[6:5]];
	5'b11001: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11001[thr_rs3[6:5]];
	5'b11010: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11010[thr_rs3[6:5]];
	5'b11011: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11011[thr_rs3[6:5]];
	5'b11100: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11100[thr_rs3[6:5]];
	5'b11101: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11101[thr_rs3[6:5]];
	5'b11110: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11110[thr_rs3[6:5]];
	5'b11111: data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11111[thr_rs3[6:5]];
        endcase
`else
         data_rs3 = `TOP_DESIGN.sparc0.exu.irf.active_window[thr_rs3];	 	 
`endif
	 chk_ce (data_rs3 [63:0],
		 data_rs3 [71:64],
		 rs3_ce);

	 //Check that if the directive is a ce directive, then there is no existing error
	 //It is ok to check parity for a ce directive because the env does not support 3 or more bit errors
	 //so, a 0 parity means no error or ue
	 if ((^err_mask_rs1 == 1'b1) && (rs1_ce == 1'b1)) //ce directive and an existing ce, ignore error mask
	   begin
	      force `TOP_DESIGN.sparc0.exu.irf.irf_byp_rs1_data_d_l[71:0] =  ~`TOP_DESIGN.sparc0.exu.irf.irf_byp_rs1_data_d;
	   end
	 else  //ue | ne | (ce directive & no existing ce) -- use the error mask
	   begin
	      force `TOP_DESIGN.sparc0.exu.irf.irf_byp_rs1_data_d_l[71:0] =  `TOP_DESIGN.sparc0.exu.irf.irf_byp_rs1_data_d ^ err_mask_rs1; 
	   end

	 if ((^err_mask_rs2 == 1'b1) && (rs2_ce == 1'b1)) //ce directive and an existing ce
	   begin	 
	      force `TOP_DESIGN.sparc0.exu.irf.irf_byp_rs2_data_d_l[71:0] =  ~`TOP_DESIGN.sparc0.exu.irf.irf_byp_rs2_data_d;
	   end
	 else
	   begin
	      force `TOP_DESIGN.sparc0.exu.irf.irf_byp_rs2_data_d_l[71:0] =  `TOP_DESIGN.sparc0.exu.irf.irf_byp_rs2_data_d ^ err_mask_rs2;
	   end
	 
	 if ((^err_mask_rs3 == 1'b1) && (rs3_ce == 1'b1)) //ce directive and an existing ce
	   begin
	      force `TOP_DESIGN.sparc0.exu.irf.irf_byp_rs3_data_d_l[71:0] =  ~`TOP_DESIGN.sparc0.exu.irf.irf_byp_rs3_data_d;
	   end
	 else
	   begin
	      force `TOP_DESIGN.sparc0.exu.irf.irf_byp_rs3_data_d_l[71:0] =  `TOP_DESIGN.sparc0.exu.irf.irf_byp_rs3_data_d ^ err_mask_rs3;
	   end

	 if (err_inj_dbg)
	   begin
	      $display ("%d: RS1 = %h, existing ce = %1b: RS2 = %h, existing ce = %1b: RS3 = %h, existing ce = %1b a/e\n", $time,`TOP_DESIGN.sparc0.exu.irf.irf_byp_rs1_data_d_l[71:0],rs1_ce,`TOP_DESIGN.sparc0.exu.irf.irf_byp_rs2_data_d_l[71:0],rs2_ce,`TOP_DESIGN.sparc0.exu.irf.irf_byp_rs3_data_d_l[71:0],rs3_ce);
	   end
	 
	 //If rs1 is being read mask the data and write back to the array
	 if (`TOP_DESIGN.sparc0.exu.irf.ifu_exu_ren1_d == 1'b1 && !((^err_mask_rs1 == 1'b1) && (rs1_ce == 1'b1)))
	   begin
              thr_rs1 = `TOP_DESIGN.sparc0.exu.irf.thr_rs1;
`ifdef FPGA_SYN
	 case(thr_rs1[4:0])
	5'b00000: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00000[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_00000[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b00001: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00001[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_00001[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b00010: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00010[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_00010[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b00011: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00011[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_00011[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b00100: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00100[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_00100[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b00101: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00101[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_00101[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b00110: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00110[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_00110[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b00111: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00111[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_00111[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b01000: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01000[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_01000[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b01001: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01001[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_01001[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b01010: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01010[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_01010[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b01011: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01011[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_01011[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b01100: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01100[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_01100[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b01101: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01101[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_01101[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b01110: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01110[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_01110[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b01111: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01111[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_01111[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b10000: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10000[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_10000[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b10001: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10001[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_10001[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b10010: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10010[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_10010[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b10011: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10011[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_10011[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b10100: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10100[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_10100[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b10101: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10101[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_10101[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b10110: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10110[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_10110[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b10111: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10111[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_10111[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b11000: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11000[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_11000[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b11001: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11001[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_11001[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b11010: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11010[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_11010[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b11011: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11011[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_11011[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b11100: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11100[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_11100[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b11101: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11101[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_11101[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b11110: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11110[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_11110[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
	5'b11111: begin
		data_rs1 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11111[thr_rs1[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_11111[thr_rs1[6:5]] = 
			data_rs1 ^ (~err_mask_rs1);
		end
        endcase
`else
              data_rs1 = `TOP_DESIGN.sparc0.exu.irf.active_window[thr_rs1];
              `TOP_DESIGN.sparc0.exu.irf.active_window[thr_rs1] = data_rs1 ^ (~err_mask_rs1);
`endif
	   end
	 
	 //If rs2 is being read mask the data and write back to the array
	 if (`TOP_DESIGN.sparc0.exu.irf.ifu_exu_ren2_d == 1'b1 && !((^err_mask_rs2 == 1'b1) && (rs2_ce == 1'b1)))
	   begin
              thr_rs2 = `TOP_DESIGN.sparc0.exu.irf.thr_rs2;	    
`ifdef FPGA_SYN
	case(thr_rs2[4:0])
	5'b00000: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00000[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_00000[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b00001: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00001[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_00001[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b00010: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00010[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_00010[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b00011: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00011[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_00011[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b00100: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00100[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_00100[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b00101: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00101[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_00101[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b00110: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00110[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_00110[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b00111: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00111[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_00111[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b01000: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01000[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_01000[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b01001: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01001[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_01001[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b01010: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01010[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_01010[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b01011: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01011[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_01011[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b01100: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01100[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_01100[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b01101: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01101[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_01101[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b01110: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01110[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_01110[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b01111: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01111[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_01111[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b10000: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10000[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_10000[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b10001: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10001[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_10001[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b10010: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10010[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_10010[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b10011: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10011[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_10011[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b10100: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10100[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_10100[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b10101: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10101[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_10101[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b10110: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10110[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_10110[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b10111: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10111[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_10111[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b11000: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11000[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_11000[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b11001: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11001[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_11001[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b11010: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11010[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_11010[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b11011: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11011[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_11011[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b11100: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11100[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_11100[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b11101: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11101[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_11101[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b11110: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11110[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_11110[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
	5'b11111: begin
		data_rs2 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11111[thr_rs2[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_11111[thr_rs2[6:5]] = 
		data_rs2 ^ (~err_mask_rs2);
		end
        endcase
`else
              data_rs2 = `TOP_DESIGN.sparc0.exu.irf.active_window[thr_rs2];
              `TOP_DESIGN.sparc0.exu.irf.active_window[thr_rs2] =  data_rs2 ^ (~err_mask_rs2);
`endif
	   end

	 //If rs3 is being read mask the data and write back to the array	
	 if (`TOP_DESIGN.sparc0.exu.irf.ifu_exu_ren3_d == 1'b1 && !((^err_mask_rs3 == 1'b1) && (rs3_ce == 1'b1)))
	   begin
              thr_rs3 = `TOP_DESIGN.sparc0.exu.irf.thr_rs3;	
`ifdef FPGA_SYN
	case(thr_rs3[4:0])
	5'b00000: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00000[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_00000[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b00001: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00001[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_00001[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b00010: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00010[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_00010[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b00011: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00011[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_00011[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b00100: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00100[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_00100[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b00101: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00101[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_00101[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b00110: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00110[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_00110[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b00111: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00111[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_00111[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b01000: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01000[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_01000[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b01001: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01001[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_01001[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b01010: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01010[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_01010[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b01011: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01011[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_01011[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b01100: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01100[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_01100[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b01101: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01101[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_01101[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b01110: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01110[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_01110[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b01111: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01111[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_01111[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b10000: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10000[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_10000[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b10001: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10001[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_10001[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b10010: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10010[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_10010[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b10011: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10011[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_10011[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b10100: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10100[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_10100[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b10101: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10101[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_10101[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b10110: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10110[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_10110[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b10111: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10111[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_10111[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b11000: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11000[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_11000[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b11001: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11001[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_11001[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b11010: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11010[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_11010[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b11011: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11011[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_11011[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b11100: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11100[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_11100[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b11101: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11101[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_11101[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b11110: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11110[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_11110[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
	5'b11111: begin
		data_rs3 = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11111[thr_rs3[6:5]];
		`TOP_DESIGN.sparc0.exu.irf.active_window_11111[thr_rs3[6:5]] = 
		data_rs3 ^ (~err_mask_rs3);
		end
        endcase
`else
              data_rs3 = `TOP_DESIGN.sparc0.exu.irf.active_window[thr_rs3];	
              `TOP_DESIGN.sparc0.exu.irf.active_window[thr_rs3] = data_rs3 ^ (~err_mask_rs3);
`endif
	   end
      end
   endtask // inj_irf_err_hdl
   
   task inj_ic_err_hdl;

      input [33:0] err_mask_ir;
      input [33:0] err_mask_nir;
      input [29:0] err_mask_tag;
      input err_inj_dbg;

      reg par;
      reg [2:0] way;
      reg [29:0] pgnum_m;
      reg [32:0] temp_tag;
      reg [131:0] tagdata;
      reg va_bit_11,va_bit_10;
      reg [9:0] index_f, top_index;
      reg [135:0] fetdata,topdata;
      reg [6:0] index_y,rd_index_d1;
      reg [29:0] cache_tag_way[0:3];
      reg [3:0] cache_set_vld, cache_way_hit;

      begin
	 index_f = `TOP_DESIGN.sparc0.ifu.icd.index_f;
	 index_y = `TOP_DESIGN.sparc0.ifu.ict.index_y;
	 rd_index_d1 = `TOP_DESIGN.sparc0.ifu.icv.rd_index_d1;
	 top_index = `TOP_DESIGN.sparc0.ifu.icd.top_index;
	 pgnum_m = `TOP_DESIGN.sparc0.ifu.itlb.pgnum_m;
	 va_bit_11 = `TOP_DESIGN.sparc0.ifu.fdp_erb_pc_f[11];
	 va_bit_10 = `TOP_DESIGN.sparc0.ifu.fdp_erb_pc_f[10];

	 for (way = 0; way < 4; way = way + 1)
	   begin
`ifdef FPGA_SYN
	case ({rd_index_d1[1:0],way[1:0]}) 
	4'b0000: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.ifu.icv.idcv_ary_0000[rd_index_d1[6:2]];
	4'b0001: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.ifu.icv.idcv_ary_0001[rd_index_d1[6:2]];
	4'b0010: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.ifu.icv.idcv_ary_0010[rd_index_d1[6:2]];
	4'b0011: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.ifu.icv.idcv_ary_0011[rd_index_d1[6:2]];
	4'b0100: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.ifu.icv.idcv_ary_0100[rd_index_d1[6:2]];
	4'b0101: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.ifu.icv.idcv_ary_0101[rd_index_d1[6:2]];
	4'b0110: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.ifu.icv.idcv_ary_0110[rd_index_d1[6:2]];
	4'b0111: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.ifu.icv.idcv_ary_0111[rd_index_d1[6:2]];
	4'b1000: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.ifu.icv.idcv_ary_1000[rd_index_d1[6:2]];
	4'b1001: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.ifu.icv.idcv_ary_1001[rd_index_d1[6:2]];
	4'b1010: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.ifu.icv.idcv_ary_1010[rd_index_d1[6:2]];
	4'b1011: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.ifu.icv.idcv_ary_1011[rd_index_d1[6:2]];
	4'b1100: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.ifu.icv.idcv_ary_1100[rd_index_d1[6:2]];
	4'b1101: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.ifu.icv.idcv_ary_1101[rd_index_d1[6:2]];
	4'b1110: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.ifu.icv.idcv_ary_1110[rd_index_d1[6:2]];
	4'b1111: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.ifu.icv.idcv_ary_1111[rd_index_d1[6:2]];
	endcase
	case (way[1:0])
	2'b00 :
	      temp_tag = `TOP_DESIGN.sparc0.ifu.ict.ictag_ary_00[index_y[6:0]];
	2'b01 :
	      temp_tag = `TOP_DESIGN.sparc0.ifu.ict.ictag_ary_01[index_y[6:0]];
	2'b10 :
	      temp_tag = `TOP_DESIGN.sparc0.ifu.ict.ictag_ary_10[index_y[6:0]];
	2'b11 :
	      temp_tag = `TOP_DESIGN.sparc0.ifu.ict.ictag_ary_11[index_y[6:0]];
	endcase
`else
	      cache_set_vld[way] = `TOP_DESIGN.sparc0.ifu.icv.idcv_ary[{rd_index_d1[6:0],way[1:0]}];
	      temp_tag = `TOP_DESIGN.sparc0.ifu.ict.ictag_ary[{index_y[6:0],way[1:0]}];
`endif
	      cache_tag_way[way] = {temp_tag[27:0],va_bit_11,va_bit_10};
	      cache_way_hit[way] = (cache_tag_way[way] == pgnum_m[29:0]) & cache_set_vld[way];
	      if (err_inj_dbg == 1'b1)
		begin
		   $display ("%d: pg_num_m = %h, index_y = %h, way = %h, vld = %h, tag = %h, hit = %h\n", $time,pgnum_m,index_y,way,cache_set_vld[way],cache_tag_way[way],cache_way_hit[way]);
		end
	   end

`ifdef FPGA_SYN
	case (index_f[1:0])
	2'b00: 
	 fetdata = {`TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_11[index_f[9:2]],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_10[index_f[9:2]],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_01[index_f[9:2]],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_00[index_f[9:2]]};
	2'b01: 
	 fetdata = {`TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_11[index_f[9:2]],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_10[index_f[9:2]],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_01[index_f[9:2]],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_00[index_f[9:2]]};
	2'b10: 
	 fetdata = {`TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_11[index_f[9:2]],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_10[index_f[9:2]],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_01[index_f[9:2]],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_00[index_f[9:2]]};
	2'b11: 
	 fetdata = {`TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_11[index_f[9:2]],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_10[index_f[9:2]],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_01[index_f[9:2]],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_00[index_f[9:2]]};
	endcase
	 
	case (top_index[1:0])
	2'b00:
	 topdata = {`TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_11[top_index[9:2]],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_10[top_index[9:2]],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_01[top_index[9:2]],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_00[top_index[9:2]]};
	2'b01:
	 topdata = {`TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_11[top_index[9:2]],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_10[top_index[9:2]],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_01[top_index[9:2]],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_00[top_index[9:2]]};
	2'b10:
	 topdata = {`TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_11[top_index[9:2]],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_10[top_index[9:2]],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_01[top_index[9:2]],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_00[top_index[9:2]]};
	2'b11:
	 topdata = {`TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_11[top_index[9:2]],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_10[top_index[9:2]],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_01[top_index[9:2]],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_00[top_index[9:2]]};
	endcase

	 tagdata = {`TOP_DESIGN.sparc0.ifu.ict.ictag_ary_11[index_y[6:0]],
			`TOP_DESIGN.sparc0.ifu.ict.ictag_ary_10[index_y[6:0]],
			`TOP_DESIGN.sparc0.ifu.ict.ictag_ary_01[index_y[6:0]],
			`TOP_DESIGN.sparc0.ifu.ict.ictag_ary_00[index_y[6:0]]};
`else
	 fetdata = {`TOP_DESIGN.sparc0.ifu.icd.icdata_ary[{index_f,2'b11}],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary[{index_f,2'b10}],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary[{index_f,2'b01}],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary[{index_f,2'b00}]};
	 
	 topdata = {`TOP_DESIGN.sparc0.ifu.icd.icdata_ary[{top_index,2'b11}],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary[{top_index,2'b10}],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary[{top_index,2'b01}],
		    `TOP_DESIGN.sparc0.ifu.icd.icdata_ary[{top_index,2'b00}]};

	 tagdata = {`TOP_DESIGN.sparc0.ifu.ict.ictag_ary[{index_y[6:0],2'b11}],
		    `TOP_DESIGN.sparc0.ifu.ict.ictag_ary[{index_y[6:0],2'b10}],
		    `TOP_DESIGN.sparc0.ifu.ict.ictag_ary[{index_y[6:0],2'b01}],
		    `TOP_DESIGN.sparc0.ifu.ict.ictag_ary[{index_y[6:0],2'b00}]};
`endif
	 
	 if (cache_way_hit[0] == 1'b1)
	   begin
	      if (err_inj_dbg == 1'b1)
		begin
		   $display ("%d: W0 IR data b/e: %h\n",$time,fetdata[33:0]);
		   $display ("%d: W0 NIR data b/e: %h\n",$time,topdata[33:0]);
		   $display ("%d: W0 tag b/e: %h\n",$time,tagdata[29:0]);		   		   
		end
	      par = ^fetdata[33:0];
	      if (par == 1'b0)
		begin
	      	   fetdata[33:0] = fetdata[33:0] ^ err_mask_ir;
`ifdef FPGA_SYN
		case (index_f[1:0])
		2'b00:
	           `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_00[index_f[9:2]] = fetdata[33:0];
		2'b01:
	           `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_00[index_f[9:2]] = fetdata[33:0];
		2'b10:
	           `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_00[index_f[9:2]] = fetdata[33:0];
		2'b11:
	           `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_00[index_f[9:2]] = fetdata[33:0];
		endcase
`else
	           `TOP_DESIGN.sparc0.ifu.icd.icdata_ary[{index_f,2'b00}] = fetdata[33:0];
`endif
		end
	      par = ^topdata[33:0];
	      if (par == 1'b0)
		begin
	           topdata[33:0] = topdata[33:0] ^ err_mask_nir;
`ifdef FPGA_SYN
		case(top_index[1:0])
		2'b00:
		   `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_00[top_index[9:2]] = topdata[33:0];
		2'b01:
		   `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_00[top_index[9:2]] = topdata[33:0];
		2'b10:
		   `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_00[top_index[9:2]] = topdata[33:0];
		2'b11:
		   `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_00[top_index[9:2]] = topdata[33:0];
		endcase
`else
		   `TOP_DESIGN.sparc0.ifu.icd.icdata_ary[{top_index,2'b00}] = topdata[33:0];
`endif
		end
	      par = ^tagdata[32:0];
	      if (par == 1'b0)
		begin
		   tagdata[32:0] = tagdata[32:0] ^ err_mask_tag;
`ifdef FPGA_SYN
		   `TOP_DESIGN.sparc0.ifu.ict.ictag_ary_00[index_y[6:0]] = tagdata[32:0];
`else
		   `TOP_DESIGN.sparc0.ifu.ict.ictag_ary[{index_y[6:0],2'b00}] = tagdata[32:0];
`endif
		end
	      if (err_inj_dbg == 1'b1)
		begin
		   $display ("%d: W0 IR data a/e: %h\n",$time,fetdata[33:0]);
		   $display ("%d: W0 NIR data a/e: %h\n",$time,topdata[33:0]);
		   $display ("%d: W0 tag a/e: %h\n",$time,tagdata[29:0]);		   		   
		end
	   end
	 else if (cache_way_hit[1] == 1'b1)
	   begin
	      if (err_inj_dbg == 1'b1)
		begin
		   $display ("%d: W1 IR data b/e: %h\n",$time,fetdata[67:34]);
		   $display ("%d: W1 NIR data b/e: %h\n",$time,topdata[67:34]);
		   $display ("%d: W1 tag b/e: %h\n",$time,tagdata[62:33]);		   		   
		end
	      par = ^fetdata[67:34];
	      if (par == 1'b0)
		begin
	      	   fetdata[67:34] = fetdata[67:34] ^ err_mask_ir;
`ifdef FPGA_SYN
		case (index_f[1:0])
		2'b00:
	           `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_01[index_f[9:2]] = fetdata[67:34];
		2'b01:
	           `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_01[index_f[9:2]] = fetdata[67:34];
		2'b10:
	           `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_01[index_f[9:2]] = fetdata[67:34];
		2'b11:
	           `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_01[index_f[9:2]] = fetdata[67:34];
		endcase
`else
	           `TOP_DESIGN.sparc0.ifu.icd.icdata_ary[{index_f,2'b01}] = fetdata[67:34];
`endif
		end
	      par = ^topdata[67:34];
	      if (par == 1'b0)
		begin
	           topdata[67:34] = topdata[67:34] ^ err_mask_nir;
`ifdef FPGA_SYN
		case (top_index[1:0])
		2'b00:
		   `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_01[top_index[9:2]] = topdata[67:34];
		2'b01:
		   `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_01[top_index[9:2]] = topdata[67:34];
		2'b10:
		   `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_01[top_index[9:2]] = topdata[67:34];
		2'b11:
		   `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_01[top_index[9:2]] = topdata[67:34];
		endcase
`else
		   `TOP_DESIGN.sparc0.ifu.icd.icdata_ary[{top_index,2'b01}] = topdata[67:34];
`endif
		end
	      par = ^tagdata[65:33];
	      if (par == 1'b0)
		begin
		   tagdata[65:33] = tagdata[65:33] ^ err_mask_tag;
`ifdef FPGA_SYN
		   `TOP_DESIGN.sparc0.ifu.ict.ictag_ary_01[index_y[6:0]] = tagdata[65:33];
`else
		   `TOP_DESIGN.sparc0.ifu.ict.ictag_ary[{index_y[6:0],2'b01}] = tagdata[65:33];
`endif
		end
	      if (err_inj_dbg == 1'b1)
		begin
		   $display ("%d: W1 IR data a/e: %h\n",$time,fetdata[67:34]);
		   $display ("%d: W1 NIR data a/e: %h\n",$time,topdata[67:34]);
		   $display ("%d: W1 tag a/e: %h\n",$time,tagdata[62:33]);		   		   
		end
	   end
	 else if (cache_way_hit[2] == 1'b1)
	   begin
	      if (err_inj_dbg == 1'b1)
		begin
		   $display ("%d: W2 IR data b/e: %h\n",$time,fetdata[101:68]);
		   $display ("%d: W2 NIR data b/e: %h\n",$time,topdata[101:68]);
		   $display ("%d: W2 tag b/e: %h\n",$time,tagdata[95:66]);		   		   
		end
	      par = ^fetdata[101:68];
	      if (par == 1'b0)
		begin
	      	   fetdata[101:68] = fetdata[101:68] ^ err_mask_ir;
`ifdef FPGA_SYN
		case (index_f[1:0])
		2'b00:
	           `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_10[index_f[9:2]] = fetdata[101:68];
		2'b01:
	           `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_10[index_f[9:2]] = fetdata[101:68];
		2'b10:
	           `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_10[index_f[9:2]] = fetdata[101:68];
		2'b11:
	           `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_10[index_f[9:2]] = fetdata[101:68];
		endcase
`else
	           `TOP_DESIGN.sparc0.ifu.icd.icdata_ary[{index_f,2'b10}] = fetdata[101:68];
`endif
		end
	      par = ^topdata[101:68];
	      if (par == 1'b0)
		begin
	           topdata[101:68] = topdata[101:68] ^ err_mask_nir;
`ifdef FPGA_SYN
		case (top_index[1:0])
		2'b00:
		   `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_10[top_index[9:2]] = topdata[101:68];
		2'b01:
		   `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_10[top_index[9:2]] = topdata[101:68];
		2'b10:
		   `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_10[top_index[9:2]] = topdata[101:68];
		2'b11:
		   `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_10[top_index[9:2]] = topdata[101:68];
		endcase
`else
		   `TOP_DESIGN.sparc0.ifu.icd.icdata_ary[{top_index,2'b10}] = topdata[101:68];
`endif
		end
	      par = ^tagdata[98:66];
	      if (par == 1'b0)
		begin
		   tagdata[98:66] = tagdata[98:66] ^ err_mask_tag;
`ifdef FPGA_SYN
		   `TOP_DESIGN.sparc0.ifu.ict.ictag_ary_10[index_y[6:0]] = tagdata[98:66];
`else
		   `TOP_DESIGN.sparc0.ifu.ict.ictag_ary[{index_y[6:0],2'b10}] = tagdata[98:66];
`endif
		end
	      if (err_inj_dbg == 1'b1)
		begin
		   $display ("%d: W2 IR data a/e: %h\n",$time,fetdata[101:68]);
		   $display ("%d: W2 NIR data a/e: %h\n",$time,topdata[101:68]);
		   $display ("%d: W2 tag a/e: %h\n",$time,tagdata[95:66]);		   		   
		end
	   end
	 else if (cache_way_hit[3] == 1'b1)
	   begin
	      if (err_inj_dbg == 1'b1)
		begin
		   $display ("%d: W3 IR data b/e: %h\n",$time,fetdata[135:102]);
		   $display ("%d: W3 NIR data b/e: %h\n",$time,topdata[135:102]);
		   $display ("%d: W3 tag b/e: %h\n",$time,tagdata[128:99]);		   		   
		end
	      par = ^fetdata[135:102];
	      if (par == 1'b0)
		begin
	      	   fetdata[135:102] = fetdata[135:102] ^ err_mask_ir;
`ifdef FPGA_SYN
		case (index_f[1:0])
		2'b00:
	           `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_11[index_f[9:2]] = fetdata[135:102];
		2'b01:
	           `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_11[index_f[9:2]] = fetdata[135:102];
		2'b10:
	           `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_11[index_f[9:2]] = fetdata[135:102];
		2'b11:
	           `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_11[index_f[9:2]] = fetdata[135:102];
		endcase
`else
	           `TOP_DESIGN.sparc0.ifu.icd.icdata_ary[{index_f,2'b11}] = fetdata[135:102];
`endif
		end
	      par = ^topdata[135:102];
	      if (par == 1'b0)
		begin
	           topdata[135:102] = topdata[135:102] ^ err_mask_nir;
`ifdef FPGA_SYN
		case (top_index[1:0])
		2'b00:
		   `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_11[top_index[9:2]] = topdata[135:102];
		2'b01:
		   `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_11[top_index[9:2]] = topdata[135:102];
		2'b10:
		   `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_11[top_index[9:2]] = topdata[135:102];
		2'b11:
		   `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_11[top_index[9:2]] = topdata[135:102];
		endcase
`else
		   `TOP_DESIGN.sparc0.ifu.icd.icdata_ary[{top_index,2'b11}] = topdata[135:102];
`endif
		end
	      par = ^tagdata[131:99];
	      if (par == 1'b0)
		begin
		   tagdata[131:99] = tagdata[131:99] ^ err_mask_tag;
`ifdef FPGA_SYN
		   `TOP_DESIGN.sparc0.ifu.ict.ictag_ary_11[index_y[6:0]] = tagdata[131:99];
`else
		   `TOP_DESIGN.sparc0.ifu.ict.ictag_ary[{index_y[6:0],2'b11}] = tagdata[131:99];
`endif
		end
	      if (err_inj_dbg == 1'b1)
		begin
		   $display ("%d: W3 IR data a/e: %h\n",$time,fetdata[135:102]);
		   $display ("%d: W3 NIR data a/e: %h\n",$time,topdata[135:102]);
		   $display ("%d: W3 tag a/e: %h\n",$time,tagdata[128:99]);		   		   
		end
	   end

//	 force `TOP_DESIGN.sparc0.ifu.icd.fetdata_f = fetdata;
	 force `TOP_DESIGN.sparc0.ifu.icd.fetdata_sa = fetdata;	 
//	 force `TOP_DESIGN.sparc0.ifu.icd.topdata_f = topdata;
	 force `TOP_DESIGN.sparc0.ifu.icd.topdata_sa = topdata;	 	 
//       force `TOP_DESIGN.sparc0.ifu.ict.rdtag_bl_y = tagdata;
	 force `TOP_DESIGN.sparc0.ifu.ict.rdtag_sa_y = tagdata;	 
	 
      end
   endtask // inj_ic_err_hdl

   task chk_frf_ce;
      
     input [31:0] d;
     input [6:0] p;
     output ce;

      begin
	ce = (p[0]^(d[0]^d[1])^(d[3]^d[4])^(d[6]^d[8])
                     ^(d[10]^d[11])^(d[13]^d[15])^(d[17]^d[19])
		     ^(d[21]^d[23])^(d[25]^d[26])^(d[28]^d[30])) ^
	     (( (((p[1]^p[2])^(p[3]^p[4])) ^
		  ((p[5]^p[6])^(d[2]^d[5]))) ^		 
		  (((d[7]^d[9])^(d[12]^d[14])) ^
		  ((d[16]^d[18])^(d[20]^d[22]))) ) ^
		  ((d[24]^d[27])^(d[29]^d[31])) );
      end
      
   endtask // endtask
   
   task inj_frf_err_hdl;
      
      input [77:0]  err_mask_frf_rs1;
      input [77:0]  err_mask_frf_rs2_rd;
      input fst;
      input err_inj_dbg;

      reg [7:0] regfile_index_low;
      reg [7:0] regfile_index_high;
      reg [38:0] reg_low_data,reg_high_data;
      reg ce_high, ce_low;

      begin

	 if (fst == 1'b1)
	   begin
	      regfile_index_low = {`TOP_DESIGN.sparc0.ffu.frf.ctl_frf_addr[6:0],1'b0};
	      regfile_index_high = {`TOP_DESIGN.sparc0.ffu.frf.ctl_frf_addr[6:0],1'b1};
`ifdef FPGA_SYN
	      reg_high_data = `TOP_DESIGN.sparc0.ffu.frf.regfile_high[regfile_index_high[7:1]];
	      reg_low_data = `TOP_DESIGN.sparc0.ffu.frf.regfile_low[regfile_index_low[7:1]];
`else
	      if (err_inj_dbg == 1'b1)
	   	begin
		   $display ("%d: RS2: even_reg = %h: odd_reg = %h b/e\n",$time,`TOP_DESIGN.sparc0.ffu.frf.regfile[regfile_index_high],`TOP_DESIGN.sparc0.ffu.frf.regfile[regfile_index_low]);
	   	end
	      
	      reg_high_data = `TOP_DESIGN.sparc0.ffu.frf.regfile[regfile_index_high];
	      reg_low_data = `TOP_DESIGN.sparc0.ffu.frf.regfile[regfile_index_low];
`endif
	      chk_frf_ce (reg_low_data[31:0],
			  reg_low_data[38:32],
			  ce_low);
	      chk_frf_ce (reg_high_data[31:0],
			  reg_high_data[38:32],
			  ce_high);

	      if (ce_high == 1'b0)
		begin
`ifdef FPGA_SYN
     		   `TOP_DESIGN.sparc0.ffu.frf.regfile_high[regfile_index_high[7:1]] = reg_high_data ^ err_mask_frf_rs2_rd[77:39];
`else
     		   `TOP_DESIGN.sparc0.ffu.frf.regfile[regfile_index_high] = reg_high_data ^ err_mask_frf_rs2_rd[77:39];
`endif
		end
	      if (ce_low == 1'b0)
		begin
`ifdef FPGA_SYN
	           `TOP_DESIGN.sparc0.ffu.frf.regfile_low[regfile_index_low[7:1]] = reg_low_data ^ err_mask_frf_rs2_rd[38:0];
`else
	           `TOP_DESIGN.sparc0.ffu.frf.regfile[regfile_index_low] = reg_low_data ^ err_mask_frf_rs2_rd[38:0];
`endif
		end

`ifdef FPGA_SYN
`else
	      if (err_inj_dbg == 1'b1)
	   	begin
		   $display ("%d: RS2: even_reg = %h: odd_reg = %h: existing ce high = %b: existing ce low = %b a/e\n",$time,`TOP_DESIGN.sparc0.ffu.frf.regfile[regfile_index_high],`TOP_DESIGN.sparc0.ffu.frf.regfile[regfile_index_low],ce_high,ce_low);	      
	   	end
`endif
	   end // if (fst == 1'b1)
	 else
	   begin
  	      regfile_index_low = {`TOP_DESIGN.sparc0.ffu.ctl.tid_e[1:0],`TOP_DESIGN.sparc0.ffu.ctl.rs2_e[5:1],1'b0};
  	      regfile_index_high = {`TOP_DESIGN.sparc0.ffu.ctl.tid_e[1:0],`TOP_DESIGN.sparc0.ffu.ctl.rs2_e[5:1],1'b1};	      
`ifdef FPGA_SYN
	      reg_high_data = `TOP_DESIGN.sparc0.ffu.frf.regfile_high[regfile_index_high[7:1]];
	      reg_low_data = `TOP_DESIGN.sparc0.ffu.frf.regfile_low[regfile_index_low[7:1]];
`else
	      if (err_inj_dbg == 1'b1)
	   	begin
		   $display ("%d: Rs2: fst = %1b; regfile_index_high = %2h; regfile_index_low = %2h\n",$time,fst,regfile_index_high,regfile_index_low);	      
		   $display ("%d: RS2: even_reg = %h: odd_reg = %h b/e\n",$time,`TOP_DESIGN.sparc0.ffu.frf.regfile[regfile_index_high],`TOP_DESIGN.sparc0.ffu.frf.regfile[regfile_index_low]);
	   	end
	      reg_high_data = `TOP_DESIGN.sparc0.ffu.frf.regfile[regfile_index_high];
	      reg_low_data = `TOP_DESIGN.sparc0.ffu.frf.regfile[regfile_index_low];
`endif
	      chk_frf_ce (reg_low_data[31:0],
			  reg_low_data[38:32],
			  ce_low);
	      chk_frf_ce (reg_high_data[31:0],
			  reg_high_data[38:32],
			  ce_high);

	      if (ce_high == 1'b0)
		begin
`ifdef FPGA_SYN
     		   `TOP_DESIGN.sparc0.ffu.frf.regfile_high[regfile_index_high[7:1]] = reg_high_data ^ err_mask_frf_rs2_rd[77:39];
`else
     		   `TOP_DESIGN.sparc0.ffu.frf.regfile[regfile_index_high] = reg_high_data ^ err_mask_frf_rs2_rd[77:39];
`endif
		end
	      if (ce_low == 1'b0)
		begin
`ifdef FPGA_SYN
	           `TOP_DESIGN.sparc0.ffu.frf.regfile_low[regfile_index_low[7:1]] = reg_low_data ^ err_mask_frf_rs2_rd[38:0];
`else
	           `TOP_DESIGN.sparc0.ffu.frf.regfile[regfile_index_low] = reg_low_data ^ err_mask_frf_rs2_rd[38:0];
`endif
		end
	      
`ifdef FPGA_SYN
`else
	      if (err_inj_dbg == 1'b1)
	   	begin
		   $display ("%d: RS2: even_reg = %h: odd_reg = %h a/e\n",$time,`TOP_DESIGN.sparc0.ffu.frf.regfile[regfile_index_high],`TOP_DESIGN.sparc0.ffu.frf.regfile[regfile_index_low]);
	   	end
`endif

	      //For rs1
  	      regfile_index_low = {`TOP_DESIGN.sparc0.ffu.ctl.tid_e[1:0],`TOP_DESIGN.sparc0.ffu.ctl.rs1_e[5:1],1'b0};
  	      regfile_index_high = {`TOP_DESIGN.sparc0.ffu.ctl.tid_e[1:0],`TOP_DESIGN.sparc0.ffu.ctl.rs1_e[5:1],1'b1};	      
`ifdef FPGA_SYN
	      reg_high_data = `TOP_DESIGN.sparc0.ffu.frf.regfile_high[regfile_index_high[7:1]];
	      reg_low_data = `TOP_DESIGN.sparc0.ffu.frf.regfile_low[regfile_index_low[7:1]];
`else
	      if (err_inj_dbg == 1'b1)
	   	begin
		   $display ("%d: Rs1: fst = %1b; regfile_index_high = %2h; regfile_index_low = %2h\n",$time,fst,regfile_index_high,regfile_index_low);	      	 
		   $display ("%d: RS1: even_reg = %h: odd_reg = %h b/e\n",$time,`TOP_DESIGN.sparc0.ffu.frf.regfile[regfile_index_high],`TOP_DESIGN.sparc0.ffu.frf.regfile[regfile_index_low]);
	   	end
	      reg_high_data = `TOP_DESIGN.sparc0.ffu.frf.regfile[regfile_index_high];
	      reg_low_data = `TOP_DESIGN.sparc0.ffu.frf.regfile[regfile_index_low];
`endif
	      chk_frf_ce (reg_low_data[31:0],
			  reg_low_data[38:32],
			  ce_low);
	      chk_frf_ce (reg_high_data[31:0],
			  reg_high_data[38:32],
			  ce_high);

	      if (ce_high == 1'b0)
		begin
`ifdef FPGA_SYN
     		   `TOP_DESIGN.sparc0.ffu.frf.regfile_high[regfile_index_high[7:1]] = reg_high_data ^ err_mask_frf_rs1[77:39];
`else
     		   `TOP_DESIGN.sparc0.ffu.frf.regfile[regfile_index_high] = reg_high_data ^ err_mask_frf_rs1[77:39];
`endif
		end
	      if (ce_low == 1'b0)
		begin
`ifdef FPGA_SYN
	           `TOP_DESIGN.sparc0.ffu.frf.regfile_low[regfile_index_low[7:1]] = reg_low_data ^ err_mask_frf_rs1[38:0];
`else
	           `TOP_DESIGN.sparc0.ffu.frf.regfile[regfile_index_low] = reg_low_data ^ err_mask_frf_rs1[38:0];
`endif
		end
`ifdef FPGA_SYN
`else      
	      if (err_inj_dbg == 1'b1)
	   	begin
		   $display ("%d: RS1: even_reg = %h: odd_reg = %h a/e\n",$time,`TOP_DESIGN.sparc0.ffu.frf.regfile[regfile_index_high],`TOP_DESIGN.sparc0.ffu.frf.regfile[regfile_index_low]);
	   	end
`endif
	   end // else: !if(fst == 1'b1)
      end
   endtask // inj_frf_err_hdl
   
   task inj_dc_data_err_hdl;

      input [71:0] err_mask_data;
      input err_inj_dbg;

      reg [7:0] parity_err;
      reg [2:0] way;
      integer i, index;
      reg [143:0] temp_data;
      reg addr_msb,va_bit_10;
      reg [29:0] pgnum_m,temp_tag;
      reg [6:0] index_y,rd_index_d1;     //M-stage
      reg [29:0] cache_tag_way[0:3];
      reg [3:0] cache_set_vld, cache_way_hit;
      
      begin
	 index_y     = `TOP_DESIGN.sparc0.lsu.dtag.index_y;
	 rd_index_d1 = `TOP_DESIGN.sparc0.lsu.dva.rd_index_d1;
	 pgnum_m     = `TOP_DESIGN.sparc0.lsu.dtlb.pgnum_m;
	 va_bit_10   = `TOP_DESIGN.sparc0.lsu.lsu_ldst_va_m[10];

	 for (way = 0; way < 4; way = way + 1)
	   begin
`ifdef FPGA_SYN
	case ({rd_index_d1[1:0],way[1:0]}) 
	4'b0000: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_0000[rd_index_d1[6:2]];
	4'b0001: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_0001[rd_index_d1[6:2]];
	4'b0010: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_0010[rd_index_d1[6:2]];
	4'b0011: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_0011[rd_index_d1[6:2]];
	4'b0100: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_0100[rd_index_d1[6:2]];
	4'b0101: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_0101[rd_index_d1[6:2]];
	4'b0110: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_0110[rd_index_d1[6:2]];
	4'b0111: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_0111[rd_index_d1[6:2]];
	4'b1000: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_1000[rd_index_d1[6:2]];
	4'b1001: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_1001[rd_index_d1[6:2]];
	4'b1010: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_1010[rd_index_d1[6:2]];
	4'b1011: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_1011[rd_index_d1[6:2]];
	4'b1100: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_1100[rd_index_d1[6:2]];
	4'b1101: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_1101[rd_index_d1[6:2]];
	4'b1110: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_1110[rd_index_d1[6:2]];
	4'b1111: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_1111[rd_index_d1[6:2]];
	endcase
	case (way[1:0]) 
	2'b00:
	      temp_tag = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_00[index_y[6:0]];
	2'b01:
	      temp_tag = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_01[index_y[6:0]];
	2'b10:
	      temp_tag = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_10[index_y[6:0]];
	2'b11:
	      temp_tag = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_11[index_y[6:0]];
	endcase
`else
	      cache_set_vld[way] = `TOP_DESIGN.sparc0.lsu.dva.idcv_ary[{rd_index_d1[6:0],way[1:0]}];
	      temp_tag = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index_y[6:0],way[1:0]}];
`endif
	      cache_tag_way[way] = {temp_tag[28:0],va_bit_10};
	      cache_way_hit[way] = (cache_tag_way[way] == pgnum_m[29:0]) & cache_set_vld[way];
	      if (err_inj_dbg == 1'b1)
		begin
		   $display ("%d: pg_num_m = %h, index_y = %h, way = %h, vld = %h, tag = %h, hit = %h\n", $time,pgnum_m,index_y,way,cache_set_vld[way],cache_tag_way[way],cache_way_hit[way]);
		end
	   end

	 for (i = 0; i < 128; i=i+1)
	   begin
	      if (`TOP_DESIGN.sparc0.lsu.dcache.rw_wdline[i] == 1'b1)
		begin
		   index = i;
		end
	   end
	 
	 addr_msb = `TOP_DESIGN.sparc0.lsu.dcache.dcache_rwaddr_m[3];

	 if (cache_way_hit[0] == 1'b1)
	   begin
	      temp_data = `TOP_DESIGN.sparc0.lsu.dcache.w0[index];
	      if (err_inj_dbg == 1'b1)
		begin
		   $display ("%d: W0 data b/e: %h\n", $time,temp_data);
		end
	      if (addr_msb == 1'b1)
		begin
		   parity_err = {^temp_data[79:72] ^ temp_data[7],
				 ^temp_data[71:64] ^ temp_data[6],				      
				 ^temp_data[63:56] ^ temp_data[5],
				 ^temp_data[55:48] ^ temp_data[4],
				 ^temp_data[47:40] ^ temp_data[3],
				 ^temp_data[39:32] ^ temp_data[2],
				 ^temp_data[31:24] ^ temp_data[1],
				 ^temp_data[23:16] ^ temp_data[0]
				 };
		   if (|parity_err == 1'b0)
		     begin
		     	temp_data = {temp_data[143:80],temp_data[79:16] ^ err_mask_data[71:8],
				     temp_data[15:8], temp_data[7:0] ^ err_mask_data[7:0]};
		     end
		end
	      else
		begin
		   parity_err = {^temp_data[143:136] ^ temp_data[15],
				 ^temp_data[135:128] ^ temp_data[14],				      
				 ^temp_data[127:120] ^ temp_data[13],
				 ^temp_data[121:114] ^ temp_data[12],
				 ^temp_data[113:112] ^ temp_data[11],
				 ^temp_data[103:96]  ^ temp_data[10],
				 ^temp_data[95:88]   ^ temp_data[9],
				 ^temp_data[87:80]   ^ temp_data[8]
				 };
		   if (|parity_err == 1'b0)
		     begin
		     	temp_data = {temp_data[143:80] ^ err_mask_data[71:8],temp_data[79:16],
				     temp_data[15:8] ^ err_mask_data[7:0], temp_data[7:0]};
		     end
		end
	      force `TOP_DESIGN.sparc0.lsu.dcache.temp_w0a_reg = temp_data;      
              `TOP_DESIGN.sparc0.lsu.dcache.w0[index] = temp_data;
	      if (err_inj_dbg == 1'b1)
		begin
		   $display ("%d: W0 data a/e: %h\n", $time,temp_data);
		end
	   end // if (cache_way_hit[0] == 1'b1)
	 
	 else if (cache_way_hit[1] == 1'b1)
	   begin
	      temp_data = `TOP_DESIGN.sparc0.lsu.dcache.w1[index];
	      if (err_inj_dbg == 1'b1)
		begin
		   $display ("%d: W1 data b/e: %h\n", $time,temp_data);
		end
	      if (addr_msb == 1'b1)
		begin
		   parity_err = {^temp_data[79:72] ^ temp_data[7],
				 ^temp_data[71:64] ^ temp_data[6],				      
				 ^temp_data[63:56] ^ temp_data[5],
				 ^temp_data[55:48] ^ temp_data[4],
				 ^temp_data[47:40] ^ temp_data[3],
				 ^temp_data[39:32] ^ temp_data[2],
				 ^temp_data[31:24] ^ temp_data[1],
				 ^temp_data[23:16] ^ temp_data[0]
				 };
		   if (|parity_err == 1'b0)
		     begin
		     	temp_data = {temp_data[143:80],temp_data[79:16] ^ err_mask_data[71:8],
				     temp_data[15:8], temp_data[7:0] ^ err_mask_data[7:0]};
		     end
		end
	      else
		begin
		   parity_err = {^temp_data[143:136] ^ temp_data[15],
				 ^temp_data[135:128] ^ temp_data[14],				      
				 ^temp_data[127:120] ^ temp_data[13],
				 ^temp_data[121:114] ^ temp_data[12],
				 ^temp_data[113:112] ^ temp_data[11],
				 ^temp_data[103:96]  ^ temp_data[10],
				 ^temp_data[95:88]   ^ temp_data[9],
				 ^temp_data[87:80]   ^ temp_data[8]
				 };
		   if (|parity_err == 1'b0)
		     begin
		     	temp_data = {temp_data[143:80] ^ err_mask_data[71:8],temp_data[79:16],
				     temp_data[15:8] ^ err_mask_data[7:0], temp_data[7:0]};
		     end
		end
	      force `TOP_DESIGN.sparc0.lsu.dcache.temp_w1a_reg = temp_data;      
              `TOP_DESIGN.sparc0.lsu.dcache.w1[index] = temp_data;
	      if (err_inj_dbg == 1'b1)
		begin
		   $display ("%d: W1 data a/e: %h\n", $time,temp_data);
		end
	   end // if (cache_way_hit[1] == 1'b1)
	 
	 else if (cache_way_hit[2] == 1'b1)
	   begin
	      temp_data = `TOP_DESIGN.sparc0.lsu.dcache.w2[index];
	      if (err_inj_dbg == 1'b1)
		begin
		   $display ("%d: W2 data b/e: %h\n", $time,temp_data);
		end
	      if (addr_msb == 1'b1)
		begin
		   parity_err = {^temp_data[79:72] ^ temp_data[7],
				 ^temp_data[71:64] ^ temp_data[6],				      
				 ^temp_data[63:56] ^ temp_data[5],
				 ^temp_data[55:48] ^ temp_data[4],
				 ^temp_data[47:40] ^ temp_data[3],
				 ^temp_data[39:32] ^ temp_data[2],
				 ^temp_data[31:24] ^ temp_data[1],
				 ^temp_data[23:16] ^ temp_data[0]
				 };
		   if (|parity_err == 1'b0)
		     begin
		     	temp_data = {temp_data[143:80],temp_data[79:16] ^ err_mask_data[71:8],
				     temp_data[15:8], temp_data[7:0] ^ err_mask_data[7:0]};
		     end
		end
	      else
		begin
		   parity_err = {^temp_data[143:136] ^ temp_data[15],
				 ^temp_data[135:128] ^ temp_data[14],				      
				 ^temp_data[127:120] ^ temp_data[13],
				 ^temp_data[121:114] ^ temp_data[12],
				 ^temp_data[113:112] ^ temp_data[11],
				 ^temp_data[103:96]  ^ temp_data[10],
				 ^temp_data[95:88]   ^ temp_data[9],
				 ^temp_data[87:80]   ^ temp_data[8]
				 };
		   if (|parity_err == 1'b0)
		     begin
		     	temp_data = {temp_data[143:80] ^ err_mask_data[71:8],temp_data[79:16],
				     temp_data[15:8] ^ err_mask_data[7:0], temp_data[7:0]};
		     end
		end
	      force `TOP_DESIGN.sparc0.lsu.dcache.temp_w2a_reg = temp_data;      
              `TOP_DESIGN.sparc0.lsu.dcache.w2[index] = temp_data;
	      if (err_inj_dbg == 1'b1)
		begin
		   $display ("%d: W2 data a/e: %h\n", $time,temp_data);
		end
	   end // if (cache_way_hit[2] == 1'b1)
	 
	 else if (cache_way_hit[3] == 1'b1)
	   begin
	      temp_data = `TOP_DESIGN.sparc0.lsu.dcache.w3[index];
	      if (err_inj_dbg == 1'b1)
		begin
		   $display ("%d: W3 data b/e: %h\n", $time,temp_data);
		end
	      if (addr_msb == 1'b1)
		begin
		   parity_err = {^temp_data[79:72] ^ temp_data[7],
				 ^temp_data[71:64] ^ temp_data[6],				      
				 ^temp_data[63:56] ^ temp_data[5],
				 ^temp_data[55:48] ^ temp_data[4],
				 ^temp_data[47:40] ^ temp_data[3],
				 ^temp_data[39:32] ^ temp_data[2],
				 ^temp_data[31:24] ^ temp_data[1],
				 ^temp_data[23:16] ^ temp_data[0]
				 };
		   if (|parity_err == 1'b0)
		     begin
		     	temp_data = {temp_data[143:80],temp_data[79:16] ^ err_mask_data[71:8],
				     temp_data[15:8], temp_data[7:0] ^ err_mask_data[7:0]};
		     end
		end
	      else
		begin
		   parity_err = {^temp_data[143:136] ^ temp_data[15],
				 ^temp_data[135:128] ^ temp_data[14],				      
				 ^temp_data[127:120] ^ temp_data[13],
				 ^temp_data[121:114] ^ temp_data[12],
				 ^temp_data[113:112] ^ temp_data[11],
				 ^temp_data[103:96]  ^ temp_data[10],
				 ^temp_data[95:88]   ^ temp_data[9],
				 ^temp_data[87:80]   ^ temp_data[8]
				 };
		   if (|parity_err == 1'b0)
		     begin
		     	temp_data = {temp_data[143:80] ^ err_mask_data[71:8],temp_data[79:16],
				     temp_data[15:8] ^ err_mask_data[7:0], temp_data[7:0]};
		     end
		end
	      force `TOP_DESIGN.sparc0.lsu.dcache.temp_w3a_reg = temp_data;      
              `TOP_DESIGN.sparc0.lsu.dcache.w3[index] = temp_data;
	      if (err_inj_dbg == 1'b1)
		begin
		   $display ("%d: W3 data a/e: %h\n", $time,temp_data);
		end
	 end // if (cache_way_hit[3] == 1'b1)
      end
      
   endtask // inj_dc_err_hdl
   
   task inj_dc_tag_err_hdl;

      input [29:0] err_mask_tag;
      input err_inj_dbg;

      reg va_bit_10;
      reg [2:0] way;
      reg [131:0] tagdata;
      reg [29:0] pgnum_m;
      reg [32:0] temp_tag;
      reg [6:0] index_y,rd_index_d1; //M-stage
      reg [29:0] cache_tag_way[0:3];
      reg [3:0] cache_set_vld, cache_way_hit;
      
      begin
	 index_y = `TOP_DESIGN.sparc0.lsu.dtag.index_y;
	 rd_index_d1 = `TOP_DESIGN.sparc0.lsu.dva.rd_index_d1;
	 pgnum_m     = `TOP_DESIGN.sparc0.lsu.dtlb.pgnum_m;
	 va_bit_10   = `TOP_DESIGN.sparc0.lsu.lsu_ldst_va_m[10];	 

	 for (way = 0; way < 4; way = way + 1)
	   begin
`ifdef FPGA_SYN
	case ({rd_index_d1[1:0],way[1:0]}) 
	4'b0000: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_0000[rd_index_d1[6:2]];
	4'b0001: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_0001[rd_index_d1[6:2]];
	4'b0010: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_0010[rd_index_d1[6:2]];
	4'b0011: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_0011[rd_index_d1[6:2]];
	4'b0100: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_0100[rd_index_d1[6:2]];
	4'b0101: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_0101[rd_index_d1[6:2]];
	4'b0110: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_0110[rd_index_d1[6:2]];
	4'b0111: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_0111[rd_index_d1[6:2]];
	4'b1000: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_1000[rd_index_d1[6:2]];
	4'b1001: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_1001[rd_index_d1[6:2]];
	4'b1010: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_1010[rd_index_d1[6:2]];
	4'b1011: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_1011[rd_index_d1[6:2]];
	4'b1100: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_1100[rd_index_d1[6:2]];
	4'b1101: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_1101[rd_index_d1[6:2]];
	4'b1110: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_1110[rd_index_d1[6:2]];
	4'b1111: cache_set_vld[way] = 
		`TOP_DESIGN.sparc0.lsu.dva.idcv_ary_1111[rd_index_d1[6:2]];
	endcase
	case (way[1:0])
	2'b00 :
	      temp_tag = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_00[index_y[6:0]];
	2'b01 :
	      temp_tag = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_01[index_y[6:0]];
	2'b10 :
	      temp_tag = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_10[index_y[6:0]];
	2'b11 :
	      temp_tag = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_11[index_y[6:0]];
	endcase
`else
	      cache_set_vld[way] = `TOP_DESIGN.sparc0.lsu.dva.idcv_ary[{rd_index_d1[6:0],way[1:0]}];
	      temp_tag = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index_y[6:0],way[1:0]}];
`endif
	      cache_tag_way[way] = {temp_tag[28:0],va_bit_10};
	      cache_way_hit[way] = (cache_tag_way[way] == pgnum_m[29:0]) & cache_set_vld[way];
	      if (err_inj_dbg == 1'b1)
		begin
		   $display ("%d: pg_num_m = %h, index_y = %h, way = %h, vld = %h, tag = %h, hit = %h\n", $time,pgnum_m,index_y,way,cache_set_vld[way],cache_tag_way[way],cache_way_hit[way]);
		end
	   end	 
`ifdef FPGA_SYN
	 tagdata [131:0] = {`TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_11[index_y[6:0]],
			    `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_10[index_y[6:0]],
			    `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_01[index_y[6:0]],
			    `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_00[index_y[6:0]]};
`else
	 tagdata [131:0] = {`TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index_y[6:0],2'b11}],
			    `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index_y[6:0],2'b10}],
			    `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index_y[6:0],2'b01}],
			    `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index_y[6:0],2'b00}]};
`endif

	 if (cache_way_hit[0] == 1'b1)
	   begin
	      if (err_inj_dbg == 1'b1)
		begin
		   $display ("%d: W0 tag b/e: %h\n", $time,tagdata[29:0]);
		end
	      if (^tagdata[29:0] == 1'b0)
	      	begin
`ifdef FPGA_SYN
		   tagdata[32:0] = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_00[index_y[6:0]] ^ err_mask_tag;
		   `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_00[index_y[6:0]] = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_00[index_y[6:0]] ^ err_mask_tag;
`else
		   tagdata[32:0] = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index_y[6:0],2'b00}] ^ err_mask_tag;
		   `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index_y[6:0],2'b00}] = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index_y[6:0],2'b00}] ^ err_mask_tag;
`endif
		end
	      if (err_inj_dbg == 1'b1)
		begin
		   $display ("%d: W0 tag a/e: %h\n", $time,tagdata[29:0]);
		end
	   end // if (cache_way_hit[0] == 1'b1)

	 else if (cache_way_hit[1] == 1'b1)
	   begin
	      if (err_inj_dbg == 1'b1)
		begin
		   $display ("%d: W1 tag b/e: %h\n", $time,tagdata[62:33]);
		end
	      if (^tagdata[62:33] == 1'b0)
	      	begin	      
`ifdef FPGA_SYN
		   tagdata[65:33] = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_01[index_y[6:0]] ^ err_mask_tag;
		   `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_01[index_y[6:0]] = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_01[index_y[6:0]] ^ err_mask_tag;
`else
		   tagdata[65:33] = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index_y[6:0],2'b01}] ^ err_mask_tag;
		   `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index_y[6:0],2'b01}] = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index_y[6:0],2'b01}] ^ err_mask_tag;
`endif
		end
	      if (err_inj_dbg == 1'b1)
		begin
		   $display ("%d: W1 tag a/e: %h\n", $time,tagdata[62:33]);
		end	      
	   end // if (cache_way_hit[1] == 1'b1)

	 else if (cache_way_hit[2] == 1'b1)
	   begin
	      if (err_inj_dbg == 1'b1)
		begin
		   $display ("%d: W2 tag b/e: %h\n", $time,tagdata[95:66]);
		end
	      if (^tagdata[95:66] == 1'b0)
	      	begin	  
`ifdef FPGA_SYN
		   tagdata[98:66] = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_10[index_y[6:0]] ^ err_mask_tag;
		   `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_10[index_y[6:0]] = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_10[index_y[6:0]] ^ err_mask_tag;
`else
		   tagdata[98:66] = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index_y[6:0],2'b10}] ^ err_mask_tag;
		   `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index_y[6:0],2'b10}] = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index_y[6:0],2'b10}] ^ err_mask_tag;
`endif
		end
	      if (err_inj_dbg == 1'b1)
		begin
		   $display ("%d: W2 tag a/e: %h\n", $time,tagdata[95:66]);
		end	      
	   end // if (cache_way_hit[2] == 1'b1)

	 else if (cache_way_hit[3] == 1'b1)
	   begin
	      if (err_inj_dbg == 1'b1)
		begin
		   $display ("%d: W3 tag b/e: %h\n", $time,tagdata[128:99]);
		end
	      if (^tagdata[128:99] == 1'b0)
	      	begin	  	      
`ifdef FPGA_SYN
		   tagdata[131:99] = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_11[index_y[6:0]] ^ err_mask_tag;
		   `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_11[index_y[6:0]] = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_11[index_y[6:0]] ^ err_mask_tag;
`else
		   tagdata[131:99] = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index_y[6:0],2'b11}] ^ err_mask_tag;
		   `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index_y[6:0],2'b11}] = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index_y[6:0],2'b11}] ^ err_mask_tag;
`endif
		end
	      if (err_inj_dbg == 1'b1)
		begin
		   $display ("%d: W3 tag a/e: %h\n", $time,tagdata[128:99]);
		end	      

	   end // if (cache_way_hit[3] == 1'b1)

//	 force `TOP_DESIGN.sparc0.lsu.dtag.rdtag_bl_y = tagdata;
	 force `TOP_DESIGN.sparc0.lsu.dtag.rdtag_sa_y = tagdata;
	 
      end
      
   endtask // inj_dc_err_hdl

   task inj_itlb_data_err_hdl;
      input [42:0] err_mask_data;
      input err_inj_dbg;
      integer i;
      reg [42:0] data;      

      begin
	 for (i = 0; i < 64; i=i+1)
	   begin
	      if (`TOP_DESIGN.sparc0.ifu.itlb.cam_hit[i] == 1'b1)
		begin
`ifdef FPGA_SYN
		if (i >= 32)
		   data = `TOP_DESIGN.sparc0.ifu.itlb.tte_data_ram1[i-32];
		else
		   data = `TOP_DESIGN.sparc0.ifu.itlb.tte_data_ram0[i];
`else
		   data = `TOP_DESIGN.sparc0.ifu.itlb.tte_data_ram[i];
`endif
		   if (^data == 1'b0)
		     begin
`ifdef FPGA_SYN
		if (i >= 32)
		   `TOP_DESIGN.sparc0.ifu.itlb.tte_data_ram1[i-32] = 
			data ^ err_mask_data;
		else
		   `TOP_DESIGN.sparc0.ifu.itlb.tte_data_ram0[i] = 
			data ^ err_mask_data;
`else
			`TOP_DESIGN.sparc0.ifu.itlb.tte_data_ram[i] = data ^ err_mask_data;
		   	$display ("%d: Injecting ITLB data error: Lookup PC %16h: thr_f %4d: error_mask %h: data a/e %h\n", $time,`TOP_DESIGN.sparc0.ifu.fdp.pc_f,`TOP_DESIGN.sparc0.ifu.fcl.thr_f,err_mask_data,`TOP_DESIGN.sparc0.ifu.itlb.tte_data_ram[i]);
`endif
		     end
		end
	   end
      end
   endtask // inj_itlb_data_err_hdl

   task inj_dtlb_data_err_hdl;
      input [47:0] addr;      
      input [42:0] err_mask_data;
      input err_inj_dbg;
      integer i;
      reg [42:0] data;

      begin
	 for (i = 0; i < 64; i=i+1)
	   begin
	      if (`TOP_DESIGN.sparc0.lsu.dtlb.cam_hit[i] == 1'b1)
		begin
`ifdef FPGA_SYN
		if (i >= 32)
		   data = `TOP_DESIGN.sparc0.lsu.dtlb.tte_data_ram1[i-32];
		else
		   data = `TOP_DESIGN.sparc0.lsu.dtlb.tte_data_ram0[i];
`else
		   data = `TOP_DESIGN.sparc0.lsu.dtlb.tte_data_ram[i];
`endif
		   if (^data == 1'b0)
		     begin
`ifdef FPGA_SYN
		if (i >=32)
			`TOP_DESIGN.sparc0.lsu.dtlb.tte_data_ram1[i-32] = 
				data ^ err_mask_data;
		else
			`TOP_DESIGN.sparc0.lsu.dtlb.tte_data_ram0[i] = 
				data ^ err_mask_data;
`else
			`TOP_DESIGN.sparc0.lsu.dtlb.tte_data_ram[i] = data ^ err_mask_data;
		   	$display ("%d: Injecting DTLB data error: Lookup Address %16h: thr_m %4d: error_mask %h: data a/e %h\n", $time,addr,`TOP_DESIGN.sparc0.ifu.fcl.thr_m,err_mask_data,`TOP_DESIGN.sparc0.lsu.dtlb.tte_data_ram[i]);
`endif
		     end
		end
	   end // for (i = 0; i < 64; i=i+1)
      end
   endtask // inj_dtlb_data_err_hdl
   
   task inj_ic_tag_err_rand_hdl;
      input [31:0] loc;
      input [31:0] bit_num;

      integer i, j;
      reg [29:0] val;

      begin
	 i = loc % 512;
	 j = bit_num % 29;
	 $display ("%d: Injecting IC tag err: index %d: bit %d\n", $time,i, j);	 
`ifdef FPGA_SYN
	case (i[1:0])
	2'b00: begin
	   val = `TOP_DESIGN.sparc0.ifu.ict.ictag_ary_00[i[8:2]];
	   val[j] = val[j] ^ 1'b1;
	   `TOP_DESIGN.sparc0.ifu.ict.ictag_ary_00[i[8:2]] = val;
	   end
	2'b01: begin
	   val = `TOP_DESIGN.sparc0.ifu.ict.ictag_ary_01[i[8:2]];
	   val[j] = val[j] ^ 1'b1;
	   `TOP_DESIGN.sparc0.ifu.ict.ictag_ary_01[i[8:2]] = val;
	   end
	2'b10: begin
	   val = `TOP_DESIGN.sparc0.ifu.ict.ictag_ary_10[i[8:2]];
	   val[j] = val[j] ^ 1'b1;
	   `TOP_DESIGN.sparc0.ifu.ict.ictag_ary_10[i[8:2]] = val;
	   end
	2'b11: begin
	   val = `TOP_DESIGN.sparc0.ifu.ict.ictag_ary_11[i[8:2]];
	   val[j] = val[j] ^ 1'b1;
	   `TOP_DESIGN.sparc0.ifu.ict.ictag_ary_11[i[8:2]] = val;
	   end
	endcase
`else
	 val = `TOP_DESIGN.sparc0.ifu.ict.ictag_ary[i];
	 val[j] = val[j] ^ 1'b1;
	 `TOP_DESIGN.sparc0.ifu.ict.ictag_ary[i] = val;
`endif
      end
   endtask // inj_ic_tag_err_rand_hdl

   task inj_ic_data_err_rand_hdl;
      input [31:0] loc;
      input [31:0] bit_num;

      integer i, j;
      reg [33:0] val;

      begin
	 i = loc % 1024;
	 j = bit_num % 34;
	 $display ("%d: Injecting IC data err: index %d: bit %d\n", $time,i, j);
`ifdef FPGA_SYN
	case (i[3:0])
	4'b0000: begin
		val = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_00[i[11:4]];
	 	val[j] = val[j] ^ 1'b1;
		`TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_00[i[11:4]] = val;
		end
	4'b0001: begin
		val = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_01[i[11:4]];
	 	val[j] = val[j] ^ 1'b1;
		`TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_01[i[11:4]] = val;
		end
	4'b0010: begin
		val = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_10[i[11:4]];
	 	val[j] = val[j] ^ 1'b1;
		`TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_10[i[11:4]] = val;
		end
	4'b0011: begin
		val = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_11[i[11:4]];
	 	val[j] = val[j] ^ 1'b1;
		`TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_11[i[11:4]] = val;
		end
	4'b0100: begin
		val = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_00[i[11:4]];
	 	val[j] = val[j] ^ 1'b1;
		`TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_00[i[11:4]] = val;
		end
	4'b0101: begin
		val = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_01[i[11:4]];
	 	val[j] = val[j] ^ 1'b1;
		`TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_01[i[11:4]] = val;
		end
	4'b0110: begin
		val = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_10[i[11:4]];
	 	val[j] = val[j] ^ 1'b1;
		`TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_10[i[11:4]] = val;
		end
	4'b0111: begin
		val = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_11[i[11:4]];
	 	val[j] = val[j] ^ 1'b1;
		`TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_11[i[11:4]] = val;
		end
	4'b1000: begin
		val = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_00[i[11:4]];
	 	val[j] = val[j] ^ 1'b1;
		`TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_00[i[11:4]] = val;
		end
	4'b1001: begin
		val = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_01[i[11:4]];
	 	val[j] = val[j] ^ 1'b1;
		`TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_01[i[11:4]] = val;
		end
	4'b1010: begin
		val = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_10[i[11:4]];
	 	val[j] = val[j] ^ 1'b1;
		`TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_10[i[11:4]] = val;
		end
	4'b1011: begin
		val = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_11[i[11:4]];
	 	val[j] = val[j] ^ 1'b1;
		`TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_11[i[11:4]] = val;
		end
	4'b1100: begin
		val = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_00[i[11:4]];
	 	val[j] = val[j] ^ 1'b1;
		`TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_00[i[11:4]] = val;
		end
	4'b1101: begin
		val = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_01[i[11:4]];
	 	val[j] = val[j] ^ 1'b1;
		`TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_01[i[11:4]] = val;
		end
	4'b1110: begin
		val = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_10[i[11:4]];
	 	val[j] = val[j] ^ 1'b1;
		`TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_10[i[11:4]] = val;
		end
	4'b1111: begin
		val = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_11[i[11:4]];
	 	val[j] = val[j] ^ 1'b1;
		`TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_11[i[11:4]] = val;
		end
	endcase
`else
	 val = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary[i];
	 val[j] = val[j] ^ 1'b1;
	 `TOP_DESIGN.sparc0.ifu.icd.icdata_ary[i] = val;
`endif
      end
   endtask // inj_ic_data_err_rand_hdl
   
   task inj_irf_err_rand_hdl;
      input [31:0] loc;
      input [31:0] bit_num;

      integer i, j;
      reg [71:0] val;

      begin
	 i = loc % 128; //There are 32 x 4 registers in the regfile
	 j = bit_num % 72;
	 $display ("%d: Injecting IRF err: index %d: bit %d\n", $time,i, j);
`ifdef FPGA_SYN
	 case(i[4:0])
	5'b00000: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00000[i[6:5]];
	5'b00001: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00001[i[6:5]];
	5'b00010: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00010[i[6:5]];
	5'b00011: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00011[i[6:5]];
	5'b00100: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00100[i[6:5]];
	5'b00101: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00101[i[6:5]];
	5'b00110: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00110[i[6:5]];
	5'b00111: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00111[i[6:5]];
	5'b01000: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01000[i[6:5]];
	5'b01001: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01001[i[6:5]];
	5'b01010: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01010[i[6:5]];
	5'b01011: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01011[i[6:5]];
	5'b01100: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01100[i[6:5]];
	5'b01101: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01101[i[6:5]];
	5'b01110: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01110[i[6:5]];
	5'b01111: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01111[i[6:5]];
	5'b10000: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10000[i[6:5]];
	5'b10001: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10001[i[6:5]];
	5'b10010: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10010[i[6:5]];
	5'b10011: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10011[i[6:5]];
	5'b10100: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10100[i[6:5]];
	5'b10101: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10101[i[6:5]];
	5'b10110: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10110[i[6:5]];
	5'b10111: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10111[i[6:5]];
	5'b11000: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11000[i[6:5]];
	5'b11001: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11001[i[6:5]];
	5'b11010: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11010[i[6:5]];
	5'b11011: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11011[i[6:5]];
	5'b11100: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11100[i[6:5]];
	5'b11101: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11101[i[6:5]];
	5'b11110: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11110[i[6:5]];
	5'b11111: val = 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11111[i[6:5]];
        endcase
`else
	 val = `TOP_DESIGN.sparc0.exu.irf.active_window[i];
`endif
	 val[j] = val[j] ^ 1'b1;
`ifdef FPGA_SYN
	 case(i[4:0])
	5'b00000: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00000[i[6:5]] = val;
	5'b00001: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00001[i[6:5]] = val;
	5'b00010: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00010[i[6:5]] = val;
	5'b00011: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00011[i[6:5]] = val;
	5'b00100: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00100[i[6:5]] = val;
	5'b00101: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00101[i[6:5]] = val;
	5'b00110: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00110[i[6:5]] = val;
	5'b00111: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_00111[i[6:5]] = val;
	5'b01000: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01000[i[6:5]] = val;
	5'b01001: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01001[i[6:5]] = val;
	5'b01010: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01010[i[6:5]] = val;
	5'b01011: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01011[i[6:5]] = val;
	5'b01100: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01100[i[6:5]] = val;
	5'b01101: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01101[i[6:5]] = val;
	5'b01110: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01110[i[6:5]] = val;
	5'b01111: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_01111[i[6:5]] = val;
	5'b10000: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10000[i[6:5]] = val;
	5'b10001: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10001[i[6:5]] = val;
	5'b10010: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10010[i[6:5]] = val;
	5'b10011: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10011[i[6:5]] = val;
	5'b10100: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10100[i[6:5]] = val;
	5'b10101: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10101[i[6:5]] = val;
	5'b10110: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10110[i[6:5]] = val;
	5'b10111: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_10111[i[6:5]] = val;
	5'b11000: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11000[i[6:5]] = val;
	5'b11001: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11001[i[6:5]] = val;
	5'b11010: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11010[i[6:5]] = val;
	5'b11011: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11011[i[6:5]] = val;
	5'b11100: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11100[i[6:5]] = val;
	5'b11101: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11101[i[6:5]] = val;
	5'b11110: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11110[i[6:5]] = val;
	5'b11111: 
		`TOP_DESIGN.sparc0.exu.irf.active_window_11111[i[6:5]] = val;
        endcase
`else
	 `TOP_DESIGN.sparc0.exu.irf.active_window[i] = val;
`endif
      end
   endtask // inj_irf_err_rand_hdl

   task inj_frf_err_rand_hdl;
      input [31:0] loc;
      input [31:0] bit_num;

      integer i, j;
      reg [77:0] val;

      begin
	 i = loc % 256;
	 j = bit_num % 78;
	 $display ("%d: Injecting FRF err: index %d: bit %d\n", $time,i, j);
`ifdef FPGA_SYN
	 val = {`TOP_DESIGN.sparc0.ffu.frf.regfile_high[i[7:1]],
	 	`TOP_DESIGN.sparc0.ffu.frf.regfile_low[i[7:1]]};
	 val[j] = val[j] ^ 1'b1;
	 {`TOP_DESIGN.sparc0.ffu.frf.regfile_high[i[7:1]],
	 	`TOP_DESIGN.sparc0.ffu.frf.regfile_low[i[7:1]]} = val;
`else
	 val = `TOP_DESIGN.sparc0.ffu.frf.regfile[i];
	 val[j] = val[j] ^ 1'b1;
	 `TOP_DESIGN.sparc0.ffu.frf.regfile[i] = val;
`endif
      end
   endtask // inj_frf_err_rand_hdl

   task inj_dc_tag_err_rand_hdl;
      input [31:0] loc;
      input [31:0] bit_num;

      integer i, j;
      reg [29:0] val;

      begin
	 i = loc % 512;
	 j = bit_num % 29;
	 $display ("%d: Injecting DC tag err: index %d: bit %d\n", $time,i, j);	 	 	 	 	 
`ifdef FPGA_SYN
	case (i[1:0])
	2'b00: begin
	   val = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_00[i[8:2]];
	   val[j] = val[j] ^ 1'b1;
	   `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_00[i[8:2]] = val;
	   end
	2'b01: begin
	   val = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_01[i[8:2]];
	   val[j] = val[j] ^ 1'b1;
	   `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_01[i[8:2]] = val;
	   end
	2'b10: begin
	   val = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_10[i[8:2]];
	   val[j] = val[j] ^ 1'b1;
	   `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_10[i[8:2]] = val;
	   end
	2'b11: begin
	   val = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_11[i[8:2]];
	   val[j] = val[j] ^ 1'b1;
	   `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_11[i[8:2]] = val;
	   end
	endcase
`else
	 val = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[i];
	 val[j] = val[j] ^ 1'b1;
	 `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[i] = val;
`endif
      end
   endtask // inj_dc_tag_err_rand_hdl
   
   task inj_dc_data_err_rand_hdl;
      input [31:0] loc;
      input [31:0] bit_num;

      integer i, j, k;
      reg [143:0] val;

      begin
	 k = loc % 4;
	 i = loc % 128;
	 j = bit_num % 143;
	 if (k == 0)
	   begin
	      val = `TOP_DESIGN.sparc0.lsu.dcache.w0[i];
	      $display ("%d: Injecting DC w0 data err: index %d: bit %d\n", $time,i, j);	 	 	     
	      val[j] = val[j] ^ 1'b1;
	      `TOP_DESIGN.sparc0.lsu.dcache.w0[i] = val;
	   end
	 else if (k == 1)
	   begin
	      val = `TOP_DESIGN.sparc0.lsu.dcache.w1[i];
	      $display ("%d: Injecting DC w1 data err: index %d: bit %d\n", $time,i, j);	 	 	     
	      val[j] = val[j] ^ 1'b1;
	      `TOP_DESIGN.sparc0.lsu.dcache.w1[i] = val;
	   end
	 else if (k == 2)
	   begin
	      val = `TOP_DESIGN.sparc0.lsu.dcache.w2[i];
	      $display ("%d: Injecting DC w2 data err: index %d: bit %d\n", $time,i, j);	 	 	        
	      val[j] = val[j] ^ 1'b1;
	      `TOP_DESIGN.sparc0.lsu.dcache.w2[i] = val;
	   end
	 else if (k == 3)
	   begin
	      val = `TOP_DESIGN.sparc0.lsu.dcache.w3[i];
	      $display ("%d: Injecting DC w2 data err: index %d: bit %d\n", $time,i, j);	 	 	       
	      val[j] = val[j] ^ 1'b1;
	      `TOP_DESIGN.sparc0.lsu.dcache.w3[i] = val;
	   end
      end
   endtask // inj_dc_data_err_rand_hdl

   task inj_rand_err_dcd_wr_hdl;

      input [7:0] bitnum; //one out of 144 bits can be flipped
      input err_inj_dbg;

      integer i, index;
      reg [143:0] err_mask;

      begin
	 for (i = 0; i < 128; i=i+1)
	   begin
	      if (`TOP_DESIGN.sparc0.lsu.dcache.rw_wdline[i] == 1'b1)
	     	begin
		   index = i;
	     	end
	   end

	 err_mask = 144'b0;
	 err_mask[bitnum] = 1'b1;

	 if (`TOP_DESIGN.sparc0.lsu.dcache.rw_wdline[index] & 
	     `TOP_DESIGN.sparc0.lsu.dcache.dcache_wvld_m & 
	     `TOP_DESIGN.sparc0.lsu.dcache.dcache_wr_rway_m[0]) 
           begin
              `TOP_DESIGN.sparc0.lsu.dcache.w0[index] = `TOP_DESIGN.sparc0.lsu.dcache.w0[index] ^ err_mask;
	      if (err_inj_dbg == 1'b1)
	     	begin
		   $display ("%d: Injecting Dcache data error: way 0: index %8d: err_mask %h: data %h\n", $time,index, err_mask,`TOP_DESIGN.sparc0.lsu.dcache.w0[index]);		   
	     	end	      
	   end

	 if (`TOP_DESIGN.sparc0.lsu.dcache.rw_wdline[index] & 
	     `TOP_DESIGN.sparc0.lsu.dcache.dcache_wvld_m & 
	     `TOP_DESIGN.sparc0.lsu.dcache.dcache_wr_rway_m[1]) 
           begin
              `TOP_DESIGN.sparc0.lsu.dcache.w1[index] = `TOP_DESIGN.sparc0.lsu.dcache.w1[index] ^ err_mask;
	      if (err_inj_dbg == 1'b1)
	     	begin
		   $display ("%d: Injecting Dcache data error: way 1: index %8d: err_mask %h: data %h\n", $time,index, err_mask,`TOP_DESIGN.sparc0.lsu.dcache.w1[index]);		
	     	end	      
	   end

	 if (`TOP_DESIGN.sparc0.lsu.dcache.rw_wdline[index] & 
	     `TOP_DESIGN.sparc0.lsu.dcache.dcache_wvld_m & 
	     `TOP_DESIGN.sparc0.lsu.dcache.dcache_wr_rway_m[2]) 
           begin
              `TOP_DESIGN.sparc0.lsu.dcache.w2[index] = `TOP_DESIGN.sparc0.lsu.dcache.w2[index] ^ err_mask;
	      if (err_inj_dbg == 1'b1)
	     	begin
		   $display ("%d: Injecting Dcache data error: way 2: index %8d: err_mask %h: data %h\n", $time,index, err_mask,`TOP_DESIGN.sparc0.lsu.dcache.w2[index]);
	     	end	      
	   end // if (`TOP_DESIGN.sparc0.lsu.dcache.rw_wdline[index] &...
	 
	 if (`TOP_DESIGN.sparc0.lsu.dcache.rw_wdline[index] & 
	     `TOP_DESIGN.sparc0.lsu.dcache.dcache_wvld_m & 
	     `TOP_DESIGN.sparc0.lsu.dcache.dcache_wr_rway_m[3]) 
           begin
              `TOP_DESIGN.sparc0.lsu.dcache.w3[index] = `TOP_DESIGN.sparc0.lsu.dcache.w3[index] ^ err_mask;
	      if (err_inj_dbg == 1'b1)
	     	begin
		   $display ("%d: Injecting Dcache data error: way 3: index %8d: err_mask %h: data %h\n", $time,index, err_mask,`TOP_DESIGN.sparc0.lsu.dcache.w3[index]);
	     	end	      
	   end     
      end
   endtask // inj_rand_err_dcache_wr
   
   task inj_rand_err_dct_wr_hdl;
      input [4:0] bitnum; //one out of 30 bits can be flipped
      input err_inj_dbg;

      reg [6:0] index;
      reg [29:0] err_mask;

      begin
	 err_mask = 29'b0;
	 err_mask[bitnum] = 1'b1;
	 index = `TOP_DESIGN.sparc0.lsu.dtag.index_y;
	 
	 if (`TOP_DESIGN.sparc0.lsu.dtag.dec_wrway_y[0])
	   begin
`ifdef FPGA_SYN
	      `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_00[index] = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_00[index] ^ err_mask;
`else
	      `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index, 2'b00}] = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index, 2'b00}] ^ err_mask;
	      if (err_inj_dbg == 1'b1)
	     	begin
		   $display ("%d: Injecting Dcache tag error: way 0: index %8d: err_mask %h: data %h\n", $time,index, err_mask,`TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index, 2'b00}]);
	     	end	      
`endif
	   end
	 
	 if (`TOP_DESIGN.sparc0.lsu.dtag.dec_wrway_y[1])
	   begin
`ifdef FPGA_SYN
	      `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_01[index] = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_01[index] ^ err_mask;
`else
	      `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index, 2'b01}] = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index, 2'b01}] ^ err_mask;
	      if (err_inj_dbg == 1'b1)
	     	begin
		   $display ("%d: Injecting Dcache tag error: way 1: index %8d: err_mask %h: data %h\n", $time,index, err_mask,`TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index, 2'b01}]);
	     	end	      
`endif
	   end
	 
	 if (`TOP_DESIGN.sparc0.lsu.dtag.dec_wrway_y[2])
	   begin
`ifdef FPGA_SYN
	      `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_10[index] = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_10[index] ^ err_mask;
`else
	      `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index, 2'b10}] = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index, 2'b10}] ^ err_mask;
	      if (err_inj_dbg == 1'b1)
	     	begin
		   $display ("%d: Injecting Dcache tag error: way 2: index %8d: err_mask %h: data %h\n", $time,index, err_mask, `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index, 2'b10}]);
	     	end	      
`endif
	   end
	 
	 if (`TOP_DESIGN.sparc0.lsu.dtag.dec_wrway_y[3])
	   begin
`ifdef FPGA_SYN
	      `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_11[index] = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary_11[index] ^ err_mask;
`else
	      `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index, 2'b11}] = `TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index, 2'b11}] ^ err_mask;
	      if (err_inj_dbg == 1'b1)
	     	begin
		   $display ("%d: Injecting Dcache tag error: way 3: index %8d: err_mask %h: data %h\n", $time,index, err_mask,`TOP_DESIGN.sparc0.lsu.dtag.ictag_ary[{index, 2'b11}]);
	     	end	      
`endif
	   end
      end
   endtask // inj_rand_err_dtag_wr

   task inj_rand_err_icd_wr_hdl;
      input [5:0] bitnum;
      input [3:0] err_word;
      input err_inj_dbg;

      reg [33:0] err_mask;

      begin

	 err_mask = 34'b0;
	 err_mask[bitnum] = 1'b1;

	 if (`TOP_DESIGN.sparc0.ifu.icd.worden_f[0] && err_word[0])
	   begin
`ifdef FPGA_SYN
	case (`TOP_DESIGN.sparc0.ifu.icd.wr_index0[1:0])
	2'b00:
	      `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_00[`TOP_DESIGN.sparc0.ifu.icd.wr_index0[11:4]] = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_00[`TOP_DESIGN.sparc0.ifu.icd.wr_index0[11:4]] ^ err_mask;
	2'b01:
	      `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_01[`TOP_DESIGN.sparc0.ifu.icd.wr_index0[11:4]] = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_01[`TOP_DESIGN.sparc0.ifu.icd.wr_index0[11:4]] ^ err_mask;
	2'b10:
	      `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_10[`TOP_DESIGN.sparc0.ifu.icd.wr_index0[11:4]] = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_10[`TOP_DESIGN.sparc0.ifu.icd.wr_index0[11:4]] ^ err_mask;
	2'b11:
	      `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_11[`TOP_DESIGN.sparc0.ifu.icd.wr_index0[11:4]] = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_00_11[`TOP_DESIGN.sparc0.ifu.icd.wr_index0[11:4]] ^ err_mask;
	endcase
`else
	      `TOP_DESIGN.sparc0.ifu.icd.icdata_ary[`TOP_DESIGN.sparc0.ifu.icd.wr_index0] = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary[`TOP_DESIGN.sparc0.ifu.icd.wr_index0] ^ err_mask;
	      if (err_inj_dbg == 1'b1)
	     	begin
		   $display ("%d: Injecting Icache data error: way 0: index %8d: err_mask %h: data %h\n", $time,`TOP_DESIGN.sparc0.ifu.icd.wr_index0,err_mask,`TOP_DESIGN.sparc0.ifu.icd.icdata_ary[`TOP_DESIGN.sparc0.ifu.icd.wr_index0]);
	     	end	      
`endif
	   end

	 if (`TOP_DESIGN.sparc0.ifu.icd.worden_f[1] && err_word[1])
	   begin
`ifdef FPGA_SYN
	case (`TOP_DESIGN.sparc0.ifu.icd.wr_index1[1:0])
	2'b00:
	      `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_00[`TOP_DESIGN.sparc0.ifu.icd.wr_index1[11:4]] = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_00[`TOP_DESIGN.sparc0.ifu.icd.wr_index1[11:4]] ^ err_mask;
	2'b01:
	      `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_01[`TOP_DESIGN.sparc0.ifu.icd.wr_index1[11:4]] = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_01[`TOP_DESIGN.sparc0.ifu.icd.wr_index1[11:4]] ^ err_mask;
	2'b10:
	      `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_10[`TOP_DESIGN.sparc0.ifu.icd.wr_index1[11:4]] = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_10[`TOP_DESIGN.sparc0.ifu.icd.wr_index1[11:4]] ^ err_mask;
	2'b11:
	      `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_11[`TOP_DESIGN.sparc0.ifu.icd.wr_index1[11:4]] = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_01_11[`TOP_DESIGN.sparc0.ifu.icd.wr_index1[11:4]] ^ err_mask;
	endcase
`else
	      `TOP_DESIGN.sparc0.ifu.icd.icdata_ary[`TOP_DESIGN.sparc0.ifu.icd.wr_index1] = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary[`TOP_DESIGN.sparc0.ifu.icd.wr_index1] ^ err_mask;
	      if (err_inj_dbg == 1'b1)
	     	begin
		   $display ("%d: Injecting Icache data error: way 1: index %8d: err_mask %h: data %h\n", $time,`TOP_DESIGN.sparc0.ifu.icd.wr_index1,err_mask,`TOP_DESIGN.sparc0.ifu.icd.icdata_ary[`TOP_DESIGN.sparc0.ifu.icd.wr_index1]);
	     	end	      
`endif
	   end

	 if (`TOP_DESIGN.sparc0.ifu.icd.worden_f[2] && err_word[2])
	   begin
`ifdef FPGA_SYN
	case (`TOP_DESIGN.sparc0.ifu.icd.wr_index2[1:0])
	2'b00:
	      `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_00[`TOP_DESIGN.sparc0.ifu.icd.wr_index2[11:4]] = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_00[`TOP_DESIGN.sparc0.ifu.icd.wr_index2[11:4]] ^ err_mask;
	2'b01:
	      `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_01[`TOP_DESIGN.sparc0.ifu.icd.wr_index2[11:4]] = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_01[`TOP_DESIGN.sparc0.ifu.icd.wr_index2[11:4]] ^ err_mask;
	2'b10:
	      `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_10[`TOP_DESIGN.sparc0.ifu.icd.wr_index2[11:4]] = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_10[`TOP_DESIGN.sparc0.ifu.icd.wr_index2[11:4]] ^ err_mask;
	2'b11:
	      `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_11[`TOP_DESIGN.sparc0.ifu.icd.wr_index2[11:4]] = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_10_11[`TOP_DESIGN.sparc0.ifu.icd.wr_index2[11:4]] ^ err_mask;
	endcase
`else
	      `TOP_DESIGN.sparc0.ifu.icd.icdata_ary[`TOP_DESIGN.sparc0.ifu.icd.wr_index2] = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary[`TOP_DESIGN.sparc0.ifu.icd.wr_index2] ^ err_mask;
	      if (err_inj_dbg == 1'b1)
	     	begin
		   $display ("%d: Injecting Icache data error: way 2: index %8d: err_mask %h: data %h\n", $time,`TOP_DESIGN.sparc0.ifu.icd.wr_index2,err_mask,`TOP_DESIGN.sparc0.ifu.icd.icdata_ary[`TOP_DESIGN.sparc0.ifu.icd.wr_index2]);
	     	end	      
`endif
	   end      

	 if (`TOP_DESIGN.sparc0.ifu.icd.worden_f[3] && err_word[3])
	   begin
`ifdef FPGA_SYN
	case (`TOP_DESIGN.sparc0.ifu.icd.wr_index3[1:0])
	2'b00:
	      `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_00[`TOP_DESIGN.sparc0.ifu.icd.wr_index3[11:4]] = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_00[`TOP_DESIGN.sparc0.ifu.icd.wr_index3[11:4]] ^ err_mask;
	2'b01:
	      `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_01[`TOP_DESIGN.sparc0.ifu.icd.wr_index3[11:4]] = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_01[`TOP_DESIGN.sparc0.ifu.icd.wr_index3[11:4]] ^ err_mask;
	2'b10:
	      `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_10[`TOP_DESIGN.sparc0.ifu.icd.wr_index3[11:4]] = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_10[`TOP_DESIGN.sparc0.ifu.icd.wr_index3[11:4]] ^ err_mask;
	2'b11:
	      `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_11[`TOP_DESIGN.sparc0.ifu.icd.wr_index3[11:4]] = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary_11_11[`TOP_DESIGN.sparc0.ifu.icd.wr_index3[11:4]] ^ err_mask;
	endcase
`else
	      `TOP_DESIGN.sparc0.ifu.icd.icdata_ary[`TOP_DESIGN.sparc0.ifu.icd.wr_index3] = `TOP_DESIGN.sparc0.ifu.icd.icdata_ary[`TOP_DESIGN.sparc0.ifu.icd.wr_index3] ^ err_mask;
	      if (err_inj_dbg == 1'b1)
	     	begin
		   $display ("%d: Injecting Icache data error: way 3: index %8d: err_mask %h: data %h\n", $time,`TOP_DESIGN.sparc0.ifu.icd.wr_index3,err_mask,`TOP_DESIGN.sparc0.ifu.icd.icdata_ary[`TOP_DESIGN.sparc0.ifu.icd.wr_index3]);
	     	end	      
`endif
	   end      
      end
   endtask // inj_rand_err_icd_wr
   
   task inj_rand_err_ict_wr_hdl;
      input [4:0] bitnum; //one out of 30 bits can be flipped
      input err_inj_dbg;

      reg [6:0] index;
      reg [29:0] err_mask;

      begin
	 err_mask = 29'b0;
	 err_mask[bitnum] = 1'b1;
	 index = `TOP_DESIGN.sparc0.ifu.ict.index_y;
	 
	 if (`TOP_DESIGN.sparc0.ifu.ict.dec_wrway_y[0])
	   begin
`ifdef FPGA_SYN
	      `TOP_DESIGN.sparc0.ifu.ict.ictag_ary_00[index] = `TOP_DESIGN.sparc0.ifu.ict.ictag_ary_00[index] ^ err_mask;
`else
	      `TOP_DESIGN.sparc0.ifu.ict.ictag_ary[{index, 2'b00}] = `TOP_DESIGN.sparc0.ifu.ict.ictag_ary[{index, 2'b00}] ^ err_mask;
	      if (err_inj_dbg == 1'b1)
	     	begin
		   $display ("%d: Injecting Icache tag error: way 0: index %8d: err_mask %h: data %h\n", $time,index, err_mask,`TOP_DESIGN.sparc0.ifu.ict.ictag_ary[{index, 2'b00}]);
	     	end	      
`endif
	   end
	 
	 if (`TOP_DESIGN.sparc0.ifu.ict.dec_wrway_y[1])
	   begin
`ifdef FPGA_SYN
	      `TOP_DESIGN.sparc0.ifu.ict.ictag_ary_01[index] = `TOP_DESIGN.sparc0.ifu.ict.ictag_ary_01[index] ^ err_mask;
`else
	      `TOP_DESIGN.sparc0.ifu.ict.ictag_ary[{index, 2'b01}] = `TOP_DESIGN.sparc0.ifu.ict.ictag_ary[{index, 2'b01}] ^ err_mask;
	      if (err_inj_dbg == 1'b1)
	     	begin
		   $display ("%d: Injecting Icache tag error: way 1: index %8d: err_mask %h: data %h\n", $time,index, err_mask,`TOP_DESIGN.sparc0.ifu.ict.ictag_ary[{index, 2'b01}]);
	     	end	      
`endif
	   end
	 
	 if (`TOP_DESIGN.sparc0.ifu.ict.dec_wrway_y[2])
	   begin
`ifdef FPGA_SYN
	      `TOP_DESIGN.sparc0.ifu.ict.ictag_ary_10[index] = `TOP_DESIGN.sparc0.ifu.ict.ictag_ary_10[index] ^ err_mask;
`else
	      `TOP_DESIGN.sparc0.ifu.ict.ictag_ary[{index, 2'b10}] = `TOP_DESIGN.sparc0.ifu.ict.ictag_ary[{index, 2'b10}] ^ err_mask;
	      if (err_inj_dbg == 1'b1)
	     	begin
		   $display ("%d: Injecting Icache tag error: way 2: index %8d: err_mask %h: data %h\n", $time,index, err_mask, `TOP_DESIGN.sparc0.ifu.ict.ictag_ary[{index, 2'b10}]);
	     	end	      
`endif
	   end
	 
	 if (`TOP_DESIGN.sparc0.ifu.ict.dec_wrway_y[3])
	   begin
`ifdef FPGA_SYN
	      `TOP_DESIGN.sparc0.ifu.ict.ictag_ary_11[index] = `TOP_DESIGN.sparc0.ifu.ict.ictag_ary_11[index] ^ err_mask;
`else
	      `TOP_DESIGN.sparc0.ifu.ict.ictag_ary[{index, 2'b11}] = `TOP_DESIGN.sparc0.ifu.ict.ictag_ary[{index, 2'b11}] ^ err_mask;
	      if (err_inj_dbg == 1'b1)
	     	begin
		   $display ("%d: Injecting Icache tag error: way 3: index %8d: err_mask %h: data %h\n", $time,index, err_mask,`TOP_DESIGN.sparc0.ifu.ict.ictag_ary[{index, 2'b11}]);
	     	end	      
`endif
	   end
      end
   endtask // inj_rand_err_ict_wr

   task inj_rand_err_irf_wr_hdl;
      input [6:0] bitnum; //one out of 72 bits can be flipped
      input [1:0] wr_stage;
      input err_inj_dbg;

      reg [72:0] err_mask;
      reg [2:0] cwp [0:3];

`ifdef FPGA_SYN
      reg [6:0] w_reg;
`endif

      begin
	 err_mask = 72'b0;
	 err_mask[bitnum] = 1'b1;
	 cwp [0] = `TOP_DESIGN.sparc0.exu.rml.cwp.cwp_thr0;
	 cwp [1] = `TOP_DESIGN.sparc0.exu.rml.cwp.cwp_thr1;
	 cwp [2] = `TOP_DESIGN.sparc0.exu.rml.cwp.cwp_thr2;
	 cwp [3] = `TOP_DESIGN.sparc0.exu.rml.cwp.cwp_thr3; 
	 if (wr_stage[0] == 1'b1) //use w-stage signals
	   begin
`ifdef FPGA_SYN
	w_reg = `TOP_DESIGN.sparc0.exu.irf.thr_rd_w_neg;
	case(w_reg[4:0])
	5'b00000: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_00000[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_00000[w_reg[6:5]] 
		^ err_mask;
		end
	5'b00001: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_00001[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_00001[w_reg[6:5]] 
		^ err_mask;
		end
	5'b00010: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_00010[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_00010[w_reg[6:5]] 
		^ err_mask;
		end
	5'b00011: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_00011[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_00011[w_reg[6:5]] 
		^ err_mask;
		end
	5'b00100: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_00100[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_00100[w_reg[6:5]] 
		^ err_mask;
		end
	5'b00101: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_00101[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_00101[w_reg[6:5]] 
		^ err_mask;
		end
	5'b00110: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_00110[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_00110[w_reg[6:5]] 
		^ err_mask;
		end
	5'b00111: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_00111[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_00111[w_reg[6:5]] 
		^ err_mask;
		end
	5'b01000: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_01000[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_01000[w_reg[6:5]] 
		^ err_mask;
		end
	5'b01001: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_01001[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_01001[w_reg[6:5]] 
		^ err_mask;
		end
	5'b01010: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_01010[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_01010[w_reg[6:5]] 
		^ err_mask;
		end
	5'b01011: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_01011[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_01011[w_reg[6:5]] 
		^ err_mask;
		end
	5'b01100: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_01100[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_01100[w_reg[6:5]] 
		^ err_mask;
		end
	5'b01101: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_01101[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_01101[w_reg[6:5]] 
		^ err_mask;
		end
	5'b01110: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_01110[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_01110[w_reg[6:5]] 
		^ err_mask;
		end
	5'b01111: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_01111[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_01111[w_reg[6:5]] 
		^ err_mask;
		end
	5'b10000: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_10000[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_10000[w_reg[6:5]] 
		^ err_mask;
		end
	5'b10001: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_10001[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_10001[w_reg[6:5]] 
		^ err_mask;
		end
	5'b10010: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_10010[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_10010[w_reg[6:5]] 
		^ err_mask;
		end
	5'b10011: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_10011[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_10011[w_reg[6:5]] 
		^ err_mask;
		end
	5'b10100: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_10100[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_10100[w_reg[6:5]] 
		^ err_mask;
		end
	5'b10101: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_10101[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_10101[w_reg[6:5]] 
		^ err_mask;
		end
	5'b10110: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_10110[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_10110[w_reg[6:5]] 
		^ err_mask;
		end
	5'b10111: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_10111[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_10111[w_reg[6:5]] 
		^ err_mask;
		end
	5'b11000: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_11000[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_11000[w_reg[6:5]] 
		^ err_mask;
		end
	5'b11001: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_11001[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_11001[w_reg[6:5]] 
		^ err_mask;
		end
	5'b11010: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_11010[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_11010[w_reg[6:5]] 
		^ err_mask;
		end
	5'b11011: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_11011[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_11011[w_reg[6:5]] 
		^ err_mask;
		end
	5'b11100: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_11100[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_11100[w_reg[6:5]] 
		^ err_mask;
		end
	5'b11101: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_11101[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_11101[w_reg[6:5]] 
		^ err_mask;
		end
	5'b11110: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_11110[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_11110[w_reg[6:5]] 
		^ err_mask;
		end
	5'b11111: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_11111[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_11111[w_reg[6:5]] 
		^ err_mask;
		end
        endcase
`else
	      `TOP_DESIGN.sparc0.exu.irf.active_window[`TOP_DESIGN.sparc0.exu.irf.thr_rd_w_neg] = `TOP_DESIGN.sparc0.exu.irf.active_window[`TOP_DESIGN.sparc0.exu.irf.thr_rd_w_neg] ^ err_mask;
	      if (err_inj_dbg == 1'b1)
	     	begin
		   $display ("%d: Injecting IRF error: thr %2d: window %1d: reg %2d: error_mask %h: data %h\n", $time,`TOP_DESIGN.sparc0.exu.irf.thr_rd_w_neg[6:5],cwp[`TOP_DESIGN.sparc0.exu.irf.thr_rd_w_neg[6:5]],`TOP_DESIGN.sparc0.exu.irf.thr_rd_w_neg[4:0],err_mask,`TOP_DESIGN.sparc0.exu.irf.active_window[`TOP_DESIGN.sparc0.exu.irf.thr_rd_w_neg]);
	     	end	      
`endif
	   end
	 else if (wr_stage[1] == 1'b1) //use w2-stage signals
	   begin
`ifdef FPGA_SYN
	w_reg = `TOP_DESIGN.sparc0.exu.irf.thr_rd_w2_neg;
	case(w_reg[4:0])
	5'b00000: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_00000[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_00000[w_reg[6:5]] 
		^ err_mask;
		end
	5'b00001: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_00001[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_00001[w_reg[6:5]] 
		^ err_mask;
		end
	5'b00010: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_00010[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_00010[w_reg[6:5]] 
		^ err_mask;
		end
	5'b00011: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_00011[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_00011[w_reg[6:5]] 
		^ err_mask;
		end
	5'b00100: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_00100[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_00100[w_reg[6:5]] 
		^ err_mask;
		end
	5'b00101: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_00101[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_00101[w_reg[6:5]] 
		^ err_mask;
		end
	5'b00110: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_00110[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_00110[w_reg[6:5]] 
		^ err_mask;
		end
	5'b00111: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_00111[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_00111[w_reg[6:5]] 
		^ err_mask;
		end
	5'b01000: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_01000[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_01000[w_reg[6:5]] 
		^ err_mask;
		end
	5'b01001: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_01001[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_01001[w_reg[6:5]] 
		^ err_mask;
		end
	5'b01010: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_01010[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_01010[w_reg[6:5]] 
		^ err_mask;
		end
	5'b01011: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_01011[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_01011[w_reg[6:5]] 
		^ err_mask;
		end
	5'b01100: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_01100[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_01100[w_reg[6:5]] 
		^ err_mask;
		end
	5'b01101: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_01101[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_01101[w_reg[6:5]] 
		^ err_mask;
		end
	5'b01110: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_01110[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_01110[w_reg[6:5]] 
		^ err_mask;
		end
	5'b01111: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_01111[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_01111[w_reg[6:5]] 
		^ err_mask;
		end
	5'b10000: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_10000[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_10000[w_reg[6:5]] 
		^ err_mask;
		end
	5'b10001: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_10001[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_10001[w_reg[6:5]] 
		^ err_mask;
		end
	5'b10010: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_10010[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_10010[w_reg[6:5]] 
		^ err_mask;
		end
	5'b10011: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_10011[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_10011[w_reg[6:5]] 
		^ err_mask;
		end
	5'b10100: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_10100[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_10100[w_reg[6:5]] 
		^ err_mask;
		end
	5'b10101: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_10101[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_10101[w_reg[6:5]] 
		^ err_mask;
		end
	5'b10110: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_10110[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_10110[w_reg[6:5]] 
		^ err_mask;
		end
	5'b10111: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_10111[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_10111[w_reg[6:5]] 
		^ err_mask;
		end
	5'b11000: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_11000[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_11000[w_reg[6:5]] 
		^ err_mask;
		end
	5'b11001: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_11001[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_11001[w_reg[6:5]] 
		^ err_mask;
		end
	5'b11010: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_11010[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_11010[w_reg[6:5]] 
		^ err_mask;
		end
	5'b11011: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_11011[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_11011[w_reg[6:5]] 
		^ err_mask;
		end
	5'b11100: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_11100[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_11100[w_reg[6:5]] 
		^ err_mask;
		end
	5'b11101: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_11101[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_11101[w_reg[6:5]] 
		^ err_mask;
		end
	5'b11110: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_11110[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_11110[w_reg[6:5]] 
		^ err_mask;
		end
	5'b11111: begin
		`TOP_DESIGN.sparc0.exu.irf.active_window_11111[w_reg[6:5]] =
		`TOP_DESIGN.sparc0.exu.irf.active_window_11111[w_reg[6:5]] 
		^ err_mask;
		end
        endcase
`else
	      `TOP_DESIGN.sparc0.exu.irf.active_window[`TOP_DESIGN.sparc0.exu.irf.thr_rd_w2_neg] = `TOP_DESIGN.sparc0.exu.irf.active_window[`TOP_DESIGN.sparc0.exu.irf.thr_rd_w2_neg] ^ err_mask;
	      if (err_inj_dbg == 1'b1)
	     	begin
		   $display ("%d: Injecting IRF error: thr %2d: window %1d: reg %2d: error_mask %h: data %h\n", $time,`TOP_DESIGN.sparc0.exu.irf.thr_rd_w2_neg[6:5],cwp[`TOP_DESIGN.sparc0.exu.irf.thr_rd_w_neg[6:5]],`TOP_DESIGN.sparc0.exu.irf.thr_rd_w2_neg[4:0],err_mask,`TOP_DESIGN.sparc0.exu.irf.active_window[`TOP_DESIGN.sparc0.exu.irf.thr_rd_w2_neg]);
	     	end	      	      
`endif
	   end
      end
   endtask // inj_rand_err_irf_wr_hdl

   task inj_rand_err_frf_wr_hdl;
      input [5:0] bitnum; //one out of 39 bits can be flipped
      input [1:0] reg_index;
      input err_inj_dbg;

      reg [38:0] err_mask;

      begin
	 err_mask = 38'b0;
	 err_mask[bitnum] = 1'b1;

	 if (reg_index[0] == 1'b1) //use lower index
	   begin
`ifdef FPGA_SYN
	      `TOP_DESIGN.sparc0.ffu.frf.regfile_low[`TOP_DESIGN.sparc0.ffu.frf.regfile_index_low[7:1]] = `TOP_DESIGN.sparc0.ffu.frf.regfile_low[`TOP_DESIGN.sparc0.ffu.frf.regfile_index_low[7:1]] ^ err_mask;
`else
	      `TOP_DESIGN.sparc0.ffu.frf.regfile[`TOP_DESIGN.sparc0.ffu.frf.regfile_index_low] = `TOP_DESIGN.sparc0.ffu.frf.regfile[`TOP_DESIGN.sparc0.ffu.frf.regfile_index_low] ^ err_mask;
	      if (err_inj_dbg == 1'b1)
	     	begin
		   $display ("%d: Injecting FRF error: thr %2d: reg %2d: error_mask %h: data %h\n", $time,`TOP_DESIGN.sparc0.ffu.frf.regfile_index_low[7:6],`TOP_DESIGN.sparc0.ffu.frf.regfile_index_low[5:0],err_mask,`TOP_DESIGN.sparc0.ffu.frf.regfile[`TOP_DESIGN.sparc0.ffu.frf.regfile_index_low]);
	     	end	      
`endif
	   end
	 else if (reg_index[1] == 1'b1) //use upper index
	   begin
`ifdef FPGA_SYN
	      `TOP_DESIGN.sparc0.ffu.frf.regfile_high[`TOP_DESIGN.sparc0.ffu.frf.regfile_index_high[7:1]] = `TOP_DESIGN.sparc0.ffu.frf.regfile_high[`TOP_DESIGN.sparc0.ffu.frf.regfile_index_high[7:1]] ^ err_mask;
`else
	      `TOP_DESIGN.sparc0.ffu.frf.regfile[`TOP_DESIGN.sparc0.ffu.frf.regfile_index_high] = `TOP_DESIGN.sparc0.ffu.frf.regfile[`TOP_DESIGN.sparc0.ffu.frf.regfile_index_high] ^ err_mask;
	      if (err_inj_dbg == 1'b1)
	     	begin
		   $display ("%d: Injecting FRF error: thr %2d: reg %2d: error_mask %h: data %h\n", $time,`TOP_DESIGN.sparc0.ffu.frf.regfile_index_high[7:6],`TOP_DESIGN.sparc0.ffu.frf.regfile_index_high[5:0],err_mask,`TOP_DESIGN.sparc0.ffu.frf.regfile[`TOP_DESIGN.sparc0.ffu.frf.regfile_index_high]);
	     	end	      
`endif
	   end
      end
   endtask // inj_rand_err_frf_wr_hdl
     
`else // !`ifdef RTL_SPARC0 
   
   //For the DRAM SAT compliation, have these dummy bodies
   
   task inj_irf_err_hdl;
      input [71:0] err_mask_rs1;
      input [71:0] err_mask_rs2;
      input [71:0] err_mask_rs3;
      input err_inj_dbg;
      begin
      end
   endtask // inj_irf_err_hdl
   
   task inj_ic_err_hdl;
      input [33:0] err_mask_ir;
      input [33:0] err_mask_nir;
      input [29:0] err_mask_tag;
      input err_inj_dbg;
      begin
      end
   endtask // inj_ic_err_hdl

   task inj_frf_err_hdl;
      input [77:0]  err_mask_frf_rs1;
      input [77:0]  err_mask_frf_rs2_rd;
      input fst;
      input err_inj_dbg;
      begin
      end
   endtask // inj_frf_err_hdl
   
   task inj_dc_data_err_hdl;
      input [71:0] err_mask_data;
      input err_inj_dbg;
      begin
      end
   endtask // inj_dc_err_hdl

   task inj_dc_tag_err_hdl;
      input [29:0] err_mask_tag;
      input err_inj_dbg;
      begin
      end
   endtask // inj_dc_tag_err_hdl

   task inj_ic_tag_err_rand_hdl;
      input [31:0] loc;
      input [31:0] bit_num;
      begin
      end
   endtask // inj_ic_tag_err_rand_hdl

   task inj_ic_data_err_rand_hdl;
      input [31:0] loc;
      input [31:0] bit_num;
      begin
      end
   endtask // inj_ic_data_err_rand_hdl

   task inj_irf_err_rand_hdl;
      input [31:0] loc;
      input [31:0] bit_num;
      begin
      end
   endtask // inj_irf_err_rand_hdl

   task inj_frf_err_rand_hdl;
      input [31:0] loc;
      input [31:0] bit_num;
      begin
      end
   endtask // inj_frf_err_rand_hdl

   task inj_dc_tag_err_rand_hdl;
      input [31:0] loc;
      input [31:0] bit_num;   
      begin
      end
   endtask // inj_dc_tag_err_rand_hdl

   task inj_dc_data_err_rand_hdl;
      input [31:0] loc;
      input [31:0] bit_num;
      begin
      end
   endtask // inj_dc_data_err_rand_hdl
   
   task inj_rand_err_dcd_wr_hdl;
      input [7:0] bitnum; //one out of 144 bits can be flipped
      input err_inj_dbg;
      begin
      end
   endtask      
   task inj_rand_err_dct_wr_hdl;
      input [4:0] bitnum; //one out of 30 bits can be flipped
      input err_inj_dbg;
      begin
      end
   endtask      
   task inj_rand_err_icd_wr_hdl;
      input [5:0] bitnum;
      input [3:0] err_word;
      input err_inj_dbg;
      begin
      end
   endtask      
   task inj_rand_err_ict_wr_hdl;
      input [4:0] bitnum; //one out of 30 bits can be flipped
      input err_inj_dbg;
      begin
      end
   endtask      
   task inj_rand_err_irf_wr_hdl;
      input [6:0] bitnum; //one out of 72 bits can be flipped
      input [1:0] wr_stage;
      input err_inj_dbg;
      begin
      end
   endtask      
   task inj_rand_err_frf_wr_hdl;
      input [5:0] bitnum; //one out of 39 bits can be flipped
      input [1:0] reg_index;
      input err_inj_dbg; 
      begin
      end
   endtask // inj_rand_err_frf_wr_hdl
   
   task inj_itlb_data_err_hdl;
      input [42:0] err_mask_data;
      input err_inj_dbg;
      begin
      end
   endtask

   task inj_dtlb_data_err_hdl;
      input [47:0] addr;            
      input [42:0] err_mask_data;
      input err_inj_dbg;
      begin
      end
   endtask
   
`endif // !`ifdef RTL_SPARC0

`endif
endmodule
