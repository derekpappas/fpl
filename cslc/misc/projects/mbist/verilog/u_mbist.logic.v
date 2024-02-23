// u_mbist verilog code

// branch address extension
s_branch_address_e={6'b0,s_branch_address};


    // shift multiplexor
    s_mux_shift= s_sh_sel ? s_rf_mux: {12'b0,s_shift_ammount};

   //sets the CZ bit in status register
    cz_f= | (s_haddr_cmp ^ p_sram_addr); 
    
    // sets the S (sign) flag in status register
    s_s_f= & s_alu_mux[15];
    
     
    // sets the Z (zero) flag in status register 
    s_z_f= | (s_alu_mux);
    
   // sets the status flags
    s_status_in = {11'b0, s_cz_f, 1'b0, s_s_f, s_c_f, s_z_f};
    
    // memory select multiplexor
    always @(mem_sel,s_rom_mux,s_es_mux,s_sram_mux,s_alu_mux)
       case (s_mem_sel)
             3'b000: s_mem_mux=s_rom_mux;
             3'b001: s_mem_mux=s_es_mux;
             3'b010: s_mem_mux=s_sram_mux;
             3'b011: s_mem_mux=rf_alu_mux;
             3'b100: s_mem_mux=s_sreg_mux;
      endcase

      //or
      //s_mem_mux= s_mem_sel[3] ? s_sreg_mux:(s_mem_sel[0] ? (s_mem_sel[0] ? s_rom_mux: s_es_mux) : (s_mem_sel[0] ? s_ram_mux: s_rf_alu_mux));

   // register file alu multiplexor
   rf_alu_mux= rf_alu_sel ? rf0.data_out2 : alu0.res;

