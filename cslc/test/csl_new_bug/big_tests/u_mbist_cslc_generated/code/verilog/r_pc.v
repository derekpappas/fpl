`include "defines.v"

module r_pc(reset_,
            enable,
            clock,
            reg_out);
// Location of source csl unit: file name = mbist_datapath.csl line number = 18
//  Bitrange of state register port for register module r_pc is of another type than number. No evaluation support available. Default is [0:0].
  parameter MIN_VALUE = {0 {1'b0}};
  input reset_;
  input enable;
  input clock;
  output [16 - 1:0] reg_out;
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

