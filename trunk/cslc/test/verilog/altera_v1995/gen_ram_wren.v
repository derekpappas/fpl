module gen_ram_wren (clk, aclr, data_valid, rama_wren, ramb_wren, ramc_wren);

input clk, aclr;
input data_valid;
output rama_wren, ramb_wren, ramc_wren;


	//Reg Declaration
	reg rama_wren, ramb_wren, ramc_wren;
	reg [1:0] ram_state;
	reg [2:0] count_end_row;
	reg [5:0] count_end_data;
	reg row_end;
	reg data_end;

	parameter idle = 0, rowA = 1, rowB = 2, rowC = 3;

always
begin
	case (ram_state)
		idle: begin
				rama_wren = 0;
				ramb_wren = 0;
				ramc_wren = 0;
			  end	
			
		rowA: begin
				rama_wren = 1;
				ramb_wren = 0;
				ramc_wren = 0;
			  end

		rowB: begin
				rama_wren = 0;
				ramb_wren = 1;
				ramc_wren = 0;
			  end

		rowC: begin
				rama_wren = 0;
				ramb_wren = 0;
				ramc_wren = 1;
			  end
			
		default : begin
					rama_wren = 1;
					ramb_wren = 0;
					ramc_wren = 0;
	    		  end
	endcase
end


always @(posedge clk or posedge aclr)
begin
	if (aclr)
		ram_state = idle;
	else
		case (ram_state)
			idle: begin
			  		if (data_valid)
						ram_state = rowA;
				  end
				
			rowA: begin
					if (row_end && data_end)		      
						ram_state = idle;
					else if (row_end)
						ram_state = rowB;
				  end

			rowB: begin
					if (row_end && data_end)		      
						ram_state = idle;
					else if (row_end)
						ram_state = rowC;
				  end

			rowC: begin
					if (row_end && data_end)		      
						ram_state = idle;
					else if (row_end)
						ram_state = rowA;
				  end
		endcase	
end		

always @(posedge clk or posedge aclr)
begin
	if (aclr) 
		begin
			count_end_row <= 0;
			row_end <= 0;
	    end
	else if (rama_wren || ramb_wren || ramc_wren || data_valid)
		begin
		   count_end_row <= count_end_row + 1;
		   if (count_end_row ==7)
		   	  row_end <= 1;
	  	   else
			  row_end <= 0;
		 end
end

always @(posedge clk or posedge aclr)
begin
   if (aclr)
	   begin
	       count_end_data <= 0;
	       data_end <= 0;
	   end
	else if (rama_wren || ramb_wren || ramc_wren || data_valid)
	   begin
	       count_end_data <= count_end_data + 1;
	       if (count_end_data == 63)
	         data_end <= 1;
	       else
	         data_end <=0;
	   end
 end
	      

endmodule
