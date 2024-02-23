module gen_ram_rdadd (
clk, 
aclr, 
sel_rama, 
sel_ramb, 
sel_ramc, 
rama_rdadd, 
ramb_rdadd, 
ramc_rdadd, 
row_end);

parameter PPR = 8;
parameter NA_row = 3;
parameter RAMWIDTH = 5;
parameter idle = 0, repeatA = 1, repeatB = 2, repeatC = 3;

input clk, aclr;
input sel_rama, sel_ramb, sel_ramc;
output [4:0] rama_rdadd, ramb_rdadd, ramc_rdadd;
output row_end;

	//Reg Declaration
	reg [4:0] rama_rdadd, ramb_rdadd, ramc_rdadd;
	reg [1:0] rama_read_state, ramb_read_state, ramc_read_state;
	reg [2:0] count_end_row_a, count_end_row_b, count_end_row_c;
	reg [23:0] count_end_data;
	reg [2:0] count_adda, count_addb, count_addc;
	reg row_end_a, row_end_b, row_end_c;
	reg data_end;
	reg rdadda, rdaddb, rdaddc; 

  
	//Wire Declaration
	wire count_en_a = sel_rama;
	wire count_en_b = sel_ramb;
	wire count_en_c = sel_ramc;
	wire count_en_c_start = sel_ramc || (~sel_ramc && sel_rama);
	
	assign row_end = row_end_a;
	

// State Machine for RAMA
always @ (rama_read_state)
begin
	case (rama_read_state)
		idle: begin
				rdadda <= 0;
			  end	
			
		repeatA: begin
				rdadda <= 0;
			  end

		repeatB: begin
				rdadda <= 0;
			  end

		repeatC: begin
				rdadda <= 1;
			  end
			
		default : begin
					rdadda <= 0;
				  end
	endcase
end


always @(posedge clk or posedge aclr)
begin
	if (aclr)
		rama_read_state = idle;
	else
		case (rama_read_state)
			idle: begin
			  		if (sel_rama)
						rama_read_state = repeatB;
					end
				
			repeatA: begin
				  if (row_end_a && data_end)		      
						rama_read_state = idle;
					else if (row_end_a)
						rama_read_state = repeatB;
  				 end

			repeatB: begin
				  if (row_end_a)
						rama_read_state = repeatC;
 				 end

			repeatC: begin
				  if (row_end_a)
						rama_read_state = repeatA;
 				 end
     	endcase	
end		


//State Machine for RAMB
always @ (ramb_read_state)
begin
	case (ramb_read_state)
		idle: begin
				rdaddb <= 0;
			  end	
			
		repeatA: begin
				rdaddb <= 0;
			  end

		repeatB: begin
				rdaddb <= 0;
			  end

		repeatC: begin
				rdaddb <= 1;
			  end
			
		default : begin
					rdaddb <= 0;
				  end
	endcase
end


always @(posedge clk or posedge aclr)
begin
	if (aclr)
		ramb_read_state = idle;
	else
		case (ramb_read_state)
			idle: begin
			  		if (sel_ramb)
						ramb_read_state = repeatA;
				    end
				
			repeatA: begin
				  if (row_end_b)
						ramb_read_state = repeatB;
				   end

			repeatB: begin
				   if (row_end_b && data_end)		      
						ramb_read_state = idle;
					else if (row_end_b)
						ramb_read_state = repeatC;
					end

			repeatC: begin
				  if (row_end_b)
						ramb_read_state = repeatA;
				 end
     	endcase	
end		


//State Machine for RAMC
always @ (ramc_read_state)
begin
	case (ramc_read_state)
		idle: begin
				rdaddc <= 0;
			  end	
			
		repeatA: begin
				rdaddc <= 0;
			  end

		repeatB: begin
				rdaddc <= 0;
			  end

		repeatC: begin
				rdaddc <= 1;
			  end
			
		default : begin
					rdaddc <= 0;
				  end
	endcase
end


always @(posedge clk or posedge aclr)
begin
	if (aclr)
		ramc_read_state = idle;
	else
		case (ramc_read_state)
			idle: begin
			  		if (sel_rama)
						ramc_read_state = repeatA;
				    end
				
			repeatA: begin
				  if (row_end_c)
						ramc_read_state = repeatB;
				 end

			repeatB: begin
				  if (row_end_c)
						ramc_read_state = repeatC;
				 end

			repeatC: begin
				  if (row_end_c && data_end)		      
						ramc_read_state = idle;
				  else if (row_end_c)
					   ramc_read_state = repeatA;
				 end
     	endcase	
end		


always @(posedge clk or posedge aclr)
begin
	if (aclr) 
		begin
			count_end_row_a <= 0;
			row_end_a <= 0;
	    end
	else if (count_en_a)
		begin
		   count_end_row_a <= count_end_row_a + 1;
		   if (count_end_row_a == 6)
		      begin
 			   	  row_end_a <= 1;
              end
	  	   else
		      begin
				  row_end_a <= 0;
			  end
		 end
end

always @ (posedge clk or posedge aclr)
begin
    if (aclr)
       begin
            rama_rdadd <= 0;
            count_adda <= 0;
       end
    else if (row_end_a)
       begin
			rama_rdadd <= (count_adda + rdadda) * PPR;
		    count_adda <= count_adda + rdadda;
	   end
	else if (count_en_a)
	   begin
			rama_rdadd <= rama_rdadd + 1;
	   end
end
	


always @(posedge clk or posedge aclr)
begin
	if (aclr) 
		begin
			count_end_row_b <= 0;
			row_end_b <= 0;
	  end
    else if (count_en_b)
		begin
		   count_end_row_b <= count_end_row_b + 1;
		   if (count_end_row_b == 6)
		      begin
 			   	  row_end_b <= 1;
              end
	  	   else
		      begin
				  row_end_b <= 0;
			  end
		 end
end

always @ (posedge clk or posedge aclr)
begin
    if (aclr)
       begin
            ramb_rdadd <= 0;
            count_addb <= 0;
       end
    else if (row_end_b)
       begin
			ramb_rdadd <= (count_addb + rdaddb) * PPR;
		    count_addb <= count_addb + rdaddb;
	   end
	else if (count_en_b)
	   begin
			ramb_rdadd <= ramb_rdadd + 1;
	   end
end
	

always @(posedge clk or posedge aclr)
begin
	if (aclr) 
		begin
			count_end_row_c <= 0;
			row_end_c <= 0;
		end
	else if (count_en_c)
		begin
		   count_end_row_c <= count_end_row_c + 1;
		   if (count_end_row_c == 6)
		      begin
 			   	  row_end_c <= 1;
              end
	  	   else
		      begin
				  row_end_c <= 0;
			  end
		 end
end

always @ (posedge clk or posedge aclr)
begin
    if (aclr)
       begin
            ramc_rdadd <= 0;
            count_addc <= 0;
       end
    else if (row_end_c)
       begin
			ramc_rdadd <= (count_addc + rdaddc) * PPR;
		    count_addc <= count_addc + rdaddc;
	   end
	else if (count_en_c)
	   begin
			ramc_rdadd <= ramc_rdadd + 1;
	   end
end
	

always @(posedge clk or posedge aclr)
begin
   if (aclr)
	   begin
	       count_end_data <= 0;
	       data_end <= 0;
	   end
	else if (count_en_a)
	   begin
	       count_end_data <= count_end_data + 1;
	       if (count_end_data == 62)
	         data_end <= 1;
	       else
	         data_end <=0;
	   end
 end
	      

endmodule
