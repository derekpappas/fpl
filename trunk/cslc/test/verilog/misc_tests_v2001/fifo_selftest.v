//fifo

module fifo_name(d_out, empty, full, d_in, push, pop, clk, reset);
    parameter W=4;
    parameter NW=16;
    
    input [W-1:0] d_in;
    input push, pop, clk, reset;
    output [W-1:0] d_out;
    output empty, full;
    
    wire [W-1:0] d_out;
    reg empty, full;
    
    reg [W-1:0] stack[0:NW-1];
    integer i, j, sp;
    
    always@(reset, posedge clk)
      begin
          if(reset==0)
            begin
                for(i=0;i<16;i=i+1)
                  stack[i]=0;
                sp=0;
            end
          else
            begin
                if(sp==0)
                  empty=1;
                else 
                  empty=0;
                if(sp==16)
                  full=1;
                else
                  full=0;
                if(push==1 && full==0)
                  begin
                      stack[sp]=d_in;
                      sp=sp+1;
                  end
                if(pop==1 && empty==0)
                  begin
                      sp=sp-1;
                      for(i=0;i<NW;i=i+1)
                         stack[i]=stack[i+1];
                      stack[NW-1]=0;
                  end
            end
      end
      assign d_out=stack[0];
endmodule


//TestBench
module tb_fifo;
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





















