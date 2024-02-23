/*******************************************************************************************************************************
**
**    Copyright © 1998..2001 Advanced Architectures
**
**    All rights reserved
**    Confidential Information
**    Limited Distribution to Authorized Persons Only
**    Created and Protected as an Unpublished Work under the U.S. Copyright act of 1976.
**
**    Project Name       : A2-Register Bus
**    Module Name        : A2-Register Bus parameters
**
**    Author             : RTT
**    Creation Date      : 2001/08/15
**    Description        : Combined master/target interface TAP
**
**    $Revision: 1.0 $
**    $Date: 2002-05-13 09:16:22-07 $
**    $ID: $
**
********************************************************************************************************************************
**    THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
**    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS
**    BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
**    TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
**    AND ON ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
**    ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*******************************************************************************************************************************/

parameter   A2R_section          =     0,       // 0 - top of the hierarchy, 1 - lower section, 2 - alternate section

// Section-0: The Global section

parameter   A2R_sec0_OR_fabric   =  1'b0,       // TAP interconnect fabric is through OR rather than daisy chain MUX
parameter   A2R_sec0_num_taps    =    15,       // Total number of TAPs in this section of the A2R bus
parameter   A2R_sec0_num_masters =     3,       // Total number of master that can initiate transfers on the A2R bus

// Section-1: The lower  section

parameter   A2R_sec1_OR_fabric   =  1'b1,       // TAP interconnect fabric is through OR rather than daisy chain MUX
parameter   A2R_sec1_num_taps    =     3,       // Total number of TAPs in this section of the A2R bus
parameter   A2R_sec1_num_masters =     3,       // Total number of master that can initiate transfers on the A2R bus

// Section-2: An Alternate section

parameter   A2R_sec2_OR_fabric   =  1'b0,       // TAP interconnect fabric is through OR rather than daisy chain MUX
parameter   A2R_sec2_num_taps    =     1,       // Total number of TAPs in this section of the A2R bus
parameter   A2R_sec2_num_masters =     1,       // Total number of master that can initiate transfers on the A2R bus

// Main parameter section ======================================================================================================

parameter   A2R_width            =  32,         // Overall Bus Width Default

parameter   A2R_OR_fabric        =  A2R_section == 0 ?  A2R_sec0_OR_fabric
                                 :  A2R_section == 1 ?  A2R_sec1_OR_fabric
                                 :                      A2R_sec2_OR_fabric,  // Also used to derive arbitration mode

parameter   A2R_num_taps         =  A2R_section == 0 ?  A2R_sec0_num_taps
                                 :  A2R_section == 1 ?  A2R_sec1_num_taps
                                 :                      A2R_sec2_num_taps,

parameter   A2R_num_masters      =  A2R_section == 0 ?  A2R_sec0_num_masters
                                 :  A2R_section == 1 ?  A2R_sec1_num_masters
                                 :                      A2R_sec2_num_masters,

parameter   A2R_num_slaves       = 256,         // Use upper byte of address space used to select slave

parameter   TapID_0              =   0,         // Renumber these to change the order in the ring
parameter   TapID_1              =   1,
parameter   TapID_2              =   2,
parameter   TapID_3              =   3,
parameter   TapID_4              =   4,
parameter   TapID_5              =   5,
parameter   TapID_6              =   6,
parameter   TapID_7              =   7,
parameter   TapID_8              =   8,
parameter   TapID_9              =   9,
parameter   TapID_10             =  10,
parameter   TapID_11             =  11,
parameter   TapID_12             =  12,
parameter   TapID_13             =  13,
parameter   TapID_14             =  14,
parameter   TapID_15             =  15,

parameter   A2R_debug            =  1'b0,      // Turn debugging ON

parameter	TRUE	= 1'b1,
parameter	FALSE	= 1'b0,
parameter	H     = 1'b1,
parameter	L    	= 1'b0,
parameter	X    	= 1'b?,

// DERIVED PARAMETERS ==========================================================================================================

parameter   A2R_num_requestors   =   A2R_OR_fabric    ?  A2R_num_masters : 1,

parameter   A2R_lg2_slaves       =   A2R_num_slaves   <=          1  ?  0
                                 :   A2R_num_slaves   <=          2  ?  1
                                 :   A2R_num_slaves   <=          4  ?  2
                                 :   A2R_num_slaves   <=          8  ?  3
                                 :   A2R_num_slaves   <=         16  ?  4
                                 :   A2R_num_slaves   <=         32  ?  5
                                 :   A2R_num_slaves   <=         64  ?  6
                                 :   A2R_num_slaves   <=        128  ?  7
                                 :   A2R_num_slaves   <=        256  ?  8
                                 :                                      9,

parameter   A2R_slv_addr_width   =   A2R_width - A2R_lg2_slaves,

parameter   TapID_0_in           =   (TapID_0 +1) % A2R_num_taps,  // Used to derive input signals to the taps from the bus
parameter   TapID_1_in           =   (TapID_1 +1) % A2R_num_taps,
parameter   TapID_2_in           =   (TapID_2 +1) % A2R_num_taps,
parameter   TapID_3_in           =   (TapID_3 +1) % A2R_num_taps,
parameter   TapID_4_in           =   (TapID_4 +1) % A2R_num_taps,
parameter   TapID_5_in           =   (TapID_5 +1) % A2R_num_taps,
parameter   TapID_6_in           =   (TapID_6 +1) % A2R_num_taps,
parameter   TapID_7_in           =   (TapID_7 +1) % A2R_num_taps,
parameter   TapID_8_in           =   (TapID_8 +1) % A2R_num_taps,
parameter   TapID_9_in           =   (TapID_9 +1) % A2R_num_taps,
parameter   TapID_10_in          =   (TapID_10+1) % A2R_num_taps,
parameter   TapID_11_in          =   (TapID_11+1) % A2R_num_taps,
parameter   TapID_12_in          =   (TapID_12+1) % A2R_num_taps,
parameter   TapID_13_in          =   (TapID_13+1) % A2R_num_taps,
parameter   TapID_14_in          =   (TapID_14+1) % A2R_num_taps,
parameter   TapID_15_in          =   (TapID_15+1) % A2R_num_taps,

// PIPELINE Control ===========================================================================================================

parameter   Request_IN        =  0,    // Pipeline Request input from initiator e.g. if request is not soon after clock
parameter   Address_OUT       =  1,    // Pipeline Address output from TAP      e.g. Arbitration needs more time
parameter   Slave_Select_IN   =  2,    // Pipeline Address decode into slave    e.g. Bus timing is slow
parameter   Slave_Ready_OUT   =  3,    // Pipeline slave ready output           e.g. slave access is slow or bus return is slow
parameter   Master_IN         =  4,    // Pipeline read data input to initiator e.g. Bus timing is slow or needs more set-up

// Adjust the pipe settings for each TAP here add more parameters for each additional TAP in the system.  Each bit is defined
// by the parameters above.  Pass these parameters in the module instantiations at the next level up in the system hierarchy
//
// e.g.  A2R_tap #(TAP_pipe_settings_1, A2R_masterID_0, A2R_targetID_1, ... ) u2 ( ..... );
//

//`define  NULL_PARAMS
//
//`define  JUST_ONE
//`define  MIXD_PARAMS
//`define  MIXD_PARAMS2

`ifdef   NULL_PARAMS
parameter   TAP_pipe_settings_0   =  5'b00000,
parameter   TAP_pipe_settings_1   =  5'b00000,
parameter   TAP_pipe_settings_2   =  5'b00000,
parameter   TAP_pipe_settings_3   =  5'b00000,
parameter   TAP_pipe_settings_4   =  5'b00000

// ADJUST THIS PARAMETER TO CONTROL THE TIMING OF THE BUS.  THE FASTER THE CLOCK THE MORE PIPES YOU WILL NEED! DUH!
// Use only for serial bus fabric !!
// Always set to zero for parallel fabric
// Each bit in this field represents a tap on the serial ring.  Setting a bit to a '1' inserts a pipeline stage at that tap
parameter   A2R_pipe_settings     =  5'b11111,  // The width of this parameter must change with the number of A2R modules

`else
`ifdef   JUST_ONE
parameter   TAP_pipe_settings_0   =  5'b00000,
parameter   TAP_pipe_settings_1   =  5'b00000,
parameter   TAP_pipe_settings_2   =  5'b00000,
parameter   TAP_pipe_settings_3   =  5'b00000,
parameter   TAP_pipe_settings_4   =  5'b00000,
parameter   A2R_pipe_settings     =  5'b00100   // The width of this parameter must change with the number of A2R modules
`else
`ifdef   MIXD_PARAMS
parameter   TAP_pipe_settings_0   =  5'b01010,
parameter   TAP_pipe_settings_1   =  5'b10101,
parameter   TAP_pipe_settings_2   =  5'b11011,
parameter   TAP_pipe_settings_3   =  5'b10001,
parameter   TAP_pipe_settings_4   =  5'b00111,
parameter   A2R_pipe_settings     =  5'b10100   // The width of this parameter must change with the number of A2R modules
`else
`ifdef   MIXD_PARAMS2
parameter   TAP_pipe_settings_0   =  5'b11001,
parameter   TAP_pipe_settings_1   =  5'b11001,
parameter   TAP_pipe_settings_2   =  5'b11001,
parameter   TAP_pipe_settings_3   =  5'b11001,
parameter   TAP_pipe_settings_4   =  5'b11001,
parameter   A2R_pipe_settings     =  5'b00010   // The width of this parameter must change with the number of A2R modules
`else
parameter   TAP_pipe_settings_0   =  5'b11111,
parameter   TAP_pipe_settings_1   =  5'b11111,
parameter   TAP_pipe_settings_2   =  5'b11111,
parameter   TAP_pipe_settings_3   =  5'b11111,
parameter   TAP_pipe_settings_4   =  5'b11111,
parameter   A2R_pipe_settings     =  5'b11111   // The width of this parameter must change with the number of A2R modules
`endif
`endif
`endif
`endif

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

