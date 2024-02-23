module gen_ram_rden (
clk, 
aclr,
rama_wren, 
ramb_wren, 
ramc_wren,
sel_row1_out, 
sel_row2_out, 
sel_row3_out, 
data_end, 
rama_rden, 
ramb_rden, 
ramc_rden);

input clk, aclr;
input rama_wren, ramb_wren, ramc_wren;
output [1:0] sel_row1_out, sel_row2_out, sel_row3_out;
output data_end;
output rama_rden, ramb_rden, ramc_rden;



	//Reg Declaration
	reg [1:0] sel_row1_out, sel_row2_out, sel_row3_out;
	reg [1:0] sel_row1, sel_row2, sel_row3;
	reg [2:0] row1_state, row2_state, row3_state;
	reg [3:0] count_ZF;
	reg [2:0] count_full_row;
	reg [5:0] count_end_data;
	reg [5:0] count_valid_data;
	reg start_filter;
	reg row_end;
	reg data_end;
	reg zero_end;
	
	
    parameter idle = 0, ZF = 1, A = 2 , B = 3, C = 4;

	//Wire Declaration
	wire count_valid_data_en = rama_wren || ramb_wren || ramc_wren;
	wire count_row =  (row2_state == A) || (row2_state == B) || (row2_state == C);
	wire count_zero = (row1_state == ZF) || (row3_state == ZF);
	
		
	assign rama_rden = (sel_row1 == 2'b11) || (sel_row2 == 2'b11) || (sel_row3 == 2'b11);
	assign ramb_rden = (sel_row1 == 2'b10) || (sel_row2 == 2'b10) || (sel_row3 == 2'b10);
	assign ramc_rden = (sel_row1 == 2'b01) || (sel_row2 == 2'b01) || (sel_row3 == 2'b01);
	

always @ (posedge clk or posedge aclr)
begin
    if (aclr)
    begin
        count_valid_data <= 0;
        start_filter <= 0;
    end
    else if (count_valid_data_en) 
    begin
        count_valid_data <= count_valid_data + 1;
        if (count_valid_data == 7)
            start_filter <= 1;
        else
            start_filter <= 0;
    end
end
    
		
		
always
begin
	case (row1_state)
		idle: begin
				sel_row1 = 2'b00;
			  end	
			
		ZF: begin
				sel_row1 = 2'b00;
			end
		A: begin
				sel_row1 = 2'b11;
		   end
		B: begin
				sel_row1 = 2'b10;
		   end
		C: begin
				sel_row1 = 2'b01;
   	       end
		default : begin
					sel_row1 = 2'b00;
	    		  end
	endcase
end


always
begin
	case (row2_state)
		idle: begin
				sel_row2 = 2'b00;
			  end	
			
		A: begin
				sel_row2 = 2'b11;
		   end
		B: begin
				sel_row2 = 2'b10;
		   end
		C: begin
				sel_row2 = 2'b01;
		   end
		default : begin
					sel_row2 = 2'b00;
	    		  end
	endcase
end


always
begin
	case (row3_state)
		idle: begin
				sel_row3 = 2'b00;
			  end	
			
		ZF: begin
				sel_row3 = 2'b00;
			end

		A: begin
				sel_row3 = 2'b11;
		   end
		B: begin
				sel_row3 = 2'b10;
		   end
		C: begin
				sel_row3 = 2'b01;
		   end
		default : begin
					sel_row3 = 2'b00;
	    		  end
	endcase
end


always @(posedge clk or posedge aclr)
begin
	if (aclr)
		row1_state = idle;
	else
		case (row1_state)
			idle: begin
			  		if (start_filter)
						row1_state = ZF;
				  end
			ZF: begin
				  if (zero_end)
						row1_state = A;
				  end
			A: begin
			      if (data_end)
			            row1_state = idle;
			      else if (row_end)
						row1_state = B;
				  end
			B: begin
				  if (row_end)
						row1_state = C;
				  end
			C: begin
				  if (row_end)
						row1_state = A;
				  end
		endcase	
end		


always @(posedge clk or posedge aclr)
begin
	if (aclr)
		row2_state = idle;
	else
		case (row2_state)
			idle: begin
			  		if (start_filter)
						row2_state = A;
				  end
				
			A: begin
			      if (row_end)
						row2_state = B;
				  end
			B: begin
				  if (data_end)
			            row2_state = idle;
			      else if (row_end)
						row2_state = C;
				  end
			C: begin
				  if (row_end)
						row2_state = A;
				  end

			
		endcase	
end		


always @(posedge clk or posedge aclr)
begin
	if (aclr)
		row3_state = idle;
	else
		case (row3_state)
			idle: begin
			  		if (start_filter)
						row3_state = B;
				  end
			B: begin
				   if (count_end_data >= 55)
			            row3_state = ZF;
			      else if (row_end)
						row3_state = C;
				  end
			ZF: begin
				  if (zero_end)
						row3_state = idle;
				  end
			C: begin
				  if (row_end)
						row3_state = A;
				  end
			A: begin
			      if (data_end)
			            row3_state = idle;
			      else if (row_end)
						row3_state = B;
				  end

		endcase	
end		

always @(posedge clk or posedge aclr)
begin
	if (aclr) 
		begin
			count_full_row <= 0;
			row_end <= 0;
	    end
	else if (count_row)
		begin
		   count_full_row <= count_full_row + 1;
		   if (count_full_row == 6)
		   	  row_end <= 1;
	  	   else
			  row_end <= 0;
		 end
end


always @(posedge clk or posedge aclr)
begin
	if (aclr) 
		begin
			count_ZF <= 0;
			zero_end <= 0;
	    end
	else if (count_zero)
		begin
		   count_ZF <= count_ZF + 1;
		      if (count_ZF == 6)
		   	     zero_end <= 1;
   	  	      else
			     zero_end <= 0;
  		end
    else
        begin
             count_ZF <= 0;
  		     zero_end <= 0;
        end
end



always @(posedge clk or posedge aclr)
begin
   if (aclr)
	   begin
	       count_end_data <= 0;
	       data_end <= 0;
	   end
	else if (count_row)
	   begin
	       count_end_data <= count_end_data + 1;
	       if (count_end_data == 62)
	         data_end <= 1;
	       else
	         data_end <=0;
	   end
 end

always @ (posedge clk or posedge aclr)
begin
    if (aclr)
       begin
          sel_row1_out <= 0;
          sel_row2_out <= 0;
		  sel_row3_out <= 0;
	   end
	else 
	   begin
		  sel_row1_out <= sel_row1;
		  sel_row2_out <= sel_row2;
		  sel_row3_out <= sel_row3;
	   end
end 
	      

endmodule
