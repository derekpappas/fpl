// alu verilog code

always @ (op_sel, op1, op2, cin)
  case (op_sel)
    3'b000: {cout,res} = op1 + op2 + cin;      // add
    3'b001: res = op1 - op2;                   // substract
    3'b010: res = op1 | op2;                   // or
    3'b011: res = op1 & op2;                   // and
    3'b100: res = (op1 == op2) ? 16'b1: 16'b0; // compare
    3'b101: res = op2 << op1[3:0];             // shift
    3'b110: res = ~op1;                        // not
    3'b111: res={op1[7:0],op1[15:9]};          // swap low byte with high byte
    default: cout=1'b0;
endcase