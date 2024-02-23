//arch_state
module as(data_in, data_out, arch_state, clk, reset_);
    parameter DATA_WIDTH=4;
    input [DATA_WIDTH-1:0]data_in;
    input clk, reset_;
    output [DATA_WIDTH-1:0]data_out;
    output [3*DATA_WIDTH-1:0] arch_state;
    
    reg [DATA_WIDTH-1:0] data_out;
    reg [DATA_WIDTH-1:0] reg0, reg1, reg2;
    wire [3*DATA_WIDTH-1:0] arch_state;
    
    assign arch_state={reg0, reg1, reg2};
    
    always@(posedge clk or negedge reset_) begin
        if(!reset_) begin
            reg0<=0;
            reg1<=0;
            reg2<=0;
            data_out<=0;
        end
        else begin
            reg0<=data_in;
            reg1<=reg0;
            reg2<=reg1;
            data_out<=reg2;
        end
    end
endmodule

//testbench
module tb_as();
    parameter DATA_WIDTH=4;
    parameter PERIOD=10;
    
    reg [DATA_WIDTH-1:0]data_in;
    reg clk, reset_;
    wire [DATA_WIDTH-1:0]data_out;
    wire [3*DATA_WIDTH-1:0] arch_state; 
    
    as DUT_as(data_in, data_out, arch_state, clk, reset_);
    
    initial begin
        clk=0;
        reset_=1;
        data_in=0;
        #6;
        reset_=0;
        #5;
        reset_=1;
        #10;
        data_in=2;
        #10;
        data_in=12;
        #10;
        data_in=10;
        #10;
        data_in=15;
    end
    always#(PERIOD/2) begin clk=~clk; end
endmodule
