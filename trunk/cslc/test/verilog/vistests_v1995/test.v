module test(clock,data,q);
    input  clock, data;
    output q;

    reg    q;

    initial q = 0;

    always @ (clock or data)
      if (clock) q = data;

endmodule // test
