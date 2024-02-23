module rn_fifo(data_out, empty, full, data_in, push, pop, clk, reset);
    parameter stack_width=64;
    parameter stack_depth=16;
    parameter stack_ptr_width=4;
    
    
    input [stack_width-1: 0] data_in;
    input push, pop, reset, clk;
    output full, empty;
    output [stack_width-1:0] data_out;
    
    reg [stack_width-1:0] data_out;
    reg [stack_ptr_width:0] gap;    
    reg [stack_width-1:0] fifo[0:stack_depth-1];
    reg [stack_ptr_width-1:0] wr, rd;
    
    assign empty=(gap==0);
    assign full=(gap==stack_depth);
    
    always@(reset, posedge clk)
      begin
          if(reset==0) begin
            data_out=0;
            gap=0;
            wr=0;
            rd=0;
          end
          else
            begin
                if(!full & push & !pop) begin
                    fifo[wr]=data_in;
                    wr=wr+1;
                    gap=gap+1;
                end
                else if(!empty & pop & !push) begin
                    data_out=fifo[rd];
                    rd=rd+1;
                    gap=gap-1;
                end
                else if(!full & pop & push) begin
                    data_out=fifo[rd];
                    fifo[wr]=data_in;
                    rd=rd+1;
                    wr=wr+1;
                end
                else if(empty & pop & push) begin
                    fifo[wr]=data_in;
                    wr=wr+1;
                    gap=gap+1;
                end
                else if(full & pop & push) begin
                    data_out=fifo[rd];
                    rd=rd+1;
                    gap=gap-1;
                end
            end
      end
endmodule

//TestBench
module tb_rn_fifo;
    parameter W=64;
    parameter NW=16;
    parameter stack_ptr_width=4;
    
    wire [W-1:0] data_out;
    wire full, empty;
    reg [W-1:0] data_in;
    reg push, pop, clk, reset;
    reg [stack_ptr_width:0] prg_depth;
    integer match_cnt, unmatch_cnt;
    
    rn_fifo DUT(data_out, empty, full, data_in, push, pop, clk, reset);
        
    always #5 clk=~clk;
    
    initial begin
        match_cnt=0;
        unmatch_cnt=0;
        clk=0;
        push=1;
        pop=0;
        data_in = 64'hffffaaaa;
        reset=0;
        @(posedge clk);
        @(posedge clk);
        reset=1;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        push=0;
        pop=1;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        pop=0;
    end
        
endmodule