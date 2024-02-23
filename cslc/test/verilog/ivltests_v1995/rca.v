module RCA(p,q,ci,r);

input [3:0] p, q;     // Declaration of two four-bit inputs
input ci;             // and the one-bit input carry 

output [4:0] r;       // Declaration of the five-bit outputs

wire [2:0] carry;     // Declaration of internal carry wires

full_adder fa0(p[0],q[0],ci,r[0],carry[0]);
full_adder fa1(p[1],q[1],carry[0],r[1],carry[1]);
full_adder fa2(p[2],q[2],carry[1],r[2],carry[2]);
full_adder fa3(p[3],q[3],carry[2],r[3],r[4]);

endmodule
