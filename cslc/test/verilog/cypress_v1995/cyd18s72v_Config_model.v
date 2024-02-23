
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











