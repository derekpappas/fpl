module dcd5_32(in, out0, out1, out2, out3, out4, out5, out6, out7,out8,out9,out10,out11,out12,out13,out14,out31);
	
	 
	input[4:0] in;
	output  out0, out1, out2, out3, out4, out5, out6, out7,out8,out9,out10,out11,out12,out13,out14,out31;

	reg out0, out1, out2, out3, out4, out5, out6, out7,out8,out9,out10,out11,out12,out13,out14,out31;


 
always@(in)
     begin
	case(in)
	  
	5'b00000: 
	begin
		 
		 #6 out0=1;
		 out1=0;
		 out2=0;
		 out3=0;
		 out4=0;
		 out5=0;
		 out6=0;
		 out7=0;
		 out8=0;
		 out9=0;
                 out10=0;
		 out11=0;
		 out12=0;
		 out13=0;
                 out14=0;
		 out31=0;
	end
	
	5'b00001: 
	begin
		 #6 out0=0;
		 out1=1;
		 out2=0;
		 out3=0;
		 out4=0;
		 out5=0;
		 out6=0;
		 out7=0;
		 out8=0;
		 out9=0;
                 out10=0;
		 out11=0;
		 out12=0;
		 out13=0;
                 out14=0;
		 out31=0;
	end
	
	5'b00010: 
	begin
		 #6 out0=0;
		 out1=0;
		 out2=1;
		 out3=0;
		 out4=0;
		 out5=0;
		 out6=0;
		 out7=0;
		 out8=0;
		 out9=0;
                 out10=0;
		 out11=0;
		 out12=0;
		 out13=0;
                 out14=0;
		 out31=0;
	end

	5'b00011: 
	begin
		 #6 out0=0;
		 out1=0;
		 out2=0;
		 out3=1;
		 out4=0;
		 out5=0;
		 out6=0;
		 out7=0;
		 out8=0;
		 out9=0;
                 out10=0;
		 out11=0;
		 out12=0;
		 out13=0;
                 out14=0;
		 out31=0;   
	end

	5'b00100: 
	begin
		 #6 out0=0;
		 out1=0;
		 out2=0;
		 out3=0;
		 out4=1;
		 out5=0;
		 out6=0;
		 out7=0;
		 out8=0;
		 out9=0;
                 out10=0;
		 out11=0;
		 out12=0;
		 out13=0;
                 out14=0;
		 out31=0;   
	end

	5'b00101:
	begin
	 	 #6 out0=0;
		 out1=0;
		 out2=0;
		 out3=0;
		 out4=0;
		 out5=1;
		 out6=0;
		 out7=0;
		 out8=0;
		 out9=0;
                 out10=0;
		 out11=0;
		 out12=0;
		 out13=0;
                 out14=0;
		 out31=0;   
		
	end

	5'b00110:
	begin
		#6  out0=0;
		 out1=0;
		 out2=0;
		 out3=0;
		 out4=0;
		 out5=0;
		 out6=1;
		 out7=0;
		 out8=0;
		 out9=0;
                 out10=0;
		 out11=0;
		 out12=0;
		 out13=0;
                 out14=0;
		 out31=0;   
	end

	5'b00111:
	begin
		 #6 out0=0;
		 out1=0;
		 out2=0;
		 out3=0;
		 out4=0;
		 out5=0;
		 out6=0;
		 out7=1;
		 out8=0;
		 out9=0;
                 out10=0;
		 out11=0;
		 out12=0;
		 out13=0;
                 out14=0;
		 out31=0;    
		
	end

	5'b01000:
	begin
		 #6 out0=0;
		 out1=0;
		 out2=0;
		 out3=0;
		 out4=0;
		 out5=0;
		 out6=0;
		 out7=0;
		 out8=1;
		 out9=0;
                 out10=0;
		 out11=0;
		 out12=0;
		 out13=0;
                 out14=0;
		 out31=0;    
		
	end
	5'b01001:
	begin
		 #6 out0=0;
		 out1=0;
		 out2=0;
		 out3=0;
		 out4=0;
		 out5=0;
		 out6=0;
		 out7=0;
		 out8=0;
		 out9=1;
                 out10=0;
		 out11=0;
		 out12=0;
		 out13=0;
                 out14=0;
		 out31=0;    
		
	end
	5'b01010:
	begin
		 #6 out0=0;
		 out1=0;
		 out2=0;
		 out3=0;
		 out4=0;
		 out5=0;
		 out6=0;
		 out7=0;
		 out8=0;
		 out9=0;
                 out10=1;
		 out11=0;
		 out12=0;
		 out13=0;
                 out14=0;
		 out31=0;    
		
	end
	5'b01011:
	begin
		 #6 out0=0;
		 out1=0;
		 out2=0;
		 out3=0;
		 out4=0;
		 out5=0;
		 out6=0;
		 out7=0;
		 out8=0;
		 out9=0;
                 out10=0;
		 out11=1;
		 out12=0;
		 out13=0;
                 out14=0;
		 out31=0;    
		
	end
5'b01100:
	begin
		 #6 out0=0;
		 out1=0;
		 out2=0;
		 out3=0;
		 out4=0;
		 out5=0;
		 out6=0;
		 out7=0;
		 out8=0;
		 out9=0;
                 out10=0;
		 out11=0;
		 out12=1;
		 out13=0;
                 out14=0;
		 out31=0;    
		
	end
	5'b01101:
	begin
		 #6 out0=0;
		 out1=0;
		 out2=0;
		 out3=0;
		 out4=0;
		 out5=0;
		 out6=0;
		 out7=0;
		 out8=0;
		 out9=0;
                 out10=0;
		 out11=0;
		 out12=0;
		 out13=1;
                 out14=0;
		 out31=0;    
		
	end
        5'b01110:
	begin
		 #6 out0=0;
		 out1=0;
		 out2=0;
		 out3=0;
		 out4=0;
		 out5=0;
		 out6=0;
		 out7=0;
		 out8=0;
		 out9=0;
                 out10=0;
		 out11=0;
		 out12=0;
		 out13=0;
                 out14=1;
		 out31=0;    
		
	end




5'b11111:
	begin
		 #6 out0=0;
		 out1=0;
		 out2=0;
		 out3=0;
		 out4=0;
		 out5=0;
		 out6=0;
		 out7=0;
		 out8=0;
		 out9=0;
                 out10=0;
		 out11=0;
		 out12=0;
		 out13=0;
 		 out14=0;
		 out31=1;    
		
	end

	endcase
end

endmodule






