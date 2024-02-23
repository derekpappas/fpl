module fifo_name(data_out, empty, full, data_in, prg_depth, push, pop, clk, reset);
    parameter stack_width=4;
    parameter stack_depth=16;
    parameter stack_ptr_width=4;
    
    
    input [stack_width-1: 0] data_in;
    input push, pop, reset, clk;
    input [stack_ptr_width:0] prg_depth;
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
                if(rd==(prg_depth-1)) begin 
                    rd=0;
                    $display("rd= %d - 1", prg_depth);
                end
                if(wr==(prg_depth-1)) begin
                    wr=0;
                    $display("wr= %d - 1", prg_depth);
                end
            end
      end
endmodule

//TestBench
module tb_fifo_name;
    parameter W=4;
    parameter NW=16;
    parameter stack_ptr_width=4;
    
    wire [W-1:0] d_out;
    wire full, empty;
    wire [W-1:0] d_in;
    reg push, pop, clk, reset;
    reg [stack_ptr_width:0] prg_depth;
    integer match_cnt, unmatch_cnt;
    
    fifo_name DUT(d_out, empty, full, d_in, prg_depth, push, pop, clk, reset);
    counter4 CNT(d_in, reset, clk);
    
    always #5 clk=~clk;
    
    initial begin
        match_cnt=0;
        unmatch_cnt=0;
        prg_depth=5'b01010;
        clk=0;
        push=1;
        pop=0;
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
    
    always@(posedge clk)
    begin
     if($time>165 && $time<350)begin
        if(d_in==d_out) begin
           match_cnt=match_cnt+1;
           //$display("State %2d match.", d_in);
        end else begin
           unmatch_cnt=unmatch_cnt+1;
           //$display("State %2d UNMATCH!.", d_in);
        end
        if(d_in==4'hF)
           $display("Test finished with %2d matches and %2d unmatches.", match_cnt, unmatch_cnt);
     end
    end
    
endmodule