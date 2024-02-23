`include "defines.v"

module pc_reg(reset_,
              enable,
              clock,
              reg_out,
              reg_in);
// Location of source csl unit: file name = csl_example_unit.csl line number = 391
//  Bitrange of state register port for register module pc_reg is of another type than number. No evaluation support available. Default is [0:0].
  input reset_;
  input enable;
  input clock;
  input [32 - 1:0] reg_in;
  output [32 - 1:0] reg_out;
  reg st_reg;
  assign   reg_out = st_reg;

  always @( posedge clock or negedge reset_ )  begin 
    if ( ~(reset_) )  begin 
      st_reg <= 0;
    end
    else if ( enable )  begin 
        st_reg <= reg_in;
      end
  end
  endmodule

