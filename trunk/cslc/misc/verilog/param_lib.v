// ff #(1) ff(.clk (clk), .r_ (reset_), .d (data_in), .q (data_out ));

module ff(clk, r_, d, q);
  parameter WIDTH = 0;
  
  input              clk;
  input              r_ ;
  input  [WIDTH-1:0] d  ;
  output [WIDTH-1:0] q  ;
  reg    [WIDTH-1:0] q  ;
  
  always @(posedge clk) begin
     if (~r_) begin
        q <= {WIDTH{1'b0}};
     end
     else begin
        q <= d;
     end
  end

endmodule // ff


// ff_en #(1) ff(.clk (clk), .r_ (reset_), .en (en), .d (data_in), .q (data_out ));

module ff_en(clk, r_, en, d, q);
  parameter WIDTH = 0;
  
  input              clk;
  input              r_ ;
  input              en ;
  input  [WIDTH-1:0] d  ;
  output [WIDTH-1:0] q  ;
  reg    [WIDTH-1:0] q  ;
  
  always @(posedge clk) begin
     if (~r_) begin
        q <= {WIDTH{1'b0}};
     end
     else if (en) begin
        q <= d;
     end
  end

endmodule // ff_en

// inc #(`WIDTH) inc0(.clk (clk), .r_ (reset_), .en (en), .clr (clr), .q (data_out ));  

module inc(clk, r_, clr, en, q);
  parameter WIDTH = 0;
  
  input              clk;
  input              r_ ;
  input              clr ;
  input              en ;
  output [WIDTH-1:0] q  ;
  reg    [WIDTH-1:0] q  ;
  
  always @(posedge clk) begin
     if (~r_) begin
        q <= {WIDTH{1'b0}};
     end
     else if (clr) begin
        q <= {WIDTH{1'b0}};
     end
     else if (en) begin
        q <= q + {{WIDTH-1{1'b0}}, 1'b1};
     end
  end

endmodule // ff_en


// inc_sa #(`WIDTH, `START_ADDRESS                 ) inc0(.clk (clk), .r_ (reset_), .clr(clr), .en (en), .q (data_out ));  

module inc_sa(clk, r_, clr, en, q);
  parameter WIDTH = 0;
  parameter START_ADDR = 0;
  
  input              clk;
  input              r_ ;
  input              clr ;
  input              en ;
  output [WIDTH-1:0] q  ;
  reg    [WIDTH-1:0] q  ;
  
  always @(posedge clk) begin
     if (~r_) begin
        q <= START_ADDR;
     end
     else if (clr) begin
        q <= START_ADDR;
     end
     else if (en) begin
        q <= q + {{WIDTH-1{1'b0}}, 1'b1};
     end
  end

endmodule // ff_en

// inc_ea #(`WIDTH, `END_ADDRESS                   ) inc0(.clk (clk), .r_ (reset_), .clr(clr), .en (en), .q (data_out ));  

module inc_ea(clk, r_, clr, en, q);
  parameter WIDTH = 0;
  parameter END_ADDR = 0;
  
  input              clk;
  input              r_ ;
  input              clr ;
  input              en ;
  output [WIDTH-1:0] q  ;
  reg    [WIDTH-1:0] q  ;
  
  always @(posedge clk) begin
     if (~r_) begin
        q <=  {WIDTH{1'b0}};
     end
     else if (clr) begin
        q <=  {WIDTH{1'b0}};
     end
     else if (q == END_ADDR) begin
        q <=  {WIDTH{1'b0}};
     end
     else if (en) begin
        q <= q + {{WIDTH-1{1'b0}}, 1'b1};
     end
  end

endmodule // ff_en

// inc_sa_ea #(`WIDTH, `START_ADDRESS, `END_ADDRESS) inc0(.clk (clk), .r_ (reset_), .clr(clr), .en (en), .q (data_out ));  


module inc_ea_sa(clk, r_, clr, en, q);
  parameter WIDTH = 0;
  parameter END_ADDR = 0;
  
  input              clk;
  input              r_ ;
  input              clr ;
  input              en ;
  output [WIDTH-1:0] q  ;
  reg    [WIDTH-1:0] q  ;
  
  always @(posedge clk) begin
     if (~r_) begin
        q <=  {WIDTH{1'b0}};
     end
     else if (clr) begin
        q <=  {WIDTH{1'b0}};
     end
     else if (q == END_ADDR) begin
        q <=  {WIDTH{1'b0}};
     end
     else if (en) begin
        q <= q + {{WIDTH-1{1'b0}}, 1'b1};
     end
  end

endmodule // ff_en


////////////////////////////////////////////////////////////////////////////////

// inc_a #(4,2) inc0(.clk (clk), .r_ (reset_), .en (en), .clr (clr), .q (data_out ));  

module inc_a(clk, r_, clr, en, q);
  parameter WIDTH = 0;
  parameter INC_AMOUNT = 1;
  
  input              clk;
  input              r_ ;
  input              clr ;
  input              en ;
  output [WIDTH-1:0] q  ;
  reg    [WIDTH-1:0] q  ;
  
  always @(posedge clk) begin
     if (~r_) begin
        q <= {WIDTH{1'b0}};
     end
     else if (clr) begin
        q <= {WIDTH{1'b0}};
     end
     else if (en) begin
        q <= q + {{WIDTH-1{1'b0}}, 1'b1};
     end
  end

endmodule // inc_a

// ADD INC_AMMOUNT TO A THE REMAINING COUNTER MODULES