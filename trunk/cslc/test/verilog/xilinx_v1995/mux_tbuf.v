module mux_tbuf (A,B,C,D,E,SEL,SIG); 
 
input A,B,C,D,E; 
input [4:0] SEL; 
output SIG; 
reg SIG; 
  
    always @ (SEL or A) 
    begin 
      if (SEL[0]==1'b0) 
          SIG=A; 
      else 
          SIG=1'bz; 
    end 
  
always @ (SEL or B) 
begin  
      if (SEL[1]==1'b0) 
          SIG=B; 
      else 
          SIG=1'bz; 
    end 
 
always @ (SEL or C) 
begin 
    if (SEL[2]==1'b0) 
        SIG=C; 
    else 
        SIG=1'bz; 
    end 
 
always @ (SEL or D) 
begin 
    if (SEL[3]==1'b0)  
        SIG=D;  
    else  
        SIG=1'bz; 
    end 
 
always @ (SEL or E) 
begin  
    if (SEL[4]==1'b0) 
        SIG=E; 
    else 
        SIG=1'bz; 
    end 
endmodule 
