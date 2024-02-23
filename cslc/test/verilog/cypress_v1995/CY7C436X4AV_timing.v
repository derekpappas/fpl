
//--------------------------------------------------------
// CY7C436X4AV  Timing Related
//--------------------------------------------------------

specify
//-------------------------
// 133MHz Timing Parameters
//-------------------------
        specparam       tCLKA_133       = 7.500 ;       // min
        specparam       tCLKB_133       = 7.500 ;       // min
        specparam       tCLKAH_133      = 3.500 ;       // min
        specparam       tCLKAL_133      = 3.500 ;       // min
        specparam       tCLKBH_133      = 3.500 ;       // min
        specparam       tCLKBL_133      = 3.500 ;       // min
        
        specparam       tDS_133         = 3.000 ;       // min
        specparam       tENS_133        = 3.000 ;       // min
        specparam       tRSTS_133       = 2.500 ;       // min
        specparam       tFSS_133        = 5.000 ;       // min
        
        specparam       tFWS_133        = 0 ;           // min
        specparam       tDH_133         = 0 ;           // min
        specparam       tENH_133        = 0 ;           // min
        
        specparam       tRSTH_133       = 1.000 ;       // min
        specparam       tFSH_133        = 1.000 ;       // min
        specparam       tSPH_133        = 0 ;           // min
        
        specparam       tSKEW1_133      = 5.000 ;       // min
        specparam       tSKEW2_133      = 7.000 ;       // min
        
        specparam       tA_133          = 6.000 ;       // max
        specparam       tWFF_133        = 6.000 ;       // max
        specparam       tREF_133        = 6.000 ;       // max 
   
        specparam       tPAE_133        = 6.000 ;       // max  
        specparam       tPAF_133        = 6.000 ;       // max 
        specparam       tPMF_133        = 6.000 ;       // max  
        specparam       tPMR_133        = 7.000 ;       // max  
        specparam       tMDV_133        = 6.000 ;       // max  
        specparam       tRSF_133        = 6.000 ;       // max  
        specparam       tEN_133         = 6.000 ;       // max  
        specparam       tDIS_133        = 5.000 ;       // max  
        
        //specparam     tPRT_133        = 6.0000 ;      // min  
        specparam       tRTR_133        = 9.0000 ;      // min  
                
//-------------------------
// 100MHz Timing Parameters
//-------------------------

        specparam       tCLKA_100       = 1.0000 ;      // min
        specparam       tCLKB_100       = 1.0000 ;      // min
        specparam       tCLKAH_100      = 4.000 ;       // min
        specparam       tCLKAL_100      = 4.000 ;       // min
        specparam       tCLKBH_100      = 4.000 ;       // min
        specparam       tCLKBL_100      = 4.000 ;       // min
        
        specparam       tDS_100         = 4.000 ;       // min
        specparam       tENS_100        = 4.000 ;       // min
        specparam       tRSTS_100       = 4.000 ;       // min
        specparam       tFSS_100        = 7.000 ;       // min
        
        specparam       tFWS_100        = 0 ;           // min
        specparam       tDH_100         = 0 ;           // min
        specparam       tENH_100        = 0 ;           // min
        
        specparam       tRSTH_100       = 2.000 ;       // min
        specparam       tFSH_100        = 1.000 ;       // min
        specparam       tSPH_100        = 1.000 ;       // min
        
        //specparam       tSKEW1_100      = 5.000 ;       // min	
        specparam       tSKEW1_100      = 4.000 ;       // min	// test -flgupdtWARB / flgupdtWBRA
        specparam       tSKEW2_100      = 8.000 ;       // min
        
        specparam       tA_100          = 8.000 ;       // max
        specparam       tWFF_100        = 8.000 ;       // max
        specparam       tREF_100        = 8.000 ;       // max 
   
        specparam       tPAE_100        = 8.000 ;       // max  
        specparam       tPAF_100        = 8.000 ;       // max 
        specparam       tPMF_100        = 8.000 ;       // max  
        specparam       tPMR_100        = 11.000 ;      // max  
        specparam       tMDV_100        = 9.000 ;       // max 
        //specparam       tMDV_100        = 4.000 ;       // max 
         
        specparam       tRSF_100        = 10.000 ;      // max  
        specparam       tEN_100         = 8.000 ;       // max  
        specparam       tDIS_100        = 6.000 ;       // max  
        
        //specparam     tPRT_100        = 60.000 ;      // min  
        specparam       tRTR_100        = 90.000 ;      // min  
                
//-------------------------
// 67MHz Timing Parameters
//-------------------------
        
        specparam       tCLKA_67        = 15.000 ;      // min
        specparam       tCLKB_67        = 15.000 ;      // min
        specparam       tCLKAH_67       = 6.000 ;       // min
        specparam       tCLKAL_67       = 6.000 ;       // min
        specparam       tCLKBH_67       = 6.000 ;       // min
        specparam       tCLKBL_67       = 6.000 ;       // min
        
        specparam       tDS_67          = 5.000 ;       // min
        specparam       tENS_67         = 5.000 ;       // min
        specparam       tRSTS_67        = 5.000 ;       // min
        specparam       tFSS_67         = 7.500 ;       // min
        
        specparam       tFWS_67         = 0 ;           // min
        specparam       tDH_67          = 0 ;           // min
        specparam       tENH_67         = 0 ;           // min
        
        specparam       tRSTH_67        = 2.000 ;       // min
        specparam       tFSH_67         = 2.000 ;       // min
        specparam       tSPH_67         = 2.000 ;       // min
        
        specparam       tSKEW1_67       = 7.500 ;       // min
        specparam       tSKEW2_67       = 12.000 ;      // min
        
        specparam       tA_67           = 10.000 ;      // max
        specparam       tWFF_67         = 10.000 ;      // max
        specparam       tREF_67         = 10.000 ;      // max 
    
        specparam       tPAE_67         = 10.000 ;      // max  
        specparam       tPAF_67         = 10.000 ;      // max 
        specparam       tPMF_67         = 12.000 ;      // max  
        specparam       tPMR_67         = 12.000 ;      // max  
        specparam       tMDV_67         = 11.000 ;      // max  
        specparam       tRSF_67         = 15.000 ;      // max  
        specparam       tEN_67          = 10.000 ;      // max  
        specparam       tDIS_67         = 80.00 ;       // max  
        
        //specparam     tPRT_67         = 60.000 ;      // min  
        specparam       tRTR_67         = 90.000 ;      // min 
         

    specparam tBES_133  = 5.000;
    specparam tBES_100  = 7.000;
    specparam tBES_67   = 7.500;

    specparam tSPMS_133 = 5.000;
    specparam tSPMS_100 = 7.000;
    specparam tSPMS_67  = 7.500;

    specparam tBEH_133  = 1.000;
    specparam tBEH_100  = 1.000;
    specparam tBEH_67   = 2.000;

    specparam tSPMH_133 = 1.000;
    specparam tSPMH_100 = 1.000;
    specparam tSPMH_67  = 2.000;


//----------------------------------------------------------------
// Timing Delay spec. w.r.t MRST1_N signal
//----------------------------------------------------------------
        if (op133) (negedge MRST1_N => (FFA_N_IRA : MRST1_N )) = tRSF_133 ;
        if (op100) (negedge MRST1_N => (FFA_N_IRA : MRST1_N )) = tRSF_100 ;
        if (op67)  (negedge MRST1_N => (FFA_N_IRA : MRST1_N )) = tRSF_67  ;
                
        if (op133) (negedge MRST1_N => (EFB_N_ORB : MRST1_N )) = tRSF_133 ;
        if (op100) (negedge MRST1_N => (EFB_N_ORB : MRST1_N )) = tRSF_100 ;
        if (op67)  (negedge MRST1_N => (EFB_N_ORB : MRST1_N )) = tRSF_67  ;
        
        if (op133) (negedge MRST1_N => (AEB_N : MRST1_N )) = tRSF_133 ;
        if (op100) (negedge MRST1_N => (AEB_N : MRST1_N )) = tRSF_100 ;
        if (op67)  (negedge MRST1_N => (AEB_N : MRST1_N )) = tRSF_67  ;
        
        if (op133) (negedge MRST1_N => (AFA_N : MRST1_N )) = tRSF_133 ;
        if (op100) (negedge MRST1_N => (AFA_N : MRST1_N )) = tRSF_100 ;
        if (op67)  (negedge MRST1_N => (AFA_N : MRST1_N )) = tRSF_67  ;
        
        if (op133) (negedge MRST1_N => (MBF1_N : MRST1_N )) = tRSF_133 ;
        if (op100) (negedge MRST1_N => (MBF1_N : MRST1_N )) = tRSF_100 ;
        if (op67)  (negedge MRST1_N => (MBF1_N : MRST1_N )) = tRSF_67  ;
//----------------------------------------------------------------
// Timing Delay spec. w.r.t MRST2_N signal
//----------------------------------------------------------------
        if (op133) (negedge MRST2_N => (FFB_N_IRB : MRST2_N )) = tRSF_133 ;
        if (op100) (negedge MRST2_N => (FFB_N_IRB : MRST2_N )) = tRSF_100 ;
        if (op67)  (negedge MRST2_N => (FFB_N_IRB : MRST2_N )) = tRSF_67  ;
                
        if (op133) (negedge MRST2_N => (EFA_N_ORA : MRST2_N )) = tRSF_133 ;
        if (op100) (negedge MRST2_N => (EFA_N_ORA : MRST2_N )) = tRSF_100 ;
        if (op67)  (negedge MRST2_N => (EFA_N_ORA : MRST2_N )) = tRSF_67  ;
        
        if (op133) (negedge MRST2_N => (AEA_N : MRST2_N )) = tRSF_133 ;
        if (op100) (negedge MRST2_N => (AEA_N : MRST2_N )) = tRSF_100 ;
        if (op67)  (negedge MRST2_N => (AEA_N : MRST2_N )) = tRSF_67  ;
        
        if (op133) (negedge MRST2_N => (AFB_N : MRST2_N )) = tRSF_133 ;
        if (op100) (negedge MRST2_N => (AFB_N : MRST2_N )) = tRSF_100 ;
        if (op67)  (negedge MRST2_N => (AFB_N : MRST2_N )) = tRSF_67  ;
        
        if (op133) (negedge MRST2_N => (MBF2_N : MRST2_N )) = tRSF_133 ;
        if (op100) (negedge MRST2_N => (MBF2_N : MRST2_N )) = tRSF_100 ;
        if (op67)  (negedge MRST2_N => (MBF2_N : MRST2_N )) = tRSF_67  ;


// Path delay for FFA_N_IRA wrt MRST1_N, PRST1_N
    // Path delay for FFB_N_IRB wrt MRST2_N, PRST2_N
    
    if ( op133)   (MRST1_N,PRST1_N *> FFA_N_IRA) = tRSF_133;
    if ( op100)   (MRST1_N,PRST1_N *> FFA_N_IRA) = tRSF_100;
    if ( op67)    (MRST1_N,PRST1_N *> FFA_N_IRA) = tRSF_67 ;
    
    if ( op133)   (MRST2_N,PRST2_N *> FFA_N_IRA) = tRSF_133; // 6/25/01
    if ( op100)   (MRST2_N,PRST2_N *> FFA_N_IRA) = tRSF_100; // 6/25/01
    if ( op67)    (MRST2_N,PRST2_N *> FFA_N_IRA) = tRSF_67 ; // 6/25/01
    
    if ( op133)   (MRST2_N,PRST2_N *> FFB_N_IRB) = tRSF_133; // 6/25/01
    if ( op100)   (MRST2_N,PRST2_N *> FFB_N_IRB) = tRSF_100; // 6/25/01
    if ( op67)    (MRST2_N,PRST2_N *> FFB_N_IRB) = tRSF_67 ; // 6/25/01
    
 // Path delay for EFA_N_ORA wrt MRST2_N, PRST2_N
    // Path delay for EFB_N_ORB wrt MRST1_N, PRST1_N
    
    if ( op133)   (MRST2_N,PRST2_N *> EFA_N_ORA) = tRSF_133;
    if ( op100)   (MRST2_N,PRST2_N *> EFA_N_ORA) = tRSF_100;
    if ( op67)    (MRST2_N,PRST2_N *> EFA_N_ORA) = tRSF_67 ;
    
    if ( op133)   (MRST1_N,PRST1_N *> EFB_N_ORB) = tRSF_133;
    if ( op100)   (MRST1_N,PRST1_N *> EFB_N_ORB) = tRSF_100;
    if ( op67)    (MRST1_N,PRST1_N *> EFB_N_ORB) = tRSF_67 ;
    
// Path delay for AEA_N/AEB_N wrt MRST1_N, PRST1_N /MRST2_N, PRST2_N  

    if ( op133)   (MRST1_N,PRST1_N *> AEB_N) = tRSF_133; // 7/05/01
    if ( op100)   (MRST1_N,PRST1_N *> AEB_N) = tRSF_100; // 7/05/01
    if ( op67)    (MRST1_N,PRST1_N *> AEB_N) = tRSF_67 ; // 7/05/01

    if ( op133)   (MRST2_N,PRST2_N *> AEA_N) = tRSF_133; // 7/05/01
    if ( op100)   (MRST2_N,PRST2_N *> AEA_N) = tRSF_100; // 7/05/01
    if ( op67)    (MRST2_N,PRST2_N *> AEA_N) = tRSF_67 ; // 7/05/01     
//------------------------------------------------------------------
// Data AccessTime Delays (ie. CLK to DataOut during FIFO read )
//------------------------------------------------------------------
        
/*
        if (op133 ) (posedge CLKA => (A : portA_output_reg )) = tA_133 ;
        if (op100 ) (posedge CLKA => (A : portA_output_reg )) = tA_100 ;
        if (op67  ) (posedge CLKA => (A : portA_output_reg )) = tA_67  ;
        
        if (op133 ) (posedge CLKB => (B : portB_output_reg )) = tA_133 ;
        if (op100 ) (posedge CLKB => (B : portB_output_reg )) = tA_100 ;
        if (op67  ) (posedge CLKB => (B : portB_output_reg )) = tA_67  ;


        if (op133 && !MBA) (posedge CLKA => (A : portA_output_reg )) = tA_133 ;
        if (op100 && !MBA) (posedge CLKA => (A : portA_output_reg )) = tA_100 ;
        if (op67  && !MBA) (posedge CLKA => (A : portA_output_reg )) = tA_67  ;
        
        if (op133 && !MBB) (posedge CLKB => (B : portB_output_reg )) = tA_133 ;
        if (op100 && !MBB) (posedge CLKB => (B : portB_output_reg )) = tA_100 ;
        if (op67  && !MBB) (posedge CLKB => (B : portB_output_reg )) = tA_67  ;
*/      

/*
        if (op133 && !MBA && popA ) (posedge CLKA => (A : portA_output_reg )) = tA_133 ;
        if (op100 && !MBA && popA ) (posedge CLKA => (A : portA_output_reg )) = tA_100 ;
        if (op67  && !MBA && popA ) (posedge CLKA => (A : portA_output_reg )) = tA_67  ;
        
        if (op133 && !MBB && popB ) (posedge CLKB => (B : portB_output_reg )) = tA_133 ;
        if (op100 && !MBB && popB ) (posedge CLKB => (B : portB_output_reg )) = tA_100 ;
        if (op67  && !MBB && popB ) (posedge CLKB => (B : portB_output_reg )) = tA_67  ;
*/       
        if (op133 && !MBA && !BE_FWFT_N_reg2 && !EFA_N_ORA) (posedge CLKA => (A : portA_output_reg )) = tA_133 ;
        if (op100 && !MBA && !BE_FWFT_N_reg2 && !EFA_N_ORA) (posedge CLKA => (A : portA_output_reg )) = tA_100 ;
        if (op67  && !MBA && !BE_FWFT_N_reg2 && !EFA_N_ORA) (posedge CLKA => (A : portA_output_reg )) = tA_67  ;
        
        if (op133 && !MBB && !BE_FWFT_N_reg1 && !EFB_N_ORB) (posedge CLKB => (B : portB_output_reg )) = tA_133 ;
        if (op100 && !MBB && !BE_FWFT_N_reg1 && !EFB_N_ORB) (posedge CLKB => (B : portB_output_reg )) = tA_100 ;
        if (op67  && !MBB && !BE_FWFT_N_reg1 && !EFB_N_ORB) (posedge CLKB => (B : portB_output_reg )) = tA_67  ;

//------------------------------------------------------------------
// DataBus Tristate  and Enable Delays 
//------------------------------------------------------------------
        if (op133 && W_RA_N) (W_RA_N => A ) = tDIS_133 ;
        if (op100 && W_RA_N) (W_RA_N => A ) = tDIS_100 ;
        if (op67  && W_RA_N) (W_RA_N => A ) = tDIS_67  ;

        if (op133 && !W_RA_N) (W_RA_N => A ) = tEN_133 ;
        if (op100 && !W_RA_N) (W_RA_N => A ) = tEN_100 ;
        if (op67  && !W_RA_N) (W_RA_N => A ) = tEN_67  ;
        
        if (op133 && CSA_N ) (CSA_N => A ) = tDIS_133 ;
        if (op100 && CSA_N ) (CSA_N => A ) = tDIS_100 ;
        if (op67  && CSA_N ) (CSA_N => A ) = tDIS_67  ;
        
        if (op133 && !CSA_N ) (CSA_N => A ) = tEN_133 ; 
        if (op100 && !CSA_N ) (CSA_N => A ) = tEN_100 ; 
        if (op67  && !CSA_N ) (CSA_N => A ) = tEN_67  ; 

        if (op133 && !W_N_RB) ( W_N_RB => B) = tDIS_133 ;
        if (op100 && !W_N_RB) ( W_N_RB => B) = tDIS_100 ;
        if (op67  && !W_N_RB) ( W_N_RB => B) = tDIS_67  ;
        
        if (op133 && W_N_RB) ( W_N_RB => B) = tEN_133 ;
        if (op100 && W_N_RB) ( W_N_RB => B) = tEN_100 ;
        if (op67  && W_N_RB) ( W_N_RB => B) = tEN_67  ;
        
        if (op133 && CSB_N ) (CSB_N => B ) = tDIS_133 ;
        if (op100 && CSB_N ) (CSB_N => B ) = tDIS_100 ;
        if (op67  && CSB_N ) (CSB_N => B ) = tDIS_67  ;
        
        if (op133 && !CSB_N ) (CSB_N => B ) = tEN_133 ; 
        if (op100 && !CSB_N ) (CSB_N => B ) = tEN_100 ; 
        if (op67  && !CSB_N ) (CSB_N => B ) = tEN_67  ; 
        
//------------------------------------------------------------------
// MailBox Data AccessTime Delays 
//------------------------------------------------------------------
/*        
        if (op133 && MBA) (MBA => A ) = tMDV_133 ;
        if (op100 && MBA) (MBA => A ) = tMDV_100 ;
        if (op67  && MBA) (MBA => A ) = tMDV_67  ;
        
        if (op133 && MBB) (MBB => B ) = tMDV_133 ;
        if (op100 && MBB) (MBB => B ) = tMDV_100 ;
        if (op67  && MBB) (MBB => B ) = tMDV_67  ;

        if (op133 ) (MBA => A ) = tMDV_133 ;    // 09-12 changes
        if (op100 ) (MBA => A ) = tMDV_100 ;
        if (op67  ) (MBA => A ) = tMDV_67  ;
        
        if (op133 ) (MBB => B ) = tMDV_133 ;
        if (op100 ) (MBB => B ) = tMDV_100 ;
        if (op67  ) (MBB => B ) = tMDV_67  ;
*/       
//------------------------------------------------------------------
// CLKA to B (when MBB=1)  /  CLKB to A (when MBA=1)  Delays  
//------------------------------------------------------------------
                        
        if (op133 && portA_mb_wr_en && MBB) (posedge CLKA => (B : portB_output_reg )) = tPMR_133 ;
        if (op100 && portA_mb_wr_en && MBB) (posedge CLKA => (B : portB_output_reg )) = tPMR_100 ;
        if (op67  && portA_mb_wr_en && MBB) (posedge CLKA => (B : portB_output_reg )) = tPMR_67  ;
        
        if (op133 && portB_mb_wr_en && MBA) (posedge CLKB => (A : portA_output_reg )) = tPMR_133 ;
        if (op100 && portB_mb_wr_en && MBA) (posedge CLKB => (A : portA_output_reg )) = tPMR_100 ;
        if (op67  && portB_mb_wr_en && MBA) (posedge CLKB => (A : portA_output_reg )) = tPMR_67  ;
        
//------------------------------------------------------------------
// Flag Related Delays
//------------------------------------------------------------------
// Full Flag related
//-------------------
        if (op133) (posedge CLKA => (FFA_N_IRA : FFA_N_IRA_i )) = tWFF_133 ;
        if (op100) (posedge CLKA => (FFA_N_IRA : FFA_N_IRA_i )) = tWFF_100 ;
        if (op67)  (posedge CLKA => (FFA_N_IRA : FFA_N_IRA_i )) = tWFF_67  ;
                
        if (op133) (posedge CLKB => (FFB_N_IRB : FFB_N_IRB_i )) = tWFF_133 ;
        if (op100) (posedge CLKB => (FFB_N_IRB : FFB_N_IRB_i )) = tWFF_100 ;
        if (op67)  (posedge CLKB => (FFB_N_IRB : FFB_N_IRB_i )) = tWFF_67  ;
        
//------------------------------------------------------------------
// Empty Flag related
//-------------------
        if (op133) (posedge CLKA => (EFA_N_ORA : EFA_N_ORA_i )) = tREF_133 ;
        if (op100) (posedge CLKA => (EFA_N_ORA : EFA_N_ORA_i )) = tREF_100 ;
        if (op67)  (posedge CLKA => (EFA_N_ORA : EFA_N_ORA_i )) = tREF_67  ;
                
        if (op133) (posedge CLKB => (EFB_N_ORB : EFB_N_ORB_i )) = tREF_133 ;
        if (op100) (posedge CLKB => (EFB_N_ORB : EFB_N_ORB_i )) = tREF_100 ;
        if (op67)  (posedge CLKB => (EFB_N_ORB : EFB_N_ORB_i )) = tREF_67  ;
                        
//------------------------------------------------------------------
// Almost Full Flag related
//-------------------------
        if (op133) (posedge CLKA => (AFA_N : AFA_N_i )) = tPAF_133 ;
        if (op100) (posedge CLKA => (AFA_N : AFA_N_i )) = tPAF_100 ;
        if (op67)  (posedge CLKA => (AFA_N : AFA_N_i )) = tPAF_67  ;
                
        if (op133) (posedge CLKB => (AFB_N : AFB_N_i )) = tPAF_133 ;
        if (op100) (posedge CLKB => (AFB_N : AFB_N_i )) = tPAF_100 ;
        if (op67)  (posedge CLKB => (AFB_N : AFB_N_i )) = tPAF_67  ;            

//------------------------------------------------------------------
// Almost Empty Flag related Delays
//----------------------------------
        if (op133) (posedge CLKA => (AEA_N : AEA_N_i )) = tPAE_133 ;
        if (op100) (posedge CLKA => (AEA_N : AEA_N_i )) = tPAE_100 ;
        if (op67)  (posedge CLKA => (AEA_N : AEA_N_i )) = tPAE_67  ;
                
        if (op133) (posedge CLKB => (AEB_N : AEB_N_i )) = tPAE_133 ;
        if (op100) (posedge CLKB => (AEB_N : AEB_N_i )) = tPAE_100 ;
        if (op67)  (posedge CLKB => (AEB_N : AEB_N_i )) = tPAE_67  ;            
//------------------------------------------------------------------
// MailBox Flag related Delays
//----------------------------
        if (op133 && !MBF1_N_i) (posedge CLKA => (MBF1_N : MBF1_N_i )) = tPMF_133 ;
        if (op100 && !MBF1_N_i) (posedge CLKA => (MBF1_N : MBF1_N_i )) = tPMF_100 ;
        if (op67  && !MBF1_N_i) (posedge CLKA => (MBF1_N : MBF1_N_i )) = tPMF_67  ;
        
        if (op133 && MBF1_N_i) (posedge CLKB => (MBF1_N : MBF1_N_i )) = tPMF_133 ;      
        if (op100 && MBF1_N_i) (posedge CLKB => (MBF1_N : MBF1_N_i )) = tPMF_100 ;      
        if (op67  && MBF1_N_i) (posedge CLKB => (MBF1_N : MBF1_N_i )) = tPMF_67  ;      
        
        if (op133 && !MBF2_N_i) (posedge CLKB => (MBF2_N : MBF2_N_i )) = tPMF_133 ;
        if (op100 && !MBF2_N_i) (posedge CLKB => (MBF2_N : MBF2_N_i )) = tPMF_100 ;
        if (op67  && !MBF2_N_i) (posedge CLKB => (MBF2_N : MBF2_N_i )) = tPMF_67  ;

        if (op133 && MBF2_N_i) (posedge CLKA => (MBF2_N : MBF2_N_i )) = tPMF_133 ;      
        if (op100 && MBF2_N_i) (posedge CLKA => (MBF2_N : MBF2_N_i )) = tPMF_100 ;      
        if (op67  && MBF2_N_i) (posedge CLKA => (MBF2_N : MBF2_N_i )) = tPMF_67  ;      
                
//-----------------------------------------
// Timing Check on the input signals.
//----------------------------------------------------------------
// CLK Period and pulse-width checking
//----------------------------------------------------------------

        $period(posedge CLKA &&& op133, tCLKA_133);
        $period(posedge CLKA &&& op100, tCLKA_100);
        $period(posedge CLKA &&& op67 , tCLKA_67 );
        
        $period(posedge CLKB &&& op133, tCLKB_133);
        $period(posedge CLKB &&& op100, tCLKB_100);
        $period(posedge CLKB &&& op67 , tCLKB_67 );
        
        $width(posedge CLKA &&& op133, tCLKAH_133);
        $width(posedge CLKA &&& op100, tCLKAH_100);
        $width(posedge CLKA &&& op67 , tCLKAH_67 );

        $width(negedge CLKA &&& op133, tCLKAL_133);
        $width(negedge CLKA &&& op100, tCLKAL_100);
        $width(negedge CLKA &&& op67 , tCLKAL_67 );
        
        $width(posedge CLKB &&& op133, tCLKBH_133);
        $width(posedge CLKB &&& op100, tCLKBH_100);
        $width(posedge CLKB &&& op67 , tCLKBH_67 );

        $width(negedge CLKB &&& op133, tCLKBL_133);
        $width(negedge CLKB &&& op100, tCLKBL_100);
        $width(negedge CLKB &&& op67 , tCLKBL_67 );

//---------------------------------------------------------------
// Setup Time check for BE_FWFT_N
//---------------------------------------------------------------
        $setup(BE_FWFT_N, posedge CLKA &&& op133_mode_latchA, tFWS_133) ;
        $setup(BE_FWFT_N, posedge CLKA &&& op100_mode_latchA, tFWS_100) ;
        $setup(BE_FWFT_N, posedge CLKA &&& op67_mode_latchA , tFWS_67) ;
        
        $setup(BE_FWFT_N, posedge CLKB &&& op133_mode_latchB, tFWS_133) ;
        $setup(BE_FWFT_N, posedge CLKB &&& op100_mode_latchB, tFWS_100) ;
        $setup(BE_FWFT_N, posedge CLKB &&& op67_mode_latchB , tFWS_67) ;

//---------------------------------------------------------------
// Setup / Hold time check for FS1_SEN_N / FS0_SD
//---------------------------------------------------------------

        $setuphold(posedge MRST1_N &&& op133, FS0_SD, tFSS_133, tFSH_133);
        $setuphold(posedge MRST1_N &&& op100, FS0_SD, tFSS_100, tFSH_100);
        $setuphold(posedge MRST1_N &&& op67 , FS0_SD, tFSS_67 , tFSH_67 );
        
        $setuphold(posedge MRST1_N &&& op133, FS1_SEN_N, tFSS_133, tFSH_133);
        $setuphold(posedge MRST1_N &&& op100, FS1_SEN_N, tFSS_100, tFSH_100);
        $setuphold(posedge MRST1_N &&& op67 , FS1_SEN_N, tFSS_67 , tFSH_67 );
        
        $setuphold(posedge MRST2_N &&& op133, FS0_SD, tFSS_133, tFSH_133);
        $setuphold(posedge MRST2_N &&& op100, FS0_SD, tFSS_100, tFSH_100);
        $setuphold(posedge MRST2_N &&& op67 , FS0_SD, tFSS_67 , tFSH_67 );
        
        $setuphold(posedge MRST2_N &&& op133, FS1_SEN_N, tFSS_133, tFSH_133);
        $setuphold(posedge MRST2_N &&& op100, FS1_SEN_N, tFSS_100, tFSH_100);
        $setuphold(posedge MRST2_N &&& op67 , FS1_SEN_N, tFSS_67 , tFSH_67 );
        
//---------------------------------------------------------------
// Setup / Hold time check for A[35:0] and B[35:0]
//---------------------------------------------------------------

        $setuphold(posedge CLKA &&& op133_pA_wr, A, tDS_133, tDH_133);
        $setuphold(posedge CLKA &&& op100_pA_wr, A, tDS_100, tDH_100);
        $setuphold(posedge CLKA &&& op67_pA_wr , A, tDS_67 , tDH_67 );
        
        $setuphold(posedge CLKB &&& op133_pB_wr, B, tDS_133, tDH_133);
        $setuphold(posedge CLKB &&& op100_pB_wr, B, tDS_100, tDH_100);
        $setuphold(posedge CLKB &&& op67_pB_wr , B, tDS_67 , tDH_67 );
//---------------------------------------------------------------
// Setup / Hold time check for Port A/B Enable signals
//---------------------------------------------------------------

        $setuphold(posedge CLKA &&& op133_ena, CSA_N, tENS_133, tENH_133);
        $setuphold(posedge CLKA &&& op100_ena, CSA_N, tENS_100, tENH_100);
        $setuphold(posedge CLKA &&& op67_ena,  CSA_N, tENS_67,  tENH_67) ;

        $setuphold(posedge CLKA &&& op133_csa_n, ENA, tENS_133, tENH_133);
        $setuphold(posedge CLKA &&& op100_csa_n, ENA, tENS_100, tENH_100);
        $setuphold(posedge CLKA &&& op67_csa_n,  ENA, tENS_67,  tENH_67) ;

        $setuphold(posedge CLKA &&& op133_ena_csa_n, W_RA_N, tENS_133, tENH_133);
        $setuphold(posedge CLKA &&& op100_ena_csa_n, W_RA_N, tENS_100, tENH_100);
        $setuphold(posedge CLKA &&& op67_ena_csa_n,  W_RA_N, tENS_67,  tENH_67) ;

        $setuphold(posedge CLKA &&& op133_ena_csa_n, MBA, tENS_133, tENH_133);
        $setuphold(posedge CLKA &&& op100_ena_csa_n, MBA, tENS_100, tENH_100);
        $setuphold(posedge CLKA &&& op67_ena_csa_n,  MBA, tENS_67,  tENH_67) ;
        
        $setuphold(posedge CLKB &&& op133_enb, CSB_N, tENS_133, tENH_133);
        $setuphold(posedge CLKB &&& op100_enb, CSB_N, tENS_100, tENH_100);
        $setuphold(posedge CLKB &&& op67_enb,  CSB_N, tENS_67,  tENH_67) ;

        $setuphold(posedge CLKB &&& op133_csb_n, ENB, tENS_133, tENH_133);
        $setuphold(posedge CLKB &&& op100_csb_n, ENB, tENS_100, tENH_100);
        $setuphold(posedge CLKB &&& op67_csb_n,  ENB, tENS_67,  tENH_67) ;

        $setuphold(posedge CLKB &&& op133_enb_csb_n, W_N_RB, tENS_133, tENH_133);
        $setuphold(posedge CLKB &&& op100_enb_csb_n, W_N_RB, tENS_100, tENH_100);
        $setuphold(posedge CLKB &&& op67_enb_csb_n,  W_N_RB, tENS_67,  tENH_67) ;

        $setuphold(posedge CLKB &&& op133_enb_csb_n, MBB, tENS_133, tENH_133);
        $setuphold(posedge CLKB &&& op100_enb_csb_n, MBB, tENS_100, tENH_100);
        $setuphold(posedge CLKB &&& op67_enb_csb_n,  MBB, tENS_67,  tENH_67) ;

//spesial for FIFO4 checks----------------------
     

     $setuphold ( posedge MRST1_N &&& op133, BE_FWFT_N, tBES_133,  tBEH_133);
     $setuphold ( posedge MRST1_N &&& op100, BE_FWFT_N, tBES_100,  tBEH_100);
     $setuphold ( posedge MRST1_N &&& op67 , BE_FWFT_N, tBES_67 ,  tBEH_67 );
       
     $setuphold ( posedge MRST2_N &&& op133, BE_FWFT_N, tBES_133,  tBEH_133);
     $setuphold ( posedge MRST2_N &&& op100, BE_FWFT_N, tBES_100,  tBEH_100);
     $setuphold ( posedge MRST2_N &&& op67 , BE_FWFT_N, tBES_67 ,  tBEH_67 );
    

     $setuphold ( posedge MRST1_N &&& op133, SPM_N,     tSPMS_133, tSPMH_133);
     $setuphold ( posedge MRST1_N &&& op100, SPM_N,     tSPMS_100, tSPMH_100);
     $setuphold ( posedge MRST1_N &&& op67 , SPM_N,     tSPMS_67 , tSPMH_67 );
       
     $setuphold ( posedge MRST2_N &&& op133, SPM_N,     tSPMS_133, tSPMH_133);
     $setuphold ( posedge MRST2_N &&& op100, SPM_N,     tSPMS_100, tSPMH_100);
     $setuphold ( posedge MRST2_N &&& op67 , SPM_N,     tSPMS_67 , tSPMH_67 );

     $setup ( negedge PRST1_N &&& op133, posedge CLKA, tRSTS_133);
     $setup ( negedge PRST1_N &&& op100, posedge CLKA, tRSTS_100);
     $setup ( negedge PRST1_N &&& op67 , posedge CLKA, tRSTS_67 );
        
     $setup ( negedge PRST2_N &&& op133, posedge CLKB, tRSTS_133);
     $setup ( negedge PRST2_N &&& op100, posedge CLKB, tRSTS_100);
     $setup ( negedge PRST2_N &&& op67 , posedge CLKB, tRSTS_67 );

     $hold  ( posedge CLKB &&& op133, posedge PRST1_N, tRSTH_133);
     $hold  ( posedge CLKB &&& op100, posedge PRST1_N, tRSTH_100);
     $hold  ( posedge CLKB &&& op67 , posedge PRST1_N, tRSTH_67 );
        
     $hold  ( posedge CLKA &&& op133, posedge PRST2_N, tRSTH_133);
     $hold  ( posedge CLKA &&& op100, posedge PRST2_N, tRSTH_100);
     $hold  ( posedge CLKA &&& op67 , posedge PRST2_N, tRSTH_67 );



                
//----------------------------------------------------------------
// Retransmit Pulse-width checking 
// This check is disabled because as per the CY7C436X2AV Datasheet (dated March 19,2001)
// this parameter is removed from the spec.
//----------------------------------------------------------------

//      $width(negedge RT1_N &&& op133, tPRT_133);
//      $width(negedge RT1_N &&& op100, tPRT_100);
//      $width(negedge RT1_N &&& op67 , tPRT_67);
        
//      $width(negedge RT2_N &&& op133, tPRT_133);
//      $width(negedge RT2_N &&& op100, tPRT_100);
//      $width(negedge RT2_N &&& op67 , tPRT_67);
                
//-----------------------------------------------------------------
endspecify
//--------------------------------------------------------

