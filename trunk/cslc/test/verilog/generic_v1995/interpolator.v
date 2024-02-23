//*****************************************************************************
//FILE NAME  : interpolator.v
//OWNER      : STEFANOS
//MODIFIED BY: NIKHIL KUMAR SRIVASTAVA
//COMMENTS   : This module fakes the interpolator to generate the outclk.Though
//             the actual implementation is fully combinational however in order//             to model it correctly we need to have state. 
//*****************************************************************************

module interpolator(out, ph1, ph2, sel);

output          out;

input           ph1, ph2;
input   [7:0]  sel ;
 
wire    [8:0]  int;

`define STAGES   16
`define CLK2     128
`define INTRV   `CLK2/`STAGES/8
 
reg     ph1Early, cycle_done;
 
wire            ePH  = (ph1Early) ? ph1 : ph2;
wire            lPH  = (ph1Early) ? ph2 : ph1;
 
integer         i;
reg     [03:0]  isel;
 
 
always @(sel or ph1Early) begin
        isel = 0;
for ( i = 7 ; i >= 0 ; i = i - 1 ) begin
                isel = isel + ( sel[i] == ~ph1Early );
               // $display("i %d ",i , " isel %b ", isel);
                end
end
 
 
assign                  int[00] = ePH;
assign  #(01*`INTRV)    int[01] = ePH;
assign  #(02*`INTRV)    int[02] = ePH;
assign  #(03*`INTRV)    int[03] = ePH;
assign  #(04*`INTRV)    int[04] = ePH;
assign  #(05*`INTRV)    int[05] = ePH;
assign  #(06*`INTRV)    int[06] = ePH;
assign  #(07*`INTRV)    int[07] = ePH;
assign                  int[08] = lPH;


assign  #0      out = int[isel];
 
 
 
initial begin
        cycle_done = 1 ;
        ph1Early   = 0 ;
end
 
always @(negedge ph1)
        cycle_done = 1;
 
always @(negedge ph2)
        cycle_done = 1;
 
always @(posedge ph1 or posedge ph2) begin
        if ( cycle_done ) begin
                cycle_done = 0;
                ph1Early   = ph1;
        end
end

endmodule // end interpolator module
