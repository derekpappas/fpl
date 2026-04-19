module m;
  parameter P = 0;
  wire x;
  generate
    case (P)
      1'd0:
        assign x = 1'b0;
      default:
        assign x = 1'b1;
    endcase
  endgenerate
endmodule
