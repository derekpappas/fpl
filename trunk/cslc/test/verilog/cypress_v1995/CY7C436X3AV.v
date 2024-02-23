//////////////////////////////////////////////////////////////////////
// File name : CY7C436X3AV.v
//////////////////////////////////////////////////////////////////////
// Functionality : CY7C43643AV,CY7C43663AV,CY7C43683AV chip behavioral 
//                 model 
// Source:  CYPRESS Data Sheet : "CY7C43643AV,CY7C43663AV,CY7C43683AV 
//          3.3V 1K/4K/16K X 36 Unidirectional Synchronous FIFO 
//          w/Bus Matching" 
//          Version: August 11, 2000
///////////////////////////////////////////////////////////////////////
// Developed by INTRINSIX CORP.
//
// version |     author      	     | mod date | changes made
//   V1.0  | Mikhail Aleksandrovich| 02/09/01 | initial coding
//         |                       |          | debugged
//
// Model represents the behavior of three chips: CY7C43643AV,
// CY7C43663AV,CY7C43683AV.
//   To select time operation rate you need to assign value to 
// OP_RATE  parameter (see readme.txt file). 
//   To select necessary chip you need
// to assign value to FIFOSize parameter(see readme.txt file).  
//                 
///////////////////////////////////////////////////////////////////////
// MODULE DECLARATION  //
///////////////////////////////////////////////////////////////////////

`timescale 1 ps/1 ps

`define FIFOWORDLENGTH  36

module CY7C436X3AV 
			(
			A,   		// Port-A data 
	     	  	AE_N,  	// Port-B  Almost-Empty IN
	       	AF_N,  	// Almost-Full IN
	       	B,  		// Port-B data 
	       	BE_FWFT_N,  // BIG ENDIAN/FIRST WORD FALL TROUGH
	       	BM  ,		// Bus mutch select
	       	CLKA,		// Port-A clock
	       	CLKB,		// Port-B clock 	 
	       	CSA_N , 	// Port-A Chip Select 
	       	CSB_N , 	// Port-B Chip Select 
	       	EF_N_OR, 	// Port-B Empty / Output Ready IN 
	       	ENA, 	      // Port A enable
	       	ENB,  	// Port B enable 
	       	FF_N_IR,  	// Port B full/Input ready IN
	       	FS1_SEN_N,	// IN offset select1/Seriall enable
	       	FS0_SD,	// IN offset select0/Seriall enable
	        	MBA,	 	// Port A mailbox select
	      	MBB,        // Port B mailbox select
	      	MBF1_N, 	// Mail 1 Register IN
	      	MBF2_N,	// Mail 2 Register IN 
	      	MRS1_N,	// Master Reset	 
	      	MRS2_N,	// Master Reset	 
	      	PRS_N,	// Partial Reset	
	      	RT_N,		// Retransmit
	      	SIZE, 	// Bus Size Select
	      	SPM_N, 	// Serial programming
	      	W_RA_N,	// Port A write/read select
	      	W_N_RB	// Port B write/read select
			);
inout	[0:`FIFOWORDLENGTH - 1] A; 	// Port-A data
output	AE_N; 			// Port-B  Almost-Empty IN 
output	AF_N;  			// Almost-Full IN
inout [0:`FIFOWORDLENGTH - 1] B; 	// Port-B data 
input		BE_FWFT_N;  		// BIG ENDIAN/FIRST WORD FALL TROUGH
input	      BM  ;       		// Bus mutch select
input	      CLKA;       		// Port-A clock
input	      CLKB; 			// Port-B clock	 
input	      CSA_N ; 			// Port-A Chip Select  
input	      CSB_N ; 			// Port-B Chip Select  
output	EF_N_OR; 	 
input	      ENA; 	 
input	      ENB;  	 
output	FF_N_IR;  
input	      FS1_SEN_N;	 
input	      FS0_SD;	 
input	      MBA;	 
input	      MBB; 
output	MBF1_N; 
output	MBF2_N;	 
input	      MRS1_N;	 
input	      MRS2_N;	 
input	      PRS_N;	
input	      RT_N;
input	      SIZE; 
input	      SPM_N; 
input	      W_RA_N;
input	      W_N_RB;

///////////////////// PHYSICAL CHARACTERISTICS /////////////////////
///////////////////// OVER THE FIFO SIZE RANGE      ////////////////
////////////////////////////////////////////////////////////////////
parameter OP_RATE  = 133; 

parameter FIFOSIZE       = 16384; // FIFO size for  43683 chip, m.b. 1K,4k, 16k

// OFFSET size for  43683 chip,m.b. 10,12,14 :
parameter OFFSET_SIZE    = (FIFOSIZE == 16384) ? 14 : ((FIFOSIZE == 4096) ? 12 : 10);

////number of bits for serial programming for 43683 chip,
					    //m.b. 20,24,28 :
parameter NUMBITPROG = (FIFOSIZE == 16384) ? 28 : ((FIFOSIZE == 4096) ? 24 : 20);

/////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////
reg [0:`FIFOWORDLENGTH -1] FIFO [0:FIFOSIZE -1];

reg [0:15] WRITE_POINTER, WRITE_POINTER_DEL, READ_POINTER ;
reg [0:35] B_OUT;  		// Port-B data internal register 
reg [0:35] A_OUT;   		// Port-A data internal  register
 
reg FF_N_IR_IN;  // Full/Input Ready IN
reg EF_N_OR_IN;  // Empty/Output Ready IN
reg AE_N_IN;     // Almost Empty IN
reg AF_N_IN;     // Almost Full  IN
reg MBF1_N_IN ;  // mailbox 1 IN
reg MBF2_N_IN ;  // mailbox 1 IN
reg MRS1_VIOL ;    // MRS1 4 clock violation
reg MRS2_VIOL ;    // MRS2 4 clock violation
reg PRS_VIOL  ;    // PRS  4 clock violation
reg BE_FWFT_N_RG;  // for determine CY and FWFT modes 
reg BIG_ENDIAN;    //=1 if BIG ENDIAN; =0 if LITTLE ENDIAN
reg  FS0_SD_RG   ; // for choosing offset programming method	
reg  FS1_SEN_N_RG; // for choosing offset programming method
reg  SPM_N_RG ;    // for choosing offset programming method	
reg [0:OFFSET_SIZE -1] X,Y ; // AlFull-AlEmpty Offset regs
reg Y_COMPL;
reg [0 : 35] MAIL1_RG;
reg [0 : 35] MAIL2_RG;
reg  PROG_COMPL ;
integer SER_BIT_NUM;
reg [0 : 35] OUTPUT_RG;
reg [0 : 35] INPUT_RG ;
reg  PAR_PROG;   
reg  SER_PROG; 
wire FIRST_CELL_WRITE;
wire READ_ALM_FULL;
reg  READ_FIRST;
wire WRITE_ALM_EMP_CELL;
reg  WRITING, READING, READING_1;
reg  FIRST_WORD;
integer READ_NO;
integer COUNTWORDS, COUNTWORDS_P; 
wire [0:FIFOSIZE -1] COUNTWORDS_del;
wire READFULL;// READFULL signal =1 during tSKEW1 when 1-st word 
reg  LOAD_FWFT;
reg [0 : 35] AUXILIARY_RG;
reg [0 : 35] OUT_MATCH_RG;
integer LIMIT;
wire [2:0]  SIZE_BE;
reg  [0:35] FWFT_RG;
reg FIFO_STD_MODE;   //
reg FIRST_TIME;
// MVA reg IN_1 ; //for tskew
// MVA reg IN_3 ; //for tskew 
integer i,j,k;

////////////////////// TIMING CONFIGURATION  ////////////////

//parameter OP_RATE  = 133; 

reg [ 31:0] Op_rate ; 
initial begin Op_rate = OP_RATE; end

wire op67  = Op_rate ==  67; 
wire op100 = Op_rate == 100; 
wire op133 = Op_rate == 133;

reg [2:0]	FIFO_CLK_COUNT [0:(FIFOSIZE-1)] ;

wire WRITE_ENABLE; assign WRITE_ENABLE = (~CSA_N) & W_RA_N & ENA & FF_N_IR_IN;
wire PUSH;         assign PUSH	   = (~CSA_N)  & ENA &  (W_RA_N)  & !MBA ;
wire READ_ENABLE;  assign READ_ENABLE  = (~CSB_N)  & ENB &  (W_N_RB)  & EF_N_OR_IN;
wire POP;          assign POP		   = (~CSB_N)  & ENB &  (W_N_RB)  & !MBB ;


 
/////////////////////////SETUP-HOLD CHECK CONDITIONS //////////////
//FOR A (page 14)
wire A_cond_100;
assign A_cond_100 = ((Op_rate==100)&&(MBA=='b0)&&(MRS1_N=='b1)&&
			   (MRS2_N =='b1)&&(ENA=='b1)&&(ENB   =='b0)&&(FF_N_IR_IN=='b1));
wire A_cond_133;
assign A_cond_133 = ((Op_rate==133)&&(MBA=='b0)&&(MRS1_N=='b1)&&
			   (MRS2_N =='b1)&&(ENA=='b1)&&(ENB   =='b0)&&(FF_N_IR_IN=='b1)); 
wire A_cond_67;
assign A_cond_67  = ((Op_rate== 67)&&(MBA=='b0)&&(MRS1_N=='b1)&&
			   (MRS2_N =='b1)&&(ENA=='b1)&&(ENB   =='b0)&&(FF_N_IR_IN=='b1));

//for W_RA_N

wire W_RA_N_cond_100 = (Op_rate == 100)&&(MBA == 'b0) &&(MRS1_N=='b1);
wire W_RA_N_cond_133 = (Op_rate == 133)&&(MBA == 'b0) &&(MRS1_N=='b1);
wire W_RA_N_cond_67  = (Op_rate ==  67)&&(MBA == 'b0) &&(MRS1_N=='b1);

//for W_N_RB

wire W_N_RB_cond_100 = (Op_rate == 100)&&(MBB == 'b0) &&(MRS2_N=='b1);
wire W_N_RB_cond_133 = (Op_rate == 133)&&(MBB == 'b0) &&(MRS2_N=='b1);
wire W_N_RB_cond_67  = (Op_rate ==  67)&&(MBB == 'b0) &&(MRS2_N=='b1);

wire PORTA_MB_READ_ENABLE;  assign PORTA_MB_READ_ENABLE = (~CSA_N)  & ENA &  (~W_RA_N) & MBA ;
wire PORTB_MB_READ_ENABLE;  assign PORTB_MB_READ_ENABLE = (~CSB_N)  & ENB &  (W_N_RB)  & MBB ;

wire PORTA_MB_WRITE_ENABLE; assign PORTA_MB_WRITE_ENABLE = (~CSA_N)  & ENA &  (W_RA_N)  & MBA & MBF1_N ;
wire PORTB_MB_WRITE_ENABLE; assign PORTB_MB_WRITE_ENABLE = (~CSB_N)  & ENB &  (~W_N_RB) & MBB & MBF2_N ;



wire op133_pA_wr	   = op133 & !MRS1_N & !MRS2_N  & (WRITE_ENABLE | PORTA_MB_WRITE_ENABLE) ;
wire op100_pA_wr	   = op100 & !MRS1_N & !MRS2_N  & (WRITE_ENABLE | PORTA_MB_WRITE_ENABLE) ;
wire op67_pA_wr	   = op67  & !MRS1_N & !MRS2_N  & (WRITE_ENABLE | PORTA_MB_WRITE_ENABLE) ;


wire op133_ena	   = op133 & !MRS1_N  & !MRS2_N  & ENA ;
wire op100_ena	   = op100 & !MRS1_N  & !MRS2_N  & ENA ;
wire op67_ena	   = op67  & !MRS1_N  & !MRS2_N  & ENA ;


wire op133_csa_n	   = op133 & !MRS1_N  & !MRS2_N & !CSA_N ;
wire op100_csa_n     = op100 & !MRS1_N  & !MRS2_N  & !CSA_N ;
wire op67_csa_n	   = op67  & !MRS1_N  & !MRS2_N  & !CSA_N ;

wire op133_ena_csa_n	= op133 & !MRS1_N   & !MRS2_N & ENA & !CSA_N ;
wire op100_ena_csa_n	= op100 & !MRS1_N   & !MRS2_N & ENA & !CSA_N ;
wire op67_ena_csa_n	= op67  & !MRS1_N   & !MRS2_N & ENA & !CSA_N ;

wire op133_enb		= op133 & !MRS1_N  & !MRS2_N  & ENB ;
wire op100_enb		= op100 & !MRS1_N  & !MRS2_N  & ENB ;
wire op67_enb		= op67  & !MRS1_N  & !MRS2_N  & ENB ;

wire op133_csb_n	= op133 & !MRS1_N  & !MRS2_N  & !CSB_N ;
wire op100_csb_n	= op100 & !MRS1_N  & !MRS2_N  & !CSB_N ;
wire op67_csb_n	= op67  & !MRS1_N  & !MRS2_N  & !CSB_N ;

wire op133_enb_csb_n	= op133 & !MRS1_N  & !MRS2_N  & ENB & !CSB_N ;
wire op100_enb_csb_n	= op100 & !MRS1_N  & !MRS2_N  & ENB & !CSB_N ;
wire op67_enb_csb_n	= op67  & !MRS1_N  & !MRS2_N  & ENB & !CSB_N ;

reg MODE_LATCH_ENA;

wire 	op133_mode_latchA = MODE_LATCH_ENA & op133 ;
wire 	op100_mode_latchA = MODE_LATCH_ENA & op100 ;
wire 	op67_mode_latchA  = MODE_LATCH_ENA & op67 ;



`include "CY7C436X3AV_timing.v"

time 	tRTR ;
time	tSKEW1 ;
time	tSKEW2 ;

//////////////// DELAYS ASSERTION //////////////////////////
initial
begin
	case(Op_rate)
		133: begin
			tSKEW1 = tSKEW1_133; 
			tSKEW2 = tSKEW2_133;
			tRTR 	 = tRTR_133;
	     	     end 	
		100: begin
			tSKEW1 = tSKEW1_100; 
			tSKEW2 = tSKEW2_100;
			tRTR 	 = tRTR_100;
	           end
		67: begin
			tSKEW1 = tSKEW1_67; 
			tSKEW2 = tSKEW2_67;
			tRTR 	 = tRTR_67;
	          end
	endcase
end
  

//////////// task for bus matching and byte swapping (FIFO read)//////////////////
      
  task BUS_MAT_READ;       // executed, when LOW-to_HIGH transition CLKB reads FIFO
  			         // result is OutReg state	
  begin  
    if (!FIFO_STD_MODE && LOAD_FWFT ) // FWFT_Mode
    begin 
        AUXILIARY_RG = FWFT_RG ; // FWFTreg contain the 1st word written in FWFT_mode
    end     
    else 
      if (READ_NO == 1) 
      begin 
           AUXILIARY_RG = FIFO [READ_POINTER];
           if (COUNTWORDS !=0)           
           begin
               COUNTWORDS_P = COUNTWORDS_P -1;
               COUNTWORDS  <= COUNTWORDS_P;
           end            
       end 
    else;         
  	 casex (SIZE_BE)

         3'bx0x:  // long word reading
	     OUT_MATCH_RG = AUXILIARY_RG;
	   3'b110:  // big endian word reading
	     case (READ_NO)
	       1:begin
		 OUT_MATCH_RG [9:17] =  AUXILIARY_RG[27:35];
             OUT_MATCH_RG [0:8]  =  AUXILIARY_RG[18:26];
             OUT_MATCH_RG [18:35]= 18'oXXXXXX;  end

	       2:begin
		 OUT_MATCH_RG [9:17] =  AUXILIARY_RG[9:17];
             OUT_MATCH_RG [0:8]  =  AUXILIARY_RG[0:8];
             OUT_MATCH_RG [18:35]= 18'oXXXXXX;  end


	     endcase // case(READ_NO)
	   3'b010:  // little endian word reading
	     case (READ_NO)
	       1:begin
		 OUT_MATCH_RG [9:17] =  AUXILIARY_RG[9:17];
             OUT_MATCH_RG [0:8]  =  AUXILIARY_RG[0:8];
             OUT_MATCH_RG [18:35]= 18'oXXXXXX;  end

	       2:begin
		 OUT_MATCH_RG [9:17] =  AUXILIARY_RG[27:35];
             OUT_MATCH_RG [0:8]  =  AUXILIARY_RG[18:26];
             OUT_MATCH_RG [18:35]= 18'oXXXXXX;  end

	     endcase // case(READ_NO)
	   3'b111:  // big endian byte reading
	     case (READ_NO)
	       1:begin
		 OUT_MATCH_RG [0:8] =  AUXILIARY_RG[27:35];
		 OUT_MATCH_RG [9:35] = 27'oXXXXXXXXX;  end

	       2:begin
		 OUT_MATCH_RG [0:8] =  AUXILIARY_RG[18:26];
		 OUT_MATCH_RG [9:35]= 27'oXXXXXXXXX;  end

	       3:begin
		 OUT_MATCH_RG [0:8] =  AUXILIARY_RG[9:17];
		 OUT_MATCH_RG [9:35]= 27'oXXXXXXXXX;  end

	       4:begin
		 OUT_MATCH_RG [0:8] = AUXILIARY_RG[0:8];
		 OUT_MATCH_RG [9:35]= 27'oXXXXXXXXX;  end

	     endcase // case(READ_NO)
	   3'b011:  // little endian byte reading
	     case (READ_NO)
	       1:begin
		 OUT_MATCH_RG [0:8] =  AUXILIARY_RG[0:8];
		 OUT_MATCH_RG [9:35]= 27'oXXXXXXXXX;  end

	       2:begin
		 OUT_MATCH_RG [0:8] =  AUXILIARY_RG[9:17];
		 OUT_MATCH_RG [9:35]= 27'oXXXXXXXXX;  end

	       3:begin
		 OUT_MATCH_RG [0:8] =  AUXILIARY_RG[18:26];
		 OUT_MATCH_RG [9:35]= 27'oXXXXXXXXX;  end
	       4:begin
		 OUT_MATCH_RG [0:8] =  AUXILIARY_RG[27:35];
		 OUT_MATCH_RG [9:35]= 27'oXXXXXXXXX;  end


	     endcase // case(READ_NO)
	 endcase // casex(SIZE_BE)
      if  (READ_NO != LIMIT) 
           READ_NO  = READ_NO +1; 
      else READ_NO  = 1;      // counter of Byte/Word for reading words/bytes

      OUTPUT_RG = OUT_MATCH_RG;
  end
 endtask 

/////////////////////////////////////////////////
////    BEHAVIORAL SECTION (without timings) ////
/////////////////////////////////////////////////
 

/////////////////////// Master Reset of FIFO ///////////////////////////

  always      
     	begin
      @( negedge MRS1_N or negedge MRS2_N );
	if (PRS_N == 1'b0)
	  begin
	     $display ("ERROR: Partial Reset should be high during Master Reset.");
	     $finish;
	  end
	else 
      begin
	   MRS1_VIOL     = 0; 
	   MRS2_VIOL     = 0;
 	   //FF_N_IR_IN  = 0;  // Full/Input Ready FLAG
 	   AF_N_IN     = 1;  // Almost Full  FLAG
	   MBF1_N_IN   = 1;
	   MBF2_N_IN   = 1;
         COUNTWORDS  = 0;
         COUNTWORDS_P  = 0;
         WRITE_POINTER = 16'b0; 
	   READ_POINTER  = 16'b0;
         MAIL1_RG      = 36'b0;  
         MAIL2_RG      = 36'b0;
         OUTPUT_RG     = 36'b0;
	   PAR_PROG	     = 0;	
	   SER_PROG      = 0;
	   PROG_COMPL    = 0;
         SER_BIT_NUM   = 0;
         FIRST_WORD    = 0;
         FIRST_TIME    = 1;
	   READ_FIRST    = 0;
         MRS1_VIOL     = 0;
         MRS2_VIOL     = 0;
	   READ_NO       = 1;  
         X = 0;
	   Y = 0;
         LOAD_FWFT = 0;
         MODE_LATCH_ENA =0;
         READING = 0;
         READING_1 = 0;

        if (op133) #(tRSTS_133);
        else if (op100) #(tRSTS_100);
        else #(tRSTS_67);

       fork
         begin 
          repeat (4) @( posedge CLKA)
          if (op133) #(tRSTH_133);
          else if (op100) #(tRSTH_100);
          else #(tRSTH_67);
 
	if (MRS1_N) MRS1_VIOL =1 ;   // 4 CLKA clocks checking
         end
         begin
          repeat (4) @( posedge CLKB)
          if (op133) #(tRSTH_133);
          else if (op100) #(tRSTH_100);
          else #(tRSTH_67);
 
	if (MRS1_N) MRS1_VIOL =1 ;   // 4 CLKB clocks checking
         end 
         begin 
          repeat (4) @( posedge CLKA)
          if (op133) #(tRSTH_133);
          else if (op100) #(tRSTH_100);
          else #(tRSTH_67);
 
	if (MRS2_N) MRS2_VIOL =1 ;   // 4 CLKA clocks checking
         end
         begin
          repeat (4) @( posedge CLKB)
          if (op133) #(tRSTH_133);
          else if (op100) #(tRSTH_100);
          else #(tRSTH_67);
 
	if (MRS2_N) MRS2_VIOL =1 ;   // 4 CLKB clocks checking
         end
       join

       if ( !MRS1_VIOL && !MRS2_VIOL)
       begin         	 
	    fork
      	 @ (posedge MRS1_N);
		 @ (posedge MRS2_N);
          join
   
         if (BE_FWFT_N )   
	   begin
             BIG_ENDIAN    = 1; //big endian
         end
         else
         begin 
             BIG_ENDIAN    = 0; //little endian
	   end
   
	    //mva   BE_FWFT_N_RG = BE_FWFT_N;  // for determine CY and FWFT modes
 
		 FS0_SD_RG    = FS0_SD;     // for choosing offset programming method	
		 FS1_SEN_N_RG = FS1_SEN_N;
		 SPM_N_RG     = SPM_N;      // for choosing offset programming method

          repeat (2) @( posedge CLKA );

             if ( !SER_PROG ) FF_N_IR_IN <= 1;
             BE_FWFT_N_RG  = BE_FWFT_N;  // for determine CY and FWFT modes 
	       FIFO_STD_MODE = BE_FWFT_N_RG; // =1, if CY Std mode, 
                                           // =0, if first-word fall-through mode

       end 
      else $display ("Time = %0d. CY7C436X3AV.FIFO Master Reset time is less 4 periods .\n ", $time); 
   end      
end //always

////////////// Partial Reset of FIFO  ////////////////

  always                                 
     begin
      @( negedge PRS_N );
	if (MRS1_N ==1'b0 || MRS2_N == 1'b0)
	  begin
	     $display ("ERROR: CY7C436X3AV.Master Reset should be high during Partial Reset.");
	     $finish;
	  end
	else
	 begin	
        PRS_VIOL     = 0; 
        WRITE_POINTER= 16'b0; 
	  READ_POINTER = 16'b0;	  
        //FF_N_IR_IN = 0;  // Full/Input Ready FLAG
 	  AF_N_IN    = 1;  // Almost Full  FLAG
	  MBF1_N_IN  = 1;  // MAIL1 FLAG
	  MBF2_N_IN  = 1;  // MAIL2 FLAG
        MAIL1_RG     = 36'b0;  
        MAIL2_RG     = 36'b0;
        OUTPUT_RG    = 36'b0;
        FIRST_WORD   = 0;
        FIRST_TIME   = 1;  
        READ_FIRST   = 0;
	  MRS1_VIOL    = 0;
        MRS2_VIOL    = 0;
	  READING   = 0;
	  READING_1 = 0;
	  LOAD_FWFT = 0;
        COUNTWORDS   <= 0; 
        COUNTWORDS_P <= 0;
        if (op133) #(tRSTS_133);
        else if (op100) #(tRSTS_100);
        else #(tRSTS_67);

	  fork
          begin 
            repeat (4) @( posedge CLKA)
          	if (op133) #(tRSTH_133);
          	else if (op100) #(tRSTH_100);
          	else #(tRSTH_67);
 
		if (PRS_N) PRS_VIOL =1 ;   // 4 CLKA clocks checking
          end
          begin
            repeat (4) @( posedge CLKB)
          	if (op133) #(tRSTH_133);
          	else if (op100) #(tRSTH_100);
          	else #(tRSTH_67);
 
		if (PRS_N) PRS_VIOL =1 ;   // 4 CLKB clocks checking
          end 
        join

        if ( !PRS_VIOL )
        begin
          @(posedge PRS_N);


	    fork  
	 	begin repeat (2) @( posedge CLKA );end
	 	begin repeat (2) @( posedge CLKB );end
	    join
	    	 //COUNTWORDS   <= 0; 
             //COUNTWORDS_P <= 0;
          if ( !SER_PROG ) FF_N_IR_IN <= 1; //memory location is free
        end 
        else $display ("Time = %0d. CY7C436X3AV. FIFO Partial Reset time is less 4 periods .\n ", $time); 
   end    
end //always

// Loading FIFO AlFull-AlEmpty Offset regs X,Y

   always 
   begin
    @( posedge MRS1_N or posedge MRS2_N )  // Loading FIFO AlFull-AlEmpty Offset regs X,Y
     if(MRS1_N=='b1 && MRS2_N =='b1)
     begin	  
//////////////////  PRESET OFFSET   /////////////// 

        case ( {SPM_N,FS1_SEN_N,FS0_SD})          //  TABLE 1
             3'b111: begin X = 64; Y = 64; PROG_COMPL='b1; SER_PROG=0; PAR_PROG=0; end
             3'b110: begin X = 16; Y = 16; PROG_COMPL='b1; SER_PROG=0; PAR_PROG=0; end
             3'b101: begin X =  8; Y =  8; PROG_COMPL='b1; SER_PROG=0; PAR_PROG=0; end
	       3'b100: begin PAR_PROG = 1; SER_PROG = 0; X = 0; Y = 0; end
	       3'b010: begin SER_PROG = 1; PAR_PROG = 0; X = 0; Y = 0; end //SER_BIT_NUM=0; 
	  endcase
     end
   end

assign SIZE_BE = {BIG_ENDIAN, BM, SIZE};

always @( posedge PAR_PROG //or posedge CLKA
         )
   begin    
     if(MRS1_N=='b1 && MRS2_N =='b1)
     begin

//////  programming the Almost empty and Almost full FLAGs  //////

//////////// parallel programming //////////// 
	  
	  if(PAR_PROG =='b1)
	  begin
           repeat(3) @( posedge CLKA ); //mva
  		if ((W_RA_N =='b1)&&(FF_N_IR_IN =='b1)) //FF_N_IR is set high
		     Y[0:OFFSET_SIZE-1]= A;
                 Y_COMPL = 1;       
	     @( posedge CLKA );
	      if ((W_RA_N =='b1)&&(FF_N_IR_IN =='b1)&& (Y_COMPL == 1))
		begin
		     X[0:OFFSET_SIZE-1]= A; 
		     PROG_COMPL        ='b1;
                 PAR_PROG          ='b0;
                 Y_COMPL = 1;       
            end
	  end //parallel programming
     end
end
//////////// serial  programming //////////////// 
always @(posedge SER_PROG )
   begin
    //@( posedge MRS1_N or posedge MRS2_N or posedge PRS_N)  // Loading FIFO AlFull-AlEmpty Offset regs X,Y
     if((MRS1_N=='b1 && MRS2_N =='b1)||(PRS_N=='b1 ))
     begin
	    if (SER_PROG =='b1) 
	     begin
		  SER_BIT_NUM  ='b0;

		  @( posedge CLKA );  	
		 //@( posedge CLKA );  	

		  for(SER_BIT_NUM=0;SER_BIT_NUM<NUMBITPROG;SER_BIT_NUM=SER_BIT_NUM+1)
	  	  begin
		   @( posedge CLKA );
		   
		    if ((FS1_SEN_N==0)&&(SER_BIT_NUM < NUMBITPROG/2))
		    begin
			  Y = Y[0:OFFSET_SIZE-1]<<1;
			  Y ={Y[0:OFFSET_SIZE-2],FS0_SD};
		    end
		    else
			  if((FS1_SEN_N==0)&&(SER_BIT_NUM >= (NUMBITPROG/2))&&
                        (SER_BIT_NUM < NUMBITPROG ))
		  	  begin
		 	       X =  X[0:OFFSET_SIZE-1]<<1;
			       X = {X[0:OFFSET_SIZE-2],FS0_SD};
		    	     if(SER_BIT_NUM == NUMBITPROG -1) 
				begin
				  PROG_COMPL ='b1;
 				  FF_N_IR_IN ='b1;
		  	      end
			   end// if
	        end //for
 	     end//ser_prog
	  end//end MRS_N      
   end //always

///// Reset Bus Matching /////


   always @(SIZE_BE )
     begin
	     READ_NO <= 1;
	    casex (SIZE_BE)   // SIZE_BE = {BigEndian,BM,SIZE}
	  	3'bx0x:
	    	  LIMIT <= 1;  // long word (36-bit)
	  	3'b110, 3'b010:
	    	  LIMIT <= 2;  // word (18-bit)
	  	3'b111, 3'b011:
	    	  LIMIT <= 4;  // byte (9-bit)
	    endcase // casex(SIZE_BE)
   end // Reset Bus Matching

/*

   always @(SIZE_BE )
     begin
       if (PROG_COMPL )
          $display ("Time = %0d. Warning: CY7C436X3AV. Attempt of change SIZE and Bus Match Select during FIFO operation.\n ", $time); 
       
     end // 
*/
/////////// choise CY Std mode or first-word fall-through mode//////

always 
     begin
       @(posedge MRS1_N or posedge MRS2_N or posedge PRS_N) /////////P.20 
        if((MRS1_N=='b1 && MRS2_N =='b1)||(PRS_N =='b1 ))
        begin   
	    @( posedge CLKA );
          MODE_LATCH_ENA = 'b1; 
	    //@( posedge CLKA );
          //@( posedge CLKA );
	    //FIFO_STD_MODE <= BE_FWFT_N_RG; // =1, if CY Std mode, 
                                         // =0, if first-word fall-through mode
	  end
	end


//////////////// WRITE CLK ACCOUNTING  ////////////////////////////


always @(posedge CLKA   or posedge CLKB or 
         negedge MRS1_N or negedge PRS_N or negedge RT_N)
begin

	if (!MRS1_N ||!PRS_N)	
	begin
		for (i=0; i < FIFOSIZE; i = i+1)	
		begin
		     FIFO_CLK_COUNT[i]	<=  3'b000;
		end			
	end	
	else 
	   if (!MBA && WRITE_ENABLE && PROG_COMPL )	
	   begin
		WRITE_POINTER_DEL	<= WRITE_POINTER ;
		#tSKEW1
		FIFO_CLK_COUNT[WRITE_POINTER_DEL]	<=  3'b001;
	   end

 	if ((!RT_N & !ENB & FIFO_STD_MODE) & (EF_N_OR) )	
	begin
		if (WRITE_POINTER == READ_POINTER)	
		begin
			for (i=0; i < FIFOSIZE; i = i+1)
			  FIFO_CLK_COUNT[i]	<=  3'b100;
		end
		else	
		begin
			for (i=0; i < WRITE_POINTER; i = i+1)
			  FIFO_CLK_COUNT[i]	<=  3'b100;
		end
	end
	else	
	begin
		for (j=0; j < FIFOSIZE; j=j+1 )	
		begin
			if ( (FIFO_CLK_COUNT[j] != 3'b000) && (FIFO_CLK_COUNT[j] != 3'b100) )	
				FIFO_CLK_COUNT[j] <= FIFO_CLK_COUNT[j] + 1;
		end
	end
	if (!MBB && READ_ENABLE )	
	begin
	    FIFO_CLK_COUNT[READ_POINTER] <= 3'b000 ;
	end	
end

////////// PORT A OPERATION /////////////////

reg [0 : 35] MAIL1_OUT;
reg [0 : 35] MAIL2_OUT;
reg          FIRST_WRITTEN; // FLAG of First Written Word  in  FWFT mode 

    always @( CSA_N or W_RA_N or ENA or MBA or MAIL2_OUT)
      if ( CSA_N | W_RA_N ) A_OUT = 36 'h ZZZZZZZZZ; // no chip-select and no read from MAIL2
      
      else  
        if (!CSA_N && !W_RA_N && MBA)
            A_OUT = MAIL2_OUT;
      
////////// FIFO WRITE OPERATION //////////// 

    always @( posedge CLKA)
     begin 
     
      case ( { CSA_N, W_RA_N, ENA, MBA}) 
      
        4 'b0110: if (FF_N_IR_IN =='b1 && PROG_COMPL=='b1) 
                  begin 
           ///////// FIFO write /////////                                                      
                     if (( COUNTWORDS == 0) && !FIFO_STD_MODE && FIRST_TIME)
                     begin 
                           FWFT_RG = A; FIRST_WRITTEN = 1; LOAD_FWFT = 1; //First written word in FWFT mode
                           READ_NO = 1;
                           FIRST_TIME = 0;  // Assign to OutReg
          // $display("CY7C436X3AV.Write FWFT, first word . WRITE_POINTER = %0d, A = %0h, ",WRITE_POINTER ,A);  

                     end  
                     else 
				  if (RT_N == 'b0)
                              $display("CY7C436X3AV. Atempt of writing when RT_N = Low");
                          else
                          begin 
                             FIFO [WRITE_POINTER] = A ;
         // $display("CY7C436X3AV.Write. WRITE_POINTER = %0d, A = %0h, ",WRITE_POINTER ,A);  
                                if ((WRITE_POINTER == FIFOSIZE-1)&&(COUNTWORDS_P == FIFOSIZE -1))  
                                     WRITE_POINTER <= 0;
					  else
                                    if ((WRITE_POINTER == FIFOSIZE-1))
                                         WRITE_POINTER <= 0; 
 
                                    else 
                                    begin
                                        WRITE_POINTER <= WRITE_POINTER +1;          
                                    end
                              COUNTWORDS_P = COUNTWORDS_P + 1;
                              COUNTWORDS  <= COUNTWORDS_P;

                          end
                  end        
	  4 'b0111: 
           begin 
                        if (MBF1_N_IN) 
				begin 
				    MAIL1_RG = A ;
////////////////////////// MAIL1 SIZING ///////////////////
 				    casex ({BM,SIZE})  
       				2'b0x:
	 				  MAIL1_OUT = MAIL1_RG;              // long word (36-bit)
       				2'b10:begin
	 				  MAIL1_OUT [0:17] = MAIL1_RG[0:17]; // word (18-bit)
	 				  MAIL1_OUT [18:35]= 18'oXXXXXX;     //
                              end 
                              2'b11:begin
	 				  MAIL1_OUT [0:8]  = MAIL1_RG[0:8];  // byte (9-bit)
	 				  MAIL1_OUT [9:35] = 27'oXXXXXXXXX;  //
                              end 
                              endcase 
				    MBF1_N_IN = 0; 
				end 
	     end // Mail 1 Write 
        4 'b0011: 
           begin  
                  MBF2_N_IN = 1; 
                  A_OUT = MAIL2_OUT ; 
           end // Mail 2 Read / set MBF2

    endcase
end


////////////////////// port B operations /////////////////////////////////

///////////////////// FIFO READ OPERATION /////////////////

                              
    always @( posedge CLKB) 
     begin   
      case ( { CSB_N, W_N_RB, ENB, MBB, RT_N} ) 
        5'b01101:
           begin
                if ((EF_N_OR_IN )&&(!LOAD_FWFT))                //////// FIFO Read //////////
                begin
                     BUS_MAT_READ;  // bus B matching FIFO read                        
                end
            end 
///////////////////////// MAIL2 WRITE /////////////////////////////////////////////
   // { CSB_N, W_N_RB, ENB, MBB, RT_N} //
	   5'b00111:  // Write from Port B into Mailbox2 Register
		 begin
		    if (MBF2_N_IN)
		      begin
			  MAIL2_RG = B;

////////////////////// MAIL2 SIZING ///////////////////
     			  casex ({BM,SIZE})  
       		    2'b0x:
	 	            MAIL2_OUT = MAIL2_RG;                        // long word (36-bit)
       	 	    2'b10:begin
	 		      MAIL2_OUT [0:17] =  MAIL2_RG[0:17];    // word (18-bit)
	 	            MAIL2_OUT [18:35]=  18'oXXXXXX;
			    end	
       		    2'b11:begin
	 		      MAIL2_OUT [0:8] =  MAIL2_RG[0:8];  // byte (9-bit)
     			      MAIL2_OUT [9:35]=  27'oXXXXXXXXX;
                      end
                    endcase // casex
 
			  MBF2_N_IN = 0;  // data had written into Mailbox2 Register
		      end
		 end
 ///////////////////////// MAIL1 READ /////////////////////////////////////////////

         5'b01111: 
              begin  
                MBF1_N_IN = 1; 
                //B_OUT = MAIL1_OUT; 
              end   // Mail 1 Read / set MBF1
        endcase
    end
 
///////////   Read pointer operation /////////////////////


always @(posedge CLKB or negedge MRS1_N or negedge PRS_N or negedge RT_N)
begin

	if (!MRS1_N || !PRS_N)
		READ_POINTER 	<= 16'h0000;
		
	else if (!RT_N && !ENB && BE_FWFT_N_RG)
	     begin	
		  READ_POINTER 	 <= 16'h0000;
		  COUNTWORDS_P     <= WRITE_POINTER;
              COUNTWORDS       <= COUNTWORDS_P;     
           end		
	else   
        if (!CSB_N && W_N_RB && ENB && !MBB && RT_N)
        begin
          if (EF_N_OR_IN )                                  
	    begin
		if (READ_POINTER == (FIFOSIZE -1))
		    READ_POINTER 	<= 16'h0000;
		else 
		    if ((READ_NO == 1)&&(LOAD_FWFT == 0))
		        READ_POINTER 	<= READ_POINTER + 1'b1 ;
          end  
	  end           
end

//////////////// Output to Port B ////////////////////

   always @(CSB_N or W_N_RB or MBB or ENB or OUTPUT_RG or LOAD_FWFT or EF_N_OR or CLKB or READ_NO)
     begin
	 if (CSB_N || !W_N_RB)
	     B_OUT = 36'hZZZZZZZZZ;  // no chip-select and no read from FIFO
      
	 else
           // @(posedge CLKB) 
           if((LOAD_FWFT == 1)&&(!CSB_N && W_N_RB && ENB && EF_N_OR )&& CLKB)
           begin
                if (READ_NO != LIMIT)
                begin  
                    BUS_MAT_READ;     
                    B_OUT = OUTPUT_RG ;  // send out FW in FWFT_Mode	              
                end
                else
                    if (READ_NO == LIMIT)
                    begin   
                        BUS_MAT_READ;    
	                  B_OUT = OUTPUT_RG ;  // send out FW in FWFT_Mode
				LOAD_FWFT = 0;
                    end
           end

	 else          
           if (!CSB_N && W_N_RB        //&& ENB 
               && !MBB 
               && RT_N                 //&& EF_N_OR 
               &&(LOAD_FWFT == 0) )
	     begin
	         B_OUT = OUTPUT_RG ;    // select from FIFO output register
	     end

	     else 
           if (!CSB_N && W_N_RB && MBB  )
	         B_OUT = MAIL1_OUT; // select from  Mail1 register
    end // always @ (CSB_N or W_N_RB or MBB or ENB or OUTPUT_RG )

 

/////////////////////   FLAGs behavior ///////////////////////

wire		AE_N_IN_RT;
wire		AF_N_IN_RT;			
wire		EF_N_OR_IN_RT;
wire		FF_N_IR_IN_RT;

reg	RT1_RTR ;
reg	RT1_RTR_2CLKA ;
reg	RT1_RTR_2CLKB ;

assign 	EF_N_OR_IN_RT = (RT1_RTR | (!MRS1_N)) ? EF_N_OR_IN: 1'bx ;

assign	FF_N_IR_IN_RT = (RT1_RTR | (!MRS1_N)) ? FF_N_IR_IN: 1'bx ;

assign	AF_N_IN_RT	  = (RT1_RTR_2CLKA | (!MRS1_N)) ? AF_N_IN: 1'bx ;

assign 	AE_N_IN_RT    = (RT1_RTR_2CLKB | (!MRS1_N)) ? AE_N_IN: 1'bx ;

///////////////////////// FLAGs outputs ////////////////////////////////

assign MBF1_N  = MBF1_N_IN ;  // Mail1 IN
assign MBF2_N  = MBF2_N_IN ;  // Mail2 IN


buf b1 (FF_N_IR, FF_N_IR_IN_RT) ;
buf b2 (EF_N_OR, EF_N_OR_IN_RT) ;


buf b3 (AF_N,  AF_N_IN_RT) ;

buf b4 (AE_N,  AE_N_IN_RT) ;

buf b5 (MBF1_N, MBF1_N_IN) ;

buf b6 (MBF2_N, MBF2_N_IN) ;


assign  #(tSKEW2)	COUNTWORDS_del = COUNTWORDS;


//------------------------------------------------------------
// IN delays related during/after Retransmit operation
//------------------------------------------------------------
// FF_N and EF_N becomes valid after tRTR period, after the deassertion of the RT1_N

always	begin
	RT1_RTR	<= 1'b1 ;
	
	@(negedge RT_N) RT1_RTR <= 1'b0 ;
	@(posedge RT_N) ;
	#tRTR
	RT1_RTR <= 1'b1 ;
end
//--------------------

// AF_N IN becomes valid , 2 CLKAs after the tRTR period.

always	begin
	RT1_RTR_2CLKA	<= 1'b1 ;
	
	@(negedge RT_N) 
       RT1_RTR_2CLKA <= 1'b0 ;
	@(posedge RT_N) ;
	#tRTR	;
	@(posedge CLKA) ; 
      @(posedge CLKA) ;
	 RT1_RTR_2CLKA <= 1'b1 ;
end

//--------------------

// AE_N IN becomes valid , 2 CLKBs after the tRTR period.

always	
begin
	  RT1_RTR_2CLKB <= 1'b1 ;	
	@(negedge RT_N)
        RT1_RTR_2CLKB <= 1'b0 ;
	@(posedge RT_N) ;
	#tRTR	;
	@(posedge CLKB) ;
      @(posedge CLKB) ;
	  RT1_RTR_2CLKB <= 1'b1 ;
end

///////////////// EF_N_OR FLAG FUNCTION //////////////////////

always @(posedge CLKB   or
         negedge MRS1_N or 
         negedge MRS2_N or 
         negedge PRS_N)	
begin

	if (!MRS1_N ||!MRS2_N ||!PRS_N  )	
	begin
		EF_N_OR_IN	<= 1'b0;
	end	
	else	
      begin
		if (EF_N_OR_IN)
      	begin
		   if (POP)	
		   begin
			if (((READ_POINTER +1) == WRITE_POINTER)&& (COUNTWORDS == 0))	
	
			begin
				EF_N_OR_IN	<= 1'b0;
			end
			else
                      if (((READ_POINTER +1) == WRITE_POINTER))	
			    begin
				EF_N_OR_IN	<= 1'b0;
			    end
			else	
			begin
		         if (( FIFO_CLK_COUNT[READ_POINTER +1]>=2)&& FIFO_STD_MODE )	
			   begin
				EF_N_OR_IN	<= 1'b1;
			   end
			   else 
			       if (( FIFO_CLK_COUNT[READ_POINTER +1]>=3)&& !FIFO_STD_MODE )	
			       begin
			      	EF_N_OR_IN	<= 1'b1;
			       end
			       else   if((COUNTWORDS <= 1))
                                   EF_N_OR_IN	<= 1'b0;
                   end
		    end
		end
		else	
		begin  
			/*
			 if (POP)
			    $display($time,":Warning :CY7C436X3AV. PortB read attempted when the Empty/OutputRdy flag was Low.");
		      */	 
			 if (READ_POINTER !== WRITE_POINTER)	
                   begin
				if (( FIFO_CLK_COUNT[READ_POINTER ]>=2)&& FIFO_STD_MODE )		
                        begin
					EF_N_OR_IN	<= 1'b1;
				end
				else 
                           if (( FIFO_CLK_COUNT[READ_POINTER ]>=3)&& !FIFO_STD_MODE )		
           			   begin
					   EF_N_OR_IN	<= 1'b1;
				   end
				   else
					   EF_N_OR_IN	<= 1'b0;
			 end
			 else 
                       if (COUNTWORDS == FIFOSIZE -1  ) 
				   EF_N_OR_IN <= 1'b1 ;
		end
	end	
end
//--------------------------------------------------------


////////////  Almost Empty FLAG behavior /////////////////////////////

reg [0:1]	AE_DELAY ;


//-------------AE_DELAY ---------------------//

always @( CLKB or negedge MRS1_N or negedge PRS_N)
begin
	if (!MRS1_N || !PRS_N)
	    AE_DELAY <= 2'b00;
	else 
        if (( !AE_N_IN  )&&(COUNTWORDS >= (X+2))&&
              !CSA_N && W_RA_N && ENA && !MBA && FF_N_IR )
	  begin
		#tSKEW2	 ;
		@(posedge CLKB) ;
 		// mva @(posedge CLKB) ;
		AE_DELAY 	<= 2'b01;
		@(negedge CLKB) ;
            AE_DELAY 	<= 2'b00;	
	  end
end

always @(CLKA or CLKB or negedge MRS1_N or negedge MRS2_N or negedge PRS_N)	
begin
	if ((!MRS2_N && !MRS1_N )||(!PRS_N))
	     AE_N_IN <= 1'b0;	
	else	
          if (!AE_N_IN)	
          begin
              if ((COUNTWORDS_del >= (X+2))&& (PROG_COMPL=='b1))
		  begin                       
		      @(AE_DELAY == 2'b01);
		       AE_N_IN  <= 1'b1;
              end
		  else 
		       AE_N_IN  <= 1'b0;
          end
	    else 
              if(AE_N_IN)
		  begin
                 if (!CSB_N && W_N_RB && ENB && !MBB && 
                      RT_N && EF_N_OR_IN && (COUNTWORDS <= (X )))                                   
                   AE_N_IN  <= 1'b0;	
		  end
end

///////////////  ALMOST FULL FLAG behavior //////////////////////

reg [0:1]	AF_DELAY ;

//-------------AF_DELAY ---------------------//
always @(//posedge CLKA or 
posedge CLKB or negedge MRS1_N or negedge PRS_N)
begin

	if (!MRS1_N || !PRS_N)
	    AF_DELAY <= 2'b00;
	else 
        if (( !AF_N_IN  )&&(COUNTWORDS <= FIFOSIZE-(Y+2))&& !CSB_N && W_N_RB && ENB && !MBB && RT_N && EF_N_OR_IN)
	  begin
		#tSKEW2	 ;
		@(posedge CLKA) ;
 		// mva @(posedge CLKA) ;
		 AF_DELAY 	<= 2'b01;
		@(posedge CLKA) ;
             AF_DELAY 	<= 2'b00;	
	  end
end

always @( CLKA  or  negedge MRS1_N or  negedge MRS2_N or negedge PRS_N)	
begin
	if ((MRS1_N=='b0 && MRS2_N =='b0)||(PRS_N=='b0 ))
	     AF_N_IN   <= 1'b1;	
	else	
      begin
		if(AF_N_IN)	begin
		  if (!CSA_N && W_RA_N && ENA && !MBA && FF_N_IR &&(COUNTWORDS == FIFOSIZE -(Y)) )                                   
			AF_N_IN  	<= 1'b0;
		  else if (COUNTWORDS >= (FIFOSIZE - Y ))
			     AF_N_IN   	<= 1'b0;	
		end
		else if ( !AF_N_IN  )	
                 begin
			 if (COUNTWORDS_del <= FIFOSIZE-(Y+2))
			 begin
                       @(AF_DELAY == 2'b01);
			     AF_N_IN   <= 1'b1;
                   end
			 else
                       if (COUNTWORDS_del > FIFOSIZE-(Y+2))

			     AF_N_IN   <= 1'b0;
		     end
	end
end

///////////////////// FF_N_IR_FLAG function /////////////////

reg [0:1]	FF_DELAY ;

//-------------FF_DELAY ---------------------//
always @(//posedge CLKA or 
         posedge CLKB or 
         negedge MRS1_N or 
         negedge PRS_N)
begin

	if (!MRS1_N || !PRS_N)
	    FF_DELAY <= 2'b00;
	else 
      begin
        if (!FF_N_IR && (POP &&(READ_NO==1)))
	  begin
		#tSKEW1	 ;
		@(posedge CLKA) ;
 		//@(posedge CLKA) ;
		  FF_DELAY 	<= 2'b01;
		@(posedge CLKA) ;
		//@(posedge CLKA) ;
              FF_DELAY 	<= 2'b00;	
	  end
      end
end

always @(//posedge CLKB   or 
           posedge CLKA   or 
           negedge MRS1_N or
           negedge PRS_N
         )	
begin
	
      if (!MRS1_N || !PRS_N)
		FF_N_IR_IN	<= 1'b0 ;
	//else if (PROG_COMPL)
	//	FF_N_IR_IN	<= 1'b1 ;


	if (FF_N_IR_IN)	
      begin
	    if   (!CSA_N && W_RA_N && ENA && !MBA && 
              ((WRITE_POINTER +1'b1) == READ_POINTER)&&
               (READ_NO == 1)) 
		    FF_N_IR_IN <= 1'b0 ;	
	    else 
             if ((COUNTWORDS_del == (FIFOSIZE-1))) 

		     FF_N_IR_IN <= 1'b0 ;	
	end
	else	
      begin
				
	    if (!CSA_N && W_RA_N && ENA && !MBA )
		$display ("Time = %0d:Warning :CY7C436X3AV. PortA write attempted when the Full/InputRdy flag was Low. COUNTWORDS = %0d.WRITE_POINTER = %0d.READ_POINTER = %0d\n ",
                      $time,COUNTWORDS,WRITE_POINTER ,READ_POINTER ); 
			
	    if( (WRITE_POINTER  !== READ_POINTER)
               && (FF_DELAY >= 1) 
               )	
	         FF_N_IR_IN <= 1'b1 ;
	    end		
end

/////////////// BIDIRECTIONAL BUS TRANSITIONS //////////////////////
	
assign A = A_OUT;
assign B = B_OUT;

///////////////////////////////////////////////////////////////////
////////////////// END OF BEHAVIORAL SECTION //////////////////////   
///////////////////////////////////////////////////////////////////

endmodule //CY7C436X3AV


