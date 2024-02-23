// id verilog code

    p_opcode=p_i[5:0];     // opcode
    p_br_len=p_i[16:13]   // burst length
    p_dstreg=p_i[21:17];  // address of destination register
    p_idreg=p_i[26:22];   // IDs of processors (sender and receiver) 
    p_srcreg1=p_i[31:27];// address of  operand register
    p_srcreg2=p_i[26:22]; // address of second  operand register
    p_null =p_i[26:22];   // field with 00000
    p_immed=p_i[21:6];     //  immediate value (constant)