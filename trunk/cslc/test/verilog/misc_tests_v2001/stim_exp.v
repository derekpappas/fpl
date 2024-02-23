module unit_a(in_sgn, out_sgn);
    input [1:0] in_sgn;
    output [1:0] out_sgn;
    
    reg [1:0]out_sgn;
    
    always@(in_sgn)
      out_sgn=~in_sgn;
endmodule

module tb_unit_a;
    parameter PERIOD=10;
    parameter WM=2;
    parameter HM=8;
    parameter MAX_ERR_CNT=3;
    
    reg [WM-1:0] in_sgn;
    wire [WM-1:0] out_sgn;
    
    //create memories to store stim_exp vecors
    reg [WM-1:0] stim_mem[0:HM-1];
    reg [WM-1:0] expect_mem[0:HM-1];
    reg output_mem[0:HM-1];
    
    reg [WM-1:0]expect_vec;
    integer addr, match, mismatch;
    
    reg clk;
    
    //instantiate the DUT
    unit_a DUT(in_sgn, out_sgn);
    
    initial begin
        clk=0;
        addr=0;
        $readmemb("stimulus.vec", stim_mem);
        $readmemb("expected.vec", expect_mem);
        match=0;
        mismatch=0;
        in_sgn=stim_mem[addr];
        //expect_vec=expect_mem[addr];
    end
    
    //testbench clock generator
    always #(PERIOD/2) clk=~clk;
    
    //compare output with expected each positive clk edge
    always@(posedge clk)
    begin
       if(addr<HM) begin
          
          expect_vec=expect_mem[addr];
          addr=addr+1;
          in_sgn=stim_mem[addr];
          if(out_sgn==expect_vec) begin
            $display("Input value: %b Output value: %b; Expected value %b => Test vector %2d matched.", in_sgn, out_sgn, expect_vec, addr);   
            output_mem[addr-1]=1;
            match=match+1;
          end
          else begin
            $display("Input value: %b Output value: %b; Expected value %b => Test vector %2d MISMATCH!.", in_sgn, out_sgn, expect_vec, addr);
            output_mem[addr]=0;
            mismatch=mismatch+1;
          end
          if(mismatch>=MAX_ERR_CNT) begin
            $display("Maximum error count reached!");
            $finish; 
          end
       end
       else if(addr==HM)
          $writememb("comp_out.vec", output_mem);
    end
    
endmodule