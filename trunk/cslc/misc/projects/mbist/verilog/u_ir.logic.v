// ir verilog code

    p_opcode=p_i[15:12]; // opcode
    p_rdst=p_i[11:8];    // address of destination register
    p_op1=p_i[7:4];      // address of first operand register
    p_op2=p_i[3:0];      // address of second operand register
    p_c=p_i[11];         // condition flag
    p_braddr=p_i[10:0];  // branch address
    p_sha=p_i[7:4];      // shift amount
    p_const8=p_i[7:0];   // constant
    p_romaddr=p_i[7:0];  // rom memory address
    p_d=p_i[11];         // transfer direction flag