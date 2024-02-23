/////////////////////////////////////////////////// 
// BND_SCAN.V                                                  // 
// Example of instantiating the BSCAN symbol in                                                 // 
// activating the Boundary Scan circuitry                                                  // 
// Count4 is an instantiated .v file of a counter                                                // 
// September 2001                                                  // 
/////////////////////////////////////////////////// 
module bnd_scan (LOAD_P, CLOCK_P, CE_P, RESET_P, 
  DATA_P, COUT_P); 
    input         LOAD_P, CLOCK_P, CE_P, RESET_P; 
input  [3:0] DATA_P; 
    output [3:0] COUT_P; 
    wire         TDI_NET, TMS_NET, TCK_NE, TDO_NET; 
    BSCAN U1 (.TDO(TDO_NET), .TDI(TDI_NET),  
            .TMS(TMS_NET), .TCK(TCK_NET)); 
    TDI U2 (.I(TDI_NET)); 
    TCK U3 (.I(TCK_NET)); 
    TMS U4 (.I(TMS_NET)); 
    TDO U5 (.O(TDO_NET)); 
    count4 U6 (.LOAD(LOAD_P), .CLOCK(CLOCK_P),  
              .RST(RESET_P), 
  .DATA(DATA_P), .COUT(COUT_P)); 
endmodule 
