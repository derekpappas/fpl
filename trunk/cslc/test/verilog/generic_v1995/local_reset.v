/*****************************************************************************
*  Copyright (c) 1999 Tundra Semiconductor Corp., Kanata, Ontario, CANADA
*  File name:      local_reset.v 
*  Date:           Aug. 8th, 1999
*  Author:         Walter Li
*  Function:       Local Reset and Abort Control Module of the Board Controller
*  Change History: 09/09/99, WL, Added PC_HOST reset control
*				   15/02/00, WL, Changed the hrst_740 and Abort internal 
*								 control logic level
******************************************************************************/

`include "opndrn.v"

module local_reset ( data, ce_wr0, abort, h_rst, s_rst,
					hrst_740_sel, srst_740_dis, host_rst,
                       hrst_740, srst_740,
							irq0_smi_, hrst_8260_, srst_8260_);
  // Port Declaration
	input [1:0] data;
	input ce_wr0, abort, h_rst, s_rst, hrst_740_sel, srst_740_dis, host_rst;
	output hrst_740, srst_740;
	inout irq0_smi_, hrst_8260_, srst_8260_;

  // Wire Declaration
	reg q0, q1;
	wire hard_rst;

  // Integer Declaration

  // Concurent Assignment
	assign hard_rst = h_rst & host_rst;	//reset sources: pushbutton & PC_HOST

	assign srst_740 = !srst_740_dis | srst_8260_;
	assign hrst_740 = (hrst_740_sel & hrst_8260_) | (!hrst_740_sel & !q1);
			// changed the q1 output level (Feb.15,00)
			// After reset, the hrst_740 is kept in "Lo" if the jumper
			// hrst_740_sel is "Lo"
  // Always Statement
	always @(posedge ce_wr0 or negedge hrst_8260_ or negedge abort)
	  begin
	
	  if (!hrst_8260_)
	    begin
	    	q0 = 0;				// default is "Lo" (Feb.15,00)
		  	q1 = 1;				// default is "Hi" to set (Feb.15,00)
	    end
	  else if (!abort)
		begin
			q0 = 1;				// set "1" to assert ABORT_(Feb.15,00)
		end
	  else
	    begin
	      	q0 = data[0];		// write "0" to clear abort (Feb.15,00)
			q1 = data[1];		// write "0" to clear hrst_740 (Feb.15,00)
	    end
	  end	// end of always begin
	   		
	// generate open drain outputs
	opndrn opndrn1 ((!q0), irq0_smi_); 	// inverted the q0 output level
										// irq0_smi_ default is "Hi".
	opndrn opndrn2 (hard_rst, hrst_8260_);
	opndrn opndrn3 (s_rst, srst_8260_);

endmodule

