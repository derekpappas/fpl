module x(b,c,a);
output a;
integer a = 5;
output b;
output c;
reg c;
//input d;
//reg d;
assign b = a;
endmodule

module ff(clk,enable,data,q);
input clk,enable,data;
output q;
reg q;

always@(posedge clk)
begin
    if(enable)
        q=data; 
end
endmodule

module top();
    
wire data_path,clock,enable,data_in,data_out;
ff ff1(.clk(clock),.enable(enable),.data(data_in),.q(data_path));
ff ff2(.clk(clock),.enable(enable),.data(data_path),.q(data_out));

    
endmodule
