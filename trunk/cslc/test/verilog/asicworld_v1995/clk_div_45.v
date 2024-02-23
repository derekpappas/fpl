//-----------------------------------------------------
// Design Name : clk_div_45
// File Name   : clk_div_45.v
// Function    : Divide by 3.4
// Coder       : Deepak"
//-----------------------------------------------------
module clk_div_45 (
clk_in, // Input Clock
enable, // Enable is sync with falling edge of clk_in
clk_out // Output Clock
);

// --------------Port Declaration-----------------------
input      clk_in     ;
input      enable     ;
output     clk_out    ;

//--------------Port data type declaration-------------
wire       clk_in     ;
wire       enable     ;
reg        clk_out    ;

//--------------Internal Registers----------------------
reg   [3:0] counter1   ;
reg   [3:0] counter2   ;
reg         clk_out1   ;
reg         clk_out2   ;


//--------------Code Starts Here-----------------------
always @ (posedge clk_in)
if (enable == 1'b0) begin 
   counter1 <= 4'b0;
end else if (counter1 == 4'b1000)  begin
   counter1 <= 4'b0;
end else   begin
   counter1 <= counter1 + 1;
end
   
always @ (negedge clk_in)
if (enable == 1'b0) begin
  counter2 <= 4'b0;
end else if (counter2 == 4'b1000)  begin
  counter2 <= 4'b0;
end  else   begin
  counter2 <= counter2 + 1;
end

always @ (posedge clk_in) 
if (enable == 1'b0)  begin
      clk_out1 <= 1'b0;
end else if (counter1 == 4'b0000) begin
      clk_out1 <= 1'b1;
end else if (counter1 == 4'b0010)  begin
      clk_out1<= 1'b0;
end

always @ (negedge clk_in) 
if (enable == 1'b0) begin
  clk_out2 <= 1'b0;
end else if (counter2 == 4'b0100) begin
  clk_out2 <= 1'b1;
end else if (counter1 == 4'b0110) begin
  clk_out2 <= 1'b0;
end

always @ (clk_out1 or clk_out2)
begin
  clk_out = clk_out1 | clk_out2;
end

endmodule
