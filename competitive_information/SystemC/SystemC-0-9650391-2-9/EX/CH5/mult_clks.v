// Copyright 2003 Star Galaxy Publishing
// File: mult_clks.v

module mult_clks (vt15ck, addclk, adn, resetn, subclr, subn, ds1ck, ds1_add, ds1_sub);
  input vt15ck, addclk, adn, resetn, subclr, subn, ds1ck;

  output ds1_add, ds1_sub;
  reg ds1_add, ds1_sub;
  reg add_state, sub_state;

  always @(negedge vt15ck) begin
    add_state = !(addclk | (adn | resetn));
    sub_state = subclr ^ (subn & resetn);
  end

  always @(posedge ds1ck) begin
    ds1_add = add_state;
    ds1_sub = sub_state;
  end
endmodule
