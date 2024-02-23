//get_signals_values
module top();
    parameter n=4;
    
    wire [n-1: 0]a_b_vec, c_e_vec, d_e_vec;
    wire [2*n-1: 0] cd_e_vec;
    wire [n-1: 0] a_out, c_out, d_out;
    
    unit_a unit_a0(a_out);
    unit_b unit_b0(a_out);
    unit_c unit_c0(c_out);
    unit_d unit_d0(d_out);
    unit_e unit_e0({c_out,d_out});
    
    assign a_b_vec=a_out;
    assign c_e_vec=c_out;
    assign d_e_vec=d_out;
    assign cd_e_vec={c_out,d_out};
    
    always@(a_b_vec, c_e_vec, d_e_vec, cd_e_vec) begin
        #2;
        $display("a_b_vec= %b", a_b_vec);
        $display("c_e_vec= %b", c_e_vec);
        $display("d_e_vec= %b", d_e_vec);
        $display("cd_e_vec= %b", cd_e_vec);
    
        #10 $finish;
    end
    
endmodule

module unit_a(a_out);
    parameter n=4;
    output [n-1: 0] a_out;
    reg [n-1: 0] a_out=1;
endmodule
module unit_b(b_in);
    parameter n=4;
    input [n-1: 0] b_in;
endmodule
module unit_c(c_out);
    parameter n=4;
    output [n-1: 0] c_out;
    reg [n-1: 0] c_out=1;
endmodule
module unit_d(d_out);
    parameter n=4;
    output [n-1: 0] d_out;
    reg [n-1: 0] d_out=0;
endmodule
module unit_e(e_in);
    parameter n=8;
    input [n-1: 0] e_in;
endmodule