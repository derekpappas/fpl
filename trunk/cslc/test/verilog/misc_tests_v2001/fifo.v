module fifo_name(data_out, empty, full, data_in, push, pop, clk, reset);
    parameter W=4;
    parameter NW=16;
    
    input [W-1: 0] data_in;
    input push, pop, reset, clk;
    output full, empty;
    output [W-1:0] data_out;
    
    reg [W-1:0] data_out;
    reg full=0, empty=1;
    
    reg [W-1:0] fifo[0:NW-1];
    integer wr, rd;
    
    assign empty=(gap==0);
    assign full=(gap==NW);
    
    always@(reset, posedge clk)
      begin
          if(reset==0)
            data_out<=0;
            gap<=0;
            wr=0;
            rd=0;
          else
            begin
                if(!full & push) begin
                    fifo[wr]=data_in;
                    wr=wr+1;
                    empty=0;
                    if(wr==NW) wr=0;
                    if(wr==rd) 
                        full=1;
                    else
                        full=0;
                end
                else if(!empty & pop) begin
                    data_out=fifo[rd];
                    rd=rd+1;
                    full=0;
                    if(rd==NW) rd=0;
                    if(rd==wr) 
                        empty=1;
                    else
                        empty=0;
                end
            end
      end
endmodule

//TestBench
module tb_fifo_name;
    parameter W=4;
    parameter NW=16;
    
    wire [W-1:0] d_out;
    wire full, empty;
    wire [W-1:0] d_in;
    reg push, pop, clk, reset;
    
    integer match_cnt, unmatch_cnt;
    
    fifo_name DUT(d_out, empty, full, d_in, push, pop, clk, reset);
    counter4 CNT(d_in, reset, clk);
    
    always #5 clk=~clk;
    
    initial begin
        match_cnt=0;
        unmatch_cnt=0;
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
        push=0;
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
           $display("State %2d match.", d_in);
        end else begin
           unmatch_cnt=unmatch_cnt+1;
           $display("State %2d UNMATCH!.", d_in);
        end
        if(d_in==4'hF)
           $display("Test finished with %2d matches and %2d unmatches.", match_cnt, unmatch_cnt);
     end
    end
    
endmodule