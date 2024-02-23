//fifo
module fifo(d_out, empty, full, d_in, push, pop, clk, reset);
    
    parameter WD=3;//word dimension
    parameter SD=15;//stack dimension
    
    input [WD:0] d_in;
    input push, pop, clk, reset;
    output [WD:0] d_out;
    output empty, full;
    
    wire [WD:0] d_out;
    reg empty, full;
    
    reg [WD:0] stack[0:SD];
    integer i, j, sp;
    
    always@(reset, posedge clk)
      begin
          if(reset==0)
            begin
                for(i=0;i<SD+1;i=i+1)
                  stack[i]=4'b Z;
                sp=0;
            end
          else
            begin
                if(sp==0)
                  empty=1;
                else 
                  empty=0;
                if(sp==SD+1)
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
                      for(i=0;i<SD+1;i=i+1)
                         stack[i]=stack[i+1];
                      stack[SD]=4'b Z;
                  end
            end
      end
      assign d_out=stack[0];
endmodule


//TestBench
module tb_fifo;
    
    parameter WD=3;
    parameter SD=8;
    parameter clk_per=10;
    
    wire [WD:0] d_out;
    wire full, empty;
    wire [WD:0] d_in;
    reg push, pop, clk, reset;
    
    integer match_cnt, unmatch_cnt;
    reg tb_init;
    
    
    fifo #(WD,SD) DUT(d_out, empty, full, d_in, push, pop, clk, reset);
    counter4 CNT(d_in, r, clk);
    
    
    assign r=reset & tb_init;
    
    always #(clk_per/2) clk=~clk;// clk generator    
    
    initial begin
        match_cnt=0;
        clk=0;
        unmatch_cnt=0;
        push=1;
        pop=0;
        reset=0;
        @(posedge clk);
        @(posedge clk);
        reset=1;
        #((SD+1)*clk_per);//push data in
        push=0;
        pop=1;
        #((SD+1)*clk_per);//pop data out(for testing)
        pop=0;
    end
    
    always@(posedge clk)
    begin
        
     if(d_in==SD) tb_init=0;//reset the ounter that loads data in fifo
     else tb_init=1;
     
     //wait until the fifo loads the data from the counter
     //and after pop out and compare 
     
     if($time>(SD*clk_per+15) && $time<(SD*2*clk_per+35))begin
        if(d_in==d_out) begin
           match_cnt=match_cnt+1;//match counter
           $display("State %2d match.", d_in);
        end else begin
           unmatch_cnt=unmatch_cnt+1;//unmatch counter
           $display("State %2d MISMATCH!.", d_in);
        end
        if(d_in==SD)
           $display("Test finished with %2d matches and %2d mismatches.", match_cnt, unmatch_cnt);
     end
    end
    
endmodule