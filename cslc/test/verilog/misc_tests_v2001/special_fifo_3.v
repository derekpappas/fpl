module spec_fifo(data_out, empty, data_in, full, push, pop, valid, stall, clk, reset);
    parameter stack_width=4;
    parameter stack_depth=16;
    parameter stack_width_gap=4; 
        
    input [stack_width-1: 0] data_in;
    input push, pop, stall, clk, reset;
    output [stack_width-1: 0] data_out;
    output full, empty, valid;//if valid=0 or empty you can't pop
    
    wire [stack_width-1: 0] d0, d1, d2;
    wire int_empty, int_full, int_pop, vi0, vo0, e0, vi1, vo1, e1, vi2, e2;
    
    FIFO #(stack_width, stack_depth, stack_width_gap)int_fifo(d0, int_empty, int_full, data_in, push, int_pop, clk, reset);
    REG #(stack_width)out_reg_0(d0, d1, vi0, vo0, e1, stall, e0, clk, reset);
    REG #(stack_width)out_reg_1(d1, d2, vi1, vo1, e2, stall, e1, clk, reset);
    REG #(stack_width)out_reg_2(d2, data_out, vi2, valid, pop, stall, e2, clk, reset);
   
    
endmodule

//tb_spec_fifo
module tb_spec_fifo;
   parameter stack_width=4;
   parameter stack_depth=16;
   parameter clk_per=10;
      
   wire [stack_width-1: 0] data_in;
   reg push, pop, stall, clk, reset;
   wire [stack_width-1: 0] data_out;
   wire full, empty, valid;
   
   spec_fifo #(stack_width, stack_depth)SFIFO(data_out, empty, data_in, full, push, pop, valid, stall, clk, reset);
   counter4 CNT(data_in, reset, clk);
   
   initial begin
       stall=0;
       clk=0;
       push=1;
       pop=0;
       reset=0;
       @(posedge clk);
       @(posedge clk);
       @(posedge clk);
       @(posedge clk);
       @(posedge clk);
       @(posedge clk);
       @(posedge clk);
       reset=1;
       @(posedge clk);
       @(posedge clk);
       @(posedge clk);
       @(posedge clk);
       pop=0;
       @(posedge clk);
       stall=0;
       @(posedge clk);
       @(posedge clk);
       @(posedge clk);
       @(posedge clk);
       stall=0;
       @(posedge clk);
       @(posedge clk);
       push=0;
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
       @(posedge clk);
       @(posedge clk);
       pop=0;
   end
   always #(clk_per/2) clk=~clk;
endmodule