//*****************************************************************************
//FILE NAME: fsm.v
//OWNER    : NIKHIL KUMAR SRIVASTAVA
//COMMENTS : It takes the up/down signal from the synchronizer as input and
//           generates 6-bit output for the seven bit adder (2nd and 3rd bits
//           are the same).
//*****************************************************************************

                                                                                
module fsm_trial(up_in_s1, add_reg_s1, phi1, phi2, reset_s1, reset_lin_s1);

input phi1, phi2;
input up_in_s1;
input reset_s1, reset_lin_s1;

output [5:0] add_reg_s1;

reg [5:0] add_reg_s1;
reg [3:0] curr_state_s1;
reg [3:0] state_s1;
reg [3:0] state_s2;
reg [3:0] d_state_s1;
reg [3:0] state_t1_s1, state_t1_s2, state_t2_s1, state_t2_s2, state_t3_s1,state_t3_s2, state_t4_s1,  state_t4_s2 ;

`define Bin_0 4'b0000
`define Bin_1 4'b0001
`define Bin_2 4'b0010
`define Bin_3 4'b0011
`define Idle_0 4'b0101
`define Idle_1 4'b0110
`define Idle_2 4'b0111
`define Idle_3 4'b1000
`define Lin 4'b0100

// latches used to store the states of the FSM 

always @(phi2 or state_s2 )
    if(phi2)
	curr_state_s1 = state_s2;

always @(phi1 or d_state_s1  )
    if(phi1)
	state_s2 = d_state_s1;

// latches used to store the final state after all the idle states have
// been traversed

always @(phi1 or state_s1)
    if(phi1)
        state_t1_s2 = state_s1;

always @(phi2 or state_t1_s2)
    if(phi2)
        state_t1_s1 = state_t1_s2;

always @(phi1 or state_t1_s1)
    if(phi1)
        state_t2_s2 = state_t1_s1;

always @(phi2 or state_t2_s2)
    if(phi2)
        state_t2_s1 = state_t2_s2;

always @(phi1 or state_t2_s1)
    if(phi1)
        state_t3_s2 = state_t2_s1;

always @(phi2 or state_t3_s2)
    if(phi2)
        state_t3_s1 = state_t3_s2;

always @(phi1 or state_t3_s1)
    if(phi1)
        state_t4_s2 = state_t3_s1;

always @(phi2 or state_t4_s2)
    if(phi2)
        state_t4_s1 = state_t4_s2;


// FSM logic


always @(curr_state_s1 or reset_s1 or reset_lin_s1 or state_s1 )
begin
     if (reset_s1)
       begin
       d_state_s1 = `Bin_0;
       end
     else if(reset_lin_s1)
             d_state_s1 = `Lin;
          else
               begin
        	casex (curr_state_s1) //  synopsys parallel_case
	 		`Bin_0 :
				begin	
					state_s1 = `Bin_1;
					d_state_s1 = `Idle_0;
				end
			`Bin_1 :
				begin
					state_s1 = `Bin_2;
					d_state_s1 = `Idle_0;
				end
			`Bin_2 :
				begin	
					state_s1 = `Bin_3;
					d_state_s1 = `Idle_0;
				end
			`Bin_3 :	
				begin
					state_s1 = `Lin;
					d_state_s1 = `Idle_0;
				end
			`Lin   :
				begin	
					state_s1 = `Lin;
					d_state_s1 = `Idle_0;
				end
			`Idle_0 :
				        d_state_s1 = `Idle_1;
			`Idle_1 :
 				        d_state_s1 = `Idle_2;
			`Idle_2 :     
                                        d_state_s1 = `Idle_3;
                        `Idle_3 :      
                                        d_state_s1 = state_t4_s1;
                        default :
                                        d_state_s1 = `Lin;


		endcase
               end
end

always @(curr_state_s1 or up_in_s1 or reset_s1)
begin
	casex (curr_state_s1)//   synopsys parallel_case full_case 
		`Bin_0 :  add_reg_s1 = 6'b000000;
		`Bin_1 :  add_reg_s1 = (up_in_s1)? 6'b010000 : 6'b110000;
		`Bin_2 :  add_reg_s1 = (up_in_s1)? 6'b001000 : 6'b111000;
		`Bin_3 :  add_reg_s1 = (up_in_s1)? 6'b000100 : 6'b111100;
		`Lin   :  add_reg_s1 = (up_in_s1)? 6'b000001 : 6'b111111;
 		`Idle_0:  add_reg_s1 = 6'b000000;
		`Idle_1:  add_reg_s1 = 6'b000000;
		`Idle_2:  add_reg_s1 = 6'b000000;
                `Idle_3:  add_reg_s1 = 6'b000000;
	endcase
end

endmodule // end fsm module
