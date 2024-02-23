// Read cycle timing requirements
parameter tRC       =     60.0;
parameter tAPA      =     15.0;
parameter tPC       =     15.0;
parameter tAA       =     60.0;
parameter tAC       =     55.0;
parameter tCO       =     60.0;
parameter tOE       =     20.0;
parameter tBA       =     60.0;
parameter tLZ       =     10.0;
parameter tOLZ      =      5.0;
parameter tBLZ      =     10.0;
parameter tHZ       =      8.0;
parameter tOHZ      =      8.0;
parameter tBHZ      =      8.0;
parameter tOH       =      5.0;

// Write cycle timing requirements
parameter tCEM      =     10.0;
parameter tWC       =     60.0;
parameter tCW       =     60.0;
parameter tAW       =     60.0;
parameter tBW       =     60.0;
parameter tWP       =     40.0;
parameter tWR       =      0.0;
parameter tWHZ      =      8.0;
parameter tAS       =      0.0;
parameter tDW       =     20.0;
parameter tDH       =      0.0;
parameter tOW       =      5.0;
parameter tCEH      =      5.0;

// Load mode register timing requirements
parameter tZZWE_min =     10.0;
parameter tZZWE_max =    500.0;
parameter tCDZZ     =      5.0;

// Deep power down timing requirements
parameter tR        = 100000.0;
parameter tZZMIN    =  10000.0;

// Power-up initialization timing requirements
parameter tPU       = 100000.0;