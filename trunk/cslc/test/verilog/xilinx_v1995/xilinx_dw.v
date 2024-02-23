       ///////////////////////////////////////////////////////
      // XILINX_DW.V Version 1.0                           //
     // Xilinx HDL Synthesis Design Guide                 //
    // Ilustrates gate reduction by the use of Synopsys  //
   // Designware compnents.  This is a lower-level      //
  // module with multiple arithmetic functions         //
 // December 1997                                     //
///////////////////////////////////////////////////////
 
module xilinx_dw (CHECK, RST, CLK, CLK_EN, TICK, ST);

input 	CHECK, RST;
input 	CLK, CLK_EN;
input 	TICK;
output 	ST;

wire ST;
reg [2:0] DCNT; 
reg [4:0] ECNT;
reg [6:0] ZCNT; 
reg    	  E2RQ, EQ2;
reg 	  ECNT_E, ZCNT_E;
reg	  CLREVENT, CLRZERO;
reg	  ST_INT;

    always @ (posedge CLK or negedge RST) 
    begin
	if (!RST)
        begin
            E2RQ = 1'b0;
            EQ2 = 1'b0;
            ECNT_E = 1'b0;
            ZCNT_E = 1'b0;
            CLREVENT = 1'b0;
            CLRZERO = 1'b0;
            DCNT = 3'b000;
            ECNT = 5'b00000;
            ZCNT = 7'b0000000;
            ST_INT = 1'b0;
	end
	else 
	begin        
	    if (CLK_EN == 1'b1) 
	    begin
                if (ST_INT == 1'b0) 
		begin
               	    if (E2RQ == 1'b0) 
		    begin
               		E2RQ = 1'b1;
             	    end
             	    if (EQ2 == 1'b1) 
               	    begin
			ECNT_E = 1'b0;
               	    	if (TICK == 1'b1) 
			begin
	                    DCNT = 3'b000;
                 	    CLREVENT = 1'b1;
                	    EQ2 = 1'b0;
                 	    E2RQ = 1'b0;
               	    	end 
		    end
             	    else if (DCNT == 3'b100)
		    begin 
               		if (TICK == 1'b1) 
			begin
                 	    CLREVENT = 1'b1;
                 	    DCNT = 3'b000;
                 	    ECNT_E = 1'b0;
                 	    if (ECNT == 5'b00000 || ECNT == 5'b00001)
			    begin 
                   		ST_INT = 1'b1;
                   		E2RQ = 1'b0;
                 	    end
               		end 
		    end
             	    else if (TICK == 1'b1) 
		    begin
               		DCNT = DCNT + 1'b1;
               		ECNT_E = 1'b1;
		    end
             	    else
              		ECNT_E = 1'b1;
             	end 
		else if (ST_INT == 1'b1) 
		begin
             	    if (DCNT == 3'b011) 
		    begin
               		if (TICK == 1'b1) 
			begin
                 	    ZCNT_E = 1'b0;
                 	    ECNT_E = 1'b0; 
                 	    CLREVENT = 1'b1;
                 	    CLRZERO = 1'b1;
                 	    DCNT = 3'b000;
                 	    if (ECNT[4] == 1'b1 && ZCNT != 7'b1100100) 
			    begin
                    		ST_INT = 1'b0;
			    end
               		end 
		    end
               	    else if (TICK == 1'b1) 
		    begin
                 	ZCNT_E = 1'b1;
                 	ECNT_E = 1'b1;
                 	DCNT = DCNT + 1'b1;
		    end
               	    else
		    begin
                 	ZCNT_E = 1'b1;
                 	ECNT_E = 1'b1;
		    end
                end
            end 
            if (CLK_EN == 1'b1) 
	    begin
                if (CLREVENT == 1'b1) 
		begin
            	    ECNT = 5'b00000;
               	    CLREVENT = 1'b0;
		end
             	else if (CHECK == 1'b1 && ECNT_E == 1'b1 && ECNT != 5'b10000) 
                    ECNT = ECNT + 1'b1;
             	
		if (E2RQ == 1'b1) 
		begin
               	    if (ECNT == 5'b00010) 
                 	EQ2 = 1'b1;
             	end 

		if (CLRZERO == 1'b1 || (CHECK == 1'b1 && ZCNT < 7'b1100100)) 
		begin
               	    ZCNT = 7'b0000000;
                    CLRZERO = 1'b0;
		end
             	else if (CHECK == 1'b0 && ZCNT_E == 1'b1 && ZCNT != 7'b1100100) 
               	    ZCNT = ZCNT + 1'b1;
            end 
        end 
    end
assign ST = ST_INT;

endmodule
