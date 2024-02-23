//delay cell
module delay_cell(d, q, r, clk);
    parameter BITS=4;
    input r, clk;
    input [BITS-1:0]d;
    output [BITS-1:0]q;
    
    reg [BITS-1:0]q;
    
    always@(posedge clk or negedge r) begin
        if(!r) begin
            q=0;
        end
        else begin
            q=d;
        end
    end
endmodule