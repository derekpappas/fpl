////////////////////////////////////////////////////////////////////////////////
//  File name : CY7C436X3AV_TBN_VER.v
////////////////////////////////////////////////////////////////////////////////
//  Developed by INTRINSIX CORP.
// 
// 
//
//  MODIFICATION HISTORY :
//
//  version | author            | mod date | changes made
//    V1.0     MVA               01  03 15   initial coding
//				          
////////////////////////////////////////////////////////////////////////////////
//
//  PART DESCRIPTION :
//  Purpose:test bench for CY7C436X3AV FIFO memory 
//  Library:     FIFO
//  Part:        CY7C436X3AV
//
//
////////////////////////////////////////////////////////////////////////////////
`timescale 1 ps/1 ps


module CLK_GEN ( pclk_new,pclk);


input [31:0] pclk_new;
output pclk;

/////////////////// controlled clock generator /////////////////
/// by default this clock is 150 Mhz
/// to change clock period during simulation ("on a fly") you need
/// to assign somewhere in test sequence new value to "pclk_new" variable
/// new value, for example: pclk_new = 16000 (32 Khz)

reg pclk;
reg [31:0] pclk_time;

initial begin pclk_time = 3750;  end  //133 mhz
				 
always   
  begin
   fork
     begin:pclk_gen
       if (pclk_time == 0) disable pclk_gen; 
       pclk =0;
       forever #(pclk_time)   pclk <= ~pclk;
     end
     begin
       wait ( pclk_time != pclk_new);
       disable pclk_gen;
       pclk_time = pclk_new;
     end
   join
  end

/////////////////// end of controlled clock //////////////////////
endmodule

`timescale 1 ps/1 ps

////////////////////////////////////////////////////////////////////////////////
// MODULE DECLARATION                                                         //
////////////////////////////////////////////////////////////////////////////////

module CY7C436X3AV_TBN_VER;
  

 //parameter timingmodel = "defaulttimingmodel";
 
   
   parameter FIFOSIZE = 1024;  // FIFO size for  43643 chip, m.b. 1K,4k, 16k
   parameter OP_RATE  = 133; 


// OFFSET size for  43683 chip,m.b. 10,12,14 :
parameter OFFSET_SIZE    = (FIFOSIZE == 16384) ? 14 : ((FIFOSIZE == 4096) ? 12 : 10);

////number of bits for serial programming for 43683 chip,
					    //m.b. 20,24,28 :
parameter NUMBITPROG = (FIFOSIZE == 16384) ? 28 : ((FIFOSIZE == 4096) ? 24 : 20);


   parameter FIFOWORDLENGTH = 36;  // number of bits in FIFO word
 
        wire        AE_N ;   //  Almost-Empty Flag
        wire        AF_N;    // Almost-Full Flag
        wire         CLKA;       //  Port-A clock
        wire         CLKB;       //  Port-Bclock

        reg         CSA_N;     //  Port-A Chip Select
        reg         CSB_N;     //  Port-B Chip Select
        wire        EF_N_OR;      // Empty Flag
        reg         ENA;         //  Port-A Enable
        reg         ENB;  // Port-B Enable

        wire        FF_N_IR;       // Full Flag
        reg         FS0_SD; 
        reg         BE_FWFT_N, BM;         // Flag Offset Select
        reg         FS1_SEN_N;         // Flag Offset Select

        reg         MBA, MBB;         // Port-A Mailbox Select
        reg         RT_N;
        
        
        wire        MBF1_N;     // Mail1 Register Flag
        wire        MBF2_N;             //   Mail2 Register Flag
        //reg       RST2_N;

        reg         MRS1_N,MRS2_N,PRS_N,PRS2_N;         // Reset
        reg         W_RA_N;           // Port-A Write/Read Select
        reg         W_N_RB;           // Port-B Write/Read Select
        reg         SIZE;
        reg         SPM_N;
        //reg         ENB;


	wire AEA_N;	// Port A Almost Empty Flag
	wire AEB_N;	// Port B Almost Empty Flag
	wire AFA_N;	// Port A Almost Full Flag
	wire AFB_N;	// Port B Almost Full Flag
	
	wire EFA_N_ORA;	// Port A Empty/Output Ready Flag
	wire EFB_N_ORB;	// Port B Empty/Output Ready Flag
	wire FFA_N_IRA;	// Port A Full/Input Ready Flag
	wire FFB_N_IRB;	// Port B Full/Input Ready Flag
			
      wire MBF1_N2   ; 	// Mail1 Register Flag
	wire MBF2_N2   ; 	// Mail2 Register Flag
			
			
			



			
  
        wire [0:FIFOWORDLENGTH-1] A; // PORT A DATA
        wire [0:FIFOWORDLENGTH-1] B; // PORT B DATA
        reg  [0:FIFOWORDLENGTH-1] ATEST;
        reg  [0:FIFOWORDLENGTH-1] BTEST;


        
   wire [0:8] B9_B17,B0_B8,B27_B35,B18_B26;

   assign   B27_B35 = B[27:35]; 
   assign   B18_B26 = B[18:26];
   assign   B9_B17  = B[ 9:17];
   assign   B0_B8   = B[ 0: 8]; 
   
   integer WriteNo, Limit, LimitB;
   //reg [0:2] SIZE_BE;
   
   wire [0:8] A27_A35,A18_A26,A9_A17,A0_A8;
   
   assign   A27_A35 =  A[27:35]; 
   assign   A18_A26 =  A[18:26]; 
   assign   A9_A17  =  A[ 9:17];
   assign   A0_A8   =  A[ 0: 8]; 
   
        assign A = ATEST;          
        assign B = BTEST;

   wire [0:8] B9_B17R,B0_B8R,B27_B35R,B18_B26R;

   
   
   wire [0:8] A27_A35R,A18_A26R,A9_A17R,A0_A8R;
   
   



   reg [0:31] test_num;

//////////// GENERATORS TIMES//////////////////////////

reg [31:0] tCLKA_HPER ,tCLKB_HPER ; //half period times

/////////////// TIMES ///////////////////////

 reg [8*4:1] DeviceType ; //range of device MAX frequency
    
 reg [31:0]  tDelta;  // INSERT VIOLATION
 reg [31:0]  tDeltaCLKA;  // INSERT VIOLATION
 reg [31:0]  tDeltaCLKB;  // INSERT VIOLATION


reg [31:0]      tCLKA   ; // min 
reg [31:0]      tCLKAH  ; // min
reg [31:0]      tCLKAL  ; // min

reg [31:0]      tCLKB   ; // min 
reg [31:0]      tCLKBH  ; // min
reg [31:0]      tCLKBL  ; // min

reg [31:0]      tDS     ; // min
reg [31:0]      tENS    ; // min
reg [31:0]      tRSTS   ; // min 
reg [31:0]      tFSS    ; // min 
reg [31:0]      tBES    ; // min 
reg [31:0]      tSPMS   ; // min 							  
reg [31:0]      tSDS    ; // min 
reg [31:0]      tSENS   ; // min 
reg [31:0]      tFWS    ; // min 						
reg [31:0]      tDH     ; // min
reg [31:0]      tENH    ; // min
reg [31:0]      tRSTH   ; // min
reg [31:0]      tFSH    ; // min 				
reg [31:0]      tBEH    ; // min
reg [31:0]      tSPMH   ; // min					
reg [31:0]      tSDH    ; // min
reg [31:0]      tSENH   ; // min	
reg [31:0]      tSPH    ; // min
reg [31:0]      tSKEW1  ; // min	
reg [31:0]      tSKEW2  ; // min
reg [31:0]      tA      ; // max
reg [31:0]      tWFF    ; // max
reg [31:0]      tREF    ; // max
reg [31:0]      tPAE    ; // max	
reg [31:0]      tPAF    ; // max
reg [31:0]      tPMF    ; // max 
reg [31:0]      tPMR    ; // max
reg [31:0]      tMDV    ; // max
reg [31:0]      tRSF    ; // max
reg [31:0]      tEN     ; // max
reg [31:0]      tDIS    ; // max
reg [31:0]      tPRT    ; // min  
reg [31:0]      tRTR    ; // min

///////////////INITIAL FOR DEVICE TYPE ///////////////////////

initial begin DeviceType ="f133"; end

initial 
  begin 
/////////////////////////////////////////////////////////////
//////////// INITIAL FOR TIME CHECKING //////////////////////
/////////////////////////////////////////////////////////////
tDelta =  000 ;
tDeltaCLKA = 000 ;
tDeltaCLKB = 000 ;

case ( DeviceType )
 
"f100": 
 begin      
//////////// INITIAL FOR GENERATOR TIMES/////////////////
 
    tCLKA_HPER = 5000; 
    tCLKB_HPER = 5000;      
      
 ///////////////INITIAL FOR TIMES ///////////////////////
 
    tCLKA  =10000 ; // min 
    tCLKAH = 4000 ; // min
    tCLKAL = 4000 ; // min
    tCLKB  = 1000 ; // min 
    tCLKBH = 4000 ; // min
    tCLKBL = 4000 ; // min
    tDS 	= 4000 ; // min
    tENS   = 4000 ; // min
    tRSTS  = 4000 ; // min 
    tFSS   = 7000 ; // min 
    tBES   = 7000 ; // min 
    tSPMS  = 7000 ; // min 							  
    tSDS   = 4000 ; // min 
    tSENS  = 4000 ; // min 
    tFWS   = 0    ; // min 						
    tDH    = 0    ; // min
    tENH 	= 0    ; // min
    tRSTH 	= 2000 ; // min
    tFSH  	= 1000 ; // min 				
    tBEH   = 1000 ; // min
    tSPMH  = 1000 ; // min					
    tSDH   = 0    ; // min
    tSENH  = 0    ; // min	
    tSPH 	= 1    ; // min
    tSKEW1 = 5000 ; // min	
    tSKEW2 = 8000 ; // min
    tA     = 8000 ; // max
    tWFF   = 8000 ; // max
    tREF   = 8000 ; // max
    tPAE   = 8000 ; // max	
    tPAF   = 8000 ; // max
    tPMF   = 8000 ; // max 
    tPMR   =11000 ; // max
    tMDV   = 9000 ; // max
    tRSF   =10000 ; // max
    tEN    = 8000 ; // max
    tDIS   = 6000 ; // max
    tPRT   = 60000; // min  
    tRTR   = 90000; // min
 
end //op_rate = 100
///////////////////////////////////////////
///"Op_rate = 67": 
///////////////////////////////////////////

"f67": 
 begin      

//////////// INITIAL FOR GENERATOR TIMES/////////////////
 
    tCLKA_HPER = 7000; 
	 tCLKB_HPER = 7000; 

 ///////////////INITIAL FOR TIMES ///////////////////////
     
    tCLKA  =15000 ; // min 
    tCLKAH = 6000 ; // min
    tCLKAL = 6000 ; // min
    tCLKB  =15000 ; // min 
    tCLKBH = 6000 ; // min
    tCLKBL = 6000 ; // min
    tDS    = 5000 ; // min
    tENS   = 5000 ; // min
    tRSTS  = 5000 ; // min 
    tFSS   = 7500 ; // min 
    tBES   = 7500 ; // min 
    tSPMS  = 7500 ; // min 							  
    tSDS   = 5000 ; // min 
    tSENS  = 5000 ; // min 
    tFWS   = 0    ; // min 						
    tDH    = 0    ; // min
    tENH   = 0    ; // min
    tRSTH  = 2000 ; // min
    tFSH   = 2000 ; // min 				
    tBEH   = 2000 ; // min
    tSPMH  = 2000 ; // min					
    tSDH   = 0    ; // min
    tSENH  = 0    ; // min	
    tSPH   = 2    ; // min
    tSKEW1 = 7500 ; // min	
    tSKEW2 =12000 ; // min
    tA     =10000 ; // max
    tWFF   =10000 ; // max
    tREF   =10000 ; // max
    tPAE   =10000 ; // max	
    tPAF   =10000 ; // max
    tPMF   =12000 ; // max 
    tPMR   =12000 ; // max
    tMDV   =11000 ; // max
    tRSF   =15000 ; // max
    tEN    =10000 ; // max
    tDIS   = 8000 ; // max
    tPRT   = 60000; // min  
    tRTR   = 90000; // min
 
 end //op_rate=67

////////////////////////////////////////////////////////////////////
///"Op_rate = 133": 
/////////////////////////////
 
"f133": 
 begin      
//////////// INITIAL FOR GENERATOR TIMES/////////////////
 
    tCLKA_HPER = 3750; 
	 tCLKB_HPER = 3750;      
      
 ///////////////INITIAL FOR TIMES ///////////////////////
 
    tCLKA  = 7500 ; // min 
    tCLKAH = 3500 ; // min
    tCLKAL = 3500 ; // min
    tCLKB  = 7500 ; // min 
    tCLKBH = 3500 ; // min
    tCLKBL = 3500 ; // min
    tDS 	= 3000 ; // min
    tENS   = 3000 ; // min
    tRSTS  = 2500 ; // min 
    tFSS   = 5000 ; // min 
    tBES   = 5000 ; // min 
    tSPMS  = 5000 ; // min 							  
    tSDS   = 3000 ; // min 
    tSENS  = 3000 ; // min 
    tFWS   = 0    ; // min 						
    tDH    = 0    ; // min
    tENH 	= 0    ; // min
    tRSTH 	= 1000 ; // min
    tFSH  	= 1000 ; // min 				
    tBEH   = 1000 ; // min
    tSPMH  = 1000 ; // min					
    tSDH   = 0    ; // min
    tSENH  = 0    ; // min	
    tSPH 	= 0    ; // min
    tSKEW1 = 5000 ; // min	
    tSKEW2 = 7000 ; // min
    tA     = 6000 ; // max
    tWFF   = 6000 ; // max
    tREF   = 6000 ; // max
    tPAE   = 6000 ; // max	
    tPAF   = 6000 ; // max
    tPMF   = 6000 ; // max 
    tPMR   = 7000 ; // max
    tMDV   = 6000 ; // max
    tRSF   = 6000 ; // max
    tEN    = 6000 ; // max
    tDIS   = 5000 ; // max
    tPRT   = 60000; // min  
    tRTR   = 90000; // min
 
    end //f133
//////////////////////////////////////////////////// 
  endcase
end //INITIAL									  
/////////////END OF INITIAL TIMES///////////////////

////////////////////////////////////////////////////
CLK_GEN CLK_A_GEN (tCLKA_HPER-tDeltaCLKA, CLKA );

CLK_GEN CLK_B_GEN (tCLKB_HPER-tDeltaCLKB, CLKB);

/////////////////////// TASKS //////////////////////
/////////////////////// BEGIN //////////////////////
integer error;   
   task Set_Timing_mode;
   
   input BE_FWFT_Nval;     // =1 if CY-Standard mode, =0 if FWFT
   
   begin 
    @(negedge CLKA);
    #(tCLKAH   - (tRSTS - tDelta));
    BE_FWFT_N  = BE_FWFT_Nval;
    @(negedge CLKA);
   end
  endtask  
    


   task Reset_FIFO;
   
    //  Reset sequence implements Master reset for FIFO.
    // This procedure produce reset signal RST1_N:
    // set it to 0 after TCLKL-tRSTSval ns,
    // set it to 1 after NPULSE edges of CLKA  and CLKB signal,
    // set FSO and FS1 signals to FS0val ,FS1val state
    // MODEval- sets BE_FWFT_N after Reset, if =1 CY-Standard mode, =0 if FWFT mode
  
     input FS1val, FS0val;     // allmost full, empty values
     input SPMNval;            // SPM =1, if parallel programming,=0 if serial
     input BE_FWFT_Nval;       // BE_FWFT_N: =1 if Big Endian, =0 if Little Endian
     input MODEval;            // after Reset, if =1 CY-Standard mode, =0 if FWFT mode
     input BMval;             //BUS MUTCH
     input SIZEval;
              
              
    begin   
      test_num =test_num + 1;
      $display ("Time = %0d. Test pattern %0d.\n ", $time, test_num);
      @(negedge CLKA);
      SPM_N =SPMNval;
	BM    <= # (tCLKAH - (tENS-tDelta)) BMval;
      SIZE  <= # (tCLKAH - (tENS-tDelta)) SIZEval;

      if (!MODEval) CSB_N = 0;
      @(negedge CLKA);
      MRS1_N = 1;PRS_N = 1;
fork
      @(negedge CLKA);
      @(negedge CLKB);
join
      #(tCLKAH  - (tRSTS -tDelta));
      MRS1_N = 0;
      MRS2_N = 0;

      BE_FWFT_N  = #(tBES) BE_FWFT_Nval;
      // mva repeat (3)  @ (posedge CLKA);
      repeat (5)
fork  
    @ (posedge CLKA);    
    @ (posedge CLKB);
join
      #(tCLKA  - (tBES-tDelta));
      BE_FWFT_N = MODEval;  //set MODE

    //@ (posedge CLKA);
      FS0_SD   =  FS0val ;
      FS1_SEN_N  =  FS1val ;

      @ (posedge CLKA);
      #(tRSTH - tDelta);
      
      BE_FWFT_N = MODEval;  //set MODE

      MRS1_N = 1; MRS2_N = 1;

      //#3 BE_FWFT_N = MODEval;
      //BE_FWFT_N = MODEval;  //set MODE
   
	//repeat (2) 
      // @ (posedge CLKA);

       if ( !FF_N_IR && !EF_N_OR && 
            AF_N && !AE_N  && MBF1_N && MBF2_N )
       begin 
          repeat (3) @ (posedge CLKA);
          #tWFF;
          if (FF_N_IR ) $display ("  FIFO  RESET is succesful.");
          else $display (" FIFO RESET: FF_N_IR is not installed.");

       end
       else 
       begin
          if (!( !FF_N_IR && !EF_N_OR && 
                 AF_N && !AE_N  && MBF1_N && MBF2_N ))
          begin 
              $display (" FIFO RESET is failed.FF_N_IR= %0b. EF_N_OR= %0b. AF_N= %0b. AE_N= %0b\n ", FIFO.FF_N_IR,FIFO.EF_N_OR,FIFO.AF_N,FIFO.AE_N); 
              error =1;
          end

       end
    


     # 100;
    end
   endtask 


    
    
   task Reset_FIFO_B;
   
    //  Reset sequence implements Master reset for FIFO.
    // This procedure produce reset signal RST1_N:
    // set it to 0 after TCLKL-tRSTSval ns,
    // set it to 1 after NPULSE edges of CLKA  and CLKB signal,
    // set FSO and FS1 signals to FS0val ,FS1val state
    // MODEval- sets BE_FWFT_N after Reset, if =1 CY-Standard mode, =0 if FWFT mode
  
     input FS1val, FS0val;     // allmost full, empty values
     input SPMNval;            // SPM =1, if parallel programming,=0 if serial
     input BE_FWFT_Nval;       // BE_FWFT_N: =1 if Big Endian, =0 if Little Endian
     input MODEval;            // after Reset, if =1 CY-Standard mode, =0 if FWFT mode
     input BMval;             //BUS MUTCH
     input SIZEval;
              
    begin   
      test_num =test_num + 1;
      $display ("Time = %0d. Test pattern %0d.\n ", $time, test_num); 
      @(negedge CLKB);
      SPM_N =SPMNval;
	BM    <= # (tCLKBH - (tENS-tDelta)) BMval;
      SIZE  <= # (tCLKBH - (tENS-tDelta)) SIZEval;

      if (!MODEval) CSB_N = 0;
      @(negedge CLKB);
      MRS1_N = 1;PRS_N = 1;
      @(negedge CLKB);
      BE_FWFT_N  = BE_FWFT_Nval;
      #(tCLKBH  - (tRSTS -tDelta));
      MRS1_N = 0;MRS2_N = 0;

      repeat (5)  @ (posedge CLKB);
    
    @ (posedge CLKB);

      #(tCLKB  - (tBES-tDelta));
      BE_FWFT_N = MODEval;  //set MODE

      FS0_SD   =  FS0val ;
      FS1_SEN_N  =  FS1val ;

      @ (posedge CLKB);
      #(tRSTH - tDelta);
      
      BE_FWFT_N = MODEval;  //set MODE

      MRS1_N = 1; MRS2_N = 1;


       if  ( !FF_N_IR && !EF_N_OR && 
            AF_N && !AE_N  && MBF1_N && MBF2_N )
       begin 
          repeat (3) @ (posedge CLKB);
          #tWFF;
          if (FF_N_IR ) $display ("  FIFO  RESET is succesful.");
          else $display (" FIFO RESET: FF_N_IR is not installed.");

       end
       else 
       begin
          if (!( !FF_N_IR && !EF_N_OR && 
                 AF_N && !AE_N  && MBF1_N && MBF2_N ))
          begin 
              $display (" FIFO RESET is failed.FF_N_IR= %0b. EF_N_OR= %0b. AF_N= %0b. AE_N= %0b\n ", FIFO.FF_N_IR,FIFO.EF_N_OR,FIFO.AF_N,FIFO.AE_N); 
              error =1;
          end

       end
    


     # 100;
    end
   endtask 



   

    task Par_Reset_FIFO;
   
    //  Reset sequence controlled by TWO clocks:CLKA,CLKB.
    // This procedure produce reset signal RST1_N:
    // set it to 0 after TCLKL-tRSTSval ns,
    // set it to 1 after NPULSE edges of CLKA  and CLKB signal,
    // set FSO and FS1 signals to FS0val ,FS1val state
  
     input FS1val, FS0val;      // allmost full, empty values
     input SPMNval, BE_FWFT_Nval;
   
    begin 
      test_num = test_num + 1;
      $display ("Time = %0d. Test pattern %0d.\n ", $time, test_num); 
       @(negedge CLKA);
      SPMNval =SPMNval;
      SIZE =1;
      @(negedge CLKA);
      PRS_N = 1;MRS1_N = 1; MRS2_N = 1;
      @(negedge CLKA);
      #(tCLKAH - (tRSTS-tDelta));
      PRS_N  = 0;
      repeat ( 4)  @ (posedge CLKB);
      FS0_SD   =  FS0val ;
      FS1_SEN_N  =  FS1val ;
      BE_FWFT_N  =  BE_FWFT_Nval;
      @ (posedge CLKB);
      #(tRSTH - tDelta);
      
      PRS_N = 1; 

       if (!FF_N_IR && !EF_N_OR && 
            AF_N && !AE_N  && MBF1_N )
       begin 
         repeat (3) @ (posedge CLKB);
         if (FF_N_IR ) $display ("Partial  FIFO  RESET is succesful.");
         else $display ("Partial FIFO RESET: FF_N_IR is not installed.");
       end
     else 
     begin 
     $display ("Partial  FIFO RESET is failed."); 
     error =1;
     end
     # 100;
    end
   endtask 

task MRST;
begin
 MRS1_N =1; 
 MRS2_N=1;
 PRS_N  =1;
 #(tCLKA);
@( negedge CLKA ) ;

#(tCLKA_HPER -(tRSTS -tDelta ));
 
 MRS1_N = 0;MRS2_N= 0;
 repeat (5) @( posedge CLKA) ;
@( negedge CLKA) ;
 MRS1_N =1; MRS2_N=1;


 if( (FF_N_IR !== 0) || (EF_N_OR  !== 0)|| (AE_N  !== 0) ||
     (AF_N    !== 1) || (MBF1_N   !== 1)|| (MBF2_N!== 1))
  begin 
   $display("Time =%0t.ERROR: MASTER RESET:Verilog model outputs are not in proper state.",$time);  
   error =1;
  end

/*
 if( (FF_N_IR !== 0) || (EF_N_OR !== 0) || (AE_N !== 0) || (AF_N !== 0)|| (MBF1_N   !== 1)  || (MBF2_N   !== 1)    )
  begin 
   $display("Time =%0t.ERROR: MASTER RESET:VHDL model outputs are not in proper state.",$time);  
   error =1;
  end
*/
  if(error ==0) $display("Time =%0t. MASTER RESET done.", $time);
  #5;
end
endtask

task PRST;
begin
 MRS1_N =1; MRS2_N=1;
 PRS_N  =1;
 #(tCLKA);
@( posedge CLKA) ;

#(tCLKA_HPER -(tRSTS - tDelta));
 PRS_N = 0;
 repeat (5) @( posedge CLKA) ;

 PRS_N =1; 
 

 if( (FF_N_IR !== 0) || (EF_N_OR !== 0) || (AE_N !== 0) || (AF_N !== 1)|| (MBF1_N   !== 1)  || (MBF2_N   !== 1)    )
  begin 
   $display("Time =%0t.ERROR: PARTIAL RESET:Verilog model outputs are not in proper state.",$time);  
   error =1;
  end

/*
 if( (FF_N_IR !== 0) || (EF_N_OR !== 0) || (AE_N !== 0) || (AF_N !== 0)|| (MBF1_N   !== 1)  || (MBF2_N   !== 1)    )
  begin 
   $display("Time =%0t.ERROR: PARTIAL RESET:VHDL model outputs are not in proper state.",$time);  
   error =1;
  end
*/
  if(error ==0) $display("Time =%0t. PARTIAL RESET done.", $time);
  #5;
end
endtask

task DEF_OFFSET;
input [31:0] OFFSET;
begin 
 @(posedge MRS1_N );
if (OFFSET == 64)
begin
  SPM_N =1;
  FS1_SEN_N =1;
  FS0_SD =1;
end
else if(OFFSET ==16)
begin
  SPM_N =1;
  FS1_SEN_N =1;
  FS0_SD =0;
end
else if(OFFSET ==8)
begin
  SPM_N =1;
  FS1_SEN_N =0;
  FS0_SD =1;
end
 @(posedge CLKA);

 if(OFFSET === CY7C436X3AV_TBN_VER.FIFO.X ) 
$display ("Time =%0t.Verilog: DEFAULT OFFSET: X=%d,Y=%d.",
         $time, CY7C436X3AV_TBN_VER.FIFO.X ,CY7C436X3AV_TBN_VER.FIFO.Y);
 else
   begin
    
   $display ("Time =%0t.ERROR:Verilog: DEFAULT OFFSET: OFFSET=%d, X=%d,Y=%d.",
		$time, OFFSET, CY7C436X3AV_TBN_VER.FIFO.X, CY7C436X3AV_TBN_VER.FIFO.Y );
    error =1;
   end
end
endtask

task PAR_PROG_OFFSET;  // 
input [OFFSET_SIZE-1:0] OFFSET_X, OFFSET_Y; 
input [0:FIFOWORDLENGTH-1] FIRST_WORD;
begin 
ENA=0;
CSA_N=0;
W_RA_N=1;
MBA=0;
SPM_N=0;
 @(negedge MRS1_N);
//#(tCLKA-(tFSS-tDelta));
repeat (3)@(posedge CLKA);

   SPM_N=1;
   FS1_SEN_N = 0;
   FS0_SD = 0;
@(posedge MRS1_N);
#(tFSH-tDelta);
   SPM_N=0;
   FS1_SEN_N = 1;
   FS0_SD = 1;
repeat(2)@(posedge CLKA);
#(tCLKA -(tDS-tDelta));
   ENA=1;
   ATEST =OFFSET_Y;
@(posedge CLKA);
#(1+tDH );
   ENA=0;
   ATEST=36'hZZZZZZZZZ;
@(negedge CLKA)
#(tCLKA_HPER -(tENS-tDelta));
   ENA=1;
   ATEST=OFFSET_X;
@(posedge CLKA);
#(10+tENH);
   ENA=0;
   ATEST=36'hZZZZZZZZZ;
@(negedge CLKA)
#(tCLKA_HPER -(tENS-tDelta));
   ENA=1;
   ATEST=FIRST_WORD; 
@(posedge CLKA);
#(tENH);
   ENA=0;
   ATEST=36'hZZZZZZZZZ;

 if(OFFSET_X === CY7C436X3AV_TBN_VER.FIFO.X && 
    OFFSET_Y === CY7C436X3AV_TBN_VER.FIFO.Y //&& 
    //OFFSET_X === CY7C436X3AV_TBN_VER.FIFO.X &&  
   ) 
$display ("Time =%0t.Verilog: PARALLEL PROGRAMMING OFFSET: X=%d,Y=%d.",
         $time, CY7C436X3AV_TBN_VER.FIFO.X ,CY7C436X3AV_TBN_VER.FIFO.Y);
 else
   begin
    
   $display ("Time =%0t.ERROR:Verilog: PARALLEL PROGRAMMING  OFFSET: OFFSET_X=%d, X=%d,OFFSET_Y=%d, Y=%d.",
		$time, OFFSET_X, CY7C436X3AV_TBN_VER.FIFO.X, OFFSET_Y, CY7C436X3AV_TBN_VER.FIFO.Y );
   error =1;
   end

end
endtask


task SER_PROG_OFFSET;  //p.10
input [0:NUMBITPROG/2 -1] OFFSET_X, OFFSET_Y; 
input [0:FIFOWORDLENGTH-1] FIRST_WORD;
integer i,j;

 begin 
  SPM_N=1;
  FS1_SEN_N = 1;
  FS0_SD = 1;
 @(negedge MRS1_N);
 repeat(3) @(posedge CLKA);
 #(tCLKA-(tFSS-tDelta));
   FS1_SEN_N = 1;
   FS0_SD = 0;
   SPM_N=0;
 @(posedge MRS1_N);
 #(tSPH-tDelta);
   FS1_SEN_N = 0;
 #(tFSH - (tSPH-tDelta));
   FS0_SD = 1;
   SPM_N=1;
 for (j=0;j <= NUMBITPROG/2 -1;j=j+1)
 begin
   @(negedge CLKA);
   #(tCLKA_HPER -(tSENS-tDelta));
     FS1_SEN_N = 0;
     FS0_SD = OFFSET_Y [j]; //next bit of offset Y value
   @(posedge CLKA);
   #(tSENH);
   FS1_SEN_N =  1;
   FS0_SD    ='b1;
 end

 for (i=0; i < NUMBITPROG/2;i=i+1)
 begin
    @(negedge CLKA);
   #(tCLKA_HPER -(tSENS-tDelta));
     FS1_SEN_N = 0;
     FS0_SD = OFFSET_X [i]; //next bit of offset X value
   @(posedge CLKA);
   #(tSENH);
   FS1_SEN_N =  1;
   FS0_SD    ='b1;
 end

@(posedge CLKA);


 if(OFFSET_X === CY7C436X3AV_TBN_VER.FIFO.X && 
    OFFSET_Y === CY7C436X3AV_TBN_VER.FIFO.Y //&& 
    //OFFSET_X === CY7C436X3AV_TBN_VER.FIFO.X &&  
   ) 
$display ("Time =%0t.Verilog: SERIAL PROGRAMMING  OFFSET: X=%d,Y=%d.",
         $time, CY7C436X3AV_TBN_VER.FIFO.X ,CY7C436X3AV_TBN_VER.FIFO.Y);
 else
   begin
    
   $display ("Time =%0t.ERROR:Verilog: SERIAL PROGRAMMING  OFFSET: OFFSET_X=%d, X=%d,OFFSET_Y=%d, Y=%d.",
		$time, OFFSET_X, CY7C436X3AV_TBN_VER.FIFO.X, OFFSET_Y,  CY7C436X3AV_TBN_VER.FIFO.Y );
   	error =1;
	end

end
endtask

//////////////////////////////////////  ////////////////////////////////////////

  
   task Ser_write_offset;
   
    input [NUMBITPROG :1] Y_X_val;
    
    integer Num;
    
    begin 
      test_num =test_num + 1;
      $display ("Time = %0d. Test pattern %0d.\n ", $time, test_num);
     @(negedge CLKA);
      Num = NUMBITPROG;
    repeat ( NUMBITPROG) 
     begin
      @(negedge CLKA);
      FS1_SEN_N = 0; FS0_SD = Y_X_val[ Num ];
      @(posedge CLKA);
      Num = Num -1;
     end
     repeat ( 4) @(posedge CLKA);
     if ((FIFO.Y == Y_X_val[NUMBITPROG     :NUMBITPROG*3/4 +1]) &&
         (FIFO.X == Y_X_val[NUMBITPROG*3/4 :NUMBITPROG/2+1]))  
          $display (" Serial programing of Offset Regs is succesful.");
     else 
	begin
	$display (" Serial programing of Offset Regs is failed.");
	error =1;
      end
    end 
   endtask 
    

    
    
    
   task Write_A ;
   
     //  Writes long words
     // It sets CSA_N,W_RA_N,ENA, MBA  and assigns
     // to ATEST values 1,2,3,... , subsequently
     
    input [31:0] WordAmount;
       
    reg [0:35] I;
   begin
     I = 1;test_num = test_num +1; 
      $display ("Time = %0d. Test pattern %0d.\n ", $time, test_num); 
   @(negedge CLKA);   
     BM =0;
     repeat ( WordAmount)
     begin
      @(negedge CLKA);
       {CSA_N,W_RA_N,ENA, MBA} <= # (tCLKA_HPER - (tENS-tDelta)) 'b0110;
       ATEST= I; 
       I = I + 1;
      @(posedge CLKA);
       {ENA, MBA} <= # (tENH) 'bXX;
     end 
    # (tDH) ATEST = 36'hZZZZZZZZZ;
    @(negedge CLKA);
      ENA <= # ( tCLKA_HPER - (tENS-tDelta)) 0;
    @(posedge CLKA);
      ENA <= # ( tENH) 'bX; 
    # (tENH); {CSA_N,W_RA_N,MBA} <=  'b1XX;    
  end
 endtask
 

/*
   task Write_B ;
   
     //  Writes long words (BM=0);
     // It sets CSB_N,W_N_RB,ENB,...  and assigns
     // to ATEST values 1,2,3,... , subsequently
    
     
    input [31:0] WordAmount;
    
        
    reg [0:35] I;
   begin
     I = 1;test_num = test_num +1; 
      $display ("Time = %0d. Test pattern %0d.\n ", $time, test_num); 
   @(negedge CLKB);   
   BM=0; 
   repeat ( WordAmount)
     begin
      @(negedge CLKB);
      {CSB_N,W_N_RB,ENB} <= # ( tCLKB_HPER - (tENS-tDelta)) 'b001;
      MBB <= # ( tCLKB_HPER - (tENS-tDelta)) 'b0;
      BTEST= I; 
      I = I + 1;
      @(posedge CLKB);
      {ENB} <= # (tENH) 'bX;      
     end 
    # (tDH) BTEST = 36'hZZZZZZZZZ;
    @(negedge CLKB);
      ENB <= # (tCLKB_HPER - (tENS-tDelta)) 0;
     @(posedge CLKB);
      ENB <= # ( tENH) 'bX; 
     {CSB_N,W_N_RB} <= # ( tENH) 'b1X;    
  end
 endtask
*/ 

 
  reg [0:35] OutReg;
  wire [31 :0] A_inf,A_exp,B_inf, B_exp,C_inf; 
 assign A_inf = { A[27:34], A[18:26], A[9:17], A[0:8]};
 assign B_inf = { B[27:35], B[18:26], B[9:17], B[0:8]};
 assign A_exp = {OutReg[27:35], OutReg[18:26], OutReg[9:17],OutReg [0:8]};
  
  
 task Read_B ;
   
     //  Long words Read procedure (BM=0)
     //  It sets CSA_N,W_N_RB,ENB, MBB  
     //  WordAmount number of values on B bus
     //  Values should be: BegValue, BegValue +1, BegValue+2 ... 
     
     
    input [31:0] WordAmount;
    input [0:35] BegValue;
    
    
    
    reg [0:35] I;
    
   begin
     I = BegValue; test_num = test_num +1;
     OutReg= I;  
     $display ("Time = %0d. Test pattern %0d.\n ", $time, test_num); 
     @(negedge CLKB);
     BM =0;
     
     @(negedge CLKB);
     MBB <= # ( tCLKAH - (tENS-tDelta)) 'b0;
     @(negedge CLKB);
     {CSB_N,W_N_RB} <= # (  tCLKAH - (tENS-tDelta)) 'b01;
     @(negedge CLKB);
       
    repeat ( WordAmount)
     begin
      ENB <= # ( tCLKAH - (tENS-tDelta)) 'b1;
      @(posedge CLKB);
      ENB <= # ( tENH) 'bX;
      if (FIFO.FIFO_STD_MODE)
        # (tA+2) if ( (B !== OutReg) && EF_N_OR) $display ( 
        " Time= %0d. Test pattern %0d.\n Read FIFO value is not equal to expected.\n Expected = %h. Read = %h.", 
        $time, test_num,OutReg, B);
      else
       begin
        if ( (B !== OutReg) && EF_N_OR) $display ( 
        " Time= %0d. Test pattern %0d.\n Read FIFO value is not equal to expected.\n Expected = %h. Read = %h.", 
        $time, test_num,OutReg, B); 
        # (tA+2) 
	  if ( (B !== OutReg) && EF_N_OR) 
        begin   
	     $display (" Time= %0d. Test pattern %0d.\n Read FIFO value is not equal to expected.\n Expected = %h. Read = %h.", 
                     $time, test_num,OutReg, B);
	     error =1;
	  end
    end
        
      @(negedge CLKB);
      I=I+1; OutReg= I; 
     end  
     @(negedge CLKB);
      ENB <= # ( tCLKAH - (tENS-tDelta)) 0;
     @(posedge CLKB);
      ENB <= # ( tENH) 'bX; 
      {CSB_N,W_N_RB} = # ( tENH) 'b10;    
   end
 endtask
 
 
 
 task Read_A ;
   
     //  reads long words
     //  It sets CSA_N,W_RA_N,ENA, MBA  and checks
     //  WordAmount number of values on B bus
     //  Values should be: BegValue, BegValue +1, BegValue+2 ... 
     
    input [31:0] WordAmount;
    input [0:35] BegValue;
    input PGAval;
    input OddEvenSelect;
     
    reg [0:35] I;
    
   begin
     I = BegValue; test_num = test_num +1;
     OutReg= I;  
     $display ("Time = %0d. Test pattern %0d.\n ", $time, test_num); 
     @(negedge CLKA);
     
     @(negedge CLKA);
     MBA   <= # ( tCLKAH - (tENS-tDelta)) 0;

     @(negedge CLKA);
     {CSA_N,W_RA_N} <= # ( tCLKAH - (tENS-tDelta)) 'b00;
     @(negedge CLKA);
       
    repeat ( WordAmount)
     begin
      ENA <= # ( tCLKAH - (tENS-tDelta)) 'b1;
      @(posedge CLKA);
      ENA <= # ( tENH) 'bX;
      if (FIFO.FIFO_STD_MODE)
      # (tA+2) if ( (A !== OutReg) && EF_N_OR) $display ( 
      " Time= %0d. Test pattern %0d.\n Read FIFO(CY mode) value is not equal to expected.\n Expected = %h. Read = %h.", 
       $time, test_num,OutReg, A);
      else if ( (A !== OutReg) && EF_N_OR) $display ( 
        " Time= %0d. Test pattern %0d.\n Read FIFO value (FWFT mode)is not equal to expected.\n Expected = %h. Read = %h.", 
        $time, test_num,OutReg, A);
      @(negedge CLKA);
      I=I+1; OutReg= I; 
     end  
     @(negedge CLKA);
      ENA <= # ( tCLKAH - (tENS-tDelta)) 0;
     @(posedge CLKA);
      ENA <= # ( tENH) 'bX; 
      {CSA_N,W_RA_N} = # ( tENH) 'b11;    
   end
 endtask
 
  integer ReadNo;
 
  
  
 
 
 reg [0:35]  OutReg2; 
  
 
 

 
 task EFBCheckflagTiming;
   
      // Before this proc. execution FIFO must be in Empty state.
     
     // It writes value FFFFFF....., in  FIFO,
     // Then - attempt to read and checking the states 
     // of B bus and EFN flag     
   
    integer Error; 
    reg [0:35] Bexp; 
    reg Flag;
     
    begin 
     @(posedge CLKB);  
     test_num = test_num +1; CSB_N <= #(tENH) 0;
     $display ("Time = %0d. Test pattern %0d.\n ", $time, test_num);
     W_N_RB <= #(tENH) 1; Error =0; Bexp = 36 'hZZZZZZZZZ;
     @(negedge CLKA);
      CSA_N <= # ( tCLKAH - (tENS-tDelta)) 0;
      W_RA_N    <= # ( tCLKAH - (tENS-tDelta)) 1;     // writing word
      ENA    <= # ( tCLKAH - (tENS-tDelta)) 1;
      MBA    <= # ( tCLKAH - (tENS-tDelta)) 0;
      ATEST  <= # ( tCLKAH - tDS)36 'hFFFFFFFFF;
      @(posedge CLKA);
      {CSA_N,W_RA_N,ENA, MBA} <= # (tENH) 'b01XX;
      ATEST <= # (tDH) 36'hZZZZZZZZZ; 
      #tSKEW1;
       @(posedge CLKB);
       
       if (  (EF_N_OR !== 0) ) begin 
                                            Error = 1; 
                                           end else;
      @(posedge CLKB); 
       
       if (  (EF_N_OR !==0) ) begin 
                                                  Error = 2; 
                                                 end else;
      @(posedge CLKB); 
       
      #(tREF+1) if (  (EF_N_OR !==1) ) begin 
                                                  Error = 3; 
                                                 end else;
      @(negedge CLKB); 
      ENB <= # ( tCLKAH - (tENS-tDelta)) 1;                                          
       Bexp = 36 'hFFFFFFFFF;
      @(posedge CLKB);                          // reading - FIFO is empty
      ENB <= # (tENH) 'bX; 
      # (tREF+1) if ( (EF_N_OR !==0) ) begin
                                                  Error = 4; 
                                                end else;

      # (tA +1) if ( (B !== Bexp) ) begin
                                                  Error = 4; 
                                                end else;
       
      # (tA +1);
      if ( Error !== 0) 
      begin 
      $display ("Time = %0d, Test pattern %0d.\n Read FIFO value and/or EF_N_OR flag are not equal to expected.\n ",
                 $time,test_num);
      $display (" Expected FIFO = %h. Read = %h.  Error =%0d.EF_N_OR =%0b ", Bexp, B,Error, EF_N_OR );
      end
  end
 endtask
 
 
  task EFACheckflagTiming;
   
      // Before this proc. execution FIFO must be in Empty state.
     //  Procedure is controlled  by clocks CLKA, CLKB .
     // It writes value 11111111....., in  FIFO,
     // Then - check EF_N_OR flag     
   
    integer Error; 
    reg [0:35] Bexp; 
    reg Flag;
     
    begin 
      @(negedge CLKB); 
     test_num = test_num +1; CSB_N =0;
     $display ("Time = %0d. Test pattern %0d.\n ", $time, test_num);
      Error =0; 
     @(negedge CLKB);
      {CSB_N,W_N_RB,ENB} <= # ( tCLKAH - (tENS-tDelta)) 'b001;
      BTEST= 36'h111111111; 
        @(posedge CLKB);
      {ENB} <= # (tENH) 'bX;
     # (tDH) BTEST = 36'hZZZZZZZZZ;

      #tSKEW1;
      @(posedge CLKA);
       
       if (  (EF_N_OR !== 0) ) begin 
 Error = 1; 
 end else;
      @(posedge CLKA); 
       if (  (EF_N_OR !==0) ) begin 
              Error = 2; 
       end else;
      if (!FIFO.FIFO_STD_MODE)
       begin
        @(posedge CLKA); 
        if (  (EF_N_OR !==0) ) begin 
               Error = 2; 
        end else;
       end 
      # (tREF+1);
      if ( (EF_N_OR !==1) ) begin
            Error = 3; 
      end else;

      
      if ( Error !== 0) 
      begin 
      $display ("Time = %0d, Test pattern %0d.\n  EF_N_OR flag is not equal to expected.\n ",
                 $time,test_num);
      $display ("  Error =%0d.EF_N_OR =%0b ", Error, EF_N_OR );
      end
  end
 endtask

 task AE_NCheckflagTiming;
   
      // Before this proc. execution FIFO must be in Allmost Empty state.
     //  Procedure is controlled  by clocks CLKA, CLKB .
     // It writes word FFFFFF....., in  FIFO,
     // Then - read and checking the states 
     // of B bus and  AE_N 
       
    integer Error; 
    reg [0:35] Bexp; 
    reg Flag;
     
    begin 
     @(negedge CLKB);  
     test_num = test_num +1; CSB_N =0;
     $display ("Time = %0d. Test pattern %0d.\n ", $time, test_num);
     W_N_RB = 1; Error =0; Bexp = 36 'hZZZZZZZZZ;
     @(negedge CLKA);
      CSA_N <= # ( tCLKAH - (tENS-tDelta)) 0;
      W_RA_N    <= # ( tCLKAH - (tENS-tDelta)) 1;
      ENA    <= # ( tCLKAH - (tENS-tDelta)) 1;        // writing FFFFFF.....
      MBA    <= # ( tCLKAH - (tENS-tDelta)) 0;
      ATEST  <= # ( tCLKAH - tDS)36 'hFFFFFFFFF;
      @(posedge CLKA);
      {CSA_N,W_RA_N,ENA, MBA} <= # (tENH) 'b01XX;
      ATEST <= # (tDH) 36'hZZZZZZZZZ; 
      #tSKEW2;
      @(posedge CLKB);
       
       if (  (AE_N !== 0) ) begin 
              Error = 1; 
       end else;
      @(posedge CLKB);
      
       if ( (AE_N !== 0) ) begin 
             Error = 2; 
       end else;
      @(posedge CLKB); 
      @(negedge CLKB);
      ENB <= #( tCLKAH - (tENS-tDelta))  'b1; 
      if  (AE_N !== 1)  begin
           Error = 3; 
      end else;
      @(posedge CLKB);
      ENB <= # (tENH) 'bX; 
       # (tPAE +1) ;
       if ( (AE_N !== 0) ) begin
             Error = 4; 
       end else;
      
     
      if ( Error !== 0) 
      begin 
      $display ("Time = %0d, Test pattern %0d.\n AE_N flag is not equal to expected.\n ",
                 $time,test_num);
      $display ("  Error =%0d.AE_N =%0b ",Error, AE_N );
      end
  end
 endtask
 
  task AFACheckflagTiming;
   
      // Before this proc. execution FIFO must be in "Allmost Full" state.
     //  Procedure is controlled  by clocks CLKA, CLKB .
     // It writes word FFFFFF....., in  FIFO,
     // Then - attempt to read and checking the states 
     // of B bus and  AFN 
       
    integer Error; 
    reg [0:35] Bexp; 
    reg Flag;
     
    begin 
     @(negedge CLKB);
     test_num = test_num +1; CSB_N =0;
     $display ("Time = %0d. Test pattern %0d.\n ", $time, test_num);
     W_N_RB = 1;  Error =0; Bexp = 36 'hZZZZZZZZZ;
     @(negedge CLKA);
      CSA_N <= # ( tCLKAH - (tENS-tDelta)) 0;
      W_RA_N    <= # ( tCLKAH - (tENS-tDelta)) 1;
      ENA    <= # ( tCLKAH - (tENS-tDelta)) 1;
      MBA    <= # ( tCLKAH - (tENS-tDelta)) 0;
      ATEST  <= # ( tCLKAH - tDS)36 'hFFFFFFFFF;
      @(posedge CLKA);
      {CSA_N,W_RA_N,ENA, MBA} <= # (tENH) 'b01XX;
      ATEST <= # (tDH) 36'hZZZZZZZZZ; 
      #tSKEW2;
      @(posedge CLKB);
       
       if   (AF_N !== 0)  begin 
             Error = 1; 
       end else;
      @(posedge CLKB);
      
       if  (AF_N !== 0)  begin 
            Error = 2; 
       end else;
      @(posedge CLKB); 
      @(negedge CLKB);
      ENB <= #( tCLKAH - (tENS-tDelta))  1; 
      if  (AF_N !== 0)  begin
           Error = 3; 
      end else;
      @(posedge CLKB);
      ENB <= # (tENH) 'bX; 
      if ( (AF_N !== 0) )  Error = 4; 
      # tSKEW2;                                         
     @(posedge CLKA);
     @(posedge CLKA); 
       # tPAF ;
       if  (AF_N !== 1)  begin
            Error = 4; 
       end else;
      
      if ( Error !== 0) 
      begin 
      $display ("Time = %0d, Test pattern %0d.\n  AF_N flag is not equal to expected.\n ",
                 $time,test_num);
      $display ("  Error =%0d.AF_N =%0b ",Error, AF_N );
      end
  end
 endtask
 
 
task AFBCheckflagTiming;
   
      // Before this proc. execution FIFO must be in "Allmost Full" state.
     //  Procedure is controlled  by clocks CLKB, CLKA .
     // It writes word FFFFFF....., in  FIFO,
     // Then - attempt to read and checking the states 
     // of B bus and   
       
    integer Error; 
    reg [0:35] Bexp; 
    reg Flag;
     
    begin 
        
     @(negedge CLKB);
     test_num = test_num +1; 
     $display ("Time = %0d. Test pattern %0d.\n ", $time, test_num);
     W_N_RB = 0;  Error =0; 
     @(negedge CLKA);
      CSA_N <= # ( tCLKAH - (tENS-tDelta)) 0;
      W_RA_N    <= # ( tCLKAH - (tENS-tDelta)) 0;
      ENA    <= # ( tCLKAH - (tENS-tDelta)) 1;
      MBA    <= # ( tCLKAH - (tENS-tDelta)) 0;
      @(posedge CLKA);
      {CSA_N,W_RA_N,ENA, MBA} <= # (tENH) 'b00XX;
      #tSKEW2;
      @(posedge CLKB);
       
       if   (AF_N !== 0)  begin 
             Error = 1; 
       end else;
      @(posedge CLKB);
      
       if  (AF_N !== 0)  begin 
            Error = 2; 
       end else;
      
       # (tPAE +1) 
       if  (AF_N !== 1)  begin
            Error = 3; 
       end else;
      
      if ( Error !== 0) 
      begin 
      $display ("Time = %0d, Test pattern %0d.\n  AF_N flag is not equal to expected.\n ",
                 $time,test_num);
      $display ("  Error =%0d.AF_N =%0b ",Error, AF_N );
      end
    end
  endtask
      


 task FFBCheckflagTiming;
   
      // Before this proc. execution FIFO must be in "Full" state.
      // Procedure is controlled  by clocks CLKA, CLKB .
      // It reads word from  FIFO, checks FF_N_IR
       
    integer Error; 
    reg [0:35] Bexp; 
    reg Flag;
     
    begin 
     @(negedge CLKB);
     test_num = test_num +1; 
     $display ("Time = %0d. Test pattern %0d.\n ", $time, test_num);
     W_N_RB = 0;  Error =0; 
     @(negedge CLKA);
      CSA_N  <= # ( tCLKAH - (tENS-tDelta)) 0;
      W_RA_N <= # ( tCLKAH - (tENS-tDelta)) 0;
      ENA    <= # ( tCLKAH - (tENS-tDelta)) 1;
      MBA    <= # ( tCLKAH - (tENS-tDelta)) 0;
      @(posedge CLKA);
      {CSA_N,W_RA_N,ENA, MBA} <= # (tENH) 'b00XX;
      #tSKEW1;
      @(posedge CLKB);
       
       if   (FF_N_IR !== 0)  begin 
                                            Error = 1; 
                                           end else;
      @(posedge CLKB);
      
       if  (FF_N_IR !== 0)  begin 
                                                  Error = 2; 
                                                 end else;
      
       # (tWFF +1) ;
       if  (FF_N_IR !== 1)  begin
                                                  Error = 3; 
                                                end else;
      
      if ( Error !== 0) 
      begin 
      $display ("Time = %0d, Test pattern %0d.\n  FF_N_IR flag is not equal to expected.\n ",
                 $time,test_num);
      $display ("  Error =%0d.FF_N_IR =%0b ",Error, FF_N_IR );
      end
  end
 endtask
  
  
task Mail1_Write;
   
     //  procedure is controlled  by clock CLKA .
     // It sets CSA_N,W_RA_N,ENA, MBA  and assigns
     // to ATEST a value of Mailval, writing this word in Mail1 reg
     // Then - checking HIGH-to-LOW transition of flag MBF1_N      
    input [0:35] Mailval;
    input [0:1]  SIZval; //BM,SIZE
    begin    
      test_num = test_num +1;
       $display ("Time = %0d. Test pattern %0d.\n ", $time, test_num);
      @(negedge CLKA);
      MBB   = 0;
      ENB   = 0;
      @(negedge CLKA);
     // MBB   <= # ( tCLKBH - (tENS-(tDelta )    )) 1;
      CSB_N <=  0;
      W_N_RB = 1;
      CSA_N <= # ( tCLKBH - (tENS-(tDelta )    )) 0;
      {BM,SIZE}  <= # ( tCLKBH - (tENS-(tDelta )    )) SIZval;
      W_RA_N<= # (  tCLKBH - (tENS-(tDelta )    )) 1;
      ENA   <= # (  tCLKBH - (tENS-(tDelta )    )) 1;
      MBA   <= # (  tCLKBH - (tENS-(tDelta )    )) 1;
      RT_N  <= # (  tCLKBH - (tENS-(tDelta )    )) 1;
      ATEST <= # (  tCLKBH - tDS)  Mailval ;
      @(posedge CLKA);
       MBB   <= 1;
      {CSA_N,W_RA_N,ENA, MBA} <= # (tENH) 'b1XXX;
      ATEST <= # (tDH) 36'hZZZZZZZZZ;
      # (tPMF+1);
      if (MBF1_N) $display (" Test pattern %0d.\n Flag MBF1_N is not LOW.\n " ,test_num);
      //if (MBF1_N_vhd) $display (" Test pattern %0d.\n Flag MBF1_N_vhd is not LOW.\n " ,test_num);
      CSB_N <=  0;
    end
 endtask
   
task Mail2_Write;
   
     //  procedure is controlled  by clock CLKB .
     // It sets CSB_N,W_N_RB,ENB and assigns
     // to ATEST a value of Mailval, writing this word in Mail2 reg
     // Then - checking HIGH-to-LOW transition of flag MBF2_N      
    input [0:35] Mailval;
    input [0:1]  SIZval; //BM,SIZE
    
    begin    
      test_num = test_num +1; 
      $display ("Time = %0d. Test pattern %0d.\n ", $time, test_num);
      @(negedge CLKB);
      MBA   = 0;
      ENA   = 0;
      @(negedge CLKB);
      CSA_N <= 0;
      W_N_RB =  0;
      CSB_N <= # (  tCLKBH - (tENS-(tDelta )    )) 0;
      {BM,SIZE}  <= # (tCLKBH - (tENS-(tDelta))) SIZval;
      ENB   <= # (  tCLKBH - (tENS-(tDelta )    )) 1;
      MBB   <= # (  tCLKBH - (tENS-(tDelta )    )) 1;
      RT_N  <= # (  tCLKBH - (tENS-(tDelta )    )) 1;
      BTEST <= # (  tCLKBH - tDS)  Mailval ;
      @(posedge CLKB);
      {CSB_N,MBB,ENB,W_N_RB} <= # (tENH) 'b10XX;
      BTEST <= # (tDH) 36'hZZZZZZZZZ;
      
      # (tPMF+1)
       if (MBF2_N) $display (" Test pattern %0d.\n Flag MBF2_N is not LOW.\n " ,test_num);
      //if (MBF2_N_vhd) $display (" Test pattern %0d.\n Flag MBF2_N_vhd is not LOW.\n " ,test_num);
@(posedge CLKB);
    end
 endtask
 
task Mail1_Read_B ;
   
     //  procedure is controlled  by clock CLKB .
     // It sets CSB_N,W_N_RB,ENB  
     // Then - comparing state B bus with input Mailval      
    input [0:35] Mailval;
    input [0:1]  SIZval;      // byte (if = 01) or word (if = 00)on B bus
     begin    
      test_num = test_num +1; 
      $display ("Time = %0d. Test pattern %0d.\n  Mail1 reading", $time, test_num);
      CSB_N <= 0;

      # 10000; 
      @(negedge CLKA);
      MBB   = 1;
      {BM,SIZE} = SIZval;
      W_N_RB = 1;
      //CSB_N = 0;
      ENB = 0;

      @(negedge CLKA);
      //MBB<= # (tCLKBH - (tENS-(tDelta -1)    )) 1;

      @(negedge CLKB);

      ENB<= #(tCLKBH - (tENS-(tDelta -1))) 1;

  
      @(posedge CLKB);
      ENB   <= # ( tENH) 0;  

      CSB_N <= # (tPMF-tENH- (tDelta -1)    ) 1;     
      MBB   <= # (tPMF-tENH- (tDelta -1)    ) 1;
      W_N_RB<= # (tPMF-tENH- (tDelta -1)    ) 0;
      //# ((tDelta -1)     + tCLKAH - (tENS-(tDelta -1)    ) + tMDV +4) // MVA
      // @(posedge CLKB);     // MVA

       casex ({BM,SIZE})  
       2'b0x:
	 Mailval = Mailval;                        // long word (36-bit)
       2'b10:begin
	 Mailval [0:17] =  Mailval[0:17];    // word (18-bit)
	 Mailval [18:35] =  18'oXXXXXX;       
       end
       2'b11:begin
	 Mailval [0:8] =  Mailval[0:8];  // byte (9-bit)
	 Mailval [9:35] = 27'oXXXXXXXXX; // 
       end
     endcase // casex 

      if (B !== Mailval)
      begin 
       $display (" Test pattern %0d.\n Mail1 reg value is not equal to expected.\n Expected = %h. Read = %h.",
       test_num,Mailval, B);
       error =1;      
	end
/*
      if (B_vhd !== Mailval)
      begin 
       $display (" Test pattern %0d.\n Mail1_vhd reg value is not equal to expected.\n Expected = %h. Read = %h.",
       test_num,Mailval, B_vhd);
       error =1;      
	end
*/
      @(posedge CLKB);    
     
      
      {CSB_N,ENB} <= # (tENH) 'b10;
     
    end
 endtask
   
   
task Mail2_Read_A ;
   
     //  procedure is controlled  by clock CLKA .
     // It sets CSA_N,W_RA_N,ENA, MBA  
     // Then - comparing state A bus with input Mailval      
    input [0:35] Mailval;
    input [0:1] SIZval;      // byte (if = 01) or word (if = 00)on A bus
    begin    
      test_num = test_num +1; 
       $display ("Time = %0d. Test pattern %0d.\n ", $time, test_num);
      CSA_N <= 0;

      @(negedge CLKB);
      MBA   <= 1;
      {BM,SIZE}  <=  SIZval;
      W_RA_N<= 0;

      W_N_RB<= 0;
      //CSA_N <= 0;
      ENA<= 0;

      @(negedge CLKB);

      @(negedge CLKA);

      ENA<= # (  tCLKBH - (tENS-(tDelta -1)    )) 1;

  
      @(posedge CLKB);
      ENA   <= # ( tENH) 0;  

      CSA_N <= # (tPMF-tENH- (tDelta -1)    ) 1;     
      MBA   <= # (tPMF-tENH- (tDelta -1)    ) 1;
      W_RA_N<= # (tPMF-tENH- (tDelta -1)    ) 1;

        casex ({BM,SIZE})  
       2'b0x:
	 Mailval = Mailval;                       // long word (36-bit)
       2'b10:begin
	 Mailval [0:17] =  Mailval[0:17];    // word (18-bit)
	 Mailval [18:35] =  18'oXXXXXX;       
       end
       2'b11:begin
	 Mailval [0:8] =  Mailval[0:8];  // byte (9-bit)
	 Mailval [9:35] = 27'oXXXXXXXXX; // 
       end
     endcase // casex 
      
      @(posedge CLKA);
      {CSA_N,W_RA_N,W_N_RB} <= # (tENH) 'b110;

       if (A[0:35] !== Mailval)
       begin
       $display (" Test pattern %0d.\n Mail2 reg value is not equal to expected.\n Expected = %o. Read = %o.",
       test_num,Mailval, A[0:35]);
       error =1;
	 end
/*
       if (A_vhd !== Mailval)
       begin
       $display (" Test pattern %0d.\n Mail2_vhd reg value is not equal to expected.\n Expected = %o. Read = %o.",
       test_num,Mailval, A_vhd);
       error =1;
	end
*/
      @(posedge CLKA);
      
      {CSA_N,W_RA_N} <= # (tENH) 'b11;
      
    end
 endtask

task Set_Mail2_flag;

     // Intended for giving to Mail2 reg a writing permission
     //  procedure is controlled  by clock CLKA .
     // It sets CSA_N,W_RA_N,ENA, MBA  
     // Then - checking state Flag MBF2_N == 1      
    input [0:35] Mailval;
    
    begin    
      test_num = test_num +1;
      $display ("Time = %0d. Test pattern %0d.\n ",$time, test_num); 
      @(negedge CLKA);
      CSA_N <= # (  tCLKAH - (tENS-tDelta)) 0;
      W_RA_N<=     # (  tCLKAH - (tENS-tDelta)) 0;
      ENA<=     # (  tCLKAH - (tENS-tDelta)) 1;
      MBA <=    # (  tCLKAH - (tENS-tDelta)) 1;

      @(posedge CLKA);
      {CSA_N,W_RA_N,ENA, MBA} <= # (tENH) 'b11X1;

      # (tPMF+1) if (!MBF2_N)
       $display (" Test pattern %0d.\n Flag MBF2_N is not HIGH.\n ",
       test_num );
    end
 endtask
   
task Set_Mail1_flag;
   
     // Intended for giving to Mail1 reg a writing permission 
     //  procedure is controlled  by clock CLKB .
     // It sets CSB_N,W_N_RB,ENB 
     // Then - checking state Flag MBF1_N == 1      
    input [0:35] Mailval;
    
    begin    
      test_num = test_num +1;  $display ("Time = %0d. Test pattern %0d.\n ", $time, test_num);      @(negedge CLKB);
      CSB_N <= # (  tCLKAH - (tENS-tDelta)) 0;
      W_N_RB<=     # (  tCLKAH - (tENS-tDelta)) 1;
      ENB<=     # (  tCLKAH - (tENS-tDelta)) 1;
      MBB<=     # (  tCLKAH - (tENS-tDelta)) 1;    
      @(posedge CLKB);
      {CSB_N,W_N_RB,ENB} <= # (tENH) 'b10X;
      MBB  <= # (tENH) 'b X;
            
      # (tPMF+1) if (!MBF1_N)
       $display (" Test pattern %0d.\n Flag MBF1_N is not HIGH.\n ",
       test_num );
    end
 endtask
 
 
 
 
  task Read_A_byte;
   
     //  It reads byte, writen by Write_A_word procedure
     //  and checks them according to BM,SIZE, BE values
     
    input [31:0] WordAmount;
  
     
    reg [0:35] I;
    
   begin
     test_num = test_num +1;
     $display ("Time = %0d. Test pattern %0d.\n ", $time, test_num); 
     @(negedge CLKA);
     //PGA = 0;
     @(negedge CLKA);
     MBA   <= # (  tCLKAH - (tENS-tDelta)) 0;

     @(negedge CLKA);
     {CSA_N,W_RA_N} <= # (  tCLKAH - (tENS-tDelta)) 'b00;
     @(negedge CLKA);
       
    repeat ( WordAmount)
     begin
      ENA <= # (  tCLKAH - (tENS-tDelta)) 'b1;
      @(posedge CLKA);
      ENA <= # ( tENH) 'bX;
      case ({SIZE,FIFO.BIG_ENDIAN})
         2'b11:                                    // big endian
            
     		 OutReg ={1'b0,8'h0A,1'b0,8'h0B,1'b0,8'h0C,1'b0,8'h0D};  //
    
         2'b10:                                    // little endian  
            
     	         OutReg ={1'b0,8'h0D,1'b0,8'h0C,1'b0,8'h0B,1'b0,8'h0A};
           
      endcase      
      
      # (tA+2) if ( (A !== OutReg) && EF_N_OR) $display ( 
      " Time= %0d. Test pattern %0d.\n Read FIFO value is not equal to expected.\n Expected = %h. Read = %h.", 
       $time, test_num,A_exp, A_inf);
      @(negedge CLKA);
      I=I+1; OutReg= I; 
     end  
     @(negedge CLKA);
      ENA <= # (  tCLKAH - (tENS-tDelta)) 0;
     @(posedge CLKA);
      ENA <= # ( tENH) 'bX; 
      {CSA_N,W_RA_N} = # ( tENH) 'b11;    
   end
 endtask
 
 task Read_A_word;
   
     //  It reads long words, writen by Write_A_word procedure
     //  and checks them according to BM,SIZE, BE values
   
     
    input [31:0] WordAmount;
  
     
    reg [0:35] I;
    
   begin
     test_num = test_num +1;
     $display ("Time = %0d. Test pattern %0d.\n ", $time, test_num); 
     
     @(negedge CLKA);
     MBA   <= # (  tCLKAH - (tENS-tDelta)) 0;

     @(negedge CLKA);
     {CSA_N,W_RA_N,MBA} <= # (  tCLKAH - (tENS-tDelta)) 'b000;
     @(negedge CLKA);
       
    repeat ( WordAmount)
     begin
      ENA <= # (  tCLKAH - (tENS-tDelta)) 'b1;
      @(posedge CLKA);
      ENA <= # ( tENH) 'bX;
      case ({SIZE,FIFO.BIG_ENDIAN})
          2'b01:                                    // big endian
           
     		 OutReg ={1'b0,8'h0A,1'b0,8'h0B,1'b0,8'h0C,1'b0,8'h0D};  
   
          2'b00:                                    // little endian  
            
     		OutReg ={1'b0,8'h0C,1'b0,8'h0D,1'b0,8'h0A,1'b0,8'h0B};  
     	      
           
      endcase      
   
      # (tA+2) if ( (A !== OutReg) && EF_N_OR) $display ( 
      " Time= %0d. Test pattern %0d.\n Read FIFO value is not equal to expected.\n Expected = %h. Read = %h.", 
       $time, test_num,OutReg, A);
      @(negedge CLKA);
      I=I+1; OutReg= I; 
     end  
     @(negedge CLKA);
      ENA <= # (  tCLKAH - (tENS-tDelta)) 0;
     @(posedge CLKA);
      ENA <= # ( tENH) 'bX; 
      {CSA_N,W_RA_N} = # ( tENH) 'b11;    
   end
 endtask
 


 task Write_swap ;
   
     // Write procedure controlled  by clock CLKA .
     // It sets CSA_N,W_RA_N,ENA, MBA  and assigns
     // to ATEST words {1,2,3,4},{5,6,7,8}... , subsequently
     
    input [35:0] WordAmount;
    //input OddEvenSelect;
    //input [0:8] Begval;    
    reg [0:35] I;
   begin
     I = 1; //test_num = test_num +1; 
   $display ("Time = %0d. Test pattern %0d.\n ", $time, test_num); 
   @(negedge CLKA);   
   //ODDEVEN = OddEvenSelect; 
   repeat ( WordAmount)
     begin
    @(negedge CLKA);
      {CSA_N,W_RA_N,ENA, MBA} <= # (tCLKA_HPER - (tENS-tDelta)) 'b0110;
      ATEST[27:35]= I; ATEST[18:26]= I+1; ATEST[9:17]= I+2; ATEST[0:8]= I+3; 
      I = I + 1;
    @(posedge CLKA);
      {ENA, MBA} <= # (tENH) 'bXX;
     end 
    # (tDH) ATEST = 36'hZZZZZZZZZ;
    @(negedge CLKA);
      ENA <= # (tCLKA_HPER - (tENS-tDelta)) 0;
    @(posedge CLKA);
      ENA <= # ( tENH) 'bX; 
     # 10; {CSA_N,W_RA_N,MBA} <= 'b1XX;    
  end
 endtask


 task Write_swap1 ;
   
     // Write procedure controlled  by clock CLKA .
     // It sets CSA_N,W_RA_N,ENA, MBA  and assigns
     // to ATEST words {1,2,3,4},{5,6,7,8}... , subsequently
     
    input [35:0] WordAmount;

    //reg [0:35] I;
   begin
     //I = 1;
     //test_num = test_num +1; 
   //$display ("Time = %0d. Test pattern %0d.\n ", $time, test_num); 
   @(negedge CLKA);   
   //ODDEVEN = OddEvenSelect; 
   //repeat ( 1)
   //begin
    	@(negedge CLKA);
      	{CSA_N,W_RA_N,ENA, MBA} <= # (tCLKA_HPER - (tENS-tDelta)) 'b0110;
      	ATEST[27:35]= WordAmount;   ATEST[18:26] = WordAmount+1; 
      	ATEST[9:17] = WordAmount+2; ATEST[0:8]   = WordAmount+3; 
      	//I = I + 1;
    	@(posedge CLKA);
      	{ENA, MBA} <= # (tENH) 'bXX;
   //end 
    # (tDH) ATEST = 36'hZZZZZZZZZ;
    @(negedge CLKA);
      ENA <= # (tCLKA_HPER - (tENS-tDelta)) 0;
    @(posedge CLKA);
      ENA <= # ( tENH) 'bX; 
     # 10; {CSA_N,W_RA_N,MBA} <= 'b1XX;    
  end
 endtask

 
 task Write_check_FF ;
   
     // Write procedure controlled  by clock CLKA .
     // It sets CSA_N,W_RA_N,ENA, MBA  and assigns
     // to ATEST words {1,2,3,4},{5,6,7,8}... , subsequently
     
    input [35:0] WordAmount;
    reg [0:35] I;
   begin
     I = 1;test_num = test_num +1; 
   $display ("Time = %0d. Test pattern %0d.\n ", $time, test_num); 
   @(negedge CLKA);   

   repeat ( WordAmount)
   begin
       
       wait (FF_N_IR == 1);
       Write_swap1(I) ;
       I=I+1;
   end
  end
 endtask


 reg [0: 8] I1; 
 reg [0:35] Aux1,OutReg1; 
  
  task Read_swap ;
   
     //  Procedure  reads long words,words or bytes from FIFO port B.
     //  according to the state of BE_FWFT_N,  SIZE signals
     //  It sets CSA_N,W_RA_N,ENA, MBA  and checks
     //  WordAmount number of values on B bus
     //  Values should be: BegValue, BegValue+1, BegValue+2 ... according to SIZE and SWAP signals
     //  SIZE_BE = {BigEndian,BM,SIZE}


    input [0:35] WordAmount;
    input [0:35] BegValue;
    input BMval;             //BUS MUTCH
    input SIZEval;
    
   begin
    @(negedge CLKB);

     I1 = BegValue; test_num = test_num +1;
     OutReg = 0; OutReg1=0; 
     $display ("Time = %0d. Test pattern %0d.\n ", $time, test_num); 
     
     @(negedge CLKB);
     
     BM    <= # (  tCLKAH - (tENS-tDelta)) BMval;
     SIZE  <= # (  tCLKAH - (tENS-tDelta)) SIZEval;
     
     @(posedge CLKB);
     @(posedge CLKB); 
     ReadNo =1;
                          
     @(negedge CLKB);
     {CSB_N,MBB,W_N_RB} <= # (  tCLKAH - (tENS-tDelta)) 'b001;
     @(negedge CLKB);
       
    repeat ( WordAmount)
     begin
     		@(negedge CLKB);
      	ENB <= # (  tCLKAH - (tENS-tDelta)) 'b1;
      	@(posedge CLKB);
      	ENB <= # ( tENH ) 'bX;
      	if (FIFO.FIFO_STD_MODE)
      	  //# (tA+1)
       	begin
              //ReadNo =1; 
              BUS_MAT_READ;
	        OutReg = OutReg1;
              # (tA+1)
                //@(negedge CLKB);
        	  if ( (B !== OutReg) && EF_N_OR)
		  begin 
                $display ("Time= %0d. Test pattern %0d.\n Read FIFO value is not equal to expected. READ_PTR = %0d. \n Expected = { %h.%h.%h.%h}\nRead = { %h.%h.%h.%h}", 
                $time, test_num, FIFO.READ_POINTER, OutReg[27:35 ],OutReg[18:26],OutReg[9:17 ],OutReg[0:8],B27_B35,B18_B26,B9_B17,B0_B8 );
       	    error =1;
              end
             
              /*
        	  if ( (B_vhd !== OutReg) && EF_N_OR)
		  begin 
                $display ("Time= %0d. Test pattern %0d.\n Read FIFO_vhd value is not equal to expected. READ_PTR = %0d. \n Expected = { %h.%h.%h.%h}\nRead = { %h.%h.%h.%h}", 
                $time, test_num, FIFO.READ_POINTER, OutReg[27:35 ],OutReg[18:26],OutReg[9:17 ],OutReg[0:8],B27_B35_vhd,B18_B26_vhd,B9_B17_vhd,B0_B8_vhd );
       	    error =1;
              end
              */ 
		end
            else
            begin
                 //ReadNo =1; 
                 BUS_MAT_READ;    
                 OutReg = OutReg1;
                 # (tA  ) //mva
            //@(negedge CLKB);

               if ( (B !== OutReg)&&(ReadNo == Limit))
               begin 
                 $display (" Time= %0d. Test pattern %0d.\n Read FIFO value is not equal to expected.READ_PTR = %0d. \n Expected = { %h.%h.%h.%h}\nRead = { %h.%h.%h.%h}", 
                 $time, test_num,FIFO.READ_POINTER, OutReg[27:35 ],OutReg[18:26],OutReg[9:17 ],OutReg[0:8],B27_B35,B18_B26,B9_B17,B0_B8);
                 error =1;
               end  
             end       
            end       
         @(negedge CLKB);
           ENB <= # (  tCLKAH - (tENS-tDelta)) 0;
         @(posedge CLKB);
           ENB <= # ( tENH ) 'bX; 
         # 10; {CSB_N,MBB,W_N_RB} =  'b110;    
   end
 endtask

  task Read_swap1 ;
   
     //  Procedure  reads long words,words or bytes from FIFO port B.
     //  according to the state of BE_FWFT_N,  SIZE signals
     //  It sets CSA_N,W_RA_N,ENA, MBA  and checks
     //  WordAmount number of values on B bus
     //  Values should be: BegValue, BegValue+1, BegValue+2 ... according to SIZE and SWAP signals
     //  SIZE_BE = {BigEndian,BM,SIZE}


    input [0:35] WordAmount;
    input [0:35] BegValue;
    input BMval;             //BUS MUTCH
    input SIZEval;
    //reg [0:35] I1;
   begin
    @(negedge CLKB);

     I1 = BegValue; //test_num = test_num +1;
     OutReg = I1;OutReg1=I1; 
     // $display ("Time = %0d. Test pattern %0d.\n ", $time, test_num); 
     
     @(negedge CLKB);
     
     BM    <= # (  tCLKAH - (tENS-tDelta)) BMval;
     SIZE  <= # (  tCLKAH - (tENS-tDelta)) SIZEval;
     
     @(posedge CLKB);
     @(posedge CLKB); 
     ReadNo =1;
                          
     @(negedge CLKB);
     {CSB_N,MBB,W_N_RB} <= # (  tCLKAH - (tENS-tDelta)) 'b001;
     @(negedge CLKB);
       
    //repeat ( 1 )
    //begin
     		@(negedge CLKB);
      	ENB <= # (  tCLKAH - (tENS-tDelta)) 'b1;
      	@(posedge CLKB);
      	ENB <= # ( tENH ) 'bX;
      	if (FIFO.FIFO_STD_MODE)
      	  //# (tA+1)
       	begin
              //ReadNo =1; 
              BUS_MAT_READ;
	        OutReg = OutReg1;
              # (tA+1)
                //@(negedge CLKB);
        	  if ( (B !== OutReg) && EF_N_OR)
              begin 
                $display ("Time= %0d. Test pattern %0d.\n Read FIFO value is not equal to expected. READ_PTR = %0d. \n Expected = { %h.%h.%h.%h}\nRead = { %h.%h.%h.%h}", 
                $time, test_num, FIFO.READ_POINTER, OutReg[27:35 ],OutReg[18:26],OutReg[9:17 ],OutReg[0:8],B27_B35,B18_B26,B9_B17,B0_B8 );
		    error =1;
	        end
       	end
            else
            begin
                 //ReadNo =1; 
                 BUS_MAT_READ;    
                 OutReg = OutReg1;
                 # (tA  ) //mva
            //@(negedge CLKB);

               if ( (B !== OutReg)&&(ReadNo == Limit))
               begin 
                 $display (" Time= %0d. Test pattern %0d.\n Read FIFO value is not equal to expected.READ_PTR = %0d. \n Expected = { %h.%h.%h.%h}\nRead = { %h.%h.%h.%h}", 
                 $time, test_num,FIFO.READ_POINTER, OutReg[27:35 ],OutReg[18:26],OutReg[9:17 ],OutReg[0:8],B27_B35,B18_B26,B9_B17,B0_B8);
                 error =1;
               end            
            end       
         //end       
         @(negedge CLKB);
           ENB <= # (  tCLKAH - (tENS-tDelta)) 0;
         @(posedge CLKB);
           ENB <= # ( tENH ) 'bX; 
         # 10; {CSB_N,MBB,W_N_RB} =  'b110;    
   end
 endtask


  task Read_check_EF ;
   
     //  Procedure  reads long words,words or bytes from FIFO port B.
     //  according to the state of BE_FWFT_N,  SIZE signals
     //  It sets CSA_N,W_RA_N,ENA, MBA  and checks
     //  WordAmount number of values on B bus
     //  Values should be: BegValue, BegValue+1, BegValue+2 ... according to SIZE and SWAP signals
     //  SIZE_BE = {BigEndian,BM,SIZE}


    input [0:35] WordAmount;
    input [0:35] BegValue;
    input BMval;             //BUS MUTCH
    input SIZEval;
    //reg [0:35] I1;
   begin
    @(negedge CLKB);

     I1 = BegValue; //test_num = test_num +1;
     OutReg = 0;OutReg1=0; 
     $display ("Time = %0d. Test pattern %0d.\n ", $time, test_num); 
     
     @(negedge CLKB);
     
     BM    <= # (  tCLKAH - (tENS-tDelta)) BMval;
     SIZE  <= # (  tCLKAH - (tENS-tDelta)) SIZEval;
     
     @(posedge CLKB);
     @(posedge CLKB); 
     ReadNo =1;
                          
     @(negedge CLKB);
     {CSB_N,MBB,W_N_RB} <= # (  tCLKAH - (tENS-tDelta)) 'b001;
     @(negedge CLKB);
       
    repeat ( WordAmount)     
     begin

     	 wait (EF_N_OR == 1);
       
     	 Read_swap1 ( 1, I1, BMval, SIZEval);           

     end
end
 endtask



   reg [0:35] Bux1,InReg1;
   wire [0:2] SIZE_BE;

assign SIZE_BE = {FIFO.BIG_ENDIAN, BM, SIZE}; 
   
///// Reset Bus Matching /////
   always @(SIZE_BE)
     begin
	ReadNo <= 1;
	WriteNo <= 1;
	casex (SIZE_BE)   // SIZE_BE = {BigEndian,BM,SIZE}
	  3'bx0x:
	    LimitB <= 1;  // long word (36-bit)
	  3'b110, 3'b010:
	    LimitB <= 2;  // word (18-bit)
	  3'b111, 3'b011:
	    LimitB <= 4;  // byte (9-bit)
	endcase // casex(SIZE_BE)
     end // Reset Bus Matching 

   
    task BUS_MAT_READ;       // executed, when LOW-to_HIGH transition CLKB reads FIFO
  			           // result is OutReg state 
  begin

    if (ReadNo == 1) begin
    
     Aux1[27:35] = I1; Aux1[18:26] =I1+1;Aux1[9:17] = I1+2; Aux1[0:8]= I1+3; 
     I1 <=I1+1;
     end
      else;                                                     
                    
    
    if (ReadNo != LimitB) ReadNo <= ReadNo +1; 
    else ReadNo <= 1;                     // counter of Byte/Word for reading words/bytes
	 casex (SIZE_BE)
	   
         3'bx0x:  // long word reading
	     OutReg1 = Aux1;
	   3'b110:  // big endian word reading
	     case (ReadNo)
	       1:begin
		 OutReg1 [9:17] =  Aux1[27:35];
             OutReg1 [0:8]  =  Aux1[18:26];
             OutReg1 [18:35]= 18'oXXXXXX;  end

	       2:begin
		 OutReg1 [9:17] =  Aux1[9:17];
             OutReg1 [0:8]  =  Aux1[0:8];
             OutReg1 [18:35]= 18'oXXXXXX;  end


	     endcase // case(ReadNo)
	   3'b010:  // little endian word reading
	     case (ReadNo)
	       1:begin
		 OutReg1 [9:17] =  Aux1[9:17];
             OutReg1 [0:8]  =  Aux1[0:8];
             OutReg1 [18:35]= 18'oXXXXXX;  end

	       2:begin
		 OutReg1 [9:17] =  Aux1[27:35];
             OutReg1 [0:8]  =  Aux1[18:26];
             OutReg1 [18:35]= 18'oXXXXXX;  end

	     endcase // case(ReadNo)
	   3'b111:  // big endian byte reading
	     case (ReadNo)
	       1:begin
		 OutReg1 [0:8] =  Aux1[27:35];
		 OutReg1 [9:35] = 27'oXXXXXXXXX; end

	       2:begin
		 OutReg1 [0:8] =  Aux1[18:26];
		 OutReg1 [9:35]= 27'oXXXXXXXXX;  end

	       3:begin
		 OutReg1 [0:8] =  Aux1[9:17];
		 OutReg1 [9:35]= 27'oXXXXXXXXX;  end

	       4:begin
		 OutReg1 [0:8] = Aux1[0:8];
		 OutReg1 [9:35]= 27'oXXXXXXXXX;  end

	     endcase // case(ReadNo)
	   3'b011:  // little endian byte reading
	     case (ReadNo)
	       1:begin
		 OutReg1 [0:8] =  Aux1[0:8];
		 OutReg1 [9:35]= 27'oXXXXXXXXX;  end

	       2:begin
		 OutReg1 [0:8] =  Aux1[9:17];
		 OutReg1 [9:35]= 27'oXXXXXXXXX;  end

	       3:begin
		 OutReg1 [0:8] =  Aux1[18:26];
		 OutReg1 [9:35]= 27'oXXXXXXXXX;  end
	       4:begin
		 OutReg1 [0:8] =  Aux1[27:35];
		 OutReg1 [9:35]= 27'oXXXXXXXXX;  end

	     endcase // case(ReadNo)
	 endcase // casex(SIZE_BE)    
  // OutReg = OutReg1;
  end
 endtask  

task RETRANSMIT;       // 
  			           // 
  begin
 
     $display ("Time = %0d. RETRANSMIT. Test pattern %0d.\n ", $time, test_num); 
     
     {CSB_N,MBB,W_N_RB,ENB} <= 'b0010;
     {CSA_N,MBA, W_RA_N,ENA}  <= 'b1010;

     	//@(negedge CLKB);
     	@(negedge CLKA);
	#(tCLKAH - (tRSTS -100));
       RT_N <= 0;
   //	#(tPRT );
     repeat (4)@(posedge CLKA);    
      @(posedge CLKB);
      #(tRSTH +100);
        RT_N <= 1;

	if ( (FIFO.READ_POINTER !== 0))
	begin 
	  $display (" Time= %0d. Test pattern %0d.\n Read POINTER value is not equal to expected. READ_PTR = %0d. ", 
	  $time, test_num,FIFO.READ_POINTER  );
        error =1;
      end

     /*
	if ( (FIFO_vhd.READ_POINTER !== 0))
	begin 
	  $display (" Time= %0d. Test pattern %0d.\n Read POINTER value is not equal to expected. READ_PTR = %0d. ", 
	  $time, test_num,FIFO_vhd.READ_POINTER  );
        error =1;
      end
     */

      #(tRTR +100);
    //    ENB <= 'b1; //READ FIRST WORD AFTER RETRANSMIT
      @(posedge CLKB);
      # (tENH  +100);
        ENB <= 'b0;

   end
endtask  

                                                                   
  

                                                                   
  
///////////////////////////////////////////////////////////////////////////   
   initial       //// Initial settings before test execution /////////////
//////////////////////////////////////////////////////////////////////////
    begin
       ATEST = 36'hZZZZZZZZZ; BTEST = 36'hZZZZZZZZZ;
       RT_N = 1; 
       CSA_N =1; CSB_N =1; test_num =0;
       
       // $dumpvars; 
  
end
///////////////////////////////////////////////////////////////////////////   
//////////////////////////// Test sequence ////////////////////////////////   
///////////////////////////////////////////////////////////////////////////   
initial      
   
    begin
       # 10;           // delay to exclude hazards with previous initial block



 test_num = 10;
    
 $display ("\nTime =%0t. Test #10. PAR_PROG_OFFSET . \n", $time);
 		 
	BE_FWFT_N = 0;  // for determine order by wich bytes 
			    // are transfered through port B
	FS0_SD    = 0;  // for choosing offset programming method	
	FS1_SEN_N = 0;
	SPM_N     = 1;
      
	

   fork
    	MRST ;
	PAR_PROG_OFFSET('hF,'hFF,'hFF); 
   join
   repeat (10) @(posedge CLKA);    // delay 

////////////////////PAR_PROG_OFFSET ///////////////////////
 
	BE_FWFT_N = 0;  //for determine order by wich bytes 
			    //are transfered through port B
	FS0_SD    = 0;  // for choosing offset programming method	
	FS1_SEN_N = 0;
	SPM_N     = 1;      

 //MRST ;

   repeat (10) @(posedge CLKA);    // delay 
/////////////////////////////////////////// 

 test_num = 20;    
 $display ("\nTime =%0t. Test #20. PAR_PROG_OFFSET . \n", $time);

   fork
    	MRST ;
	PAR_PROG_OFFSET('h7,'h77,'h77); 
   join

   repeat (10) @(posedge CLKA);    // delay 




////////////////////SER_PROG_OFFSET/////////////////////// 


	 BE_FWFT_N = 0;  //for determine order by wich bytes 
	 	            //are transfered through port B
	 FS0_SD    = 0;  //for choosing offset programming method	
	 FS1_SEN_N = 1;
	 SPM_N     = 0;

 
test_num = 30;    
 $display ("\nTime =%0t. Test #30. SER_PROG_OFFSET . \n", $time);
   fork
    	MRST ;
	SER_PROG_OFFSET('h15,'h15,'h77); 
   join

   repeat (10) @(posedge CLKA);    // delay 

///////////////////SER_PROG_OFFSET//////////////////////// 

       MRST ;
   repeat (10) @(posedge CLKA);    // delay

       BE_FWFT_N = 0;  //for determine order by wich bytes 
	 	           //are transfered through port B
	 FS0_SD    = 0;  //for choosing offset programming method	
	 FS1_SEN_N = 1;
	 SPM_N     = 0;



test_num = 40; 

   
 $display ("\nTime =%0t. Test #40. SER_PROG_OFFSET . \n", $time);
   fork
    	MRST ;
	SER_PROG_OFFSET('ha5,'h5a,'h8); 
   join

   repeat (10) @(posedge CLKA);    // delay




/////////////////////////////////////////// 
 test_num = 50;    
 $display ("\nTime =%0t. Test #50. DEFAULT OFFSET = 64 . \n", $time);

 		 BE_FWFT_N = 0;  //for determine order by wich bytes 
				      //are transfered through port B
		 FS0_SD    = 1;  // for choosing offset programming method	
		 FS1_SEN_N = 1;
		 SPM_N     = 1;
   fork
    MRST ;
    DEF_OFFSET(64);
   join

   repeat (10) @(posedge CLKA);    // delay 

/////////////////////////////////////////// 
 test_num = 60;    
 $display ("\nTime =%0t. Test #60. DEFAULT OFFSET = 8 . \n", $time);

 		 BE_FWFT_N = 0;  //for determine order by wich bytes 
				     //are transfered through port B
		 FS0_SD    = 1;  // for choosing offset programming method	
		 FS1_SEN_N = 1;
		 SPM_N     = 1;
   fork
    MRST ;
    DEF_OFFSET(8);
   join

   repeat (10) @(posedge CLKA);    // delay 
/////////////////////////////////////////// 
 test_num = 70;    
 $display ("\nTime =%0t. Test #70. DEFAULT OFFSET = 16 . \n", $time);

 		 BE_FWFT_N = 0;  //for determine order by wich bytes 
				      //are transfered through port B
		 FS0_SD    = 1;  // for choosing offset programming method	
		 FS1_SEN_N = 1;
		 SPM_N     = 1;
   fork
     MRST ;
     DEF_OFFSET(16);
   join

 test_num = 80;    
 $display ("\nTime =%0t. Test #80. PARTIAL RESET . \n", $time);


     Par_Reset_FIFO (  1 ,1 ,1, 1   );       // 





test_num = 90; 

   
 $display ("\nTime =%0t. Test #90. FIFO write A of words. \n", $time);

       
                ////// FIFO operation with different sizes of words//////////
       Reset_FIFO (  0 ,1 ,1, 1,1,0,1 );           //20 + 21: Master reset with 8 offset, 
                                               //Big Endian (BE=1), CY mode

       Write_A (  24 );                  //22: write of long words

test_num = 100; 
  
$display ("\nTime =%0t. Test #100. FIFO long words read. \n", $time);

       Read_B  (24,1 );                   //long words read

///////////////////////////////////////////


test_num = 110; 

   
 $display ("\nTime =%0t. Test #110. FIFO write A of words. \n", $time);

       
                ////// FIFO operation with different sizes of words//////////
       Reset_FIFO (  0 ,1 ,1, 1,1,0,1 );           //20 + 21: Master reset with 8 offset, 
                                               //Big Endian (BE=1), CY mode

       Write_A (  FIFOSIZE );                  //22: write of long words 



///////////////////////////////////////////
test_num = 120;
   
 $display ("\nTime =%0t. Test #120. FIFO operation with different sizes of words. \n", $time);
       
 
              ////// FIFO operation with different sizes of words//////////
test_num = 130; 
 
 $display ("\nTime =%0t. Test #130: Master reset with 8 offset,Big Endian (BE=1), CY mode. \n", $time);

       Reset_FIFO (  0 ,1 ,1, 1, 1,0,0 );          //20 + 21: Master reset with 8 offset, 
                                               //Big Endian (BE=1), CY mode
test_num = 140; 
 
 $display ("\nTime =%0t. Test #: 140: write of long words  \n", $time);

       Write_swap ( 'd240 );                      //22: write of long words

 
test_num = 150; 
 
 $display ("\nTime =%0t. Test #:150: read all long words (bytes AB/CD),big endian\n", $time);
       
         Read_swap ( ('d240), 1, 0, 0);      //23: read long words (bytes AB/CD),big endian
       

///////////////////////////////////////////




 test_num = 160; 
  
 $display ("\nTime =%0t. Test #160. FIFO operation with different sizes of words. \n", $time);

       
                ////// FIFO operation with different sizes of words//////////
       Reset_FIFO (  0 ,1 ,1, 1, 1,0,0 );           //20 + 21: Master reset with 8 offset, 
                                               //Big Endian (BE=1),CY mode 
       

       Write_swap( FIFOSIZE+2 );         //22: write of long words 

       Read_swap ((FIFOSIZE+2), 1, 0, 0); //23: read long words (bytes ABCD),big endian
       Write_swap( 2);                   //22: write of long words 
 

 test_num = 170; 
  
 $display ("\nTime =%0t. Test #170. FIFO operation with different sizes of words. \n", $time);

       
                ////// FIFO operation with different sizes of words//////////
       Reset_FIFO (  0 ,1 ,1, 1, 1,1,0 );   // 20 + 21: Master reset with 8 offset, 
                                        // BIG Endian (BE=1),CY mode 
       

       Write_swap( 24 );         //22: write of long words 

       
	 Read_swap ((24)* 2, 1, 1, 0); //23: read  words (bytes AB/CD),big endian




 test_num = 180; 
  
 $display ("\nTime =%0t. Test #180. FIFO operation with different sizes of words. \n", $time);

       
                ////// FIFO operation with different sizes of words//////////
       Reset_FIFO (  0 ,1 ,1, 1, 1,1,0 );   // 20 + 21: Master reset with 8 offset, 
                                        // BIG Endian (BE=1),CY mode 
       


       Write_swap( FIFOSIZE+2 );         //22: write of long words 
       

       Read_swap ((FIFOSIZE+2)* 2, 1, 1, 0); //23: read  words (bytes AB/CD),big endian
       Write_swap( 2);                    //22: write of long words 




 test_num = 190; 
  
 $display ("\nTime =%0t. Test #190. FIFO operation with words. Big endian\n", $time);

       
                ////// FIFO operation with different sizes of words//////////
       Reset_FIFO (  0 ,1 ,1, 0, 1,1,0 );   // 20 + 21: Master reset with 8 offset, 
                                        // LITTLE Endian (BE=1),CY mode 
       

       Write_swap( 24 );         //: write of long words 

	 Read_swap ((24)* 2, 1, 1, 0); //23: read  words (bytes AB/CD),little endian
        

 test_num = 200; 
  
 $display ("\nTime =%0t. Test #200. FIFO operation with words Little endian. \n", $time);

       
                ////// FIFO operation with different sizes of words//////////
       Reset_FIFO (  0 ,1 ,1, 0, 1,1,0 );   // 20 + 21: Master reset with 8 offset, 
                                        // LITTLE Endian (BE=1),CY mode 
       


       Write_swap( FIFOSIZE+2 );         //22: write of long words 
       Read_swap ((FIFOSIZE+2)* 2, 1, 1, 0); //23: read  words (bytes AB/CD),little endian
       Write_swap( 10);                    //22: write of long words 


 
  test_num = 210; 
  
 $display ("\nTime =%0t. Test #210. FIFO operation with byte sizes of words. \n", $time);

       
                ////// FIFO operation with different sizes of words//////////
       Reset_FIFO (  0 ,1 ,1, 1, 1,1,1 );   //  Master reset with 8 offset, 
                                        // BIG Endian (BE=1),CY mode 
       

       Write_swap( 24 );         //22: write of long words 

       
	 Read_swap ((24)* 2, 1, 1, 1); //23: read  bytes A/B/C/D/,big endian

       



  test_num = 220; 
  
 $display ("\nTime =%0t. Test #220. FIFO operation with byte sizes of words. \n", $time);

       
                ////// FIFO operation with different sizes of words//////////
       Reset_FIFO (  0 ,1 ,1, 1, 1,1,1 );   //  Master reset with 8 offset, 
                                        // BIG Endian (BE=1),CY mode 
       


       Write_swap( FIFOSIZE+2 );         //22: write of long words 
       

       Read_swap ((FIFOSIZE+2)* 2, 1, 1, 1); //23: read   bytes A/B/C/D/,big endian
       Write_swap( 10);                    //22: write of long words 

       
 
 test_num = 230; 
  
 $display ("\nTime =%0t. Test #230. FIFO operation with byte sizes of words.Little endian \n", $time);

       
                ////// FIFO operation with different sizes of words//////////
       Reset_FIFO (  0 ,1 ,1, 0, 1,1,1 );   // 20 + 21: Master reset with 8 offset, 
                                        // LITTLE Endian (BE=1),CY mode 
       

       Write_swap( 24 );         //: write of long words 


	 Read_swap ((24)* 2, 1, 1, 1); //23: read  bytes AB/CD), little endian

 


 test_num = 240; 
  
 $display ("\nTime =%0t. Test #240. FIFO operation with byte sizes of words.Little endian \n", $time);

       
                ////// FIFO operation with different sizes of words//////////
       Reset_FIFO (  0 ,1 ,1, 0, 1,1,1 );   // 20 + 21: Master reset with 8 offset, 
                                        // LITTLE Endian (BE=1),CY mode 
       


       Write_swap( FIFOSIZE+2 );         //22: write of long words 


       Read_swap ((FIFOSIZE+2)* 2, 1, 1, 1); //23: read  bytes AB/CD),little endian
       Write_swap( 10);                    //22: write of long words 



test_num = 250; 

   
 $display ("\nTime =%0t. Test #250. FIFO write A of words in FWFT. \n", $time);

       
                ////// FIFO operation with different sizes of words//////////
       Reset_FIFO (  0 ,1 ,1, 1,0,0,0 );           // Master reset with 8 offset, 
                                               //Big Endian (BE=1), FWFT mode
       Write_A (  20 );                        //write of long words 




 test_num = 260; 
  
 $display ("\nTime =%0t. Test #260. FIFO operation with byte sizes of words.Little endian \n", $time);
       
                ////// FIFO operation with different sizes of words//////////
       Reset_FIFO (  0 ,1 ,1, 1, 0,0,0 );   // Master reset with 8 offset, 
                                        // Big Endian (BE=1),FWFT mode 
       

       Write_swap( 24 );         //: write of long words 


	 Read_swap ((23), 1, 0, 0); //read  long words, big endian

 
 ////////////////////// FIFO FWFT mode operations //////////////////////////////////////

 
test_num = 270;    
 $display ("\nTime =%0t. Test #270. FIFO FWFT mode operations . \n", $time);
     
       Reset_FIFO (  0 ,1 ,1, 1,0,1,1 ); //Master reset with 8 offset, Big Endian (BE=1),FWFT mode

       Write_swap( 12);              //FIFO:write of long words
       Read_swap ( 12*4, 2, 1, 1);   //FIFO:read of bytes

 

test_num = 280;    
 $display ("\nTime =%0t. Test #280. FIFO FWFT mode operations . \n", $time);


       Reset_FIFO (  0 ,1 ,1, 1,0,1,1 );       //Master reset with 8 offset, Big Endian (BE=1),FWFT mode

       Write_swap( FIFOSIZE);      //FIFO:write of long words
       Read_swap ( FIFOSIZE*4, 2, 1, 1); //FIFO:read of bytes

 

 ////////////////////// Mail registers operations Checking //////////////////////////////////////
 test_num = 290;
    
 $display ("\nTime =%0t. Test #290. Mail1 registers operations Checking . \n", $time);

       Reset_FIFO (  0 ,1 ,1, 1,0,0,0 );       //74: Master reset with 8 offset, Big Endian (BE=1),FWFT mode

       Mail1_Write  ( 36'h 777777777,'b0X);   //80: Write in  Mail1 register ( A bus)
	$display ( " Write in  Mail1 register ( A bus) 35'h 777777777" );

       Mail1_Read_B ( 36'h 777777777, 'b0X);     //81: Checking by reading, that Bus B has Mail1 value(word)
	$display ( " Checking by reading, that Bus B has Mail1 value( long word)"   );
       

repeat (10) @(posedge CLKA);    // delay


test_num = 300;    
 $display ("\nTime =%0t. Test #300. Mail2 registers operations Checking . \n", $time);

    
       Mail2_Write  ( 36'o 123456123456,'b00);        //83: Write in  Mail2 register (word)

	$display ( " Write in  Mail2 register (long word)"   );
       
       Mail2_Read_A ( 36'o 123456123456,'b00);          //84: Checking by reading, that Bus A has Mail2 value(word)
	
      $display ( " Checking by reading, that Bus A has Mail2 value(long word)");       


 test_num = 310;    
 $display ("\nTime =%0t. Test #310. Mail1 registers operations Checking . \n", $time);
       Reset_FIFO (  0 ,1 ,1, 1,0,0,0 );       //74: Master reset with 8 offset, Big Endian (BE=1),FWFT mode


       Mail1_Write  ( 36'h 777777777,'b10);   //80: Write in  Mail1 register ( A bus)
	$display ( " Write in  Mail1 register ( A bus) 35'h 777777777" );

       Mail1_Read_B ( 36'h 777777777, 'b10);     //81: Checking by reading, that Bus B has Mail1 value(word)
	$display ( " Checking by reading, that Bus B has Mail1 value(word)"   );



repeat (10) @(posedge CLKA);    // delay
 
     
 test_num = 320;
    
 $display ("\nTime =%0t. Test #320. Mail2 registers operations Checking . \n", $time);
   
	Mail2_Write  ( 36'h 321123321,'b11);        //85: Write in  Mail2 register (byte) -failed
 
 $display ( " Write in  Mail2 register (byte) ");         
      
      Mail2_Read_A ( 36'h 321123321,'b11);  //86: Checking by reading, that Bus A has  Mail2 value(byte)
        
 $display ( " Checking by reading, that Bus A has  Mail2 value(byte)");         

////////////////////////////////// RETRANSMIT OPERATION //////////////////////////////
  test_num = 330; 
  
 $display ("\nTime =%0t. Test #330. FIFO operation with byte sizes of words. \n", $time);

       
                ////// FIFO operation with different sizes of words//////////
       Reset_FIFO (  0 ,1 ,1, 1, 1,0,0 );   // 20 + 21: Master reset with 8 offset, 
                                            // BIG Endian (BE=1),CY mode 
       
       Write_swap( 20 );         //22: write of long words 

       Read_swap ((6), 1, 0, 0); //23: read long words (bytes AB/CD),big endian

       RETRANSMIT; 
	 
       Read_swap ((20), 1, 0, 0); //23: read long words (bytes AB/CD),big endian




///////////////////////////////////////////



 test_num = 340; 
  
 $display ("\nTime =%0t. Test #340. FIFO operation with different sizes of words. \n", $time);

       
                ////// FIFO operation with different sizes of words//////////
       Reset_FIFO (  0 ,1 ,1, 1, 1,0,0 );           //20 + 21: Master reset with 8 offset, 
                                               //Big Endian (BE=1),CY mode 

	
       Write_swap( 24 );         //22: write of long words 

       Read_swap ((24), 1, 0, 0); //23: read long words (bytes AB/CD),big endian
	

///////////////////////////////////////////


 test_num = 350; 
  
 $display ("\nTime =%0t. Test #350. FIFO operation with different sizes of words. \n", $time);

       
                ////// FIFO operation with different sizes of words//////////
       Reset_FIFO (  0 ,1 ,1, 1, 1,0,0 );           //20 + 21: Master reset with 8 offset, 
                                               //Big Endian (BE=1),CY mode 
       
	
       Write_swap( 100 );         //22: write of long words 

       Read_swap ((100), 1, 0, 0); //23: read long words (bytes AB/CD),big endian
       Write_swap( 20);                   //22: write of long words 

	
///////////////////////////////////////////

      

        /////// FIFO flags checking ///////////////////

 test_num = 360; 
  
 $display ("\nTime =%0t. Test #360. FIFO:write of long words. \n", $time);

       Reset_FIFO (  0 ,1 , 1, 1, 1, 0, 1 );       //68: Master reset with 8 offset, Big Endian (BE=1)
       
       Write_swap( FIFOSIZE+2);      //70:  FIFO:write of long words
 
test_num = 370; 
  
 $display ("\nTime =%0t. Test #370. FIFO operation with different sizes of words.FIFO:read of FIFOSIZE - 6 long words \n", $time);

       Read_swap ( FIFOSIZE - 6, 1, 0, 1); //71:  FIFO:read of long words

test_num = 380; 
 
$display ("\nTime =%0t. Test #380. FIFO:write of 10 long words. \n", $time);

       Write_swap( 6);      //70:  FIFO:write of long words

test_num = 390;

$display ("\nTime =%0t. Test #390. FIFO: read of long words.FIFO: read of 10 long words \n", $time);

       Read_swap ( 6, 'h1fb, 0, 1);           //73:  FIFO: read of long words
 

        /////// FIFO flags checking with different clocks ///////////

 test_num = 400;
 
@(negedge CLKB);

#(tCLKBH - tRSTS);

 tCLKB_HPER = 7000; // 67 MHZ

 $display ("\nTime =%0t. Test #400. FIFO:flags checking with different clocks, write and read of long words. \n", $time);
 $display ("\nTime =%0t. Test #400. Attention! CLKB frequency was changed from 133 MHZ to 67 MHZ. Frequency of CLKA=133MHZ. \n", $time);

@(posedge CLKB);
 
  Reset_FIFO_B (  0 ,1 , 1, 1, 1, 0, 1 );     //Master reset with 8 offset, Big Endian (BE=1)

  //Reset_FIFO (  0 ,1 , 1, 1, 1, 0, 1 );     //Master reset with 8 offset, Big Endian (BE=1)
 
 fork
 
  Write_check_FF ( 20);      
  Read_check_EF  ( 20 , 1, 0, 1);
 
 join



        /////// FIFO flags checking with different clocks ///////////

 test_num = 410; 
@(posedge CLKB);
@(posedge CLKA);

 tCLKB_HPER = 7000; // 67 MHZ

 $display ("\nTime =%0t. Test #410. FIFO:flags checking with different clocks, write and read of long words. \n", $time);

  Reset_FIFO (  0 ,1 , 1, 1, 1, 0, 1 );     //Master reset with 8 offset, Big Endian (BE=1)
 							  // long words	
fork
 
  Write_check_FF ( FIFOSIZE + 200);      
  Read_check_EF  ( FIFOSIZE + 200, 1, 0, 1);
 
 join

 ////////////////////// Mail1 register  operations Checking //////////////////////////////////////


// @(edgeCLK_AB == 1);

repeat (3)@ (posedge CLKA)

 tCLKB_HPER = 3750; // 67 MHZ

test_num = 420;
    
 $display ("\nTime =%0t. Test #420. Mail1 registers operations Checking . \n", $time);

       Reset_FIFO (  0 ,1 ,1, 1,0,0,0 );       //74: Master reset with 8 offset, Big Endian (BE=1)

       Mail1_Write  ( 36'h 777777777,'b11);   //80: Write in  Mail1 register ( A bus) byte
	$display ( " Write in  Mail1 register ( A bus) 36'h 777777777" );

       Mail1_Read_B ( 36'h 777777777, 'b11);     //81: Checking by reading, that Bus B has Mail1 value( byte)
	$display ( " Checking by reading, that Bus B has Mail1 value(byte)"   );
       
test_num = 430;
    
 $display ("\nTime =%0t. Test #430. Mail1 registers operations Checking . \n", $time);

       Reset_FIFO (  0 ,1 ,1, 1,0,0,0 );       //74: Master reset with 8 offset, Big Endian (BE=1)

       Mail1_Write  ( 36'h 555555555,'b10);   //80: Write in  Mail1 register ( A bus)  word
	$display ( " Write in  Mail1 register ( A bus) 36'h 555555555" );

       Mail1_Read_B ( 36'h 555555555, 'b10);     //81: Checking by reading, that Bus B has Mail1 value(  word)
	$display ( " Checking by reading, that Bus B has Mail1 value(word)"   );
       

test_num = 440;
    
 $display ("\nTime =%0t. Test #420. Mail1 registers operations Checking . \n", $time);

       Reset_FIFO (  0 ,1 ,1, 1,0,0,0 );       //74: Master reset with 8 offset, Big Endian (BE=1)

       Mail1_Write  ( 36'h 777777777,'b0X);   //80: Write in  Mail1 register ( A bus) long word
	$display ( " Write in  Mail1 register ( A bus) 36'h 777777777" );

       Mail1_Read_B ( 36'h 777777777, 'b0X);     //81: Checking by reading, that Bus B has Mail1 value( long word)
	$display ( " Checking by reading, that Bus B has Mail1 value(long word)"   );
       


repeat (10) @(posedge CLKA);    // delay


/////////////////////////////////////////////////////////////////////////////////

repeat (10) @(posedge CLKA);    // delay
       
   if(error) $display ("\nTime =%0t. ERROR: Test FAILED. See messages above.\n", $time);
   else      $display ( " CONGRATULATION, TEST HAS PASSED. Test pattern amount = %0d.\n ",test_num);
                                 
//       $display ( " CONGRATULATION, TEST HAS PASSED. Test pattern amount = %0d.\n ", test_num);
     
       # 100;
       $stop;
       //$finish;
    end



/// verilog version of chip

CY7C436X3AV #( 133,1024) FIFO
			( 	
			A,   		// Port-A data 
	     	  	AE_N,  	// Port-B  Almost-Empty Flag
	       	AF_N,  	// Almost-Full Flag
	       	B,  		// Port-B data 
	       	BE_FWFT_N,
	       	BM  ,
	       	CLKA,		// Port-A clock
	       	CLKB,		// Port-B clock 	 
	       	CSA_N , 	// Port-A Chip Select 
	       	CSB_N , 	// Port-B Chip Select 
	       	EF_N_OR, 	// Port-B Empty / Output Ready Flag 
	       	ENA, 	 
	       	ENB,  	 
	       	FF_N_IR,  
	       	FS1_SEN_N,	 
	       	FS0_SD,	 
	       	MBA,	 
	      	MBB, 
	      	MBF1_N, 
	      	MBF2_N,	 
	      	MRS1_N,	// Master Reset	 
	      	MRS2_N,	// Master Reset	 
	      	PRS_N,	// Partial Reset	
	      	RT_N,		// Partial Reset
	      	SIZE, 	// Bus Size Select
	      	SPM_N, 
	      	W_RA_N,
	      	W_N_RB
			 );
 
endmodule
