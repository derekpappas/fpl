
module TB;
parameter VW=4;
parameter VN=50;
  reg [VW:0] tb_vec_mem [0:VN];
  initial begin
     $readmemb("stimulus.vec", tb_vec_mem);
 end
endmodule