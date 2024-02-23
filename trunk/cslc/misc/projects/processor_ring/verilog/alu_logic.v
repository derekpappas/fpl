//alu verilog code

always @ (op_sel, op1, op2, ci)
  case (op_sel)
    `E_OP_SEL_ADD_OP: {co,alu_rez} = op1 + op2 + ci;      // add
    `E_OP_SEL_SUB_OP: alu_rez = op1 - op2;                // substract
    `E_OP_SEL_EQUAL_OP: alu_rez=(op1 == op2);             //equal
    `E_OP_SEL_ORI_OP: alu_rez=op1 | op2;                 //ori  
    `E_OP_SEL_STW_OP: alu_rez={op1,op2};                //stw
    
default: co=1'b0;
endcase


