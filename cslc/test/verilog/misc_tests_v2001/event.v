/*csl_unit unit_a;
  unit_a.add_signal(output, out0);
  unit_a.add_signal(output, out1);
  csl_event event_a(unit_a.in0 | unit_a.in1);
  csl_vector tb_vec_a, tb_vec_b;
  csl_clock clk;
  tb_vec_a.add_event(event_a);
  tb_vec_b.add_event(clk);*/
  module tb;
      parameter MAX_NUM=2;
      parameter MAX_WIDTH=2;
      parameter period=10;
      
      wire out0, out1;
      reg clk;
      reg [MAX_WIDTH-1:0] tb_vec_a, tb_vec_b; 
      reg [MAX_WIDTH-1:0] vec_a_mem[0:MAX_NUM-1], vec_b_mem[0:MAX_NUM-1];
      integer i=0, j=0;
      
      unit_a unit_a0(out0, out1);
      
      assign event_a=out0 || out1;
      
      initial begin
          clk=0;
          $readmemb("a.vec", vec_a_mem);
          $readmemb("b.vec", vec_b_mem);
      end
      always@(posedge event_a) begin
          tb_vec_a<=vec_a_mem[i];
          i=i+1;
      end
      always@(posedge clk) begin
          tb_vec_b<=vec_b_mem[j];
          j=j+1;
      end
      always #(period/2) clk=~clk;
  endmodule
  