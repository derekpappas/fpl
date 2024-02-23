//--------------------------------------------------------
// CY7C436X3AV  Timing Related
//--------------------------------------------------------

//////////////
specify
//////////////

/////////////////////SWITCHING CHARACTERISTICS /////////////////////
///////////////////// OVER THE OPERATING RANGE      ////////////////
////////////////////////////////////////////////////////////////////
///"Op_rate = 133": 
/////////////////////////////
 
specparam    CLKA_HPER_133 = 3750; 
specparam	 CLKB_HPER_133 = 3750;      
specparam    tCLKA_133  = 7500 ; // min 
specparam    tCLKAH_133 = 3500 ; // min
specparam    tCLKAL_133 = 3500 ; // min
specparam    tCLKB_133  = 7500 ; // min 
specparam    tCLKBH_133 = 3500 ; // min
specparam    tCLKBL_133 = 3500 ; // min
specparam    tDS_133 	= 3000 ; // min
specparam    tENS_133   = 3000 ; // min
specparam    tRSTS_133  = 2500 ; // min 
specparam    tFSS_133   = 5000 ; // min 
specparam    tBES_133   = 5000 ; // min 
specparam    tSPMS_133  = 5000 ; // min 							  
specparam    tSDS_133   = 3000 ; // min 
specparam    tSENS_133  = 3000 ; // min 
specparam    tFES_133   = 0    ; // min 						
specparam    tDH_133    = 0    ; // min
specparam    tENH_133 	= 0    ; // min
specparam    tRSTH_133 	= 1000 ; // min
specparam    tFSH_133  	= 1000 ; // min 				
specparam    tBEH_133   = 1000 ; // min
specparam    tSPMH_133  = 1000 ; // min					
specparam    tSDH_133   = 0    ; // min
specparam    tSENH_133  = 0    ; // min	
specparam    tSPH_133 	= 0    ; // min
specparam    tSKEW1_133 = 5000 ; // min	
specparam    tSKEW2_133 = 7000 ; // min
specparam    tA_133     = 6000 ; // max
specparam    tWFF_133   = 6000 ; // max
specparam    tREF_133   = 6000 ; // max
specparam    tPAE_133   = 6000 ; // max	
specparam    tPAF_133   = 6000 ; // max
specparam    tPMF_133   = 6000 ; // max 
specparam    tPMR_133   = 7000 ; // max
specparam    tMDV_133   = 6000 ; // max
specparam    tRSF_133   = 6000 ; // max
specparam    tEN_133    = 6000 ; // max
specparam    tDIS_133   = 5000 ; // max
specparam    tPRT_133   = 60000; // min  
specparam    tRTR_133   = 90000; // min
 
// end f133
///////////////////////////////////////////// 
///"Op_rate = 100": 
////////////////////////////////////////////
 
specparam    CLKA_HPER_100 = 5000; 
specparam	 CLKB_HPER_100 = 5000;      
specparam    tCLKA_100  =10000 ; // min 
specparam    tCLKAH_100 = 4000 ; // min
specparam    tCLKAL_100 = 4000 ; // min
specparam    tCLKB_100  = 1000 ; // min 
specparam    tCLKBH_100 = 4000 ; // min
specparam    tCLKBL_100 = 4000 ; // min
specparam    tDS_100 	= 4000 ; // min
specparam    tENS_100   = 4000 ; // min
specparam    tRSTS_100  = 4000 ; // min 
specparam    tFSS_100   = 7000 ; // min 
specparam    tBES_100   = 7000 ; // min 
specparam    tSPMS_100  = 7000 ; // min 							  
specparam    tSDS_100   = 4000 ; // min 
specparam    tSENS_100  = 4000 ; // min 
specparam    tFES_100   = 0    ; // min 						
specparam    tDH_100    = 0    ; // min
specparam    tENH_100 	= 0    ; // min
specparam    tRSTH_100 	= 2000 ; // min
specparam    tFSH_100  	= 1000 ; // min 				
specparam    tBEH_100   = 1000 ; // min
specparam    tSPMH_100  = 1000 ; // min					
specparam    tSDH_100   = 0    ; // min
specparam    tSENH_100  = 0    ; // min	
specparam    tSPH_100 	= 1    ; // min
specparam    tSKEW1_100 = 5000 ; // min	
specparam    tSKEW2_100 = 8000 ; // min
specparam    tA_100     = 8000 ; // max
specparam    tWFF_100   = 8000 ; // max
specparam    tREF_100   = 8000 ; // max
specparam    tPAE_100   = 8000 ; // max	
specparam    tPAF_100   = 8000 ; // max
specparam    tPMF_100   = 8000 ; // max 
specparam    tPMR_100   =11000 ; // max
specparam    tMDV_100   = 9000 ; // max
specparam    tRSF_100   =10000 ; // max
specparam    tEN_100    = 8000 ; // max
specparam    tDIS_100   = 6000 ; // max
specparam    tPRT_100   = 60000; // min  
specparam    tRTR_100   = 90000; // min
 
//end op_rate = 100
///////////////////////////////////////////
///"Op_rate = 67": 
///////////////////////////////////////////
 
specparam    CLKA_HPER_67 = 7000; 
specparam	 CLKB_HPER_67 = 7000;      
specparam    tCLKA_67  =15000 ; // min 
specparam    tCLKAH_67 = 6000 ; // min
specparam    tCLKAL_67 = 6000 ; // min
specparam    tCLKB_67  =15000 ; // min 
specparam    tCLKBH_67 = 6000 ; // min
specparam    tCLKBL_67 = 6000 ; // min
specparam    tDS_67    = 5000 ; // min
specparam    tENS_67   = 5000 ; // min
specparam    tRSTS_67  = 5000 ; // min 
specparam    tFSS_67   = 7500 ; // min 
specparam    tBES_67   = 7500 ; // min 
specparam    tSPMS_67  = 7500 ; // min 							  
specparam    tSDS_67   = 5000 ; // min 
specparam    tSENS_67  = 5000 ; // min 
specparam    tFES_67   = 0    ; // min 						
specparam    tDH_67    = 0    ; // min
specparam    tENH_67   = 0    ; // min
specparam    tRSTH_67  = 2000 ; // min
specparam    tFSH_67   = 2000 ; // min 				
specparam    tBEH_67   = 2000 ; // min
specparam    tSPMH_67  = 2000 ; // min					
specparam    tSDH_67   = 0    ; // min
specparam    tSENH_67  = 0    ; // min	
specparam    tSPH_67   = 2    ; // min
specparam    tSKEW1_67 = 7500 ; // min	
specparam    tSKEW2_67 =12000 ; // min
specparam    tA_67     =10000 ; // max
specparam    tWFF_67   =10000 ; // max
specparam    tREF_67   =10000 ; // max
specparam    tPAE_67   =10000 ; // max	
specparam    tPAF_67   =10000 ; // max
specparam    tPMF_67   =12000 ; // max 
specparam    tPMR_67   =12000 ; // max
specparam    tMDV_67   =11000 ; // max
specparam    tRSF_67   =15000 ; // max
specparam    tEN_67    =10000 ; // max
specparam    tDIS_67   = 8000 ; // max
specparam    tPRT_67   = 60000; // min  
specparam    tRTR_67   = 90000; // min
 
// end op_rate=67

/////////////  END SWITCHING CHARACTERISTICS ///////////////////////////

//////////////// propagation delays setting ////////////////////////////

//////Path delay for FF_N_IR TO CLKA 

if(Op_rate == 100 &&( CLKA && MBA =='b0))(CLKA *> FF_N_IR) = tWFF_100; 
if(Op_rate == 133 &&( CLKA && MBA =='b0))(CLKA *> FF_N_IR) = tWFF_133; 
if(Op_rate ==  67 &&( CLKA && MBA =='b0))(CLKA *> FF_N_IR) = tWFF_67 ;



//////Path delay for EF_N_OR TO CLKB

if(Op_rate == 100)(posedge CLKB *> (EF_N_OR : CLKB)) = tREF_100; 
if(Op_rate == 133)(posedge CLKB *> (EF_N_OR : CLKB)) = tREF_133; 
if(Op_rate ==  67)(posedge CLKB *> (EF_N_OR : CLKB)) = tREF_67 ;



//////Path delay for FF_N_IR to MRS1/MRS2 negedge

if(Op_rate == 100)(negedge MRS1_N *> (FF_N_IR : MRS1_N)) = tRSF_100; 
if(Op_rate == 133)(negedge MRS1_N *> (FF_N_IR : MRS1_N)) = tRSF_133; 
if(Op_rate ==  67)(negedge MRS1_N *> (FF_N_IR : MRS1_N)) = tRSF_67 ;

//////Path delay for EF_N_OR to MRS1/MRS2 negedge

if(Op_rate == 100)(negedge MRS1_N *> (EF_N_OR: MRS1_N )) = tRSF_100; 
if(Op_rate == 133)(negedge MRS1_N *> (EF_N_OR: MRS1_N )) = tRSF_133; 
if(Op_rate ==  67)(negedge MRS1_N *> (EF_N_OR: MRS1_N )) = tRSF_67 ;

//////Path delay for AE_N to MRS1/MRS2 negedge

if(Op_rate == 100)(negedge MRS1_N *> (AE_N : MRS1_N)) = tRSF_100; 
if(Op_rate == 133)(negedge MRS1_N *> (AE_N : MRS1_N)) = tRSF_133; 
if(Op_rate ==  67)(negedge MRS1_N *> (AE_N : MRS1_N)) = tRSF_67 ;

//////Path delay for AF_N to MRS1/MRS2 negedge

if(Op_rate == 100)(negedge MRS1_N *> (AF_N : MRS1_N)) = tRSF_100; 
if(Op_rate == 133)(negedge MRS1_N *> (AF_N : MRS1_N)) = tRSF_133; 
if(Op_rate ==  67)(negedge MRS1_N *> (AF_N : MRS1_N)) = tRSF_67 ;

//////Path delay for MBF1_N to MRS1/MRS2 negedge

if(Op_rate == 100)(negedge MRS1_N *> (MBF1_N : MRS1_N)) = tRSF_100; 
if(Op_rate == 133)(negedge MRS1_N *> (MBF1_N : MRS1_N)) = tRSF_133; 
if(Op_rate ==  67)(negedge MRS1_N *> (MBF1_N : MRS1_N)) = tRSF_67 ;

//////Path delay for MBF2_N to MRS1/MRS2 negedge

if(Op_rate == 100)(negedge MRS1_N *> (MBF2_N : MRS1_N)) = tRSF_100; 
if(Op_rate == 133)(negedge MRS1_N *> (MBF2_N : MRS1_N)) = tRSF_133; 
if(Op_rate ==  67)(negedge MRS1_N *> (MBF2_N : MRS1_N)) = tRSF_67 ;

//////Path delay for FF_N_IR to PRS_N negedge

if(Op_rate == 100)(negedge PRS_N *> (FF_N_IR : PRS_N)) = tRSF_100; 
if(Op_rate == 133)(negedge PRS_N *> (FF_N_IR : PRS_N)) = tRSF_133; 
if(Op_rate ==  67)(negedge PRS_N *> (FF_N_IR : PRS_N)) = tRSF_67 ;

//////Path delay for EF_N_OR to PRS_N negedge

if(Op_rate == 100)(negedge PRS_N *> (EF_N_OR: PRS_N)) = tRSF_100; 
if(Op_rate == 133)(negedge PRS_N *> (EF_N_OR: PRS_N)) = tRSF_133; 
if(Op_rate ==  67)(negedge PRS_N *> (EF_N_OR: PRS_N)) = tRSF_67 ;

//////Path delay for AE_N to PRS_N negedge

if(Op_rate == 100)(negedge PRS_N *> (AE_N  : PRS_N)) = tRSF_100; 
if(Op_rate == 133)(negedge PRS_N *> (AE_N  : PRS_N)) = tRSF_133; 
if(Op_rate ==  67)(negedge PRS_N *> (AE_N  : PRS_N)) = tRSF_67 ;

//////Path delay for AF_N to PRS_N negedge

if(Op_rate == 100)(negedge PRS_N *> (AF_N  : PRS_N)) = tRSF_100; 
if(Op_rate == 133)(negedge PRS_N *> (AF_N  : PRS_N)) = tRSF_133; 
if(Op_rate ==  67)(negedge PRS_N *> (AF_N  : PRS_N)) = tRSF_67 ;

//////Path delay for MBF1_N to PRS_N negedge

if(Op_rate == 100)(negedge PRS_N *> (MBF1_N  : PRS_N)) = tRSF_100; 
if(Op_rate == 133)(negedge PRS_N *> (MBF1_N  : PRS_N)) = tRSF_133; 
if(Op_rate ==  67)(negedge PRS_N *> (MBF1_N  : PRS_N)) = tRSF_67 ;

//////Path delay for MBF2_N to PRS_N negedge

if(Op_rate == 100)(posedge CLKB *> (MBF2_N  : CLKB)) = tREF_100; 
if(Op_rate == 133)(posedge CLKB *> (MBF2_N  : CLKB)) = tREF_133; 
if(Op_rate ==  67)(posedge CLKB *> (MBF2_N  : CLKB)) = tREF_67 ;


//////Path delay for MBF2_N to PRS_N negedge

if(Op_rate == 100)(negedge PRS_N *> (MBF2_N  : PRS_N)) = tRSF_100; 
if(Op_rate == 133)(negedge PRS_N *> (MBF2_N  : PRS_N)) = tRSF_133; 
if(Op_rate ==  67)(negedge PRS_N *> (MBF2_N  : PRS_N)) = tRSF_67 ;

//////Path delay for MBF1_N to CLKA posedge

if(Op_rate == 100)(posedge CLKA *> (MBF1_N  : CLKA)) = tPMF_100; 
if(Op_rate == 133)(posedge CLKA *> (MBF1_N  : CLKA)) = tPMF_133; 
if(Op_rate ==  67)(posedge CLKA *> (MBF1_N  : CLKA)) = tPMF_67 ;

//////Path delay for MBF1_N to CLKB posedge

if(Op_rate == 100)(posedge CLKB *> (MBF1_N  : CLKB)) = tPMF_100; 
if(Op_rate == 133)(posedge CLKB *> (MBF1_N  : CLKB)) = tPMF_133; 
if(Op_rate ==  67)(posedge CLKB *> (MBF1_N  : CLKB)) = tPMF_67 ;

//////Path delay for MBF2_N to CLKA posedge

if(Op_rate == 100)(posedge CLKA *> (MBF2_N  : CLKA)) = tPMF_100; 
if(Op_rate == 133)(posedge CLKA *> (MBF2_N  : CLKA)) = tPMF_133; 
if(Op_rate ==  67)(posedge CLKA *> (MBF2_N  : CLKA)) = tPMF_67 ;

//////Path delay for MBF1_N to CLKB posedge

if(Op_rate == 100)(posedge CLKB *> (MBF2_N  : CLKB)) = tPMF_100; 
if(Op_rate == 133)(posedge CLKB *> (MBF2_N  : CLKB)) = tPMF_133; 
if(Op_rate ==  67)(posedge CLKB *> (MBF2_N  : CLKB)) = tPMF_67 ;


////// Data AccessTime Delays (ie. CLK to DataOut during FIFO read )////

if (op133 ) (posedge CLKA => (A : A_OUT )) = tA_133 ;
if (op100 ) (posedge CLKA => (A : A_OUT )) = tA_100 ;
if (op67  ) (posedge CLKA => (A : A_OUT )) = tA_67  ;
	
if (op133 ) (posedge CLKB => (B : OUTPUT_RG )) = tA_133  ;
if (op100 ) (posedge CLKB => (B : OUTPUT_RG )) = tA_100 ;
if (op67  ) (posedge CLKB => (B : OUTPUT_RG )) = tA_67  ;
	
///////////// DataBus Tristate  and Enable Delays //////////////// 

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

/////////////// MailBox Data AccessTime Delays /////////////////////

if (op133 && MBA) (MBA => A ) = tMDV_133 ;
if (op100 && MBA) (MBA => A ) = tMDV_100 ;
if (op67  && MBA) (MBA => A ) = tMDV_67  ;
	
if (op133 && MBB) (MBB => B ) = tMDV_133 ;
if (op100 && MBB) (MBB => B ) = tMDV_100 ;
if (op67  && MBB) (MBB => B ) = tMDV_67  ;





//////////////// setup/hold violation checking //////////////////////
//for A 
$setuphold ( posedge CLKA &&& A_cond_100, A, tDS_100, tDH_100);  
$setuphold ( posedge CLKA &&& A_cond_133, A, tDS_133, tDH_133);  
$setuphold ( posedge CLKA &&& A_cond_67 , A, tDS_67 , tDH_67 );  

//for W_RA_N
$setuphold ( posedge CLKA &&& W_RA_N_cond_100, W_RA_N, tENS_100, tENH_100);  
$setuphold ( posedge CLKA &&& W_RA_N_cond_133, W_RA_N, tENS_133, tENH_133);  
$setuphold ( posedge CLKA &&& W_RA_N_cond_67 , W_RA_N, tENS_67 , tENH_67 );  

//for W_N_RB
$setuphold ( posedge CLKB &&& W_N_RB_cond_100, W_N_RB, tENS_100, tENH_100);  
$setuphold ( posedge CLKB &&& W_N_RB_cond_133, W_N_RB, tENS_133, tENH_133);  
$setuphold ( posedge CLKB &&& W_N_RB_cond_67 , W_N_RB, tENS_67 , tENH_67 );

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


////////// CLK period and pulse width checking (high & low)////////

// FOR CLKA
   $width (posedge CLKA &&& op133, tCLKAH_133);
   $width (posedge CLKA &&& op100, tCLKAH_100);
   $width (posedge CLKA &&& op67 , tCLKAH_67 );

   $width (negedge CLKA &&& op133, tCLKAL_133);
   $width (negedge CLKA &&& op100, tCLKAL_100);
   $width (negedge CLKA &&& op67 , tCLKAL_67 );
// FOR CLKB
   $width (posedge CLKB &&& op133, tCLKBH_133);
   $width (posedge CLKB &&& op100, tCLKBH_100);
   $width (posedge CLKB &&& op67 , tCLKBH_67 );

   $width (negedge CLKB &&& op133, tCLKBL_133);
   $width (negedge CLKB &&& op100, tCLKBL_100);
   $width (negedge CLKB &&& op67 , tCLKBL_67 );

////////// Retransmit Pulse-width checking ///////////////////

//   $width (negedge RT_N &&& op133, tPRT_133);
//   $width (negedge RT_N &&& op100, tPRT_100);
//   $width (negedge RT_N &&& op67 , tPRT_67);
	
   $width (negedge RT_N &&& op133, tCLKB_133*4);
   $width (negedge RT_N &&& op100, tCLKB_100*4);
   $width (negedge RT_N &&& op67 , tCLKB_67*4);

 
//////////////// end of timing section ///////////////////////

///////////
endspecify
///////////
