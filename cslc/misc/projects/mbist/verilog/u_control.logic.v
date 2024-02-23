// u_control verilog code

   // alu/memory operation decoder
     s_opcode_alu_mem_dec= 1<< p_opcode[3];

    // opcode decoder
     s_opcode_dec = 1 <<p_opcode;
  
    // transfer direction decoder
     s_direction_dec=1<<p_direction;  

   r2sr=s_direction_dec[0];
   sr2r=s_direction_dec[1];

  
   //this should be generated from enum in ISA 
   //begin
   s_add= s_opcode[0]; 
   s_sub=s_opcode[1]; 
   s_or=s_opcode[2];
   s_and=s_opcode[3];
   s_cmp=s_opcode[4];
   s_sh=s_opcode[5]; 
   s_not=s_opcode[6]; 
   s_swp=s_opcode[7]; 
   s_mov=s_opcode[8];
   s_movr=s_opcode[9]; 
   s_movc=s_opcode[10]; 
   s_movrs=s_opcode[11]; 
   s_mramrs=s_opcode[12]; 
   s_br=s_opcode[13]; 
   s_incr=s_opcode[14]; 
   s_decr=s_opcode[15];
   //end
   // or shorter when concatenation will work
   //{s_add, s_sub, s_or, s_and, s_cmp, s_sh, s_not, s_swp, s_mov, s_movr, s_movc, s_movrs, s_mramrs, s_br, s_incr, s_decr}=s_opcode;
   

   s_z=p_status[0];  // zero flag

    //control signal equations
   p_br_sel    =s_br & (p_cond==!s_z);
   p_sreg_sel  = s_opcode_mem & s_movrs;
   p_rf_wr_en  = s_opcode_alu | s_mov | s_movr |s_movc | s_sr2r & (s_movrs | s_mramrs);
   p_rf_rd1_en =s_add | s_sub | s_or | s_and | s_cmp;
   p_rf_rd2_en =s_opcode_alu | s_mov | rs2r & (s_movrs | mramrs);
   p_rom_en    = s_movr;
   p_sram_wr   = s_mramrs & r2sr;
   p_sram_en   = s_mramrs & sr2r;
   s_mem_sel[2] =s_movrs & sr2r;
   s_mem_sel[1]= s_movr | (s_mramrs & sr2r);
   s_mem_sel[0]= s_movr | s_movc;
   p_caddr_dir= s_decr ;
   p_caddr_en = s_incr & s_decr ;
   p_caddr_ld = s_movrs & r2sr ;  
   p_haddr_en = s_movrs & r2sr ;
   p_haddr_ld = s_movrs & r2sr ;
   p_sh_sel = s_sh   ;
   p_rf_alu_sel= s_mov;