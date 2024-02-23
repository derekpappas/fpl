   
module pm_mod_ffenset (clk,                               r_,                                s,  // set signal                               d,                               e,                               q);  parameter W  = 1;   parameter RV = 0;   parameter SV = 0;   input     clk;  input     r_ ;  input     s ;  input [W-1:0] d;  input         e;  output [W-1:0] q;  reg [W-1:0]    q;    always @(posedge clk or negedge r_) begin     if (~r_) begin        q <= RV;           end     else if (s) begin        q <= SV;           end     else if (e) begin        q <= d;     end  end    endmodule




module pm_mod_ffen (clk,                            r_,                             d,                            e,                            q);  parameter W = 1;   input     clk;  input     r_ ;  input [W-1:0] d;  input         e;  output [W-1:0] q;  reg [W-1:0]    q;    always @(posedge clk or negedge r_) begin     if (~r_) begin        q <= {W{1'b0}};           end     else if (e) begin        q <= d;     end  end    endmodule    

 
module pm_mod_ffen (clk,                            r_,                             d,                            e,                            q);  parameter W = 1;   input     clk;  input     r_ ;  input [W-1:0] d;  input         e;  output [W-1:0] q;  reg [W-1:0]    q;    always @(posedge clk or negedge r_) begin     if (~r_) begin        q <= {W{1'b0}};           end     else if (e) begin        q <= d;     end  end    endmodule 


 module pm_mod_ffen (clk,                            r_,                             d,                            e,                            q);  parameter W = 1;   input     clk;  input     r_ ;  input [W-1:0] d;  input         e;  output [W-1:0] q;  reg [W-1:0]    q;    always @(posedge clk or negedge r_) begin     if (~r_) begin        q <= {W{1'b0}};           end     else if (e) begin        q <= d;     end  end    endmodule    



module pm_mod_ff (clk,                          r_,                           d,                          q);  parameter W = 1;   input     clk;  input     r_ ;  input  [W-1:0] d;  output [W-1:0] q;  reg    [W-1:0] q;    always @(posedge clk or negedge r_) begin     if (~r_) begin        q <= {W{1'b0}};           end     else begin        q <= d;     end  end    endmodule    

module pm_mod_inc (clk,                           r_,                           inc,                            clr,                            sum);  parameter W = 1;   parameter INC_AMT = 1;   parameter INIT_VAL = 0;   input clk;  input r_;  input inc;  input clr;  output [W-1:0]  sum;  reg [W-1:0]    sum;    always @(posedge clk or negedge r_) begin     if (~r_) begin        sum <= INIT_VAL;     end     else if (clr) begin        sum <= INIT_VAL;     end     else if (inc) begin        sum <= sum + INC_AMT;     end  end    endmodule    


module pm_mod_srff (clk,                            r_,                             s,                            r,                             q);  parameter W = 1;   input clk;  input r_;  input s;  input r;  output q;  reg    q;    reg    sr;    always @(/*AS*/q or r or s) begin     if (r) begin        sr = 1'b0;     end     else if (s) begin        sr = 1'b1;     end     else begin        sr = q;     end  end    always @(posedge clk or negedge r_) begin     if (~r_) begin        q <= 1'b0;           end    else begin        q <= sr;     end    end    endmodule    


module pm_mod_ff (clk,                          r_,                           d,                          q);  parameter W = 1;   input     clk;  input     r_ ;  input  [W-1:0] d;  output [W-1:0] q;  reg    [W-1:0] q;    always @(posedge clk or negedge r_) begin     if (~r_) begin        q <= {W{1'b0}};           end     else begin        q <= d;     end  end    endmodule    

module pm_mod_ffen (clk,                            r_,                             d,                            e,                            q);  parameter W = 1;   input     clk;  input     r_ ;  input [W-1:0] d;  input         e;  output [W-1:0] q;  reg [W-1:0]    q;    always @(posedge clk or negedge r_) begin     if (~r_) begin        q <= {W{1'b0}};           end     else if (e) begin        q <= d;     end  end    endmodule    



module pm_mod_ff (clk,                          r_,                           d,                          q);  parameter W = 1;   input     clk;  input     r_ ;  input  [W-1:0] d;  output [W-1:0] q;  reg    [W-1:0] q;    always @(posedge clk or negedge r_) begin     if (~r_) begin        q <= {W{1'b0}};           end     else begin        q <= d;     end  end    endmodule    


module pm_mod_inc (clk,                           r_,                           inc,                            clr,                            sum);  parameter W = 1;   parameter INC_AMT = 1;   parameter INIT_VAL = 0;   input clk;  input r_;  input inc;  input clr;  output [W-1:0]  sum;  reg [W-1:0]    sum;    always @(posedge clk or negedge r_) begin     if (~r_) begin        sum <= INIT_VAL;     end     else if (clr) begin        sum <= INIT_VAL;     end     else if (inc) begin        sum <= sum + INC_AMT;     end  end    endmodule    


module pm_mod_srff (clk,                            r_,                             s,                            r,                             q);  parameter W = 1;   input clk;  input r_;  input s;  input r;  output q;  reg    q;    reg    sr;    always @(/*AS*/q or r or s) begin     if (r) begin        sr = 1'b0;     end     else if (s) begin        sr = 1'b1;     end     else begin        sr = q;     end  end    always @(posedge clk or negedge r_) begin     if (~r_) begin        q <= 1'b0;           end     else begin        q <= sr;     end    end    endmodule    


module pm_mod_inc (clk,                           r_,                           inc,                            clr,                            sum);  parameter W = 1;   parameter INC_AMT = 1;   parameter INIT_VAL = 0;   input clk;  input r_;  input inc;  input clr;  output [W-1:0]  sum;  reg [W-1:0]    sum;    always @(posedge clk or negedge r_) begin     if (~r_) begin        sum <= INIT_VAL;     end     else if (clr) begin        sum <= INIT_VAL;     end     else if (inc) begin        sum <= sum + INC_AMT;     end  end    endmodule      


module pm_mod_ffen (clk,                            r_,                             d,                            e,                            q);  parameter W = 1;   input     clk;  input     r_ ;  input [W-1:0] d;  input         e;  output [W-1:0] q;  reg [W-1:0]    q;    always @(posedge clk or negedge r_) begin     if (~r_) begin        q <= {W{1'b0}};           end     else if (e) begin        q <= d;     end  end    endmodule      


module pm_mod_ff (clk,                          r_,                           d,                          q);  parameter W = 1;   input     clk;  input     r_ ;  input  [W-1:0] d;  output [W-1:0] q;  reg    [W-1:0] q;    always @(posedge clk or negedge r_) begin     if (~r_) begin        q <= {W{1'b0}};           end     else begin        q <= d;     end  end    endmodule    


module pm_mod_inc (clk,                           r_,                           inc,                            clr,                            sum);  parameter W = 1;   parameter INC_AMT = 1;   parameter INIT_VAL = 0;   input clk;  input r_;  input inc;  input clr;  output [W-1:0]  sum;  reg [W-1:0]    sum;    always @(posedge clk or negedge r_) begin     if (~r_) begin        sum <= INIT_VAL;     end     else if (clr) begin        sum <= INIT_VAL;     end     else if (inc) begin        sum <= sum + INC_AMT;     end  end    endmodule    


module pm_mod_srff (clk,                            r_,                             s,                            r,                             q);  parameter W = 1;   input clk;  input r_;  input s;  input r;  output q;  reg    q;    reg    sr;    always @(/*AS*/q or r or s) begin     if (r) begin        sr = 1'b0;     end     else if (s) begin        sr = 1'b1;     end     else begin        sr = q;     end  end    always @(posedge clk or negedge r_) begin     if (~r_) begin        q <= 1'b0;           end     else begin        q <= sr;     end    end    endmodule    


module pm_mod_srff (clk,                            r_,                             s,                            r,                             q);  parameter W = 1;   input clk;  input r_;  input s;  input r;  output q;  reg    q;    reg    sr;    always @(/*AS*/q or r or s) begin     if (r) begin        sr = 1'b0;     end     else if (s) begin        sr = 1'b1;     end     else begin        sr = q;     end  end    always @(posedge clk or negedge r_) begin     if (~r_) begin        q <= 1'b0;           end     else begin        q <= sr;     end    end    endmodule    


module pm_mod_ffen (clk,                            r_,                             d,                            e,                            q);  parameter W = 1;   input     clk;  input     r_ ;  input [W-1:0] d;  input         e;  output [W-1:0] q;  reg [W-1:0]    q;    always @(posedge clk or negedge r_) begin     if (~r_) begin        q <= {W{1'b0}};           end     else if (e) begin        q <= d;     end  end    endmodule    


module pm_mod_ff (clk,                          r_,                           d,                          q);  parameter W = 1;   input     clk;  input     r_ ;  input  [W-1:0] d;  output [W-1:0] q;  reg    [W-1:0] q;    always @(posedge clk or negedge r_) begin     if (~r_) begin        q <= {W{1'b0}};           end     else begin        q <= d;     end  end    endmodule    


module pm_mod_inc (clk,                           r_,                           inc,                            clr,                            sum);  parameter W = 1;   parameter INC_AMT = 1;   parameter INIT_VAL = 0;   input clk;  input r_;  input inc;  input clr;  output [W-1:0]  sum;  reg [W-1:0]    sum;    always @(posedge clk or negedge r_) begin     if (~r_) begin        sum <= INIT_VAL;     end     else if (clr) begin        sum <= INIT_VAL;     end     else if (inc) begin        sum <= sum + INC_AMT;     end  end    endmodule    


module pm_mod_srff (clk,                            r_,                             s,                            r,                             q);  parameter W = 1;   input clk;  input r_;  input s;  input r;  output q;  reg    q;    reg    sr;    always @(/*AS*/q or r or s) begin     if (r) begin        sr = 1'b0;     end     else if (s) begin        sr = 1'b1;     end     else begin        sr = q;     end  end    always @(posedge clk or negedge r_) begin     if (~r_) begin        q <= 1'b0;           end     else begin        q <= sr;     end    end    endmodule    