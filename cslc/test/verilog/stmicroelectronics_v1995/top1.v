// Main Characteristics 
`define ADDRBUS_dim 23
`define DATABUS_dim 16
`define BLOCK_dim 64

module top;

  // Signal Bus
  wire [`ADDRBUS_dim - 1:0] A;         // Address Bus 
  wire [`DATABUS_dim - 1:0] DQ;        // Data I/0 Bus
  // Control Signal
  wire W_N;                            // Write Enable 
  wire G_N;                            // Output Enable
  wire E0,E1,E2;                       // Chip Enable
  wire RP_N;                           // Reset/Power-Down

  // Voltage signal rappresentad by integer Vector which correspond to millivolts
  wire [31:0] VDD;                     // Supply Voltage
  wire [31:0] VDDQ;                    // Input/Output Supply Voltage
  
  // Others Signal       
  wire BYTE_N;                         // Byte/Word Organization Select
  wire VPEN;                           

  wire STS;
  
  wire Info;                          // Activate/Deactivate info device operation 
  
  stimulus stim(A, DQ, W_N, G_N, E0, E1, E2, RP_N, BYTE_N, VPEN, VDD, VDDQ, Info);
  m58lwXXXd m58lw064d(A, DQ, W_N, G_N, E0, E1, E2, RP_N, BYTE_N, VPEN, STS, VDD, VDDQ, Info);

endmodule

