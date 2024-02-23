module MULT ( X, Y, P );
input  [7:0] X;
input  [7:0] Y;
output [15:0] P;
   wire [0:8] A;
   wire [0:7] B;
   wire [0:15] Q;
   wire  CLK = 0;
   MULTIPLIER_9_8 U1 (A , B , CLK , Q );
   assign A[0] = X[0];
   assign A[1] = X[1];
   assign A[2] = X[2];
   assign A[3] = X[3];
   assign A[4] = X[4];
   assign A[5] = X[5];
   assign A[6] = X[6];
   assign A[7] = X[7];
   assign A[8] = X[7];
   assign B[0] = Y[0];
   assign B[1] = Y[1];
   assign B[2] = Y[2];
   assign B[3] = Y[3];
   assign B[4] = Y[4];
   assign B[5] = Y[5];
   assign B[6] = Y[6];
   assign B[7] = Y[7];
   assign P[0] = Q[0];
   assign P[1] = Q[1];
   assign P[2] = Q[2];
   assign P[3] = Q[3];
   assign P[4] = Q[4];
   assign P[5] = Q[5];
   assign P[6] = Q[6];
   assign P[7] = Q[7];
   assign P[8] = Q[8];
   assign P[9] = Q[9];
   assign P[10] = Q[10];
   assign P[11] = Q[11];
   assign P[12] = Q[12];
   assign P[13] = Q[13];
   assign P[14] = Q[14];
   assign P[15] = Q[15];
endmodule


module AND_GATE ( INA, INB, Q );
input  INA;
input  INB;
output Q;
   assign Q = INA & INB;
endmodule


module NAND_GATE ( INA, INB, Q );
input  INA;
input  INB;
output Q;
   assign Q =  ~ (INA & INB);
endmodule


module PPGEN_9_8 ( OPA, OPB, SUMMAND );
input  [0:8] OPA;
input  [0:7] OPB;
output [0:81] SUMMAND;
   wire LOGIC_ONE, LOGIC_ZERO;
   assign LOGIC_ONE = 1;
   assign LOGIC_ZERO = 0;
   AND_GATE U0 (OPA[0] , OPB[0] , SUMMAND[0] );
   AND_GATE U1 (OPA[1] , OPB[0] , SUMMAND[1] );
   AND_GATE U3 (OPA[2] , OPB[0] , SUMMAND[3] );
   AND_GATE U6 (OPA[3] , OPB[0] , SUMMAND[6] );
   AND_GATE U10 (OPA[4] , OPB[0] , SUMMAND[10] );
   AND_GATE U15 (OPA[5] , OPB[0] , SUMMAND[15] );
   AND_GATE U21 (OPA[6] , OPB[0] , SUMMAND[21] );
   AND_GATE U28 (OPA[7] , OPB[0] , SUMMAND[28] );
   AND_GATE U38 (OPA[8] , OPB[0] , SUMMAND[38] );
   AND_GATE U2 (OPA[0] , OPB[1] , SUMMAND[2] );
   AND_GATE U4 (OPA[1] , OPB[1] , SUMMAND[4] );
   AND_GATE U7 (OPA[2] , OPB[1] , SUMMAND[7] );
   AND_GATE U11 (OPA[3] , OPB[1] , SUMMAND[11] );
   AND_GATE U16 (OPA[4] , OPB[1] , SUMMAND[16] );
   AND_GATE U22 (OPA[5] , OPB[1] , SUMMAND[22] );
   AND_GATE U29 (OPA[6] , OPB[1] , SUMMAND[29] );
   AND_GATE U39 (OPA[7] , OPB[1] , SUMMAND[39] );
   AND_GATE U47 (OPA[8] , OPB[1] , SUMMAND[47] );
   AND_GATE U5 (OPA[0] , OPB[2] , SUMMAND[5] );
   AND_GATE U8 (OPA[1] , OPB[2] , SUMMAND[8] );
   AND_GATE U12 (OPA[2] , OPB[2] , SUMMAND[12] );
   AND_GATE U17 (OPA[3] , OPB[2] , SUMMAND[17] );
   AND_GATE U23 (OPA[4] , OPB[2] , SUMMAND[23] );
   AND_GATE U30 (OPA[5] , OPB[2] , SUMMAND[30] );
   AND_GATE U40 (OPA[6] , OPB[2] , SUMMAND[40] );
   AND_GATE U48 (OPA[7] , OPB[2] , SUMMAND[48] );
   AND_GATE U56 (OPA[8] , OPB[2] , SUMMAND[56] );
   AND_GATE U9 (OPA[0] , OPB[3] , SUMMAND[9] );
   AND_GATE U13 (OPA[1] , OPB[3] , SUMMAND[13] );
   AND_GATE U18 (OPA[2] , OPB[3] , SUMMAND[18] );
   AND_GATE U24 (OPA[3] , OPB[3] , SUMMAND[24] );
   AND_GATE U31 (OPA[4] , OPB[3] , SUMMAND[31] );
   AND_GATE U41 (OPA[5] , OPB[3] , SUMMAND[41] );
   AND_GATE U49 (OPA[6] , OPB[3] , SUMMAND[49] );
   AND_GATE U57 (OPA[7] , OPB[3] , SUMMAND[57] );
   AND_GATE U63 (OPA[8] , OPB[3] , SUMMAND[63] );
   AND_GATE U14 (OPA[0] , OPB[4] , SUMMAND[14] );
   AND_GATE U19 (OPA[1] , OPB[4] , SUMMAND[19] );
   AND_GATE U25 (OPA[2] , OPB[4] , SUMMAND[25] );
   AND_GATE U32 (OPA[3] , OPB[4] , SUMMAND[32] );
   AND_GATE U42 (OPA[4] , OPB[4] , SUMMAND[42] );
   AND_GATE U50 (OPA[5] , OPB[4] , SUMMAND[50] );
   AND_GATE U58 (OPA[6] , OPB[4] , SUMMAND[58] );
   AND_GATE U64 (OPA[7] , OPB[4] , SUMMAND[64] );
   AND_GATE U69 (OPA[8] , OPB[4] , SUMMAND[69] );
   AND_GATE U20 (OPA[0] , OPB[5] , SUMMAND[20] );
   AND_GATE U26 (OPA[1] , OPB[5] , SUMMAND[26] );
   AND_GATE U33 (OPA[2] , OPB[5] , SUMMAND[33] );
   AND_GATE U43 (OPA[3] , OPB[5] , SUMMAND[43] );
   AND_GATE U51 (OPA[4] , OPB[5] , SUMMAND[51] );
   AND_GATE U59 (OPA[5] , OPB[5] , SUMMAND[59] );
   AND_GATE U65 (OPA[6] , OPB[5] , SUMMAND[65] );
   AND_GATE U70 (OPA[7] , OPB[5] , SUMMAND[70] );
   AND_GATE U74 (OPA[8] , OPB[5] , SUMMAND[74] );
   AND_GATE U27 (OPA[0] , OPB[6] , SUMMAND[27] );
   AND_GATE U34 (OPA[1] , OPB[6] , SUMMAND[34] );
   AND_GATE U44 (OPA[2] , OPB[6] , SUMMAND[44] );
   AND_GATE U52 (OPA[3] , OPB[6] , SUMMAND[52] );
   AND_GATE U60 (OPA[4] , OPB[6] , SUMMAND[60] );
   AND_GATE U66 (OPA[5] , OPB[6] , SUMMAND[66] );
   AND_GATE U71 (OPA[6] , OPB[6] , SUMMAND[71] );
   AND_GATE U75 (OPA[7] , OPB[6] , SUMMAND[75] );
   AND_GATE U78 (OPA[8] , OPB[6] , SUMMAND[78] );
   NAND_GATE U35 (OPA[0] , OPB[7] , SUMMAND[35] );
   NAND_GATE U45 (OPA[1] , OPB[7] , SUMMAND[45] );
   NAND_GATE U53 (OPA[2] , OPB[7] , SUMMAND[53] );
   NAND_GATE U61 (OPA[3] , OPB[7] , SUMMAND[61] );
   NAND_GATE U67 (OPA[4] , OPB[7] , SUMMAND[67] );
   NAND_GATE U72 (OPA[5] , OPB[7] , SUMMAND[72] );
   NAND_GATE U76 (OPA[6] , OPB[7] , SUMMAND[76] );
   NAND_GATE U79 (OPA[7] , OPB[7] , SUMMAND[79] );
   NAND_GATE U81 (OPA[8] , OPB[7] , SUMMAND[81] );
   NAND_GATE U46 (OPA[8] , OPB[0] , SUMMAND[46] );
   NAND_GATE U55 (OPA[8] , OPB[1] , SUMMAND[55] );
   NAND_GATE U62 (OPA[8] , OPB[2] , SUMMAND[62] );
   NAND_GATE U68 (OPA[8] , OPB[3] , SUMMAND[68] );
   NAND_GATE U73 (OPA[8] , OPB[4] , SUMMAND[73] );
   NAND_GATE U77 (OPA[8] , OPB[5] , SUMMAND[77] );
   NAND_GATE U80 (OPA[8] , OPB[6] , SUMMAND[80] );
   assign SUMMAND[37] = LOGIC_ZERO;
   assign SUMMAND[36] = LOGIC_ONE;
   assign SUMMAND[54] = LOGIC_ONE;
endmodule


module FULL_ADDER ( DATA_A, DATA_B, DATA_C, SAVE, CARRY );
input  DATA_A;
input  DATA_B;
input  DATA_C;
output SAVE;
output CARRY;
   wire TMP;
   assign TMP = DATA_A ^ DATA_B;
   assign SAVE = TMP ^ DATA_C;
   assign CARRY =  ~ (( ~ (TMP & DATA_C)) & ( ~ (DATA_A & DATA_B)));
endmodule


module HALF_ADDER ( DATA_A, DATA_B, SAVE, CARRY );
input  DATA_A;
input  DATA_B;
output SAVE;
output CARRY;
   assign SAVE = DATA_A ^ DATA_B;
   assign CARRY = DATA_A & DATA_B;
endmodule


module WALLACE_9_8 ( SUMMAND, CARRY, SUM );
input  [0:81] SUMMAND;
output [0:15] CARRY;
output [0:15] SUM;
   wire [0:41] INT_CARRY;
   wire [0:58] INT_SUM;
   assign SUM[0] = SUMMAND[0];
   assign CARRY[0] = 0;
   HALF_ADDER HA_0 (SUMMAND[1], SUMMAND[2], SUM[1], CARRY[1]);
   FULL_ADDER FA_0 (SUMMAND[3], SUMMAND[4], SUMMAND[5], SUM[2], CARRY[2]);
   FULL_ADDER FA_1 (SUMMAND[6], SUMMAND[7], SUMMAND[8], INT_SUM[0], INT_CARRY[0]);
   assign INT_SUM[1] = SUMMAND[9];
   HALF_ADDER HA_1 (INT_SUM[0], INT_SUM[1], SUM[3], CARRY[3]);
   FULL_ADDER FA_2 (SUMMAND[10], SUMMAND[11], SUMMAND[12], INT_SUM[2], INT_CARRY[1]);
   HALF_ADDER HA_2 (SUMMAND[13], SUMMAND[14], INT_SUM[3], INT_CARRY[2]);
   FULL_ADDER FA_3 (INT_SUM[2], INT_SUM[3], INT_CARRY[0], SUM[4], CARRY[4]);
   FULL_ADDER FA_4 (SUMMAND[15], SUMMAND[16], SUMMAND[17], INT_SUM[4], INT_CARRY[3]);
   FULL_ADDER FA_5 (SUMMAND[18], SUMMAND[19], SUMMAND[20], INT_SUM[5], INT_CARRY[4]);
   FULL_ADDER FA_6 (INT_SUM[4], INT_SUM[5], INT_CARRY[1], INT_SUM[6], INT_CARRY[5]);
   assign INT_SUM[7] = INT_CARRY[2];
   HALF_ADDER HA_3 (INT_SUM[6], INT_SUM[7], SUM[5], CARRY[5]);
   FULL_ADDER FA_7 (SUMMAND[21], SUMMAND[22], SUMMAND[23], INT_SUM[8], INT_CARRY[6]);
   FULL_ADDER FA_8 (SUMMAND[24], SUMMAND[25], SUMMAND[26], INT_SUM[9], INT_CARRY[7]);
   assign INT_SUM[10] = SUMMAND[27];
   FULL_ADDER FA_9 (INT_SUM[8], INT_SUM[9], INT_SUM[10], INT_SUM[11], INT_CARRY[8]);
   HALF_ADDER HA_4 (INT_CARRY[3], INT_CARRY[4], INT_SUM[12], INT_CARRY[9]);
   FULL_ADDER FA_10 (INT_SUM[11], INT_SUM[12], INT_CARRY[5], SUM[6], CARRY[6]);
   FULL_ADDER FA_11 (SUMMAND[28], SUMMAND[29], SUMMAND[30], INT_SUM[13], INT_CARRY[10]);
   FULL_ADDER FA_12 (SUMMAND[31], SUMMAND[32], SUMMAND[33], INT_SUM[14], INT_CARRY[11]);
   FULL_ADDER FA_13 (SUMMAND[34], SUMMAND[35], SUMMAND[36], INT_SUM[15], INT_CARRY[12]);
   FULL_ADDER FA_14 (INT_SUM[13], INT_SUM[14], INT_SUM[15], INT_SUM[16], INT_CARRY[13]);
   assign INT_SUM[17] = INT_CARRY[6];
   assign INT_SUM[18] = INT_CARRY[7];
   FULL_ADDER FA_15 (INT_SUM[16], INT_SUM[17], INT_SUM[18], INT_SUM[19], INT_CARRY[14]);
   assign INT_SUM[20] = INT_CARRY[8];
   assign INT_SUM[21] = INT_CARRY[9];
   FULL_ADDER FA_16 (INT_SUM[19], INT_SUM[20], INT_SUM[21], SUM[7], CARRY[7]);
   FULL_ADDER FA_17 (SUMMAND[37], SUMMAND[38], SUMMAND[39], INT_SUM[22], INT_CARRY[15]);
   FULL_ADDER FA_18 (SUMMAND[40], SUMMAND[41], SUMMAND[42], INT_SUM[23], INT_CARRY[16]);
   FULL_ADDER FA_19 (SUMMAND[43], SUMMAND[44], SUMMAND[45], INT_SUM[24], INT_CARRY[17]);
   FULL_ADDER FA_20 (INT_SUM[22], INT_SUM[23], INT_SUM[24], INT_SUM[25], INT_CARRY[18]);
   FULL_ADDER FA_21 (INT_CARRY[10], INT_CARRY[11], INT_CARRY[12], INT_SUM[26], INT_CARRY[19]);
   FULL_ADDER FA_22 (INT_SUM[25], INT_SUM[26], INT_CARRY[13], INT_SUM[27], INT_CARRY[20]);
   HALF_ADDER HA_5 (INT_SUM[27], INT_CARRY[14], SUM[8], CARRY[8]);
   FULL_ADDER FA_23 (SUMMAND[46], SUMMAND[47], SUMMAND[48], INT_SUM[28], INT_CARRY[21]);
   FULL_ADDER FA_24 (SUMMAND[49], SUMMAND[50], SUMMAND[51], INT_SUM[29], INT_CARRY[22]);
   FULL_ADDER FA_25 (SUMMAND[52], SUMMAND[53], SUMMAND[54], INT_SUM[30], INT_CARRY[23]);
   FULL_ADDER FA_26 (INT_SUM[28], INT_SUM[29], INT_SUM[30], INT_SUM[31], INT_CARRY[24]);
   FULL_ADDER FA_27 (INT_CARRY[15], INT_CARRY[16], INT_CARRY[17], INT_SUM[32], INT_CARRY[25]);
   FULL_ADDER FA_28 (INT_SUM[31], INT_SUM[32], INT_CARRY[18], INT_SUM[33], INT_CARRY[26]);
   assign INT_SUM[34] = INT_CARRY[19];
   FULL_ADDER FA_29 (INT_SUM[33], INT_SUM[34], INT_CARRY[20], SUM[9], CARRY[9]);
   FULL_ADDER FA_30 (SUMMAND[55], SUMMAND[56], SUMMAND[57], INT_SUM[35], INT_CARRY[27]);
   FULL_ADDER FA_31 (SUMMAND[58], SUMMAND[59], SUMMAND[60], INT_SUM[36], INT_CARRY[28]);
   assign INT_SUM[37] = SUMMAND[61];
   FULL_ADDER FA_32 (INT_SUM[35], INT_SUM[36], INT_SUM[37], INT_SUM[38], INT_CARRY[29]);
   FULL_ADDER FA_33 (INT_CARRY[21], INT_CARRY[22], INT_CARRY[23], INT_SUM[39], INT_CARRY[30]);
   FULL_ADDER FA_34 (INT_SUM[38], INT_SUM[39], INT_CARRY[24], INT_SUM[40], INT_CARRY[31]);
   assign INT_SUM[41] = INT_CARRY[25];
   FULL_ADDER FA_35 (INT_SUM[40], INT_SUM[41], INT_CARRY[26], SUM[10], CARRY[10]);
   FULL_ADDER FA_36 (SUMMAND[62], SUMMAND[63], SUMMAND[64], INT_SUM[42], INT_CARRY[32]);
   FULL_ADDER FA_37 (SUMMAND[65], SUMMAND[66], SUMMAND[67], INT_SUM[43], INT_CARRY[33]);
   FULL_ADDER FA_38 (INT_SUM[42], INT_SUM[43], INT_CARRY[27], INT_SUM[44], INT_CARRY[34]);
   assign INT_SUM[45] = INT_CARRY[28];
   FULL_ADDER FA_39 (INT_SUM[44], INT_SUM[45], INT_CARRY[29], INT_SUM[46], INT_CARRY[35]);
   assign INT_SUM[47] = INT_CARRY[30];
   FULL_ADDER FA_40 (INT_SUM[46], INT_SUM[47], INT_CARRY[31], SUM[11], CARRY[11]);
   FULL_ADDER FA_41 (SUMMAND[68], SUMMAND[69], SUMMAND[70], INT_SUM[48], INT_CARRY[36]);
   FULL_ADDER FA_42 (SUMMAND[71], SUMMAND[72], INT_CARRY[32], INT_SUM[49], INT_CARRY[37]);
   assign INT_SUM[50] = INT_CARRY[33];
   FULL_ADDER FA_43 (INT_SUM[48], INT_SUM[49], INT_SUM[50], INT_SUM[51], INT_CARRY[38]);
   assign INT_SUM[52] = INT_CARRY[34];
   FULL_ADDER FA_44 (INT_SUM[51], INT_SUM[52], INT_CARRY[35], SUM[12], CARRY[12]);
   FULL_ADDER FA_45 (SUMMAND[73], SUMMAND[74], SUMMAND[75], INT_SUM[53], INT_CARRY[39]);
   assign INT_SUM[54] = SUMMAND[76];
   FULL_ADDER FA_46 (INT_SUM[53], INT_SUM[54], INT_CARRY[36], INT_SUM[55], INT_CARRY[40]);
   assign INT_SUM[56] = INT_CARRY[37];
   FULL_ADDER FA_47 (INT_SUM[55], INT_SUM[56], INT_CARRY[38], SUM[13], CARRY[13]);
   FULL_ADDER FA_48 (SUMMAND[77], SUMMAND[78], SUMMAND[79], INT_SUM[57], INT_CARRY[41]);
   assign INT_SUM[58] = INT_CARRY[39];
   FULL_ADDER FA_49 (INT_SUM[57], INT_SUM[58], INT_CARRY[40], SUM[14], CARRY[14]);
   FULL_ADDER FA_50 (SUMMAND[80], SUMMAND[81], INT_CARRY[41], SUM[15], CARRY[15]);
endmodule


module INVBLOCK ( GIN, PHI, GOUT );
input  GIN;
input  PHI;
output GOUT;
   assign GOUT =  ~ GIN;
endmodule


module XXOR1 ( A, B, GIN, PHI, SUM );
input  A;
input  B;
input  GIN;
input  PHI;
output SUM;
   assign SUM = ( ~ (A ^ B)) ^ GIN;
endmodule


module BLOCK0 ( A, B, PHI, POUT, GOUT );
input  A;
input  B;
input  PHI;
output POUT;
output GOUT;
   assign POUT =  ~ (A | B);
   assign GOUT =  ~ (A & B);
endmodule


module BLOCK1 ( PIN1, PIN2, GIN1, GIN2, PHI, POUT, GOUT );
input  PIN1;
input  PIN2;
input  GIN1;
input  GIN2;
input  PHI;
output POUT;
output GOUT;
   assign POUT =  ~ (PIN1 | PIN2);
   assign GOUT =  ~ (GIN2 & (PIN2 | GIN1));
endmodule


module BLOCK2 ( PIN1, PIN2, GIN1, GIN2, PHI, POUT, GOUT );
input  PIN1;
input  PIN2;
input  GIN1;
input  GIN2;
input  PHI;
output POUT;
output GOUT;
   assign POUT =  ~ (PIN1 & PIN2);
   assign GOUT =  ~ (GIN2 | (PIN2 & GIN1));
endmodule


module BLOCK1A ( PIN2, GIN1, GIN2, PHI, GOUT );
input  PIN2;
input  GIN1;
input  GIN2;
input  PHI;
output GOUT;
   assign GOUT =  ~ (GIN2 & (PIN2 | GIN1));
endmodule


module BLOCK2A ( PIN2, GIN1, GIN2, PHI, GOUT );
input  PIN2;
input  GIN1;
input  GIN2;
input  PHI;
output GOUT;
   assign GOUT =  ~ (GIN2 | (PIN2 & GIN1));
endmodule


module PRESTAGE_16 ( A, B, CIN, PHI, POUT, GOUT );
input  [0:15] A;
input  [0:15] B;
input  CIN;
input  PHI;
output [0:15] POUT;
output [0:16] GOUT;
   BLOCK0 U10 (A[0] , B[0] , PHI , POUT[0] , GOUT[1] );
   BLOCK0 U11 (A[1] , B[1] , PHI , POUT[1] , GOUT[2] );
   BLOCK0 U12 (A[2] , B[2] , PHI , POUT[2] , GOUT[3] );
   BLOCK0 U13 (A[3] , B[3] , PHI , POUT[3] , GOUT[4] );
   BLOCK0 U14 (A[4] , B[4] , PHI , POUT[4] , GOUT[5] );
   BLOCK0 U15 (A[5] , B[5] , PHI , POUT[5] , GOUT[6] );
   BLOCK0 U16 (A[6] , B[6] , PHI , POUT[6] , GOUT[7] );
   BLOCK0 U17 (A[7] , B[7] , PHI , POUT[7] , GOUT[8] );
   BLOCK0 U18 (A[8] , B[8] , PHI , POUT[8] , GOUT[9] );
   BLOCK0 U19 (A[9] , B[9] , PHI , POUT[9] , GOUT[10] );
   BLOCK0 U110 (A[10] , B[10] , PHI , POUT[10] , GOUT[11] );
   BLOCK0 U111 (A[11] , B[11] , PHI , POUT[11] , GOUT[12] );
   BLOCK0 U112 (A[12] , B[12] , PHI , POUT[12] , GOUT[13] );
   BLOCK0 U113 (A[13] , B[13] , PHI , POUT[13] , GOUT[14] );
   BLOCK0 U114 (A[14] , B[14] , PHI , POUT[14] , GOUT[15] );
   BLOCK0 U115 (A[15] , B[15] , PHI , POUT[15] , GOUT[16] );
   INVBLOCK U2 (CIN , PHI , GOUT[0] );
endmodule


module DBLC_0_16 ( PIN, GIN, PHI, POUT, GOUT );
input  [0:15] PIN;
input  [0:16] GIN;
input  PHI;
output [0:14] POUT;
output [0:16] GOUT;
   INVBLOCK U10 (GIN[0] , PHI , GOUT[0] );
   BLOCK1A U21 (PIN[0] , GIN[0] , GIN[1] , PHI , GOUT[1] );
   BLOCK1 U32 (PIN[0] , PIN[1] , GIN[1] , GIN[2] , PHI , POUT[0] , GOUT[2] );
   BLOCK1 U33 (PIN[1] , PIN[2] , GIN[2] , GIN[3] , PHI , POUT[1] , GOUT[3] );
   BLOCK1 U34 (PIN[2] , PIN[3] , GIN[3] , GIN[4] , PHI , POUT[2] , GOUT[4] );
   BLOCK1 U35 (PIN[3] , PIN[4] , GIN[4] , GIN[5] , PHI , POUT[3] , GOUT[5] );
   BLOCK1 U36 (PIN[4] , PIN[5] , GIN[5] , GIN[6] , PHI , POUT[4] , GOUT[6] );
   BLOCK1 U37 (PIN[5] , PIN[6] , GIN[6] , GIN[7] , PHI , POUT[5] , GOUT[7] );
   BLOCK1 U38 (PIN[6] , PIN[7] , GIN[7] , GIN[8] , PHI , POUT[6] , GOUT[8] );
   BLOCK1 U39 (PIN[7] , PIN[8] , GIN[8] , GIN[9] , PHI , POUT[7] , GOUT[9] );
   BLOCK1 U310 (PIN[8] , PIN[9] , GIN[9] , GIN[10] , PHI , POUT[8] , GOUT[10] );
   BLOCK1 U311 (PIN[9] , PIN[10] , GIN[10] , GIN[11] , PHI , POUT[9] , GOUT[11] );
   BLOCK1 U312 (PIN[10] , PIN[11] , GIN[11] , GIN[12] , PHI , POUT[10] , GOUT[12] );
   BLOCK1 U313 (PIN[11] , PIN[12] , GIN[12] , GIN[13] , PHI , POUT[11] , GOUT[13] );
   BLOCK1 U314 (PIN[12] , PIN[13] , GIN[13] , GIN[14] , PHI , POUT[12] , GOUT[14] );
   BLOCK1 U315 (PIN[13] , PIN[14] , GIN[14] , GIN[15] , PHI , POUT[13] , GOUT[15] );
   BLOCK1 U316 (PIN[14] , PIN[15] , GIN[15] , GIN[16] , PHI , POUT[14] , GOUT[16] );
endmodule


module DBLC_1_16 ( PIN, GIN, PHI, POUT, GOUT );
input  [0:14] PIN;
input  [0:16] GIN;
input  PHI;
output [0:12] POUT;
output [0:16] GOUT;
   INVBLOCK U10 (GIN[0] , PHI , GOUT[0] );
   INVBLOCK U11 (GIN[1] , PHI , GOUT[1] );
   BLOCK2A U22 (PIN[0] , GIN[0] , GIN[2] , PHI , GOUT[2] );
   BLOCK2A U23 (PIN[1] , GIN[1] , GIN[3] , PHI , GOUT[3] );
   BLOCK2 U34 (PIN[0] , PIN[2] , GIN[2] , GIN[4] , PHI , POUT[0] , GOUT[4] );
   BLOCK2 U35 (PIN[1] , PIN[3] , GIN[3] , GIN[5] , PHI , POUT[1] , GOUT[5] );
   BLOCK2 U36 (PIN[2] , PIN[4] , GIN[4] , GIN[6] , PHI , POUT[2] , GOUT[6] );
   BLOCK2 U37 (PIN[3] , PIN[5] , GIN[5] , GIN[7] , PHI , POUT[3] , GOUT[7] );
   BLOCK2 U38 (PIN[4] , PIN[6] , GIN[6] , GIN[8] , PHI , POUT[4] , GOUT[8] );
   BLOCK2 U39 (PIN[5] , PIN[7] , GIN[7] , GIN[9] , PHI , POUT[5] , GOUT[9] );
   BLOCK2 U310 (PIN[6] , PIN[8] , GIN[8] , GIN[10] , PHI , POUT[6] , GOUT[10] );
   BLOCK2 U311 (PIN[7] , PIN[9] , GIN[9] , GIN[11] , PHI , POUT[7] , GOUT[11] );
   BLOCK2 U312 (PIN[8] , PIN[10] , GIN[10] , GIN[12] , PHI , POUT[8] , GOUT[12] );
   BLOCK2 U313 (PIN[9] , PIN[11] , GIN[11] , GIN[13] , PHI , POUT[9] , GOUT[13] );
   BLOCK2 U314 (PIN[10] , PIN[12] , GIN[12] , GIN[14] , PHI , POUT[10] , GOUT[14] );
   BLOCK2 U315 (PIN[11] , PIN[13] , GIN[13] , GIN[15] , PHI , POUT[11] , GOUT[15] );
   BLOCK2 U316 (PIN[12] , PIN[14] , GIN[14] , GIN[16] , PHI , POUT[12] , GOUT[16] );
endmodule


module DBLC_2_16 ( PIN, GIN, PHI, POUT, GOUT );
input  [0:12] PIN;
input  [0:16] GIN;
input  PHI;
output [0:8] POUT;
output [0:16] GOUT;
   INVBLOCK U10 (GIN[0] , PHI , GOUT[0] );
   INVBLOCK U11 (GIN[1] , PHI , GOUT[1] );
   INVBLOCK U12 (GIN[2] , PHI , GOUT[2] );
   INVBLOCK U13 (GIN[3] , PHI , GOUT[3] );
   BLOCK1A U24 (PIN[0] , GIN[0] , GIN[4] , PHI , GOUT[4] );
   BLOCK1A U25 (PIN[1] , GIN[1] , GIN[5] , PHI , GOUT[5] );
   BLOCK1A U26 (PIN[2] , GIN[2] , GIN[6] , PHI , GOUT[6] );
   BLOCK1A U27 (PIN[3] , GIN[3] , GIN[7] , PHI , GOUT[7] );
   BLOCK1 U38 (PIN[0] , PIN[4] , GIN[4] , GIN[8] , PHI , POUT[0] , GOUT[8] );
   BLOCK1 U39 (PIN[1] , PIN[5] , GIN[5] , GIN[9] , PHI , POUT[1] , GOUT[9] );
   BLOCK1 U310 (PIN[2] , PIN[6] , GIN[6] , GIN[10] , PHI , POUT[2] , GOUT[10] );
   BLOCK1 U311 (PIN[3] , PIN[7] , GIN[7] , GIN[11] , PHI , POUT[3] , GOUT[11] );
   BLOCK1 U312 (PIN[4] , PIN[8] , GIN[8] , GIN[12] , PHI , POUT[4] , GOUT[12] );
   BLOCK1 U313 (PIN[5] , PIN[9] , GIN[9] , GIN[13] , PHI , POUT[5] , GOUT[13] );
   BLOCK1 U314 (PIN[6] , PIN[10] , GIN[10] , GIN[14] , PHI , POUT[6] , GOUT[14] );
   BLOCK1 U315 (PIN[7] , PIN[11] , GIN[11] , GIN[15] , PHI , POUT[7] , GOUT[15] );
   BLOCK1 U316 (PIN[8] , PIN[12] , GIN[12] , GIN[16] , PHI , POUT[8] , GOUT[16] );
endmodule


module DBLC_3_16 ( PIN, GIN, PHI, POUT, GOUT );
input  [0:8] PIN;
input  [0:16] GIN;
input  PHI;
output [0:0] POUT;
output [0:16] GOUT;
   INVBLOCK U10 (GIN[0] , PHI , GOUT[0] );
   INVBLOCK U11 (GIN[1] , PHI , GOUT[1] );
   INVBLOCK U12 (GIN[2] , PHI , GOUT[2] );
   INVBLOCK U13 (GIN[3] , PHI , GOUT[3] );
   INVBLOCK U14 (GIN[4] , PHI , GOUT[4] );
   INVBLOCK U15 (GIN[5] , PHI , GOUT[5] );
   INVBLOCK U16 (GIN[6] , PHI , GOUT[6] );
   INVBLOCK U17 (GIN[7] , PHI , GOUT[7] );
   BLOCK2A U28 (PIN[0] , GIN[0] , GIN[8] , PHI , GOUT[8] );
   BLOCK2A U29 (PIN[1] , GIN[1] , GIN[9] , PHI , GOUT[9] );
   BLOCK2A U210 (PIN[2] , GIN[2] , GIN[10] , PHI , GOUT[10] );
   BLOCK2A U211 (PIN[3] , GIN[3] , GIN[11] , PHI , GOUT[11] );
   BLOCK2A U212 (PIN[4] , GIN[4] , GIN[12] , PHI , GOUT[12] );
   BLOCK2A U213 (PIN[5] , GIN[5] , GIN[13] , PHI , GOUT[13] );
   BLOCK2A U214 (PIN[6] , GIN[6] , GIN[14] , PHI , GOUT[14] );
   BLOCK2A U215 (PIN[7] , GIN[7] , GIN[15] , PHI , GOUT[15] );
   BLOCK2 U316 (PIN[0] , PIN[8] , GIN[8] , GIN[16] , PHI , POUT[0] , GOUT[16] );
endmodule


module XORSTAGE_16 ( A, B, PBIT, PHI, CARRY, SUM, COUT );
input  [0:15] A;
input  [0:15] B;
input  PBIT;
input  PHI;
input  [0:16] CARRY;
output [0:15] SUM;
output COUT;
   XXOR1 U20 (A[0] , B[0] , CARRY[0] , PHI , SUM[0] );
   XXOR1 U21 (A[1] , B[1] , CARRY[1] , PHI , SUM[1] );
   XXOR1 U22 (A[2] , B[2] , CARRY[2] , PHI , SUM[2] );
   XXOR1 U23 (A[3] , B[3] , CARRY[3] , PHI , SUM[3] );
   XXOR1 U24 (A[4] , B[4] , CARRY[4] , PHI , SUM[4] );
   XXOR1 U25 (A[5] , B[5] , CARRY[5] , PHI , SUM[5] );
   XXOR1 U26 (A[6] , B[6] , CARRY[6] , PHI , SUM[6] );
   XXOR1 U27 (A[7] , B[7] , CARRY[7] , PHI , SUM[7] );
   XXOR1 U28 (A[8] , B[8] , CARRY[8] , PHI , SUM[8] );
   XXOR1 U29 (A[9] , B[9] , CARRY[9] , PHI , SUM[9] );
   XXOR1 U210 (A[10] , B[10] , CARRY[10] , PHI , SUM[10] );
   XXOR1 U211 (A[11] , B[11] , CARRY[11] , PHI , SUM[11] );
   XXOR1 U212 (A[12] , B[12] , CARRY[12] , PHI , SUM[12] );
   XXOR1 U213 (A[13] , B[13] , CARRY[13] , PHI , SUM[13] );
   XXOR1 U214 (A[14] , B[14] , CARRY[14] , PHI , SUM[14] );
   XXOR1 U215 (A[15] , B[15] , CARRY[15] , PHI , SUM[15] );
   BLOCK1A U1 (PBIT , CARRY[0] , CARRY[16] , PHI , COUT );
endmodule


module DBLCTREE_16 ( PIN, GIN, PHI, GOUT, POUT );
input  [0:15] PIN;
input  [0:16] GIN;
input  PHI;
output [0:16] GOUT;
output [0:0] POUT;
   wire [0:14] INTPROP_0;
   wire [0:16] INTGEN_0;
   wire [0:12] INTPROP_1;
   wire [0:16] INTGEN_1;
   wire [0:8] INTPROP_2;
   wire [0:16] INTGEN_2;
   DBLC_0_16 U_0 (PIN, GIN, PHI, INTPROP_0, INTGEN_0);
   DBLC_1_16 U_1 (INTPROP_0, INTGEN_0, PHI, INTPROP_1, INTGEN_1);
   DBLC_2_16 U_2 (INTPROP_1, INTGEN_1, PHI, INTPROP_2, INTGEN_2);
   DBLC_3_16 U_3 (INTPROP_2, INTGEN_2, PHI, POUT, GOUT);
endmodule


module DBLCADDER_16_16 ( OPA, OPB, CIN, PHI, SUM, COUT );
input  [0:15] OPA;
input  [0:15] OPB;
input  CIN;
input  PHI;
output [0:15] SUM;
output COUT;
   wire [0:15] INTPROP;
   wire [0:16] INTGEN;
   wire [0:0] PBIT;
   wire [0:16] CARRY;
   PRESTAGE_16 U1 (OPA , OPB , CIN , PHI , INTPROP , INTGEN );
   DBLCTREE_16 U2 (INTPROP , INTGEN , PHI , CARRY , PBIT );
   XORSTAGE_16 U3 (OPA[0:15] , OPB[0:15] , PBIT[0] , PHI , CARRY[0:16] , SUM , COUT );
endmodule


module MULTIPLIER_9_8 ( MULTIPLICAND, MULTIPLIER, PHI, RESULT );
input  [0:8] MULTIPLICAND;
input  [0:7] MULTIPLIER;
input  PHI;
output [0:15] RESULT;
   wire [0:81] PPBIT;
   wire [0:16] INT_CARRY;
   wire [0:15] INT_SUM;
   wire LOGIC_ZERO;
   wire DUMMY;
   assign LOGIC_ZERO = 0;
   PPGEN_9_8 PP (MULTIPLICAND[0:8], MULTIPLIER[0:7], PPBIT[0:81]);
   WALLACE_9_8 W (PPBIT[0:81], INT_CARRY[1:16], INT_SUM[0:15]);
   assign INT_CARRY[0] = LOGIC_ZERO;
   DBLCADDER_16_16 D (INT_SUM[0:15], INT_CARRY[0:15], LOGIC_ZERO, PHI, RESULT[0:15], DUMMY);
endmodule
