`define PERIOD 10

//DUT description
module mux4(mux_out, a0,a1, a2, a3, sel);
    input a0, a1, a2, a3;
    input [1:0] sel;
    output mux_out;
    
    reg mux_out;
    
    always@(a0 or a1 or a2 or a3 or sel)
    begin
    case (sel)
        2'b 00: mux_out=a0;
        2'b 01: mux_out=a1;
        2'b 10: mux_out=a2;
        2'b 11: mux_out=a3;
        default mux_out=a0;
    endcase
    
end
endmodule

//now the testbench
module tb_mux4;
    wire mux_out;
    
    reg [5:0] stimul[0:7];
    reg expected[0:7];
    reg a0, a1, a2, a3;
    reg [1:0] sel;
    
    integer addr;
    reg [5:0] vect_in;
    reg [0:7] vect_out;
    
    //instantiate the dut
    mux4 DUT(mux_out, a0, a1, a2, a3, sel);
    
    initial begin
  	    $readmemb( "stimul.list" , stimul);
  	    $readmemb( "expected.list" , expected);
  	    addr=0;
  	    vect_in=stimul[addr];
       vect_out=expected[addr];
       a0=vect_in[5];
       a1=vect_in[4];
       a2=vect_in[3];
       a3=vect_in[2];
       sel=vect_in[1:0];
  	 end
    
    always #(period/2) clk=~clk;
    
    always @(posedge clk)
      begin
        if(addr<8) begin
          vect_in=stimul[addr];
          vect_out=expected[addr];
          a0=vect_in[5];
          a1=vect_in[4];
          a2=vect_in[3];        
          a3=vect_in[2];
          sel=vect_in[1:0];
          if(mux_out==vect_out) 
            $display("a0=%b a1=%b a2=%b a3=%b sel=%b Result: %b, expected: %b. Test %d Match.",a0, a1, a2, a3, sel, mux_out, vect_out[7], addr);
          else
            $display("a0=%b a1=%b a2=%b a3=%b sel=%b Result: %b, expected: %b. Test %d UNMATCH!",a0, a1, a2, a3, sel, mux_out, vect_out[7], addr);
          
          addr=addr+1;
        end;
      end
endmodule