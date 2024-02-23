//LFSR with XORed output
module LFSR(out, clk, reset_);
    input clk, reset_;
    output [3:0] out;
    
    reg [7:0] lfsr;
    
    assign out= lfsr[7:4] ^ lfsr[3:0];
    
    always@(posedge clk or negedge reset_) begin
        if(!reset_) begin
            lfsr = 8'h01;
        end
        else begin
            lfsr = lfsr<<1;
            lfsr[0]= lfsr[7] ^ lfsr[6] ^ lfsr[5] ^ lfsr[0];
        end
    end
endmodule

//tb for LFSR
module tb_LFSR();
    reg clk, reset_;
    wire [3:0] out;
    
    reg [7:0] state_data_mem [0:50];
    reg [7:0] sd, exp_sd;
    integer addr;
    
    LFSR LFSR(out, clk, reset_);
    
    initial begin
        clk=0;
        $readmemb("expected.sd", state_data_mem);
        addr=0;
        exp_sd = state_data_mem[0];
        reset_=1;
        #3;
        reset_=0;
        #5;
        reset_=1;
    end
    always #5 begin
        clk=~clk;
    end
    always@(posedge clk) begin
        sd = LFSR.lfsr;
        if(sd == exp_sd)begin
            $display("sd %2d matched", addr);
        end
        else begin
            $display("sd %2d mismatched", addr);
        end
        exp_sd = state_data_mem[addr];
        addr=addr+1;
    end
endmodule