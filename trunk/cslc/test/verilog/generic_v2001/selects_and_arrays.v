
module selects_and_arrays;

reg [63:0] word; 
reg [3:0] byte_num; //a value from 0 to 7 
wire [7:0] byteN = word[byte_num*8 +: 8];

parameter address = 5;
//1-dimensional array of 8-bit reg variables 
//(allowed in Verilog-1995 and Verilog-2000) 
reg [7:0] array1 [0:255]; 
wire [7:0] out1 = array1[address]; 

parameter addr1=1 , addr2 = 2, addr3 =3;
//3-dimensional array of 8-bit wire nets 
//(new for Verilog-2000) 
wire [7:0] array3 [0:255][0:255][0:15];
wire [7:0] out3 = array3[addr1][addr2][addr3];


//2-dimensional array of 32-bit reg variables 
reg [31:0] array2 [0:255][0:15]; 
wire [7:0] out2 = array2[100][7][31:24];

signed_test s1 (8'sH08);

endmodule

