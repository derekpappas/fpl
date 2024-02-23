/*
===============================================inference
|           Line           |  full/ parallel  |hardware
===============================================
|           xxx            |      no/no       |latch
|           xxx            |      no/auto     |mux
|           xxx            |    auto/no       |
|           xxx            |    auto/auto     |mux
===============================================
*/

module case_examples(a,b,c,d,e,f,g,h,sel2,sel3,
                     casea_out   ,
                     caseadef_out,
                     caseapre_out,
                     caseb_out   ,
                     casebdef_out,
                     casebpre_out,
                     casec_out   ,
                     casecdef_out,
                     casecpre_out,
                     cased_out   ,
                     caseddef_out,
                     casedpre_out,
                     casee_out   ,
                     caseedef_out,
                     caseepre_out,
                     casef_out   ,
                     casefdef_out,
                     casefpre_out,
                     caseg_out   ,
                     casegdef_out,
                     casegpre_out,
                     caseh_out   
                     );
input a;
input b;
input c;
input d;
input e;
input f;
input g;
input h;
input sel2;
input sel3;

output casea_out   ;
output caseadef_out;
output caseapre_out;
output caseb_out   ;
output casebdef_out;
output casebpre_out;
output casec_out   ;
output casecdef_out;
output casecpre_out;
output cased_out   ;
output caseddef_out;
output casedpre_out;
output casee_out   ;
output caseedef_out;
output caseepre_out;
output casef_out   ;
output casefdef_out;
output casefpre_out;
output caseg_out   ;
output casegdef_out;
output casegpre_out;
output caseh_out   ;

   
wire [1:0] sel2;
wire [3:0] sel3;

reg casea_out   ;
reg caseadef_out;
reg caseapre_out;
reg caseb_out   ;
reg casebdef_out;
reg casebpre_out;
reg casec_out   ;
reg casecdef_out;
reg casecpre_out;
reg cased_out   ;
reg caseddef_out;
reg casedpre_out;
reg casee_out   ;
reg caseedef_out;
reg caseepre_out;
reg casef_out   ;
reg casefdef_out;
reg casefpre_out;
reg caseg_out   ;
reg casegdef_out;
reg casegpre_out;
reg caseh_out   ;

wire              aa;
wire              bb;
wire              cc;
wire              dd;
wire              ee;
wire              ff;
wire              gg;
wire              hh;

wire [1:0]        casea = sel2;

////////////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////////////

// case with all cases defined and no default

always @(/*AS*/a or b or c or casea or d) begin
   case (casea)
     2'b00: casea_out = a;
     2'b01: casea_out = b;
     2'b10: casea_out = c;
     2'b11: casea_out = d;
   endcase
end

// case with all cases defined and default

always @(/*AS*/a or b or c or casea or d) begin
   case (casea)
     2'b00: caseadef_out = a;
     2'b01: caseadef_out = b;
     2'b10: caseadef_out = c;
     2'b11: caseadef_out = d;
     default: caseadef_out = 1'b0;
   endcase
end

always @(/*AS*/a or b or c or casea or d) begin
   caseapre_out = 1'b0;
   case (casea)
     2'b00: caseapre_out = a;
     2'b01: caseapre_out = b;
     2'b10: caseapre_out = c;
     2'b11: caseapre_out = d;
   endcase
end

////////////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////////////

// case with one case missing and no default

wire [1:0] caseb = sel2;

always @(/*AS*/a or b or c or caseb) begin
   case (caseb)
     2'b00: caseb_out = a;
     2'b01: caseb_out = b;
     2'b10: caseb_out = c;
   endcase
end

// case with one case missing and default

always @(/*AS*/a or b or c or caseb) begin
   case (caseb)
     2'b00: casebdef_out = a;
     2'b01: casebdef_out = b;
     2'b10: casebdef_out = c;
     default: casebdef_out = 1'b0;
   endcase
end

// case with predefined output and one case missing 

always @(/*AS*/a or b or c or caseb) begin
   casebpre_out = 1'b0;
   case (caseb)
     2'b00: casebpre_out = a;
     2'b01: casebpre_out = b;
     2'b10: casebpre_out = c;
   endcase
end

////////////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////////////

// one hot encoding
// case with one case missing and don't cares and no default

wire [2:0] casec = sel3;

always @(/*AS*/a or b or c or casec) begin
   casez (casec)
     3'b1??: casec_out = a;
     3'b01?: casec_out = b;
     3'b001: casec_out = c;
   endcase
end

// case with one case missing and default

always @(/*AS*/a or b or c or casec) begin
   casez (casec)
     3'b1??: casecdef_out = a;
     3'b01?: casecdef_out = b;
     3'b001: casecdef_out = c;
     default: casecdef_out = 1'b0;
   endcase
end

// case with predefined output and one case missing

always @(/*AS*/a or b or c or casec) begin
   casecpre_out = 1'b0;
   casez (casec)
     3'b1??: casecpre_out = a;
     3'b01?: casecpre_out = b;
     3'b001: casecpre_out = c;
   endcase
end

////////////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////////////

// one hot encoding
// case with one case missing and don't cares and no default

wire [2:0] cased = sel3;

always @(/*AS*/a or b or c or cased) begin
   casez (cased)
     3'b1??: cased_out = a;
     3'b?1?: cased_out = b;
     3'b??1: cased_out = c;
   endcase
end

// case with one case missing and default

always @(/*AS*/a or b or c or cased) begin
   casez (cased)
     3'b1??: caseddef_out = a;
     3'b?1?: caseddef_out = b;
     3'b??1: caseddef_out = c;
     default: caseddef_out = 1'b0;
   endcase
end

// case with predefined output and one case missing

always @(/*AS*/a or b or c or cased) begin
   casedpre_out = 1'b0;
   casez (cased)
     3'b1??: casedpre_out = a;
     3'b?1?: casedpre_out = b;
     3'b??1: casedpre_out = c;
   endcase
end

////////////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////////////

// one hot encoding
// case with one case missing and don't cares and no default

wire [2:0] casee = sel3;

always @(/*AS*/a or b or c or casee) begin
   casex (casee)
     3'b1??: casee_out = a;
     3'b01?: casee_out = b;
     3'b001: casee_out = c;
   endcase
end

// case with one case missing and default

always @(/*AS*/a or b or c or casee) begin
   casex (casee)
     3'b1??: caseedef_out = a;
     3'b01?: caseedef_out = b;
     3'b001: caseedef_out = c;
     default: caseedef_out = 1'b0;
   endcase
end

// case with predefined output and one case missing

always @(/*AS*/a or b or c or casee) begin
   caseepre_out = 1'b0;
   casex (casee)
     3'b1??: caseepre_out = a;
     3'b01?: caseepre_out = b;
     3'b001: caseepre_out = c;
   endcase
end


////////////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////////////

// one hot encoding
// case with one case missing and don't cares and no default

wire [2:0] casef = sel3;

always @(/*AS*/a or b or c or casef) begin
   casex (casef)
     3'b1??: casef_out = a;
     3'b?1?: casef_out = b;
     3'b??1: casef_out = c;
   endcase
end

// case with one case missing and default

always @(/*AS*/a or b or c or casef) begin
   casex (casef)
     3'b1??: casefdef_out = a;
     3'b?1?: casefdef_out = b;
     3'b??1: casefdef_out = c;
     default: casefdef_out = 1'b0;
   endcase
end

// case with predefined output and one case missing

always @(/*AS*/a or b or c or casef) begin
   casefpre_out = 1'b0;
   casex (casef)
     3'b1??: casefpre_out = a;
     3'b?1?: casefpre_out = b;
     3'b??1: casefpre_out = c;
   endcase
end

endmodule