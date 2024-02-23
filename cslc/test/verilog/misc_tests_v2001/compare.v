//compare 2 vectors: 1 with values from a truth table and 1 with the responses
module comp (res,tab,cnt_match,cnt_unmatch);
    input [3:0] res;
    input [3:0] tab;
    output [3:0] cnt_match;
    output [3:0] cnt_unmatch;
    
    integer cnt_match, cnt_unmatch;
    
    always @(res,tab) begin
       if (res == tab)begin
          cnt_match = cnt_match + 1;
          $display("cnt_match=%d",cnt_match);
       end
       else begin
          cnt_unmatch = cnt_unmatch + 1;
          $display("cnt_unmatch=%d",cnt_unmatch);
      end
    end
    
endmodule

module Test_comp;
    reg [3:0] response;
    reg [3:0] truth;
    wire [3:0] good;
    wire [3:0] bad;
    comp DUT(response,truth,good,bad);
    initial begin
        truth   = 4'b0000;
        response= 4'b0000;
        #15
        truth   = 4'b0001;
        #1
        response= 4'b0001;
        #15
        truth   = 4'b0010;
        response= 4'b0010;
        #15
        truth   = 4'b1000;
        response= 4'b0001;
        #15
        truth   = 4'b0110;
        #1
        response= 4'b0010;
        #15
        truth   = 4'b1110;
        response= 4'b1110;
        #15
        truth   = 4'b0110;
        response= 4'b0110;
        #15
        truth   = 4'b0010;
        response= 4'b0010;
    end
endmodule