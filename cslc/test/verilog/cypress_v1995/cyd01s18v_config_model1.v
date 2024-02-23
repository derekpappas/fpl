`ifdef CYD01S18V

       `define  AD_S           16

       `define  AD_M           15 

       `define  BT_S           2 
 
       `define  BT_M           1 

       `define  DT_S           18

       `define  DT_M           17

       `define  LAST_ADR      65535

       `define  DELAYED_WRITE  1

`else

`ifdef CYD02S18V

       `define  AD_S           17              

       `define  AD_M           16

       `define  BT_S           2

       `define  BT_M           1 

       `define  DT_S           18

       `define  DT_M           17

       `define  LAST_ADR       131071

       `define  DELAYED_WRITE  1

`else

`ifdef CYD04S18V

       `define  AD_S           18         

       `define  AD_M           17

       `define  BT_S           2 

       `define  BT_M           1

       `define  DT_S           18

       `define  DT_M           17 

       `define  LAST_ADR       262143

       `define  DELAYED_WRITE  1

`else

`ifdef CYD09S18V

       `define  AD_S           19        

       `define  AD_M           18

       `define  BT_S           2

       `define  BT_M           1

       `define  DT_S           18

       `define  DT_M           17

       `define  LAST_ADR       524287

       `define  DELAYED_WRITE  1

`else

`ifdef CYD01S36V

       `define  AD_S           15         
 
       `define  AD_M           14       

       `define  BT_S           4

       `define  BT_M           3 

       `define  DT_S           36

       `define  DT_M           35

       `define  LAST_ADR       32767

       `define  DELAYED_WRITE  1

`else

`ifdef CYD02S36V

       `define  AD_S           16        

       `define  AD_M           15

       `define  BT_S           4

       `define  BT_M           3

       `define  DT_S           36

       `define  DT_M           35

       `define  LAST_ADR       65535

       `define  DELAYED_WRITE  1

`else

`ifdef CYD04S36V

       `define  AD_S           17         

       `define  AD_M           16 

       `define  BT_S           4

       `define  BT_M           3

       `define  DT_S           36

       `define  DT_M           35

       `define  LAST_ADR       131071 

       `define  DELAYED_WRITE  1

`else

`ifdef CYD09S36V

       `define  AD_S           18  

       `define  AD_M           17 

       `define  BT_S           4

       `define  BT_M           3 

       `define  DT_S           36

       `define  DT_M           35

       `define  LAST_ADR       262143

       `define  DELAYED_WRITE  1

`else

 
`ifdef CYD18S36V

       `define  AD_S           19   

       `define  AD_M           18  

       `define  BT_S           4
   
       `define  BT_M           3

       `define  DT_S           36

       `define  DT_M           35

       `define  LAST_ADR       524287

       `define  DELAYED_WRITE  1

`else

 
`ifdef CYD04S72V

       `define  AD_S           16         

       `define  AD_M           15 

       `define  BT_S           8

       `define  BT_M           7

       `define  DT_S           72

       `define  DT_M           71

       `define  LAST_ADR       65535

       `define  DELAYED_WRITE  1

`else

 
`ifdef CYD09S72V

       `define  AD_S           17        

       `define  AD_M           16 

       `define  BT_S           8

       `define  BT_M           7

       `define  DT_S           72

       `define  DT_M           71

       `define  LAST_ADR       131071

       `define  DELAYED_WRITE  1

`else

 
`ifdef CY7C0837V

       `define  AD_S           15        

       `define  AD_M           14 

       `define  BT_S           2

       `define  BT_M           1

       `define  DT_S           18

       `define  DT_M           17

       `define  LAST_ADR       32767

       `define  DELAYED_WRITE  0

`else

`ifdef CY7C0830V

       `define  AD_S           16         

       `define  AD_M           15

       `define  BT_S           2

       `define  BT_M           1

       `define  DT_S           18 

       `define  DT_M           17

       `define  LAST_ADR       65535

       `define  DELAYED_WRITE  0

`else


`ifdef CY7C0831V

       `define  AD_S           17         

       `define  AD_M           16

       `define  BT_S           2

       `define  BT_M           1

       `define  DT_S           18

       `define  DT_M           17

       `define  LAST_ADR       131071

       `define  DELAYED_WRITE  0

`else

 
`ifdef CY7C0832V

       `define  AD_S           18         

       `define  AD_M           17

       `define  BT_S           2

       `define  BT_M           1 

       `define  DT_S           18

       `define  DT_M           17 

       `define  LAST_ADR       262143

       `define  DELAYED_WRITE  0

`else


`ifdef CY7C0833V

       `define  AD_S           19         

       `define  AD_M           18

       `define  BT_S           2 

       `define  BT_M           1

       `define  DT_S           18

       `define  DT_M           17 

       `define  LAST_ADR       524287

       `define  DELAYED_WRITE  0

`else

 
`ifdef CY7C0830V

       `define  AD_S           16        

       `define  AD_M           15 

       `define  BT_S           2

       `define  BT_M           1

       `define  DT_S           18
 
       `define  DT_M           17 

       `define  LAST_ADR       65535

       `define  DELAYED_WRITE  0

`else

`ifdef CY7C0850V

       `define  AD_S          15         

       `define  AD_M          14 

       `define  BT_S          4 

       `define  BT_M          3

       `define  DT_S          36

       `define  DT_M          35

       `define  LAST_ADR      32767

       `define  DELAYED_WRITE  0
`else
       `define  AD_S           16

       `define  AD_M           15 

       `define  BT_S           2 
 
       `define  BT_M           1 

       `define  DT_S           18

       `define  DT_M           17

       `define  LAST_ADR      65535

       `define  DELAYED_WRITE  1
`endif  
`endif
`endif
`endif
`endif
`endif
`endif
`endif
`endif
`endif
`endif
`endif
`endif
`endif
`endif
`endif
`endif
`endif

 

 

 

 

 

 

 

 

 

 



 

 

 


