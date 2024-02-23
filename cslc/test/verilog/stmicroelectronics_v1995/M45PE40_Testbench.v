//////////////////////////////////////////////////////////////////////////
//
// File:           - M45PE40_Testbench.v
// Date:           - July 2004
// Author:         - Xue-feng Hu at MPG Memory Competence Center of China
// Description:    - Links the M45PE40 access driver to the M45PE40 memory
// Revision:       - Version 1.3
// Quotation:      - No bugs, all are features. 
//
//////////////////////////////////////////////////////////////////////////
//
// LIMITATION OF LIABILITY: 
// NEITHER STMicroelectronics NOR ITS VENDORS OR AGENTS SHALL 
// BE LIABLE FOR ANY LOSS OF PROFITS, LOSS OF USE, LOSS OF
// DATA, INTERRUPTION OF BUSINESS, NOR FOR INDIRECT, SPECIAL, 
// INCIDENTAL OR CONSEQUENTIAL DAMAGES OF ANY KIND WHETHER 
// UNDER THIS AGREEMENT OR OTHERWISE, EVEN IF ADVISED OF THE 
// POSSIBILITY OF SUCH DAMAGES.
//
// Copyright 2003, STMicroelectrons Corporation, All Rights Reserved.
//
//////////////////////////////////////////////////////////////////////////

`include "M45PE40_Macro.v"

//=====================================
module M45PE40_SIM;
wire reset;
wire vcc,vss;
wire c,d,q,s,w;

//-------------------------------------
M45PE40 U_M45PE40(
                    .C(c),
                    .D(d),
                    .Q(q),
                    .S(s),
                    .W(w),
                    .RESET(reset),
                    .VCC(vcc),
                    .VSS(vss)
                 );
//-------------------------------------
M45PE40_DRV M45PE40_Driver(
                            .C(c),
                            .D(d),
                            .Q(q),
                            .S(s),
                            .W(w),
                            .RESET(reset),
                            .VCC(vcc),
                            .VSS(vss)
                          );
//-------------------------------------
initial begin
    $display("%t: NOTE: Load memory with Initial content.",$realtime); 
    $readmemh("M45PE40_Initial.dat",U_M45PE40.memory);
    $display("%t: NOTE: Initial Load End.\n",$realtime); 
end
//-------------------------------------

endmodule