module testbench_genvar_declaration;
    genvar_declaration0 genvar_declaration_instance0();
    genvar_declaration1 genvar_declaration_instance1();
    genvar_declaration2 genvar_declaration_instance2();
endmodule
//@
//author : andreib
module genvar_declaration0;
genvar abcd;
endmodule
//author : andreib
module genvar_declaration1;
genvar abcd , ABCD;
endmodule
//author : andreib
module genvar_declaration2;
genvar abcd , ABCD , _123;
endmodule
