//Control verilog code

always @(p_opcode) begin
 
case(p_opcode)

`E_E_OPCODE_READ32REQ : s_read32req=1;   
                     
`E_E_OPCODE_WRITE32 : s_write32=1;
             
`E_E_OPCODE_READ32RESP :s_read32resp=1;
             
`E_E_OPCODE_WRITE64 : s_write64=1;
             
`E_E_OPCODE_READ64RESP : s_read64resp=1;
             
`E_E_OPCODE_READ32DMAREQ  : s_read32DMAreq=1;
             
`E_E_OPCODE_WRITE32DMA :  s_write32DMA=1;
            
`E_E_OPCODE_READ64DMAREQ : s_read64DMAreq=1;
             
`E_E_OPCODE_WRITE64DMA : s_write64DMA=1;
             
`E_E_OPCODE_ADD :s_add=1;
             
`E_E_OPCODE_SUB :  s_sub=1;
             
`E_E_OPCODE_EQUAL : s_equal=1;
            
`E_E_OPCODE_BRANCH_:s_branch=1;
              
`E_E_OPCODE_MOVHI : s_movhi=1;
              
`E_E_OPCODE_MOVI :s_movi=1;
            
`E_E_OPCODE_ORI : s_ori=1;
           
`E_E_OPCODE_LDW : s_ldw=1;
              
`E_E_OPCODE_STW : s_stw=1;

`E_E_OPCODE_BRLT : s_brlt=1;

`E_E_OPCODE_BRGE : s_brge=1;
             
`E_E_OPCODE_BRLE : s_brle=1;

`E_E_OPCODE_BRGT : s_brgt=1;
             
`E_E_OPCODE_BREQ : s_breq=1;

`E_E_OPCODE_BRNE : s_brne=1;

`E_E_OPCODE_BRP : s_brp=1;

`E_E_OPCODE_BRN : s_brn=1;

`E_E_OPCODE_BRNN : s_brnn=1;

`E_E_OPCODE_BRZ : s_brz=1;  

`E_E_OPCODE_BRNZ : s_brnz=1;

`E_E_OPCODE_BRC : s_brc=1;
           
`E_E_OPCODE_BRNC : s_brnc=1;

`E_E_OPCODE_BRV : s_brnv=1;

`E_E_OPCODE_BRNV : s_brnv=1;
             
default : begin
              s_read32req=0;              
              s_write32=0;
              s_read32resp=0;
              s_write64=0;
              s_read64resp=0;
              s_read32DMAreq=0;
              s_write32DMA=0;
              s_read64DMAreq=0;
              s_write64DMA=0;
              s_add=0;
              s_sub=0;
              s_equal=0;
              s_branch=0;
              s_movhi=0;
              s_movi=0;
              s_ori=0;
              s_ldw=0;
              s_stw=0;     
              s_brlt=0;
              s_brge=0;
              s_brle=0;
              s_brgt=0;
              s_breq=0;
              s_brne=0;
              s_brp=0;
              s_brn=0;
              s_brnn=0;
              s_brz=0;
              s_brnz=0;
              s_brc=0;
              s_brnc=0;
              s_brv=0;
              s_brnv=0;      
          end
endcase
 end

always @(posedge clk) begin
    case(p_opcode)

`E_E_OPCODE_ADD : p_op_sel=`E_OP_SEL_ADD_OP;
`E_E_OPCODE_SUB : p_op_sel=`E_OP_SEL_SUB_OP;
`E_E_OPCODE_EQUAL : p_op_sel=`E_OP_SEL_EQUAL_OP;
`E_E_OPCODE_ORI : p_op_sel=`E_OP_SEL_ORI_OP;
`E_E_OPCODE_STW : p_op_sel=`E_OP_SEL_STW_OP;

default : p_op_sel=3'bxxx;
endcase

/*always @(p_opcode) begin
 
   if(s_add==1)
         p_op_sel= `E_OP_SEL_ADD_OP; //select add operation
      else
         if(s_sub==1)
         p_op_sel=`E_OP_SEL_SUB_OP; //select sub operation
     else
      if(s_equal==1)
       p_op_sel= `E_OP_SEL_EQUAL_OP;  //select equal operation
     else
       if(s_ori==1)
      p_op_sel=`E_OP_SEL_ORI_OP;   //select ori operation
     else
       if(s_stw==1)
      p_op_sel=`E_OP_SEL_STW_OP; //select stw operation
   else
   p_op_sel=3'bxxx;

end*/

