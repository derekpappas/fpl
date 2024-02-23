module ff_d(in,out, clk);
    input [5:0] in;
    input clk;
    output [5:0] out;
    reg  [5:0] out;
    always@(posedge clk)begin
        out<=in;
    end
endmodule


module add(a,b,out_add);
    input [4:0] a;
    input [4:0] b;
    output[5:0] out_add;
    wire [5:0] out_add;
    wire [5:0] ab;
    reg clock;
    initial begin
        clock=0;
          end
    assign ab=a+b;
    
    ff_d ff_d(.in(ab), .out(out_add), .clk(clock));
    
    always #5 clock=~clock;
endmodule

module memory(clk, address,oe,we,cs,data, data_o);
    input clk;
    input [7:0] address;
    input oe;
    input we;
    input cs;
    input [5:0] data;
    output [5:0] data_o;
    wire [5:0] data;
    
    reg [5:0] mem[0:255];
    reg [5:0] data_o;
   
  endmodule

module top;
    reg [4:0] a;
    reg [4:0] b;
    wire [5:0]ab;
    wire oe,we,cs;
    wire [7:0] address;
    wire [5:0] data;
    reg [5:0] data_o;
    reg clk;
    
    initial begin
        clk=0;
        a=5'b1110;
        b=5'b1001;
         $monitor("a=%b, b=%b, out_add=%b",a,b,add.out_add);

        end
        add add(.a(a), .b(b));
    memory mem( .clk(clk), .address(address),.oe(oe),.we(we),.cs(cs),.data(data),.data_o(data_o));
     assign ab=add.out_add;   
     
      always @ (posedge clk)
  begin : MEM_WRITE
     if ( cs && we ) begin
         mem[32] <= ab;
     end
  end
  always #5 clk=~clk;
endmodule