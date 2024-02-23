`define tCH2  5                        // Clock period is set to 10ns for 100MHz frequency.
`define tCCS  8                        // Skew between two clocks
`define RESET_PULSE_WIDTH  15          // Reset Pulse Width is taken value greater than required  
                                       // reset pulse width
`define RESET_RECOVERY_TIME 20         // Reset recovery time is set to value greater that required 
                                       // reset recovery time   
`define  RESET_SETUP_TIME   15                                         

`define SAFE_TIME          6          // Time period is chosen so that no setup or hold time is
                                      // violated to drive all the inputs from clock edge

`define SETUP_VIOLATION_TIME 9       // Time period to violate setup time.

`define HOLD_VIOLATION_TIME 0.2       // Time period to violate setup time.


`define BACK_TO_BACK_L          0       
`define BACK_TO_BACK_R          1   
`define LATE_OE_L               2
`define LATE_OE_R               3 
`define SETUP_VIOLATION_RD_L    4
`define SETUP_VIOLATION_RD_R    5
`define SETUP_VIOLATION_ADDR_L  6
`define SETUP_VIOLATION_ADDR_R  7 
`define SETUP_VIOLATION_BE_L    8
`define SETUP_VIOLATION_BE_R    9
`define SETUP_VIOLATION_DATA_L  10
`define SETUP_VIOLATION_DATA_R  11
`define HOLD_VIOLATION_RD_L     12
`define HOLD_VIOLATION_RD_R     13
`define HOLD_VIOLATION_ADDR_L   14
`define HOLD_VIOLATION_ADDR_R   15
`define HOLD_VIOLATION_BE_L     16
`define HOLD_VIOLATION_BE_R     17
`define HOLD_VIOLATION_DATA_L   18
`define HOLD_VIOLATION_DATA_R   19
`define LEFT_INTR               20
`define RIGHT_INTR              21
`define LEFT_DATA               71:0
`define RIGHT_DATA              143:72    
`define LEFT_MAILBOX_INT        144 
`define RIGHT_MAILBOX_INT       145  

`define LAST_ADDRESS            262143 

`define OESKEW                  0.00

`include "cyd18s72v_test_config.v"








