`define SIG1_DIM0 3
`define SIG1_DIM1 4
`define SIG1_DIM2 2
`define SIG1_DIM3 2

`define SIG2_DIM0 3
`define SIG2_DIM1 4
`define SIG2_DIM2 4

module top();
 wire [(`SIG1_DIM0*`SIG1_DIM1*`SIG1_DIM2*`SIG1_DIM3)-1:0] trans;
prod prod0(.x_out(trans));
cons cons0(.y_in(trans));
endmodule

module prod(x_out);
   output [(`SIG1_DIM0*`SIG1_DIM1*`SIG1_DIM2*`SIG1_DIM3)-1:0] x_out;
   
   wire [(`SIG1_DIM0*`SIG1_DIM1*`SIG1_DIM2)-1:0] x0;
   wire [(`SIG1_DIM0*`SIG1_DIM1*`SIG1_DIM2)-1:0] x1;
    
   wire [(`SIG1_DIM0*`SIG1_DIM1)-1:0] x0_0 ;
   wire [(`SIG1_DIM0*`SIG1_DIM1)-1:0] x0_1 ;
   wire [(`SIG1_DIM0*`SIG1_DIM1)-1:0] x1_0 ;
   wire [(`SIG1_DIM0*`SIG1_DIM1)-1:0] x1_1 ;

   wire [`SIG1_DIM0 - 1 : 0] x000;
   wire [`SIG1_DIM0 - 1 : 0] x001;
   wire [`SIG1_DIM0 - 1 : 0] x002;
   wire [`SIG1_DIM0 - 1 : 0] x003;
   
   wire [`SIG1_DIM0 - 1 : 0] x010;
   wire [`SIG1_DIM0 - 1 : 0] x011;
   wire [`SIG1_DIM0 - 1 : 0] x012;
   wire [`SIG1_DIM0 - 1 : 0] x013;

   wire [`SIG1_DIM0 - 1 : 0] x100;
   wire [`SIG1_DIM0 - 1 : 0] x101;
   wire [`SIG1_DIM0 - 1 : 0] x102;
   wire [`SIG1_DIM0 - 1 : 0] x103;

   wire [`SIG1_DIM0 - 1 : 0] x110;
   wire [`SIG1_DIM0 - 1 : 0] x111;
   wire [`SIG1_DIM0 - 1 : 0] x112;
   wire [`SIG1_DIM0 - 1 : 0] x113;

   assign x0_0 = {x000, x001, x002, x003};
   assign x0_1 = {x010, x011, x012, x013};
   assign x1_0 = {x100, x101, x102, x103};
   assign x1_1 = {x110, x111, x112, x113};   

   assign x0 = {x0_0, x0_1};
   assign x1 = {x1_0, x1_1};
	   
   assign x_out = {x0,x1};        
endmodule

module cons(y_in);
   input [(`SIG2_DIM0*`SIG2_DIM1*`SIG2_DIM2)-1:0] y_in;

   wire [(`SIG2_DIM0*`SIG2_DIM1)-1:0] y0;
   wire [(`SIG2_DIM0*`SIG2_DIM1)-1:0] y1;
   wire [(`SIG2_DIM0*`SIG2_DIM1)-1:0] y2;
   wire [(`SIG2_DIM0*`SIG2_DIM1)-1:0] y3;

   wire [`SIG1_DIM0 - 1 : 0] y000;
   wire [`SIG1_DIM0 - 1 : 0] y001;
   wire [`SIG1_DIM0 - 1 : 0] y002;
   wire [`SIG1_DIM0 - 1 : 0] y003;
   
   wire [`SIG1_DIM0 - 1 : 0] y010;
   wire [`SIG1_DIM0 - 1 : 0] y011;
   wire [`SIG1_DIM0 - 1 : 0] y012;
   wire [`SIG1_DIM0 - 1 : 0] y013;

   wire [`SIG1_DIM0 - 1 : 0] y100;
   wire [`SIG1_DIM0 - 1 : 0] y101;
   wire [`SIG1_DIM0 - 1 : 0] y102;
   wire [`SIG1_DIM0 - 1 : 0] y103;

   wire [`SIG1_DIM0 - 1 : 0] y110;
   wire [`SIG1_DIM0 - 1 : 0] y111;
   wire [`SIG1_DIM0 - 1 : 0] y112;
   wire [`SIG1_DIM0 - 1 : 0] y113;

   assign y0 = {y000, y001, y002, y003};
   assign y1 = {y010, y011, y012, y013};
   assign y2 = {y100, y101, y102, y103};
   assign y3 = {y110, y111, y112, y113};

   assign y_in = {y0, y1, y2, y3};
   
endmodule