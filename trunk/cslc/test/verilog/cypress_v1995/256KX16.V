// This model is the property of Cypress Semiconductor Corp and is protected 

// by the US copyright laws, any unauthorized copying and distribution is prohibited.

// Cypress reserves the right to change any of the functional specifications without

// any prior notice.

// Cypress is not liable for any damages which may result from the use of this 

// functional model.

//This model checks for all the timimg violations and if any timing specifications are violated,the output might be undefined or go to a high impedance state while reading.Please note that the variable "tsim" in this model has to be changed as per your convenience for the simulation time.

//      Model:       256Kx16
//      Date :       Jan 11,2001
//	  Rev  : 	   1.3
//      Contact:     mpd_apps@cypress.com   

//******************************************************************************
`timescale 1 ns/1 ps


module A256Kx16(Address,dataIO ,OE_bar,CE_bar,WE_bar,BLE_bar, BHE_bar);

`define tsim  30000

// Signal Definitions

input [17:0] Address;
inout [15:0]  dataIO ;
input OE_bar,CE_bar,WE_bar, BLE_bar, BHE_bar;
reg   [7:0] temp_array0 [262143:0];
reg   [15:8] temp_array1 [262143:0];
reg   [7:0] mem_array0 [262143:0];
reg   [15:8] mem_array1 [262143:0];
reg   [15:0] data_temp;
reg   [17:0] Address1,Address2,Address3,Address4 ;
reg   [15:0] dataIO1;
reg   ini_cebar,ini_webar,ini_wecebar;
reg   initiate_write1,initiate_write2,initiate_write3, initiate_byte_write,initiate_byte_write_low;
reg   initiate_read1,initiate_read2; 
reg   delayed_WE;

time twc ;
time tpwe;
time tsce;
time tsd ;
time trc;
time thzwe;
time tdoe;
time taa;
time toha;
time temptaa;
time write_address1,write_data1,write_CE_bar_start1,write_WE_bar_start1; 
time write_CE_bar_start,write_WE_bar_start,write_address,write_data;
time read_address,read_CE_bar_start,read_WE_bar_start,read_address10,read_address11;

// Initializing values

initial
  begin
    initiate_write1 = 1'b0;
    initiate_write2 = 1'b0;
    initiate_write3 = 1'b0;
    initiate_read1 =1'b0;
    initiate_read2 =1'b0;
    initiate_byte_write =1'b0;
    initiate_byte_write_low = 1'b0;
    read_address =0;  
    data_temp = 16'hzz;
    twc =70 ;
    tpwe =40;
    tsce =45 ;
    tsd = 25 ;
    trc =70 ;
    thzwe = 20;
    tdoe = 25;
    taa = 70;
    toha=10;
    read_address10=0;
    temptaa =  taa + read_address10 - read_address11;
  end


wire [15:0] dataIO =  (!OE_bar && delayed_WE) ?  data_temp[15:0] : 16'bz ;

always@(CE_bar or WE_bar or OE_bar or Address or dataIO )
begin
     	if ((CE_bar==1'b0) && (WE_bar ==1'b0))
	begin
           	Address1 <= Address;
            Address2 <= Address1;
     	      dataIO1  <= dataIO;  
 	     	temp_array0[Address1] <=  dataIO1[7:0] ;
     	      temp_array1[Address1] <=  dataIO1[15:8] ;
      end
 end



always@(negedge CE_bar)
begin
     write_CE_bar_start <= $time;
     read_CE_bar_start <=$time;
     ini_cebar <= 1'b0;
     ini_wecebar<=1'b0;
end

//*******************Write_cycle**********************

always@(posedge CE_bar)
begin
      if (($time - write_CE_bar_start) >= tsce)
      begin
            if ( (WE_bar == 1'b0) && ( ($time - write_WE_bar_start) >=tpwe) )
            begin
	            Address2 <= Address1;
      	      temp_array0[Address1] <= dataIO1[7:0];  
            	temp_array1[Address1] <= dataIO1[15:8] ;  
               	ini_cebar <= 1'b1;
            end
            else
               ini_cebar <= 1'b0;
      end            
      else
      begin 
           ini_cebar <= 1'b0;
      end
end

always@(posedge BHE_bar)
begin
	initiate_byte_write <= 1'b1;
end
always@(posedge BLE_bar)
begin
	initiate_byte_write_low <= 1'b1;
end
always@(negedge WE_bar)
begin
      write_WE_bar_start <= $time;
      ini_webar <= 1'b0;
      ini_wecebar<=1'b0;
	#thzwe delayed_WE <= WE_bar;
end
always@(posedge WE_bar  )
begin
      delayed_WE <= WE_bar;
      read_WE_bar_start <=$time;
      if (($time - write_WE_bar_start) >=tpwe)
      begin
            if ( (CE_bar == 1'b0) && ( ($time - write_CE_bar_start) >= tsce) )
            begin
	            Address2 <= Address1;  
      		temp_array0[Address1] <= dataIO1[7:0]; 
               	temp_array1[Address1] <= dataIO1[15:8] ;
               	ini_webar <= 1'b1;
            end 
            else 
                  ini_webar <= 1'b0;
      end       
      else
      begin
            ini_webar <= 1'b0;
      end 
end    
always@(CE_bar && WE_bar)
begin
     if ( (CE_bar ==1'b1) && (WE_bar ==1'b1) )
     begin 
           if ( ( ($time - write_WE_bar_start) >=tpwe) && (($time-write_CE_bar_start) >=tsce))
	             ini_wecebar <=1'b1;
           else
      	       ini_wecebar <= 1'b0 ;    
           end 
     else
           ini_wecebar <=1'b0;
end
always@(dataIO)
begin
     write_data <= $time;
     write_data1 <=write_data;
     write_WE_bar_start1 <=$time;
     write_CE_bar_start1 <=$time;
     if ( ($time - write_data) >= tsd)
     begin
         if ( (WE_bar == 1'b0) && (CE_bar == 1'b0))
         begin
             if ( ( ($time - write_CE_bar_start) >=tsce) && ( ($time - write_WE_bar_start) >=tpwe) && (($time - write_address) >=twc) )
                initiate_write2 <= 1'b1;
             else
                initiate_write2 <= 1'b0;
         end
    end
end
always@(Address)
begin
     write_address <= $time;
     write_address1 <= write_address;
     write_WE_bar_start1 <=$time;
     write_CE_bar_start1 <=$time;
     if ( ($time - write_address) >= twc)
     begin
         if ( (WE_bar == 1'b0) &&  (CE_bar ==1'b0))
         begin
             if ( ( ($time - write_CE_bar_start) >=tsce) && ( ($time - write_WE_bar_start) >=tpwe) && (($time - write_data) >=tsd) )
                initiate_write3 <= 1'b1;
             else
                initiate_write3 <= 1'b0;
         end
         else
            initiate_write3 <= 1'b0;
     end
     else
        initiate_write3 <= 1'b0;
end
always@(ini_cebar or ini_webar or ini_wecebar) 
begin
     if ( (ini_cebar == 1'b1) || (ini_webar == 1'b1) || (ini_wecebar == 1'b1) ) 
     begin
         if ( ( ($time - write_data1) >= tsd) && ( ($time - write_address1) >= twc) )
            initiate_write1 <= 1'b1;
         else
            initiate_write1 <= 1'b0;
     end
     else
       initiate_write1 <= 1'b0;
end 
always@(initiate_write2)
begin
	 if ( (initiate_write2==1'b1) || (initiate_write3==1'b1)) 
       begin  
		initiate_write2 <=1'b0;
      	initiate_write3 <=1'b0;
	 end
end
always @(initiate_write2 )  
begin
       if ( ( ($time - write_WE_bar_start) >=tpwe) && ( ($time - write_CE_bar_start) >=tsce))
       begin		
	 	 if (BLE_bar == 1'b0 && BHE_bar == 1'b0)
		 begin	          
       		  mem_array0[Address2] <= temp_array0[Address2];
			  mem_array1[Address2] <= temp_array1[Address2];
		 end
	end
end
always@(posedge(initiate_byte_write) or posedge(initiate_byte_write_low))
begin
	if ( ( ($time - write_WE_bar_start) >=tpwe) && ( ($time - write_CE_bar_start) >=tsce))
	begin
		if(BHE_bar == 1'b1 && BLE_bar == 1'b0)
		begin
			mem_array0[Address2] <= temp_array0[Address2];
		end
		if ( BLE_bar == 1'b1 && BHE_bar == 1'b0)
		begin
			mem_array1[Address2] <= temp_array1[Address2];
		end
	end
	initiate_byte_write <= 1'b0;
	initiate_byte_write_low <= 1'b1;
end
always@( initiate_write1 )   
begin
      if ( ( ($time - write_WE_bar_start) >=tpwe) && ( ($time - write_CE_bar_start) >=tsce) && (($time - write_WE_bar_start1) >=tpwe) && (($time - write_CE_bar_start1) >=tsce))     
      begin
		if(BHE_bar == 1'b0 && BLE_bar == 1'b0)
		begin
                  mem_array1[Address2] <= temp_array1[Address2];
			mem_array0[Address2] <= temp_array0[Address2];
	      end
		if(BHE_bar == 1'b0 && BLE_bar == 1'b1)
		begin
			mem_array1[Address2] <= temp_array1[Address2];
		end
		if (BHE_bar == 1'b1 && BLE_bar == 1'b0)
		begin
			mem_array0[Address2] <= temp_array0[Address2];
		end   
      end	
      initiate_write1 <=1'b0;
end    

//*********************Read_cycle******************

always@(Address)
begin 
     read_address <=$time;
     Address3 <=Address;
     Address4 <=Address3;
     if ( ($time - read_address) == trc) 
     begin
         if ( (CE_bar == 1'b0) && (WE_bar == 1'b1) )
	          initiate_read1 <= 1'b1;
         else
      	    initiate_read1 <= 1'b0;
     end  
     else
       initiate_read1 <= 1'b0;
end
always #1
begin 
     if ( ($time - read_address) >= trc)
     begin
         if ( (CE_bar == 1'b0) && (WE_bar == 1'b1) )
         begin
             Address4 <=Address3;
             initiate_read2 <= 1'b1;
         end
         else
             initiate_read2 <= 1'b0;
     end
     else
       initiate_read2 <= 1'b0;
end
initial # `tsim $finish;    
always@(initiate_read1 or initiate_read2)
begin
     if ( (initiate_read1 == 1'b1) || (initiate_read2 == 1'b1) )
     begin
         if ( (CE_bar == 1'b0) && (WE_bar ==1'b1) )
         begin
             if ( ( ($time - read_WE_bar_start) >=trc) && ( ($time -read_CE_bar_start) >=trc) )
             begin
			if(BLE_bar == 1'b0)             
      		   	data_temp[7:0] <= mem_array0[Address4];
			else
		  		data_temp[7:0] <= 8'bzz;
			if(BHE_bar == 1'b0)
      		      data_temp[15:8] <= mem_array1[Address4];
		      else
          	  		data_temp[15:8] <= 8'bzz;
             end
         end
         else
        	   #toha data_temp <=8'bzz;
      end
      initiate_read1 <=1'b0;
      initiate_read2 <=1'b0;
end
always @(Address or WE_bar or CE_bar)
begin
	if (CE_bar == 1'b0 && WE_bar == 1'b1 && OE_bar == 1'b0)
     	begin
      	if (BLE_bar == 1'b0)
        		#taa data_temp[7:0] <= mem_array0[Address];
      	else
        		data_temp[7:0] <= 8'bzz;
      	end
end
always @(Address or WE_bar or CE_bar)
begin
 	if (CE_bar == 1'b0 && WE_bar == 1'b1 && OE_bar == 1'b0)
     	begin
      	if (BHE_bar == 1'b0)
        		#taa data_temp[15:8] <= mem_array1[Address];  
      	else
        		data_temp[15:8] <= 8'bzz;
     	end
	read_address10 <= $time; 
end
always @(OE_bar )
begin
    	if (temptaa >= taa)
   	begin
   		if (CE_bar == 1'b0 && WE_bar == 1'b1 && OE_bar == 1'b0)
     		begin
      		if (BLE_bar == 1'b0)
        			#tdoe data_temp[7:0] <= mem_array0[Address];
      		else
        			data_temp[7:0] <= 8'bzz;
      	end
	else 
		if (CE_bar == 1'b0 && WE_bar == 1'b1 && OE_bar == 1'b0)
     		begin
      		if (BLE_bar == 1'b0)
        			#temptaa data_temp[7:0] <= mem_array0[Address];
      		else
        			data_temp[7:0] <= 8'bzz;
      	end
	end	
end
always @(OE_bar)
begin
	read_address11 <= $time;
	if (temptaa >= taa)
	begin
		if (CE_bar == 1'b0 && WE_bar == 1'b1 && OE_bar == 1'b0)
     		begin
      		if (BHE_bar == 1'b0)
        			#tdoe data_temp[15:8] <= mem_array1[Address];  
      		else
        			data_temp[15:8] <= 8'bzz;
     		end
   	else
		if (CE_bar == 1'b0 && WE_bar == 1'b1 && OE_bar == 1'b0)
     		begin
      		if (BHE_bar == 1'b0)
        			#temptaa data_temp[15:8] <= mem_array1[Address];  
      		else
        			data_temp[15:8] <= 8'bzz;
     		end
	end 
end

endmodule
