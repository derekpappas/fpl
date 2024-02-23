// id verilog code

assign    p_opcode=p_i[5:0],     // opcode
          p_bb=p_i[12:12],         //burst bit
          p_src=p_i[11:11],        //
          p_id=p_i[10:10],
          p_dst=p_i[9:9],
          p_br_len=p_i[16:13],   // burst length
          p_dstreg=p_i[21:17],  // address of destination register
          p_srcreg1=p_i[31:27,  // address of  operand register
          p_srcreg2=p_i[26:22],  // address of second  operand register
          p_immed=p_i[21:6];     //  immediate value (constant)

