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