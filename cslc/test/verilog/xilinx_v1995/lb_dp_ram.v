// Xilinx Verilog produced by program ngd2ver, Version M1.3.7
// Date: Tue Sep  2 15:53:17 1997
// Design file: /var/tmp/lb_dp_ram.ngd
// Device: xc4000e
`timescale 1 ns/1 ps

  module lb_dp_ram (WR_EN, WR_CLK, A, DPRA, DI, DPO, SPO);
    input WR_EN;
    input WR_CLK;
    input [3:0] A;
    input [3:0] DPRA;
    input [3:0] DI;
    output [3:0] DPO;
    output [3:0] SPO;


    X_RAMS16 \MEM0_0/X_RAMS16  (.ADR0 (A[0]), .ADR1 (A[1]), .ADR2 (A[2]), 
    .ADR3 (A[3]), .IN (DI[0]), .CLK (WR_CLK), .WE (WR_EN), .OUT (SPO[0]));
    initial begin
      \MEM0_0/X_RAMS16 .mem[0] = 1'b0;
      \MEM0_0/X_RAMS16 .mem[1] = 1'b1;
      \MEM0_0/X_RAMS16 .mem[2] = 1'b0;
      \MEM0_0/X_RAMS16 .mem[3] = 1'b0;
      \MEM0_0/X_RAMS16 .mem[4] = 1'b0;
      \MEM0_0/X_RAMS16 .mem[5] = 1'b0;
      \MEM0_0/X_RAMS16 .mem[6] = 1'b0;
      \MEM0_0/X_RAMS16 .mem[7] = 1'b1;
      \MEM0_0/X_RAMS16 .mem[8] = 1'b1;
      \MEM0_0/X_RAMS16 .mem[9] = 1'b0;
      \MEM0_0/X_RAMS16 .mem[10] = 1'b0;
      \MEM0_0/X_RAMS16 .mem[11] = 1'b1;
      \MEM0_0/X_RAMS16 .mem[12] = 1'b1;
      \MEM0_0/X_RAMS16 .mem[13] = 1'b1;
      \MEM0_0/X_RAMS16 .mem[14] = 1'b1;
      \MEM0_0/X_RAMS16 .mem[15] = 1'b1;
    end
    X_RAMD16 \MEM0_0/X_RAMD16  (.RADR0 (DPRA[0]), .RADR1 (DPRA[1]), 
    .RADR2 (DPRA[2]), .RADR3 (DPRA[3]), .WADR0 (A[0]), .WADR1 (A[1]), 
    .WADR2 (A[2]), .WADR3 (A[3]), .IN (DI[0]), .CLK (WR_CLK), .WE (WR_EN), 
    .OUT (DPO[0]));
    initial begin
      \MEM0_0/X_RAMD16 .mem[0] = 1'b0;
      \MEM0_0/X_RAMD16 .mem[1] = 1'b1;
      \MEM0_0/X_RAMD16 .mem[2] = 1'b0;
      \MEM0_0/X_RAMD16 .mem[3] = 1'b0;
      \MEM0_0/X_RAMD16 .mem[4] = 1'b0;
      \MEM0_0/X_RAMD16 .mem[5] = 1'b0;
      \MEM0_0/X_RAMD16 .mem[6] = 1'b0;
      \MEM0_0/X_RAMD16 .mem[7] = 1'b1;
      \MEM0_0/X_RAMD16 .mem[8] = 1'b1;
      \MEM0_0/X_RAMD16 .mem[9] = 1'b0;
      \MEM0_0/X_RAMD16 .mem[10] = 1'b0;
      \MEM0_0/X_RAMD16 .mem[11] = 1'b1;
      \MEM0_0/X_RAMD16 .mem[12] = 1'b1;
      \MEM0_0/X_RAMD16 .mem[13] = 1'b1;
      \MEM0_0/X_RAMD16 .mem[14] = 1'b1;
      \MEM0_0/X_RAMD16 .mem[15] = 1'b1;
    end
    X_RAMS16 \MEM1_0/X_RAMS16  (.ADR0 (A[0]), .ADR1 (A[1]), .ADR2 (A[2]), 
    .ADR3 (A[3]), .IN (DI[1]), .CLK (WR_CLK), .WE (WR_EN), .OUT (SPO[1]));
    initial begin
      \MEM1_0/X_RAMS16 .mem[0] = 1'b0;
      \MEM1_0/X_RAMS16 .mem[1] = 1'b0;
      \MEM1_0/X_RAMS16 .mem[2] = 1'b1;
      \MEM1_0/X_RAMS16 .mem[3] = 1'b0;
      \MEM1_0/X_RAMS16 .mem[4] = 1'b0;
      \MEM1_0/X_RAMS16 .mem[5] = 1'b0;
      \MEM1_0/X_RAMS16 .mem[6] = 1'b1;
      \MEM1_0/X_RAMS16 .mem[7] = 1'b0;
      \MEM1_0/X_RAMS16 .mem[8] = 1'b0;
      \MEM1_0/X_RAMS16 .mem[9] = 1'b1;
      \MEM1_0/X_RAMS16 .mem[10] = 1'b0;
      \MEM1_0/X_RAMS16 .mem[11] = 1'b0;
      \MEM1_0/X_RAMS16 .mem[12] = 1'b0;
      \MEM1_0/X_RAMS16 .mem[13] = 1'b0;
      \MEM1_0/X_RAMS16 .mem[14] = 1'b1;
      \MEM1_0/X_RAMS16 .mem[15] = 1'b1;
    end
    X_RAMD16 \MEM1_0/X_RAMD16  (.RADR0 (DPRA[0]), .RADR1 (DPRA[1]), 
    .RADR2 (DPRA[2]), .RADR3 (DPRA[3]), .WADR0 (A[0]), .WADR1 (A[1]), 
    .WADR2 (A[2]), .WADR3 (A[3]), .IN (DI[1]), .CLK (WR_CLK), .WE (WR_EN), 
    .OUT (DPO[1]));
    initial begin
      \MEM1_0/X_RAMD16 .mem[0] = 1'b0;
      \MEM1_0/X_RAMD16 .mem[1] = 1'b0;
      \MEM1_0/X_RAMD16 .mem[2] = 1'b1;
      \MEM1_0/X_RAMD16 .mem[3] = 1'b0;
      \MEM1_0/X_RAMD16 .mem[4] = 1'b0;
      \MEM1_0/X_RAMD16 .mem[5] = 1'b0;
      \MEM1_0/X_RAMD16 .mem[6] = 1'b1;
      \MEM1_0/X_RAMD16 .mem[7] = 1'b0;
      \MEM1_0/X_RAMD16 .mem[8] = 1'b0;
      \MEM1_0/X_RAMD16 .mem[9] = 1'b1;
      \MEM1_0/X_RAMD16 .mem[10] = 1'b0;
      \MEM1_0/X_RAMD16 .mem[11] = 1'b0;
      \MEM1_0/X_RAMD16 .mem[12] = 1'b0;
      \MEM1_0/X_RAMD16 .mem[13] = 1'b0;
      \MEM1_0/X_RAMD16 .mem[14] = 1'b1;
      \MEM1_0/X_RAMD16 .mem[15] = 1'b1;
    end
    X_RAMS16 \MEM2_0/X_RAMS16  (.ADR0 (A[0]), .ADR1 (A[1]), .ADR2 (A[2]), 
    .ADR3 (A[3]), .IN (DI[2]), .CLK (WR_CLK), .WE (WR_EN), .OUT (SPO[2]));
    initial begin
      \MEM2_0/X_RAMS16 .mem[0] = 1'b0;
      \MEM2_0/X_RAMS16 .mem[1] = 1'b0;
      \MEM2_0/X_RAMS16 .mem[2] = 1'b0;
      \MEM2_0/X_RAMS16 .mem[3] = 1'b1;
      \MEM2_0/X_RAMS16 .mem[4] = 1'b0;
      \MEM2_0/X_RAMS16 .mem[5] = 1'b1;
      \MEM2_0/X_RAMS16 .mem[6] = 1'b0;
      \MEM2_0/X_RAMS16 .mem[7] = 1'b0;
      \MEM2_0/X_RAMS16 .mem[8] = 1'b0;
      \MEM2_0/X_RAMS16 .mem[9] = 1'b0;
      \MEM2_0/X_RAMS16 .mem[10] = 1'b1;
      \MEM2_0/X_RAMS16 .mem[11] = 1'b0;
      \MEM2_0/X_RAMS16 .mem[12] = 1'b0;
      \MEM2_0/X_RAMS16 .mem[13] = 1'b1;
      \MEM2_0/X_RAMS16 .mem[14] = 1'b0;
      \MEM2_0/X_RAMS16 .mem[15] = 1'b1;
    end
    X_RAMD16 \MEM2_0/X_RAMD16  (.RADR0 (DPRA[0]), .RADR1 (DPRA[1]), 
    .RADR2 (DPRA[2]), .RADR3 (DPRA[3]), .WADR0 (A[0]), .WADR1 (A[1]), 
    .WADR2 (A[2]), .WADR3 (A[3]), .IN (DI[2]), .CLK (WR_CLK), .WE (WR_EN), 
    .OUT (DPO[2]));
    initial begin
      \MEM2_0/X_RAMD16 .mem[0] = 1'b0;
      \MEM2_0/X_RAMD16 .mem[1] = 1'b0;
      \MEM2_0/X_RAMD16 .mem[2] = 1'b0;
      \MEM2_0/X_RAMD16 .mem[3] = 1'b1;
      \MEM2_0/X_RAMD16 .mem[4] = 1'b0;
      \MEM2_0/X_RAMD16 .mem[5] = 1'b1;
      \MEM2_0/X_RAMD16 .mem[6] = 1'b0;
      \MEM2_0/X_RAMD16 .mem[7] = 1'b0;
      \MEM2_0/X_RAMD16 .mem[8] = 1'b0;
      \MEM2_0/X_RAMD16 .mem[9] = 1'b0;
      \MEM2_0/X_RAMD16 .mem[10] = 1'b1;
      \MEM2_0/X_RAMD16 .mem[11] = 1'b0;
      \MEM2_0/X_RAMD16 .mem[12] = 1'b0;
      \MEM2_0/X_RAMD16 .mem[13] = 1'b1;
      \MEM2_0/X_RAMD16 .mem[14] = 1'b0;
      \MEM2_0/X_RAMD16 .mem[15] = 1'b1;
    end
    X_RAMS16 \MEM3_0/X_RAMS16  (.ADR0 (A[0]), .ADR1 (A[1]), .ADR2 (A[2]), 
    .ADR3 (A[3]), .IN (DI[3]), .CLK (WR_CLK), .WE (WR_EN), .OUT (SPO[3]));
    initial begin
      \MEM3_0/X_RAMS16 .mem[0] = 1'b0;
      \MEM3_0/X_RAMS16 .mem[1] = 1'b0;
      \MEM3_0/X_RAMS16 .mem[2] = 1'b0;
      \MEM3_0/X_RAMS16 .mem[3] = 1'b0;
      \MEM3_0/X_RAMS16 .mem[4] = 1'b1;
      \MEM3_0/X_RAMS16 .mem[5] = 1'b1;
      \MEM3_0/X_RAMS16 .mem[6] = 1'b1;
      \MEM3_0/X_RAMS16 .mem[7] = 1'b1;
      \MEM3_0/X_RAMS16 .mem[8] = 1'b1;
      \MEM3_0/X_RAMS16 .mem[9] = 1'b1;
      \MEM3_0/X_RAMS16 .mem[10] = 1'b1;
      \MEM3_0/X_RAMS16 .mem[11] = 1'b1;
      \MEM3_0/X_RAMS16 .mem[12] = 1'b1;
      \MEM3_0/X_RAMS16 .mem[13] = 1'b1;
      \MEM3_0/X_RAMS16 .mem[14] = 1'b1;
      \MEM3_0/X_RAMS16 .mem[15] = 1'b1;
    end
    X_RAMD16 \MEM3_0/X_RAMD16  (.RADR0 (DPRA[0]), .RADR1 (DPRA[1]), 
    .RADR2 (DPRA[2]), .RADR3 (DPRA[3]), .WADR0 (A[0]), .WADR1 (A[1]), 
    .WADR2 (A[2]), .WADR3 (A[3]), .IN (DI[3]), .CLK (WR_CLK), .WE (WR_EN), 
    .OUT (DPO[3]));
    initial begin
      \MEM3_0/X_RAMD16 .mem[0] = 1'b0;
      \MEM3_0/X_RAMD16 .mem[1] = 1'b0;
      \MEM3_0/X_RAMD16 .mem[2] = 1'b0;
      \MEM3_0/X_RAMD16 .mem[3] = 1'b0;
      \MEM3_0/X_RAMD16 .mem[4] = 1'b1;
      \MEM3_0/X_RAMD16 .mem[5] = 1'b1;
      \MEM3_0/X_RAMD16 .mem[6] = 1'b1;
      \MEM3_0/X_RAMD16 .mem[7] = 1'b1;
      \MEM3_0/X_RAMD16 .mem[8] = 1'b1;
      \MEM3_0/X_RAMD16 .mem[9] = 1'b1;
      \MEM3_0/X_RAMD16 .mem[10] = 1'b1;
      \MEM3_0/X_RAMD16 .mem[11] = 1'b1;
      \MEM3_0/X_RAMD16 .mem[12] = 1'b1;
      \MEM3_0/X_RAMD16 .mem[13] = 1'b1;
      \MEM3_0/X_RAMD16 .mem[14] = 1'b1;
      \MEM3_0/X_RAMD16 .mem[15] = 1'b1;
    end
  endmodule

