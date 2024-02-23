`include "defines.v"

module reg1(reset_,
            enable,
            clock,
            reg_out);
// Location of source csl unit: file name = parameter_test6.csl line number = 3
//  Bitrange of state register port for register module reg1 is of another type than number. No evaluation support available. Default is [0:0].
  parameter data_width = 8;
  parameter MIN_VALUE = {0 {1'b0}};
  input reset_;
  input enable;
  input clock;
  output [data_width - 1:0] reg_out;
  reg st_reg;
  assign   reg_out = st_reg;

  always @( posedge clock or negedge reset_ )  begin 
    if ( ~(reset_) )  begin 
      st_reg <= MIN_VALUE;
    end
    else if ( enable )  begin 
        st_reg <= st_reg + 1;
      end
  end
  endmodule

