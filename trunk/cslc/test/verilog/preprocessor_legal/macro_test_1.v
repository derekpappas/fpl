`define macro_identifier9$1( _ ) macro _text
`define \macro_escaped_identifier!@#$%^&*()1 ( _ ) macro_ text
module m1;
`define macro_identifier9$_1( _ ) macro _ text
`define \macro_escaped_identifier!@#$%^&*()_1 ( _ ) macro _ text

`macro_identifier9$1( 1 )
`\macro_escaped_identifier!@#$%^&*()1 ( 2 )
`macro_identifier9$_1( 3 )
`\macro_escaped_identifier!@#$%^&*()_1 ( 4 )
endmodule

