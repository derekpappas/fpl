module mux_ram_row (
clk, 
aclr, 
rama,
ramb,
ramc,
sel_row1,
sel_row2,
sel_row3,
row_end,
row1_1,
row1_2,
row1_3,
row2_1,
row2_2,
row2_3,
row3_1,
row3_2,
row3_3
);

parameter idle=0, A=3, B=2, C=1;

input clk, aclr;
input [7:0] rama, ramb, ramc;
input [1:0] sel_row1, sel_row2, sel_row3;
input row_end;
output [7:0] row1_1, row1_2, row1_3;
output [7:0] row2_1, row2_2, row2_3;
output [7:0] row3_1, row3_2, row3_3;


	//Reg Declaration
	reg [7:0] col1_a, col1_b, col1_c;
	reg [7:0] col2_a, col2_b, col2_c;
	reg [7:0] col3_a, col3_b, col3_c;
	reg row_end_del1, row_end_del2, row_end_del3, row_end_del4, row_end_del5;
	reg [7:0] ram_col3_a, ram_col3_b, ram_col3_c;
	
	
	//Wire Declaration
	wire sel_edge_col3 = row_end_del3;
	wire sel_edge_col1 = row_end_del4;
	
	
	
	assign row1_1 = sel_edge_col1 ? (8'b00000000) : (col1_a);
	assign row1_2 = col2_a;
	assign row1_3 = sel_edge_col3 ? (8'b00000000) : (col3_a);
	assign row2_1 = sel_edge_col1 ? (8'b00000000) : (col1_b);
	assign row2_2 = col2_b;
	assign row2_3 = sel_edge_col3 ? (8'b00000000) : (col3_b);
	assign row3_1 = sel_edge_col1 ? (8'b00000000) : (col1_c);
	assign row3_2 = col2_c;
	assign row3_3 = sel_edge_col3 ? (8'b00000000) : (col3_c);
	
	
	
always @ (posedge clk or posedge aclr)
begin
    if (aclr)
	   begin
       	   row_end_del1 <= 0;
		   row_end_del2 <= 0;
	       row_end_del3 <= 0;
    	   row_end_del4 <= 0;
 		   row_end_del5 <= 0;
       end
    else 
       begin
           row_end_del1 <= row_end;
           row_end_del2 <= row_end_del1;
           row_end_del3 <= row_end_del2;
           row_end_del4 <= row_end_del3;
		   row_end_del5 <= row_end_del4;
       end       
end

always @ (rama or ramb or ramc or sel_row1)
begin
	   case (sel_row1)
				idle: begin
			  			ram_col3_a = 0;
				 	 end
				
				A: begin
						ram_col3_a = rama;  
			  	 end

				B: begin
						ram_col3_a = ramb;
					 end

		    	C: begin
				 		ram_col3_a = ramc;
  			  	   end
   	   endcase	
end
			

always @ (posedge clk or posedge aclr)
begin
   if (aclr)
	   begin
			col1_a <= 0;
			col2_a <= 0;
			col3_a <= 0;
		end
	else
		begin
			col3_a <= ram_col3_a;
		    col2_a <= col3_a;
			col1_a <= col2_a;
		 end
end

always @ (rama or ramb or ramc or sel_row2)
begin
	   case (sel_row2)
				idle: begin
			  			ram_col3_b = 0;
				 	 end
				
				A: begin
						ram_col3_b = rama;  
			  	 end

				B: begin
						ram_col3_b = ramb;
					 end

		    	C: begin
				 		ram_col3_b = ramc;
  			  	   end
   	   endcase	
end


always @ (posedge clk or posedge aclr) 
begin
   if (aclr)
	   begin
			col1_b <= 0;
			col2_b <= 0;
			col3_b <= 0;
		end
	else
		begin
			col3_b <= ram_col3_b;
			col2_b <= col3_b;
			col1_b <= col2_b;
		 end
end

always @ (rama or ramb or ramc or sel_row3)
begin
	   case (sel_row3)
				idle: begin
			  			ram_col3_c = 0;
				 	 end
				
				A: begin
						ram_col3_c = rama;  
			  	 end

				B: begin
						ram_col3_c = ramb;
					 end

		    	C: begin
				 		ram_col3_c = ramc;
  			  	   end
   	   endcase	
end


always @ (posedge clk or posedge aclr)
begin
   if (aclr)
	   begin
			col1_c <= 0;
			col2_c <= 0;
			col3_c <= 0;
		end
	else
		begin
	     	 col3_c <= ram_col3_c;
			 col2_c <= col3_c;
			 col1_c <= col2_c;
		 end
end



	      

endmodule
