module FIFO(data_out, empty, full, data_in, push, pop, clk, reset);
    parameter stack_width=4;
    parameter stack_depth=16;
    parameter stack_width_gap=4;
    
    input [stack_width-1: 0] data_in;
    input push, pop, reset, clk;
    output full, empty;
    output [stack_width-1:0] data_out;
    
    reg [stack_width-1:0] data_out;
    reg [stack_width_gap:0] gap;    //gap between wr pointer and rd pointer
    reg [stack_width-1:0] fifo[0:stack_depth-1];
    reg [stack_width-1:0] wr, rd;
    
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
module tb_sefttest_fifo;
    parameter stack_width=4;
    parameter stack_depth=16;
    parameter stack_width_gap=4;
    
    wire [stack_width-1: 0] data_in;
    reg push, pop, reset, clk;
    wire full, empty;
    wire [stack_width-1:0] data_out, data_cnto, data_exp;
    
    FIFO #(stack_width, stack_depth, stack_width_gap)DUT_FIFO(data_out, empty, full, data_in, push, pop, clk, reset);
    counter #(stack_width) CNT_IN(data_in, push, reset, clk);
    counter #(stack_width) CNT_OUT(data_cnto, pop, reset, clk);
    delay_cell #(stack_width) DELAY(data_cnto, data_exp, reset, clk);
    
    initial begin
        clk=0;
        push=0;
        pop=0;
        reset=1;
        #6;
        reset=0;
        #5;
        reset=1;
        #10;
        push=1;
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
        pop=1;
    end
    
    always #5 clk=~clk;
endmodule











