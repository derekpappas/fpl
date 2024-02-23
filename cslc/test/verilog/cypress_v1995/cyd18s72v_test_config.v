`ifdef FREQ167
        `define tCH2  3.1                        // Clock period is set to 10ns for 100MHz frequency.
        `define tCCS  5.4                       // Skew between two clocks
        `define RESET_PULSE_WIDTH  15          // Reset Pulse Width is taken value greater than required  
                                       // reset pulse width
        `define RESET_RECOVERY_TIME 20         // Reset recovery time is set to value greater that required 
                                       // reset recovery time   
        `define  RESET_SETUP_TIME   15                                         

        `define SAFE_TIME          3.2          // Time period is chosen so that no setup or hold time is
                                      // violated to drive all the inputs from clock edge

        `define SETUP_VIOLATION_TIME 5       // Time period to violate setup time.
`else
 `ifdef FREQ133   
        `define tCH2  3.76                        // Clock period is set to 10ns for 100MHz frequency.
        `define tCCS  6.2                        // Skew between two clocks
        `define RESET_PULSE_WIDTH  15          // Reset Pulse Width is taken value greater than required  
                                       // reset pulse width
        `define RESET_RECOVERY_TIME 20         // Reset recovery time is set to value greater that required 
                                       // reset recovery time   
        `define  RESET_SETUP_TIME   15                                         

        `define SAFE_TIME          2.0          // Time period is chosen so that no setup or hold time is
                                      // violated to drive all the inputs from clock edge

        `define SETUP_VIOLATION_TIME 6       // Time period to violate setup time.

`else
    //  FREQ100       
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

`endif
`endif



`ifdef CYD18S36V

       `define  AD_S           19              

       `define  AD_M           18

       `define  BT_S           4

       `define  BT_M           3 

       `define  DT_S           36

       `define  DT_M           35

       `define  LAST_ADR       524287
       
       `define  LAST_ADDRESS   524287 



`else
    
`ifdef CYD18S72V

       `define LAST_ADR           262143        // memory size => 256 K
       `define AD_M               17            // addr width  => 18
       `define DT_M               71            // data width  => 72
       `define BT_M               7             // byte width  =>  8

       `define AD_S               18            // addr width  => 18
       `define DT_S               72            // data width  => 72
       `define BT_S               8             // byte width  => 8
       `define LAST_ADDRESS       262143        // memory size => 256 K


`else 

`ifdef CYD9S18V    
       `define  AD_S           19              
       `define  AD_M           18
       `define  BT_S           2
       `define  BT_M           1 
       `define  DT_S           18
       `define  DT_M           17
       `define  LAST_ADR       524287
       `define  LAST_ADDRESS   524287 
 
`endif


`endif

`endif





