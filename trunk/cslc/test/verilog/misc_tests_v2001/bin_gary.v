//bin-gray
module bin_gray(bin, gray);
    parameter WIDTH=4;
    input [WIDTH-1:0] bin;
    output [WIDTH-1:0] gray;
    
    reg [WIDTH-1:0] gray;
    integer i;
    
    always@(bin) begin
        for(i=0;i<WIDTH;i=i+1) begin
            gray[i]= bin[i] ^ bin[i+1];
        end
        gray[WIDTH-1]=bin[WIDTH-1];
    end
endmodule

module tb_bin_gray();
    parameter WIDTH=6;
    reg [WIDTH-1:0] bin;
    wire [WIDTH-1:0] gray;
    
    bin_gray #(WIDTH)BG(bin, gray);
    
    initial begin
        bin=0;
    end
    always #5 bin=bin+1;
endmodule