module test;

reg [20:0] address;
reg oe,ce1,ce2,we;
reg [7:0] temp_data;

wire[7:0] data =!we ? temp_data[7:0] : 8'bz;

A2Mx8 g(address,data,oe,ce1,ce2,we);

initial
begin
  $dumpfile("dumpfile.dump");
  $dumpvars(0,test);
end

initial
   begin  

   $display($time,"ce1=%b ce2=%b we=%b oe=%b address=%h        data=%h",ce1,ce2,we,oe,address,data);
//Write
    #3 temp_data=8'h0; ce1 = 0; ce2=1; we=0; oe = 1; address= 21'h0;    //3 write start
    #12 address =21'h1; temp_data=8'h1;					//15
    #12 address =21'h0FFFFF; temp_data=8'h2;					//27
    #13 address =21'h3; temp_data=8'h3;					//40
    #15 ce1 = 0; temp_data = 8'hz; 				//55 deselect
    #5 ce1 = 0; we = 1; oe = 0; address =21'h3;				//60 read start
    #15 address =21'h0FFFFF;							//75
    #15 address =21'h1;
//ce=0;we=0;oe=0;temp_data=8'h10; 			//90
    #6  oe = 1'b1;
    #12 address = 21'h0; oe = 1'b0;							//102
    #10 address = 21'h3;
//    #10 $finish;	
//    #10 address =15'h0001;ce=0;we=1;oe=0;
//    #1 we=1;
//    #10 address = 15'h0002;ce=0;we=1;oe=0;
//    #10 address =15'h0003;ce=0;we=1;oe=0;
//    #7  we=0; 
//    #10 address =15'h0006;ce=0;we=0;oe=0;temp_data=8'h20;
//    #4  ce=0;
//    #10 address=15'h0004;ce=0;we=0;oe=0;temp_data=8'h80;
//    #10 address=15'h0005;ce=0;we=1;oe=0;
//    #10 address=15'h0004;ce=0;we=1;oe=0;
//    #10 address=15'h1000;ce=0;we=0;temp_data=8'haf; 
//    #10 address=15'h0156;ce=0;we=0;
//    #4  ce=1;
//    #10 address=15'h0173;ce=0;temp_data=8'h00;
//    #10 address=15'h0156;ce=0;we=1;
//    #10 address=15'hafdd;we=1;
   
   end
endmodule   
