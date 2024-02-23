module full_adder(a,b,cin,s,cout);

  input a,b,cin;       // declaration of the list of inputs
  output s, cout;      // declaration of the list of outputs

  assign s = a ^ b ^ cin;
  assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
