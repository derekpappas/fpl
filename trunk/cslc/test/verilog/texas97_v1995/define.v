/* Assertion and negation macros for active-low signals: */

`define asserted0  == 0
`define negated1   == 1

// Go ahead and brute force define the transfer types
`define		XferTypeCLEAN_BLOCK	 5'b00000
`define		XferTypeFLUSH_BLOCK      5'b00100
`define		XferTypeSYNC		 5'b01000
`define		XferTypeKILL_BLOCK	 5'b01100
`define		XferTypeEIEIO		 5'b10000
`define		XferTypeTLBIE		 5'b11000
`define		XferTypeLWARX_SET	 5'b00001
`define		XferTypeTLBSYNC		 5'b01001
`define		XferTypeICBI		 5'b01101

		// Write operations
`define		XferTypeWRITE_N_FLUSH	 5'b00010
`define		XferTypeWRITE_N_FLUSH_ATOMIC	 5'b10010
`define		XferTypeWRITE_N_KILL	 5'b00110

		// Read operations
`define		XferTypeREAD		 5'b01010
`define		XferTypeRWITM		 5'b01110
`define		XferTypeREAD_ATOMIC	 5'b11010
`define		XferTypeRWITM_ATOMIC	 5'b11110
`define		XferTypeRWNITC		 5'b01011

typedef enum {
	      CPU1,
	      CPU2
	      } Cpu;

typedef enum { 
	       ArbiterStatusIDLE1,
	       ArbiterStatusIDLE2,		
	       ArbiterStatusGRANTED1,		
	       ArbiterStatusGRANTED1_AACK,	
	       ArbiterStatusGRANTED2,		
	       ArbiterStatusGRANTED2_AACK 
	       } ArbiterStatus;

typedef enum {
	      AddrStatusIDLE,		
	      AddrStatusDELAY,		
	      AddrStatusAACK_WAIT,
	      AddrStatusAACK	
	      } AddrStatus;


typedef enum {
	       // See for example pp. 8-6 and 8-7, or 8-10 through 8-13 of grey book
	      AddressTenureIDLE,	
	      AddressTenureTS,		// Transaction started
	      AddressTenureAACK_WAIT,	// Wait for AACK
	      AddressTenureAWINDOW,	// Wait one cycle to sample ARTRY_
	      AddressTenureARTRY_HOLD   // Allow other CPU's snoop push
	      } AddressTenure;

typedef enum {
	      DataTenureIDLE,		
	      DataTenureTA_WAIT,	
	      DataTenureDRTRY_CHK_DBB,	   // checking for DRTRY_ of preceding TA_, which wasn't the possible last beat
	      DataTenureDRTRY_CHK_NOT_DBB  // checking for DRTRY_ of preceding last-beat TA_
	      } DataTenure;

typedef enum {	
		SharedControlXU,
		SharedControlXM
		} SharedControl; 

typedef enum {
	      SnoopControlIDLE,
	      SnoopControlTS_1,
	      SnoopControlTS_2,
	      SnoopControlREADY,
	      SnoopControlARTRY,
	      SnoopControlSHARED,
	      SnoopControlBOTH
	      } SnoopControl;

typedef enum {	// Here we use the high-order bit for BR_ assertion, but perhaps that
		// doesn't matter.
		BusRequestIDLE,
		BusRequestNORMAL,
		BusRequestSNOOP,
		BusRequestSNOOP_OLD_DATA,
		BusRequestSNOOP_PENDING_DATA,
		BusRequestSNOOP_FINISH_DATA
	      } BusRequest;