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