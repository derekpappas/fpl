// Copyright (c) 2003 by Wipro Technologies
//
// This module is confidential and propritery property of Wiipro Technologies  
// and a possetion or use of this module requires a written permission from Wipro 
// Technologies.
// -----------------------------------------------------------------------------
// File Name : cyd18s`DT_Sv_testcases_tasks.v
// Version : 0.1
// Status : Module is Complete
// -----------------------------------------------------------------------------
// Author : Ashlesha Gokhale
// E-mail : ashlesha.gokhale@wipro.com
// Company : Wipro Technologies
// Creation date : May, 12, 2003
// -----------------------------------------------------------------------------
// Last modified by : Ashlesha Gokhale 
// Last modified on : May 12, 2003
// -----------------------------------------------------------------------------
// Dependencies : model cyd18s`DT_Sv
// Description  : This file contains the test cases as described in test document
//               
// Simulation Notes : NA
// Application Note : NA
// Simulator : verilog xl.
// Terms & concepts : 
// Open issues and future enhancements : None
// References : 
// Revision History :
// Rev  Author    Phone           Date           Changes
// -----------------------------------------------------------------------------
//0.1   Ashlesha  2933700.2074    12.05.2003       New file
//1.0   Ashlesha                  16.05.2003       Added tasks SimultaneousRead, 
//                                                 SimultaneousWrite, SimultaneousReadWrite,
//                                                 BacktoBackReadDiffBytes, BacktoBackWriteDiffBytes 
//-----------------------------------------------------------------------------


task ReadLeftPort;
begin
      a1 = `AD_S'h000f;  
      data_out = `DT_S'h0000f; 
      b1 = `BT_S'h0;
      ReadLeft(a1, b1, data_out); 
      repeat(2)
      @(posedge clkl);
end
endtask//

task ReadRightPort; 
begin
      a1 = `AD_S'h005f;  
      data_out = `DT_S'h0005f; 
      b1 = `BT_S'h0;
      ReadRight(a1, b1, data_out); 
      repeat(2)
      @(posedge clkl);
end
endtask//

task WriteLeftPort;
begin
      a1 = `AD_S'h7ff0;
      d1 = `DT_S'h01111; 
      b1 = `BT_S'h0;
      WriteLeft(a1, b1, d1);
      data_out = d1;
      @(posedge clkl);
      ReadLeft(a1, b1, data_out); 
      repeat(2)
      @(posedge clkl);
end
endtask//

task WriteRightPort;
begin
      a1 = `AD_S'h0ff0;
      d1 = `DT_S'h11111; 
      b1 = `BT_S'h0;
      WriteRight(a1, b1, d1);
      data_out = d1;
      @(posedge clkl);
      ReadRight(a1, b1, data_out); 
      repeat(2)
      @(posedge clkl);
end
endtask//

task LateOERead;
begin
//Left Port        
      test_control_reg[`LATE_OE_L] = 1'b1;
      a1 = `AD_S'h000f;  
      data_out = `DT_S'h0000f; 
      b1 = `BT_S'h0;
      ReadLeft(a1, b1, data_out); 
      repeat(2)
      @(posedge clkl);

      //Right Port        
      test_control_reg[`LATE_OE_R] = 1'b1;
      a1 = `AD_S'h0054;  
      data_out = `DT_S'h00054; 
      b1 = `BT_S'h0;
      ReadRight(a1, b1, data_out); 
      repeat(2)
      @(posedge clkl);
      
     test_control_reg[`LATE_OE_L] = 1'b0;
     test_control_reg[`LATE_OE_R] = 1'b0;
end
endtask//      




task BytesEnabled2;
begin
    a1 =  `AD_S'h1111;
    a2 =  `AD_S'h2222;
    a3 =  `AD_S'h3333;                                  
    d1 =  `DT_S'h11111;                                  
    d2 =  `DT_S'h22222;
    d3 =  `DT_S'h33333;
    b1 = `BT_S'h0;
      @(posedge clkl);
    WriteLeft(a1, b1, d1);    
      @(posedge clkl);
    WriteLeft(a2, b1, d2);
      @(posedge clkl);
    WriteLeft(a3, b1, d3);
      @(posedge clkl); 
    b1 = `BT_S'b01;
    b2 = `BT_S'b10;
    b3 = `BT_S'b00;
    @(posedge clkl);
    get_result(d1,`DT_S'bz , b1, data_out);
    ReadLeft(a1, b1, data_out);  
    get_result(d2,`DT_S'bz , b2, data_out);   
    ReadLeft(a2, b2, data_out);  
    get_result(d3,`DT_S'bz , b3, data_out);
    ReadLeft(a3, b3, data_out);  
      repeat(2)            
      @(posedge clkl);     


  //Testing Left Port write Operation
    d1 =  `DT_S'h0000;                                  
    d2 =  `DT_S'h0ffff;
    d3 =  `DT_S'h0000;
      @(posedge clkl);
    WriteLeft(a1, b1, d1);
      @(posedge clkl);
    WriteLeft(a2, b2, d2);
      @(posedge clkl);
    WriteLeft(a3, b3, d3);
      @(posedge clkl); 
    get_result(d1, `DT_S'h11111, b1, data_out);
    b1 = 3'h0;
      @(posedge clkl);
    ReadLeft(a1, b1, data_out);  
    get_result(d2, `DT_S'h22222, b2, data_out);
    ReadLeft(a2, b1, data_out);  
    get_result(d3, `DT_S'h33333, b3, data_out);
    ReadLeft(a3, b1, data_out);  
    repeat(2)            
    @(posedge clkl);                



  //Right Port 
  //Testing 2 byte read

    a1 =  `AD_S'h0fff;
    a2 =  `AD_S'h0aaa;
    a3 =  `AD_S'h0555;                                  
    d1 =  `DT_S'haaaa;                                  
    d2 =  `DT_S'h5555;
    d3 =  `DT_S'hf0f0;
    b1 =  `BT_S'h0;
      @(posedge clkl);
    WriteRight(a1, b1, d1);    
      @(posedge clkl);
    WriteRight(a2, b1, d2);
      @(posedge clkl);
    WriteRight(a3, b1, d3);
      @(posedge clkl);           
    b1 = `BT_S'b01;
    b2 = `BT_S'b10;
    b3 = `BT_S'b00;
    @(posedge clkl);
    get_result(d1,`DT_S'bz , b1, data_out);
    ReadRight(a1, b1, data_out);  
    get_result(d2,`DT_S'bz , b2, data_out);
    ReadRight(a2, b2, data_out);  
    get_result(d3,`DT_S'bz , b3, data_out);
    ReadRight(a3, b3, data_out);  

//Right port write operation
// Testing  4 byte write
    d1 =  `DT_S'h0000;                                  
    d2 =  `DT_S'hffff;
    d3 =  `DT_S'h0f0f;
      @(posedge clkl);
    WriteRight(a1, b1, d1);    
      @(posedge clkl);
    WriteRight(a2, b2, d2);
      @(posedge clkl);
    WriteRight(a3, b3, d3);
      @(posedge clkl);           
    get_result(d1, `DT_S'haaaa, b1, data_out);
    b1 = `BT_S'h0;
    ReadRight(a1, b1, data_out);  
    get_result(d2, `DT_S'h5555, b2, data_out);
    ReadRight(a2, b1, data_out);  
    get_result(d3, `DT_S'hf0f0, b3, data_out);
    ReadRight(a3, b1, data_out); 
      repeat(2)            
      @(posedge clkl);                
end
endtask//

task SingleByteReadWrite;
begin
    a1 = `AD_S'h200;
    d1 = `DT_S'h676;
    b1 = `BT_S'h0;
    for (i= 0; i<= `BT_S; i = i+1) 
       begin    
           WriteLeft(a1,b1,d1);
           a1 = a1+3;
           d1 = d1+5;
       end

    a1 = `AD_S'h200;
    d1 = `DT_S'h676;
    b1 = `BT_S'hf;
    for (i =0; i<= `BT_S; i = i +1)   
      begin
         b1[i] = 0;
         get_result(d1, `DT_S'bz, b1, data_out);
         ReadLeft(a1, b1, data_out);
         a1 = a1+3;
         d1 = d1+5;
      end      

     repeat(5) 
     @(posedge clkl);
      

    a1 = `AD_S'h200;
    d2 = `DT_S'hfe17;   
    b1 = `BT_S'h3;
    for (i= 0; i<= `BT_S; i = i+1) 
       begin    
           b1[i] = 0;     
           WriteRight(a1,b1,d2);
           a1 = a1+3;
           d2 = d2+1;
       end
    a1 = `AD_S'h200;
    d2 = `DT_S'hfe17;   
    b2 = `BT_S'h0;
    b1 = `BT_S'h3;
    for (i =0; i<= `BT_S; i = i +1)   
      begin
         b1[i] = 0;
         get_result(d2, d1, b1, data_out);
         ReadRight(a1, b2, data_out);
         a1 = a1+3;
         d1 = d1+5;
         d2 = d2+1;
      end         
      
end
endtask




task SimultaneousRead;
begin
  a1 = `AD_S'h0035;
  a2 = `AD_S'h0045;
  a3 = `AD_S'h0057;
  b1 = `BT_S'b0;
  d1 = `DT_S'h00035;
  d2 = `DT_S'h00045;
  d3 = `DT_S'h00057;
  
  fork
    ReadRight(a1, b1, d1);  
    ReadLeft(a2, b1, d2);  
  join
  @(posedge clkl);
  fork
    ReadRight(a3, b1, d3);  
    ReadLeft(a3, b1, d3);  
  join


end
endtask//

task SimultaneousWrite;
begin
  a1 = `AD_S'h7cc0;
  d1 = `DT_S'h23412; 
  b1 = `BT_S'h0;
  a2 = `AD_S'h1cc0;
  d2 = `DT_S'h6789a; 
  fork
    WriteLeft(a1, b1, d1);
    WriteRight(a2, b1, d2);
  join
  @(posedge clkl);
  fork
    ReadLeft(a2, b1, d2); 
    ReadRight(a1, b1, d1); 
  join  
  repeat(2)
  @(posedge clkl);
  a3 = `AD_S'h3ccc;
  d3 = `DT_S'hbcdef;
  fork 
    WriteRight(a3, b1, d3);
    WriteLeft(a3, b1, d1);
  join
  fork  
    ReadLeft(a3, b1, `DT_S'bx); 
    ReadRight(a3, b1, `DT_S'bx); 
  join 
   repeat(2)
  @(posedge clkl);
end
endtask//


task SimultaneousReadWrite;
begin

  a1 = `AD_S'h1234;
  d1 = `DT_S'hdefff; 
  b1 = `BT_S'h0;
  a2 = `AD_S'h000c;
  d2 = `DT_S'h0000c; 
  d3 = `DT_S'hdddef;
  a3 = `AD_S'b0;
  fork
    WriteLeft(a1, b1, d1);
    ReadRight(a2, b1, d2);
  join
  @(posedge clkl);
  fork
    ReadLeft(a1, b1, d1); 
    WriteRight(a2, b1, d3); 
  join  
  repeat(2)
  @(posedge clkl);
  fork 
    ReadLeft(a2, b1, d3);
    ReadRight(a2, b1, d3);
  join
     test_control_reg[`LATE_OE_L] = 1'b1;
     test_control_reg[`LATE_OE_R] = 1'b1;    
  fork
    WriteRight(a3, b1, d3);
    ReadLeft(a3, b1, `DT_S'bx);
  join

     test_control_reg[`LATE_OE_L] = 1'b1;
     test_control_reg[`LATE_OE_R] = 1'b1;    
    ReadRight(a3, b1, d3);   
  
   repeat(2)
  @(posedge clkl);
end
endtask//

task SimultaneousReadWriteDiffBytes;
begin
  a1 =  `AD_S'h3ff0;   
  d1 =  `DT_S'haaaa;                                  
  a2 =  `AD_S'h3aaa;
  d2 =  `DT_S'h5555;
  @(posedge clkl);
  fork
    WriteLeft(a1, b1, d1);    
    WriteRight(a2, b1, d2);
  join
    b1 = `BT_S'b01;
    b2 = `BT_S'b10;
    get_result(d1, `DT_S'hz, b1, d1); 
    get_result(d2, `DT_S'hz, b2, d2); 

 fork
    
    ReadLeft(a2, b2, d2);    
    ReadRight(a1, b1, d1);
  join
    d1 =  `DT_S'h00000;                                  
    d2 =  `DT_S'hffff;
      @(posedge clkl);
  fork    
    WriteLeft(a1, b1, d1);    
    WriteRight(a2, b2, d2);
   join
    get_result(d1, `DT_S'haaaa, b1, d1); 
    get_result(d2, `DT_S'h5555, b2, d2); 

    b1 = `BT_S'b0;
   fork
    ReadLeft(a2, b1, d2);    
    ReadRight(a1, b1, d1);
   join
  repeat(2) 
  @(posedge clkl);
end
endtask//


task BackToBackRead;
begin
test_control_reg[`BACK_TO_BACK_L] = 1'b1;
 address = 0;
 data_out = 0;
  for (i = 0; i <= 4 ; i = i+1) 
  begin
   address = address +1;
   data_out = data_out +1 ;
   ReadLeft(address, b1, data_out); 
  end
  repeat(3)
  @(posedge clkl);
 test_control_reg[`BACK_TO_BACK_L] = 1'b0;
   ReadLeft(`AD_S'h30, b1, `DT_S'h30); 

 test_control_reg[`BACK_TO_BACK_R] = 1'b1;

  for (i = 0; i <= 4 ; i = i+1) 
  begin
   address = address +5;
   data_out = data_out +5 ;
   ReadRight(address, b1, data_out); 
  end
  repeat(3)
  @(posedge clkl);
  test_control_reg[`BACK_TO_BACK_R] = 1'b0;
  ReadRight(`AD_S'h60, b1, `DT_S'h60); 

end 
endtask//



task BackToBackWrite;
begin
    address = 80;
    data_out    = `DT_S'h900;  
//  test_control_reg[`BACK_TO_BACK_L] = 1'b1;

    for (i = 0; i <= 4 ; i = i+1) begin
        address = address +5;
        data_out = data_out +5 ;
        WriteLeft(address, b1, data_out); 
    end

    test_control_reg[`BACK_TO_BACK_L] = 1'b0;
    address = 80;
    data_out    = `DT_S'h900;  
    @(posedge clkl);
    for (i = 0; i <= 4 ; i = i+1) begin
        address = address +5;
        data_out = data_out +5 ;
        ReadLeft(address, b1, data_out); 
    end
    repeat(3)
    @(posedge clkl);
    address = `AD_S'h123;
    data_out    = `DT_S'h781;  
    test_control_reg[`BACK_TO_BACK_R] = 1'b1;

    for (i = 0; i <= 4 ; i = i+1) begin
        address = address +5;
        data_out = data_out +5 ;
        WriteRight(address, b1, data_out); 
    end
    @(posedge clkl);
    address = `AD_S'h123;
    data_out    = `DT_S'h781;  
    for (i = 0; i <= 4 ; i = i+1) begin
        address = address +5;
        data_out = data_out +5 ;
        ReadRight(address, b1, data_out); 
    end
    repeat(3)
    @(posedge clkl);
    test_control_reg[`BACK_TO_BACK_R] = 1'b0;
    ReadRight(`AD_S'h30, b1, `DT_S'h30); 
end
endtask//

task ReadToWriteToRead;
begin
     test_control_reg[`BACK_TO_BACK_R] = 1'b1;

     test_control_reg[`BACK_TO_BACK_L] = 1'b1;

      address = `AD_S'h008f;
      d1 = `DT_S'h337e;
      data_out = `DT_S'h0008f;  

      ReadLeft(address, b1, data_out); 
      data_out = d1;
      b1 = `BT_S'b0;
      @(posedge clkl);
      //WriteLeft(address, b1, d1);
      @(posedge clkl);
      @(posedge clkl);
      WriteLeft(address, b1, d1);
      @(posedge clkl);
      ReadLeft(address, b1, data_out); 

      address = `AD_S'h007f;
      d1 = `DT_S'h9663;
      data_out = `DT_S'h0007f;  

      ReadRight(address, b1, data_out); 
      data_out = d1;
      b1 = `BT_S'b0;
      @(posedge clkl);
      WriteRight(address, b1, d1);
      //WriteRight(address, b1, d1);
      @(posedge clkr);
      ReadRight(address, b1, data_out); 

     test_control_reg[`BACK_TO_BACK_R] = 1'b0;
     test_control_reg[`BACK_TO_BACK_L] = 1'b0;
      ReadRight(`AD_S'h30, b1, `DT_S'h30); 
      ReadRight(`AD_S'h60, b1, `DT_S'h60); 
end
endtask//

task BackToBackReadDiffBytes;
begin
  test_control_reg[`BACK_TO_BACK_L] = 1'b1;
  a1= `AD_S'h500;
  d1= `DT_S'h33445;
  b1= `BT_S'h0;
  for (i= 0; i<= `BT_S; i = i+1) 
     begin    
       @(posedge clkl);
       WriteLeft(a1,b1,d1);
       a1 = a1+3;
       d1 = d1+5;
     end
  a1= `AD_S'h500;
  d1= `DT_S'h33445;
  b1= `BT_S'h0;
  for (i =0; i<= `BT_S; i = i +1)   
      begin
         b1 = b1 + 2 ;
         get_result(d1, `DT_S'bz, b1, data_out);
           @(posedge clkl);
         ReadLeft(a1, b1, data_out);
         a1 = a1+3;
         d1 = d1+5;
      end      
      repeat(5)
      @(posedge clkl);
  test_control_reg[`BACK_TO_BACK_L] = 1'b0;
  ReadLeft(`AD_S'h30, `BT_S'b0, `DT_S'h030);
end
endtask//

task BackToBackWriteDiffBytes;
begin
  test_control_reg[`BACK_TO_BACK_R] = 1'b1;
    a1 = `AD_S'h700;
    d1 = `DT_S'hfff;
    b1 = `BT_S'h0;
    for (i= 0; i<= `BT_S; i = i+1) 
         begin   
           WriteRight(a1,b1,d1);
           a1 = a1+3;
           
       end
    a1 = `AD_S'h700;
    d2 = `DT_S'h8888;   
    b1 = `BT_S'hf;
    for (i= 0; i<= `BT_S; i = i+1) 
         begin 
           b1= b1 - 3;
           WriteRight(a1,b1,d2);
           a1 = a1+3;
           d2 = d2+7;
       end
    a1 = `AD_S'h700;
    d2 = `DT_S'h8888;   
    b2 = `BT_S'h0;
    b1 = `BT_S'hf;
    for (i =0; i<= `BT_S; i = i +1)   
      begin
         b1 = b1 - 3;
         get_result(d2, d1, b1, data_out);
         ReadRight(a1, b2, data_out);
         a1 = a1+3;
         d2 = d2+7;
      end         
  test_control_reg[`BACK_TO_BACK_R] = 1'b0;
  ReadRight(`AD_S'h40, 8'b0, `DT_S'h040);
  b1 = 0;
  b2 = 0;
end
endtask


task SimultaneousBackToBackRead;
fork
    begin
        test_control_reg[`BACK_TO_BACK_L] = 1'b1;
        address = 0;
        data_out = 0;
        for (i = 0; i <= `BT_S ; i = i+1)   begin
            address = address +1;
            data_out = data_out +1 ;
            ReadLeft(address, b1, data_out); 
        end
        repeat(3)
        @(posedge clkl);
        test_control_reg[`BACK_TO_BACK_L] = 1'b0;
        ReadLeft(`AD_S'h30, b1, `DT_S'h30); 
    end
    begin
        test_control_reg[`BACK_TO_BACK_R] = 1'b1;
        for (i = 0; i <= `BT_S ; i = i+1) begin
            address = address +5;
            data_out = data_out +5 ;
            ReadRight(address, b1, data_out); 
       end
       repeat(3)
       @(posedge clkl);
       test_control_reg[`BACK_TO_BACK_R] = 1'b0;
       ReadRight(`AD_S'h60, b1, `DT_S'h60); 
    end
join 
endtask//

task SimultaneousBackToBackWrite;
reg[`AD_M:0] address_left;
reg[`AD_M:0] address_right;     
reg[`DT_M:0] data_out1; 
fork
    begin
       
        address_left = 15;
        data_out    = `DT_S'h900;  
        for (i = 0; i <= `BT_S ; i = i+1) 
        begin

            address_left = address_left +5;
            data_out = data_out +5 ;
            WriteLeft(address_left, b1, data_out); 
        end
    
        test_control_reg[`BACK_TO_BACK_L] = 1'b0;
        address_left = 15;
        data_out    = `DT_S'h900;  
        @(posedge clkl);
        for (i = 0; i <= `BT_S ; i = i+1)begin
            address_left = address_left +5;
            data_out = data_out +5 ;
            ReadLeft(address_left, b1, data_out); 
        end
    repeat(3)
    @(posedge clkl);

    end
    begin
        address_right = `AD_S'h123;
        data_out1    = `DT_S'h781;  
        test_control_reg[`BACK_TO_BACK_R] = 1'b1;
        
        for (i = 0; i <= `BT_S ; i = i+1) begin
    
            address_right = address_right +5;
            data_out1 = data_out1 +5 ;
            WriteRight(address_right, b1, data_out1); 
        end
        @(posedge clkl);
        address_right = `AD_S'h123;
        data_out1    = `DT_S'h781;  
        for (i = 0; i <= `BT_S ; i = i+1) begin
            address_right = address_right +5;
            data_out1 = data_out1 +5 ;
            ReadRight(address_right, b1, data_out1); 
        end
        repeat(3)
        @(posedge clkl);
        test_control_reg[`BACK_TO_BACK_R] = 1'b0;
        ReadRight(`AD_S'h30, b1, `DT_S'h30); 

    end
join
endtask//



task SimultaneousReadToWriteToRead;
begin
  fork
    begin
     test_control_reg[`BACK_TO_BACK_L] = 1'b1;
      address = `AD_S'h0088;
      d1 = `DT_S'hc37e;
      data_out = `DT_S'h00088;  

      ReadLeft(address, b1, data_out); 
      data_out = d1;
      b1 = `BT_S'b0;
      @(posedge clkl);
      WriteLeft(address, b1, d1);
      WriteLeft(address, b1, d1);
      ReadLeft(address, b1, data_out); 
    end
    begin
     test_control_reg[`BACK_TO_BACK_R] = 1'b1;
      a2 = `AD_S'h0077;
      d2 = `DT_S'h3ce7;
      d3 = `DT_S'h00077;  
      ReadRight(a2, b1, d3); 
      d3 = d2;
      b1 = `BT_S'b0;
      @(posedge clkl);
      WriteRight(a2, b1, d2);
      WriteRight(a2, b1, d2);
      ReadRight(a2,  b1, d3); 
    end
 join
     test_control_reg[`BACK_TO_BACK_R] = 1'b0;
     test_control_reg[`BACK_TO_BACK_L] = 1'b0;
   fork
      ReadRight(`AD_S'h30, b1, `DT_S'h30); 
      ReadLeft (`AD_S'h90, b1, `DT_S'h90); 

   join   
   repeat(2)
    @(posedge clkl);
end
endtask//


  

task RdWrSetupViolation;
begin
    test_control_reg[`SETUP_VIOLATION_RD_L]= 1'b1;
    a1= `AD_S'h300;
    b1 = 00;
    d1 = `DT_S'h3445;
    WriteLeft(a1, b1,d1);

    ReadLeft(a1,b1,`DT_S'hx);
    repeat(2)
    @(posedge clkl);

    test_control_reg[`SETUP_VIOLATION_RD_L]= 1'b0;
    test_control_reg[`SETUP_VIOLATION_RD_R]= 1'b1;

    a1= `AD_S'h301;
    b1 = 00;
    d1 = `DT_S'h3440;

    WriteRight(a1, b1,d1);
    ReadRight(a1,b1,`DT_S'hx);
    repeat(2)
    @(posedge clkl);
    test_control_reg[`SETUP_VIOLATION_RD_R]= 1'b0;

end
endtask//



task ByteEnSetupViolation;
begin


    a1 = `AD_S'h200;
    d1 = `DT_S'h676;
    b1 = `BT_S'h0;
    WriteLeft(a1,b1,d1);
    b1 = `BT_S'hf;
    WriteLeft(a1,b1,d1);
    test_control_reg[`SETUP_VIOLATION_BE_L]= 1'b1;
    b1 = `BT_S'h0;
    WriteLeft(a1,b1,d1);
    get_result(`DT_S'hx, `DT_S'bz, b1, data_out);
    test_control_reg[`SETUP_VIOLATION_BE_L]= 1'b0;
    ReadLeft(a1, b1, data_out);

    a1 = `AD_S'h100;
    d1 = `DT_S'h767;
    b1 = `BT_S'h0;
    WriteRight(a1,b1,d1);
    b1 = `BT_S'hf;
    WriteRight(a1,b1,d1);
    test_control_reg[`SETUP_VIOLATION_BE_R]= 1'b1;
    b1 = `BT_S'h0;

    WriteRight(a1,b1,d1);
    get_result(`DT_S'hx, `DT_S'bz, b1, data_out);
    ReadRight(a1, b1, data_out);
    test_control_reg[`SETUP_VIOLATION_BE_R]= 1'b0;
     repeat(5) 
    @(posedge clkl);



end
endtask//


task AddressSetupViolation;
begin
    test_control_reg[`SETUP_VIOLATION_ADDR_L]= 1'b1;
    a1= `AD_S'h300;
    b1 = 00;
    d1 = `DT_S'h3445;
    WriteLeft(a1, b1,d1);
    a1= `AD_S'h302;
    d1 = `DT_S'h3446;
    @(posedge clkl);
    WriteLeft(a1, b1,d1);
    ReadLeft(a1,b1,`DT_S'hx);
//    repeat(2)
    @(posedge clkl);

 test_control_reg[`SETUP_VIOLATION_ADDR_L]= 1'b0;
 test_control_reg[`SETUP_VIOLATION_ADDR_R]= 1'b1;

    a1= `AD_S'h401;
    b1 = 00;
    d1 = `DT_S'h3440;

    WriteRight(a1, b1,d1);

//     @(posedge clkl);
    a1= `AD_S'h404;
    d1 = `DT_S'h3446;
    @(posedge clkl);
    WriteRight(a1, b1,d1);
    ReadRight(a1,b1,`DT_S'hx);
//    repeat(2)
    @(posedge clkl);
test_control_reg[`SETUP_VIOLATION_ADDR_R]= 1'b0;

end
endtask//


task DataSetupViolation;
begin
    test_control_reg[`SETUP_VIOLATION_DATA_L]= 1'b1;
    a1= `AD_S'h305;
    b1 = 00;
    d1 = `DT_S'h4488;

    WriteLeft(a1, b1,d1);

    
    ReadLeft(a1,b1,`DT_S'hx);
    repeat(2)
    @(posedge clkl);

 test_control_reg[`SETUP_VIOLATION_DATA_L]= 1'b0;
 test_control_reg[`SETUP_VIOLATION_DATA_R]= 1'b1;

    a1= `AD_S'h107;
    b1 = 00;
    d1 = `DT_S'h4477;

    WriteRight(a1, b1,d1);

    
    ReadRight(a1,b1,`DT_S'hx);
    repeat(2)
    @(posedge clkl);
test_control_reg[`SETUP_VIOLATION_DATA_R]= 1'b0;

end
endtask//


  

task RdWrHoldViolation;
begin
    test_control_reg[`HOLD_VIOLATION_RD_L]= 1'b1;
    a1= `AD_S'h300;
    b1 = 00;
    d1 = `DT_S'h4455;

    WriteLeft(a1, b1,d1);
//  @(posedge clkl);
    
    ReadLeft(a1,b1,`DT_S'hx);
    repeat(2)
    @(posedge clkl);

    test_control_reg[`HOLD_VIOLATION_RD_L]= 1'b0;
    test_control_reg[`HOLD_VIOLATION_RD_R]= 1'b1;

    a1= `AD_S'h301;
    b1 = 00;
    d1 = `DT_S'h3400;

    WriteRight(a1, b1,d1);
//    @(posedge clkl);
    
    ReadRight(a1,b1, `DT_S'hx);
    repeat(2)
    @(posedge clkl);
test_control_reg[`HOLD_VIOLATION_RD_R]= 1'b0;

end
endtask//



task ByteEnHoldViolation;
begin

    a1 = `AD_S'h200;
    d1 = `DT_S'h676;
    b1 = `BT_S'h0;
    WriteLeft(a1,b1,d1);
    b1 = `BT_S'hf; 
    test_control_reg[`HOLD_VIOLATION_BE_L]= 1'b1;
    WriteLeft(a1,b1,d1);

    b1 = `BT_S'h0; 
//  WriteLeft(a1,b1,d1);
    get_result(`DT_S'hx, `DT_S'bz, b1, data_out);
    ReadLeft(a1, b1, data_out);
    test_control_reg[`HOLD_VIOLATION_BE_L]= 1'b0;

    a1 = `AD_S'h100;
    d1 = `DT_S'h767;
    b1 = `BT_S'h0;
    WriteRight(a1,b1,d1);
    b1 = `BT_S'hf;
    WriteRight(a1,b1,d1);
    test_control_reg[`HOLD_VIOLATION_BE_R]= 1'b1;
    b1 = `BT_S'h0;
//    WriteRight(a1,b1,d1);
    get_result(`DT_S'hx, `DT_S'bz, b1, data_out);

    ReadRight(a1, b1, data_out);
    test_control_reg[`HOLD_VIOLATION_BE_R]= 1'b0;

     repeat(5) 
     @(posedge clkl);


end
endtask//


task AddressHoldViolation;
begin
    
    a1= `AD_S'h300;
    b1 = 00;
    d1 = `DT_S'h4455;
    a2 = `AD_S'h301;    
    d2 = `DT_S'h5566;

    @(posedge clkl);
    WriteLeft(a1, b1,d1);

    test_control_reg[`HOLD_VIOLATION_ADDR_L]= 1'b1;
    @(posedge clkl);
    WriteLeft(a2, b1,d2);

    test_control_reg[`HOLD_VIOLATION_ADDR_L]= 1'b0;
    ReadLeft(a1,b1, `DT_S'hx);
    repeat(2)
    @(posedge clkl);

    test_control_reg[`HOLD_VIOLATION_ADDR_L]= 1'b0;


    a1= `AD_S'h302;
    b1 = 00;
    d1 = `DT_S'h4400;
    
    a2= `AD_S'h303;
    b1 = 00;
    d2 = `DT_S'h5500;


    WriteRight(a1, b1,d1);
    test_control_reg[`HOLD_VIOLATION_ADDR_R]= 1'b1;
    WriteRight(a2, b1,d2);
    ReadRight(a1,b1, `DT_S'hx);
    repeat(2)
    @(posedge clkl);
    test_control_reg[`HOLD_VIOLATION_ADDR_R]= 1'b0;

end
endtask//


task DataHoldViolation;
begin
    test_control_reg[`HOLD_VIOLATION_DATA_L]= 1'b1;
    a1= `AD_S'h305;
    b1 = 00;
    d1 = `DT_S'h4488;
    a2= `AD_S'h306;
    b2 = 00;
    d2 = `DT_S'h4499;
    WriteLeft(a1, b1,d1);
    WriteLeft(a2, b2,d2);
    ReadLeft(a1,b1,`DT_S'hx);
    repeat(2)
    @(posedge clkl);
    test_control_reg[`HOLD_VIOLATION_DATA_L]= 1'b0;

    test_control_reg[`HOLD_VIOLATION_DATA_R]= 1'b1;

    a1= `AD_S'h307;
    b1 = 00;
    d1 = `DT_S'h4477;
    a2= `AD_S'h308;
    b2 = 00;
    d2 = `DT_S'h44aa;

    WriteRight(a1, b1,d1);

    WriteRight(a2, b2,d2);
    
    ReadRight(a1,b1, `DT_S'hx);
    repeat(2)
    @(posedge clkl);
   test_control_reg[`HOLD_VIOLATION_DATA_R]= 1'b0;

end
endtask//



task LeftPortMailboxInterrupt;
begin
    a1 = `LAST_ADR-1;
    d1 = `DT_S'h1010;
    b1 = `BT_S'h0;
    WriteRight(a1, b1, d1);
    ReadRight(a1, b1, d1);
    repeat(5)
    @(posedge clkl);
    ReadLeft(a1, b1, d1);
    repeat(5)
    @(posedge clkl);
    end
    endtask//
    
    
task RightPortMailboxInterrupt;
begin
    a1 = `LAST_ADR;        
    d1 = `DT_S'h10101;
    b1 = `BT_S'h0;
    WriteLeft(a1, b1, d1);
    ReadLeft(a1, b1, d1);
    repeat(5)
    @(posedge clkl);
    ReadRight(a1, b1, d1);
    repeat(5)
    @(posedge clkl);
end
endtask//


task MasterResetIntr;
begin
    a1 = `LAST_ADR;
    d1 = `DT_S'h10101;
    b1 = `BT_S'h0;
    WriteRight(a1, b1, d1);
    ReadRight(a1, b1, d1);
    repeat(5)
    @(posedge clkl);
    a1 = `AD_S'h0fff;
    d1 = `DT_S'h10101;
    b1 = `BT_S'h0;
    WriteLeft(a1, b1, d1);
    ReadLeft(a1, b1, d1);
    repeat(5)
    @(posedge clkl);
    reset_over_test = 1'b0;
    MasterReset;
end
endtask

task  MaskReadBack;
begin
    a1 = `AD_S'h0f;
    d1 = `DT_S'h0f;
    b1 = `BT_S'h0;
   //   #(1);
   WriteLeft(a1, b1,d1);
   repeat(2)
      @(posedge clkr);
   //    @(posedge clkr);
   //   #(01)
    readback_mask_l(`LAST_ADR);
    ReadLeft(a1, b1, d1);      
    a1 = `AD_S'h1f;
    d1 = `DT_S'h1f;
    b1 = `BT_S'h0;
    WriteRight(a1, b1,d1);
    @(posedge clkr);
    readback_mask_r(`LAST_ADR);
    ReadRight(a1, b1, d1);
    repeat(1)    
    @(posedge clkr);
end
endtask

task MaskLoad;
begin
    a1 = `AD_S'h2f;
    d1 = `DT_S'h2f;
    b1 = `BT_S'h0;
    @(posedge clkl);
    WriteLeft(a1, b1,d1);
    @(posedge clkl);
    load_counter_mask_l(`AD_S'h0f);
    ReadLeft(a1, b1, d1);
     @(posedge clkl);
    readback_mask_l(`AD_S'h0f);
    ReadLeft(a1, b1, d1);
    repeat(2)
    @(posedge clkr);
    a1 = `AD_S'h3f;
    d1 = `DT_S'h1f;
    b1 = `BT_S'h0;
    WriteRight(a1, b1,d1);
    load_counter_mask_r(`AD_S'h07);
    ReadRight(a1, b1, d1);
    @(posedge clkr);
    readback_mask_r(`AD_S'h07);
    ReadRight(a1, b1, d1);
    repeat(2)    
    @(posedge clkr);
end
endtask

task MaskReset;
begin
    a1 = `AD_S'h2f;
    d1 = `DT_S'h2f;
    b1 = `BT_S'h0;
    @(posedge clkl);
    WriteLeft(a1, b1,d1);
    @(posedge clkl);
    load_counter_mask_l(`AD_S'h0f);
    ReadLeft(a1, b1, d1);
     @(posedge clkl);
    readback_mask_l(`AD_S'h0f);
    ReadLeft(a1, b1, d1);
    repeat(2)
    @(posedge clkl);
    reset_counter_mask_l;
     @(posedge clkl);
    readback_mask_l(`LAST_ADR);
    repeat(2)
    @(posedge clkr);
    a1 = `AD_S'h3f;
    d1 = `DT_S'h1f;
    b1 = `BT_S'h0;
    @(posedge clkr);
    WriteRight(a1, b1,d1);
    load_counter_mask_r(`AD_S'h07);
    ReadRight(a1, b1, d1);
     @(posedge clkr);
    readback_mask_r(`AD_S'h07);
    ReadRight(a1, b1, d1);
    repeat(2)    
    @(posedge clkr);
    reset_counter_mask_r;
     @(posedge clkr);
    readback_mask_r(`LAST_ADR);
    
end
endtask

task CounterReadBack;
begin
    a1 = `AD_S'h123;
    d1 = `DT_S'haaa;
    b1 = `BT_S'h0;
    WriteLeft(a1, b1,d1);    
    a2 = `AD_S'habc;
    d2 = `DT_S'h555;
    b1 = `BT_S'h0;
    @(posedge clkl);
    WriteLeft(a2, b1,d2);
    @(posedge clkl);
    readback_counter_l(a2);
    ReadLeft(a1, b1, d1);
    readback_counter_l(a1);
    repeat(2)
        @(posedge clkl);
    ReadLeft(a2, b1, d2);
    @(posedge clkr);
    a1 = `AD_S'h456;
    d1 = `DT_S'hbbb;
    b1 = `BT_S'h0;
    
    @(posedge clkr);
    WriteRight(a1, b1,d1);    
    @(posedge clkr);
    a2 = `AD_S'hdef;
    d2 = `DT_S'h666;
    b1 = `BT_S'h0;
    @(posedge clkr);
    WriteRight(a2, b1,d2);
    @(posedge clkr);
    readback_counter_r(a2);
    repeat(2)
    @(posedge clkr);
    ReadRight(a1, b1, d1);
    repeat(2)
    @(posedge clkr);    
    readback_counter_r(a1);
    repeat(2)
    @(posedge clkr);    
    ReadRight(a2, b1, d2);
    repeat(2)
    @(posedge clkr);    
end
endtask

task CounterReset;
begin
    a1 = `AD_S'h123;
    d1 = `DT_S'haaa;
    b1 = `BT_S'h0;
    @(posedge clkl);
    WriteLeft(a1, b1,d1);    
    @(posedge clkl);
    readback_counter_l(a1);
    repeat(2)
    @(posedge clkl);
    reset_counter_l;
    @(posedge clkl);
    readback_counter_l(`AD_S'h0);
    repeat(2)
    @(posedge clkl);
    a1 = `AD_S'h456;
    d1 = `DT_S'hbbb;
    b1 = `BT_S'h0;
    @(posedge clkr);    
    WriteRight(a1, b1,d1);    
    @(posedge clkr);    
    readback_counter_r(a1);
    @(posedge clkr);    
    reset_counter_r;
    @(posedge clkr);    
    readback_counter_r(`AD_S'h0);
    repeat(2)
    @(posedge clkr);    
end
endtask


task BurstWrite;
reg[`DT_M:0] data_offset;
reg[`AD_M:0] burst_count;
integer i;
begin
     a1 = `AD_S'h123;
     d1 = `DT_S'h00;
     data_offset = 5;
     b1 = `BT_S'h0;
     burst_count = 10;
     @(posedge clkl);
     WriteLeft(a1, b1,d1);
     @(posedge clkl);
     WriteLeftBurst(a1, b1,  burst_count, d1+data_offset, data_offset);
     for (i =0;  i <= burst_count; i = i+1)begin
         ReadLeft(a1+i, b1, d1);
         d1 = d1 + data_offset;
     end     
     ReadLeft(a1, b1, `DT_S'h0);
     a1 = `AD_S'h100;
     d1 = `DT_S'h100;
     data_offset = 4;
     b1 = `BT_S'h0;
     burst_count = 7;
     @(posedge clkr);
     WriteRight(a1, b1,d1);
     @(posedge clkr);
     WriteRightBurst(a1, b1,  burst_count, d1+data_offset, data_offset);
     for (i =0;  i <= burst_count; i = i+1)begin
         ReadRight(a1+i, b1, d1);
         d1 = d1 + data_offset;
     end     
     ReadRight(a1, b1, `DT_S'h100);

end
endtask

task BurstRead;
reg[`DT_M:0] data_offset;
reg[`AD_M:0] burst_count;
integer i;
begin
     a1 = `AD_S'h123;
     d1 = `DT_S'h00;
     data_offset = 5;
     b1 = `BT_S'h0;
     burst_count = 10;
     @(posedge clkl);
     WriteLeft(a1, b1,d1);
     @(posedge clkl);
     WriteLeftBurst(a1, b1,  burst_count+1, d1+data_offset, data_offset);
     ReadLeft(a1, b1, d1);
     ReadLeftBurst(a1, b1, 10, data_offset, d1, `AD_S'hff);
     ReadLeft(a1, b1, d1);

     $display("Right port burst read");
     a1 = `AD_S'h200;
     d1 = `DT_S'h200;
     data_offset = 4;
     b1 = `BT_S'h0;
     burst_count = 10;
     @(posedge clkr);
     WriteRight(a1, b1,d1);
     @(posedge clkr);
     WriteRightBurst(a1, b1,  burst_count+1, d1+data_offset, data_offset);
     ReadRight(a1, b1, d1);
     ReadRightBurst(a1, b1, burst_count, data_offset, d1, `AD_S'hff);
     ReadRight(a1, b1, d1);


end
endtask


task RetransmitData;
reg[`DT_M:0] data_offset;
reg[`AD_M:0] burst_count;
integer i;
begin
    a1 = `AD_S'h300;
    b1 = `BT_S'h0;
    d1 = `AD_S'h300;    
    data_offset = 2;
    load_counter_mask_l(`AD_S'h03);
    WriteLeft(a1, b1, d1);
    WriteLeftBurst(a1, b1, 2, d1+data_offset, data_offset);
    ReadLeft(a1, b1, d1);
    ReadLeftBurst(a1, b1, 5, data_offset, d1, `AD_S'h03);
    ReadLeft(a1, b1, d1);


    a1 = `AD_S'h600;
    b1 = `BT_S'h0;
    d1 = `AD_S'h600;    
    data_offset = 4;
    load_counter_mask_r(`AD_S'h03);
    WriteRight(a1, b1, d1);
    WriteRightBurst(a1, b1, 2, d1+data_offset, data_offset);
    ReadRight(a1, b1, d1);
    ReadRightBurst(a1, b1, 6, data_offset, d1, `AD_S'h03);
    ReadRight(a1, b1, d1);
end
endtask





task BankSelect;
reg[`DT_M:0] data_offset;
reg[`AD_M:0] burst_count;
integer i;
begin
     load_counter_mask_l(`AD_S'h00);
     a1 = `AD_S'h123;
     d1 = `DT_S'h00;
     data_offset = 5;
     b1 = `BT_S'h0;
     burst_count = 10;
     WriteLeft(a1, b1,d1);
     @(posedge clkl);
     WriteLeftBurst(a1, b1,  burst_count, d1+data_offset, data_offset);
     ReadLeft(a1, b1, d1);
     ReadLeftBurst(a1, b1, 10, data_offset, d1, `AD_S'hff);
     ReadLeft(a1, b1, d1);

     load_counter_mask_r(`AD_S'h00);
     $display("Right port burst read");
     a1 = `AD_S'h200;
     d1 = `DT_S'h200;
     data_offset = 4;
     b1 = `BT_S'h0;
     burst_count = 10;
     WriteRight(a1, b1,d1);
     @(posedge clkl);
     WriteRightBurst(a1, b1,  burst_count, d1+data_offset, data_offset);
     ReadRight(a1, b1, d1);
     ReadRightBurst(a1, b1, burst_count, data_offset, d1, `AD_S'hff);
     ReadRight(a1, b1, d1);


end
endtask













