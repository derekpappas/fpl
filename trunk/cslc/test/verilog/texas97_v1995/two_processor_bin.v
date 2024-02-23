/************************************************************
   Final Project for Formal Verification : Fall 97 UT Austin
   Verification of Cache Coherence Protocol (sc2p3)
   Parminder, Praveen & Srivatsan 
   Copyright 1997 UT :-)
   No Guarantees Provided right now..sc2p3 V0.7c, 29th Nov 1997
 *************************************************************/
//typedef enum {D, S, I, X} state_inf; // D - Dirty, S - Shared, I - Invaild
//typedef enum {SHW, SMRW, IHRW, IMRW, DMRW, OTHERS} state_comb;
`define D 2'b00
`define S 2'b01
`define I 2'b10
`define X 2'b11
`define SHW 3'b001
`define SMRW 3'b010
`define IHRW 3'b011
`define IMRW 3'b100
`define DMRW 3'b101
`define OTHERS 3'b000
module protocol(clk);
   input clk;
   wire all_shared, is_sharedA, is_sharedB;
   wire ND_inA, ND_inB, ndA, ndB;
   wire master_outA, master_outB;
   wire master_inA, master_inB;
   wire inv_outA, inv_outB, invalidate;
   wire mem_served;
   wire info_availA, info_availB;
   wire bus_reqA, bus_reqB;
   wire bus_ackA, bus_ackB;
   wire[2:0] snoop_typeA, snoop_typeB;
   wire[2:0] shared_snoop;

   pcache pcacheA(clk, shared_snoop, is_snoop, master_inA, ND_inA, bus_ackA, 
		  all_shared, mem_served, invalidate,
		  inv_outA, snoop_typeA, bus_reqA, master_outA, is_sharedA, 
		  info_availA);
   pcache pcacheB(clk, shared_snoop, is_snoop, master_inB, ND_inB, bus_ackB, 
		  all_shared, mem_served, invalidate,
		  inv_outB, snoop_typeB, bus_reqB, master_outB, is_sharedB,
		  info_availB);
   
   assign all_shared = (is_sharedA && is_sharedB); 
   // All the proceesors are in Shared state
   assign ND_inA = ndA && !bus_ackA;
   assign ND_inB = (master_outA ) ? ND_inA : (ndB && !bus_ackB);
   // Non deter. B if proc. A is not Master
   assign master_inA = 0;
   assign master_inB = master_outA;
   assign ndA = $ND(0,1);
   assign ndB = $ND(0,1);
   
   assign mem_served = !(info_availA || info_availB);
   // if no proc. has info, Mem supplies
   arbiter   bus_arbiter(clk, bus_reqA, bus_reqB, snoop_typeA, snoop_typeB, 
    		         inv_outA, inv_outB, bus_ackA, bus_ackB, is_snoop, 
			 shared_snoop, invalidate);
endmodule // protocol
module pcache(clk, shared_snoop, is_snoop, master_in, ND_in, bus_ack, all_shared, 
		mem_served, invalidate,
		inv_out, snoop_type, bus_req, master_out, is_shared, info_avail);
//   input random_reg;
   input clk;
   input shared_snoop; // snoop status of state_comb type from the Bus arbiter, generated by any processor
   input is_snoop;     // if info is available in the processor, then there is a snoop
   input master_in;    // master status of previous processors
   input ND_in;        // non-deterministic input info-available generation for certain cases
   input bus_ack;      // bus acknowledge signal from the bus arbiter
   input all_shared;   // Are all processors in shared state?
   input mem_served;   // Request serviced by memory
   input invalidate;   // invalidate info received from the arbiter, sent by other processors
   output snoop_type;  // state_comb type snooping information generated based on State, R/W, Hit/Miss
   output bus_req;     // request for bus; sent to the bus arbiter
   output master_out;  // master status outputed for other processors
   output is_shared;   // flags if the processor state is shared
   output inv_out;     // invalidate sent on valid write request
   output info_avail;  // info flag: if information is available in the processor, activate
   // declarations of interface signals
   wire[31:0] random_reg;
   wire clk;
   wire[2:0] shared_snoop;
   wire is_snoop, master_in, ND_in, bus_ack, all_shared, invalidate, mem_served;
   wire info_avail;
   wire is_shared, master_out;
   //internal signals
   wire hit_miss;
   wire[2:0] sh_snp;
   wire req_enable;
   wire proc_req;
   wire valid;
   reg inv_out;
   reg bus_req;
   reg[1:0] state;
//   reg t_req_enable;
//   reg[2:0] t_snoop_type;   
   reg[2:0] snoop_type;
//   reg t_read, t_write;
//   reg t_info_avail;
   reg update;
   reg[1:0] next_state;
   reg hit, miss, read, write;

   initial
    begin
       state = `I;
       next_state = `D;
       bus_req = 0;
//       t_req_enable = 1;
//       t_snoop_type = `SMRW;       
       snoop_type = `SMRW;
       read = 1;
       write = 0;
       hit = 0;
       miss = 1;
       update = 0;
       inv_out = 0;
    end // initial begin

   assign req_enable = (is_snoop && info_avail) ? 0 :
		       (is_snoop && !info_avail && sh_snp==`SMRW && is_shared) ? 0 :
		       (!(sh_snp==`OTHERS)&&valid) ? 0 :
		       (bus_req) ? 0 : 1;
   processor proc(clk, req_enable, valid);   
//   assign hit_miss = random_reg[19];  // non-deter. generate hit or miss information
//   assign proc_req = random_reg[21];
   assign hit_miss = $ND(0,1);
   assign proc_req = $ND(0,1);
   
 
   assign is_shared = (state == `S) ? 1 : 0;
   //If the processor is in shared state, activate this signal
   assign sh_snp = shared_snoop; // alias for `shared_snoop' - being lazy here ;-)
   /* proc. cant be a master if Invalid state or some other previous processor in master state *or in other state dependencies */
   assign master_out = (master_in || (next_state==`I)) ? 0 : 
		       ((sh_snp==`SMRW)||(sh_snp==`IMRW)||(sh_snp==`DMRW)||
			((sh_snp==`SHW)&&(next_state==`S))||
			((sh_snp==`IHRW)&&(next_state==`D))) ? 1: 0;
   //info available generation based on state dependencie 
   assign info_avail = //(bus_ack) ? 0 :
		       ((sh_snp==`SHW) || (next_state==`S)) ? 1:
		       (((next_state==`D) && !((sh_snp==`OTHERS)||(sh_snp==`SHW))) ||
		       ((next_state==`S) && ((sh_snp==`IMRW)||(sh_snp==`DMRW)))) ? ND_in:
		       0;
   always @(posedge clk)
    begin
       if((state==`S) && hit && write)
	begin
	       snoop_type = `SHW;
	end // if ((state==S) && hit && write)
       else if ((state==`S) && miss && (read || write)) 
	begin
	   snoop_type= `SMRW;
	end // if ((state==S) && miss && (read || write))
       else if ((state==`I) && (hit==1)  && ((read==1) || (write==1)))
	begin
	   snoop_type = `IHRW;
	end // if ((state==I) && hit  && (read || write))
       else if ((state==`I) && (miss==1) && ((read==1) || (write==1)))
	begin
	   snoop_type = `IMRW;
	end // if ((state==I) && miss && (read || write))
       else if((state==`D) && miss && (read || write))
	begin
	   snoop_type = `DMRW;
	end // if ((state==D) && miss && (read || write))
       else 
	begin
	   snoop_type = `OTHERS;
	end // else: !if((state==`D) && miss && (read || write))
       
       if((snoop_type!=`OTHERS) && (valid)) 
	begin 
	   bus_req = 1;
	end
       else 
	begin 
	end // else: !if((snoop_type!=`OTHERS) && (valid))
      
       if(is_snoop && (!bus_ack)) 
	begin	   
	   update = 0;
	   if(info_avail)
	    begin
	       case(shared_snoop)//what type of snoop request is routed by the arbiter?
		 `SHW:            // Shared Hit Write
		  begin
		     if(state == `S) begin next_state = `I; update = 1; end 
		     // Change state to Invalid on S state
		     else begin next_state = state; update = 0;  end
		  end // case SHW
		 `SMRW:              // Shared Miss Read-Write
		  begin
		     if(state == `D) // On Dirty state do the following
		      begin
			 if(!invalidate) begin next_state = `S; update = 1;end 
			 // Not(Invalidate) = Read  Supply info- update to S
			 else 
			  begin 
			     next_state = `I; 
			     update = 1; 
			  end 
			 // Invalidate = Write, update state to I
		      end // if (state == D)
		     else
		      begin
			 next_state = state;
			 update = 0;
		      end // else: !if(state == D)
		  end // case: SMRW
		 `IHRW:              // Inva`lid Hit Read-Write
		  begin
		     if(state == `D) // On Dirty state do the following
		      begin
			 if(!invalidate) begin next_state = `S; update = 1;end 
			 // Not(Invalidate) = Read  Supply info- update to S
			 else begin next_state = `I; update = 1; end 
			 // Invalidate = Write, update state to I
		      end // if (state == D)
		     else
		      begin
			 next_state = state;
			 update = 0;
		      end // else: !if(state == D)
		  end // case: IHRW
		 `IMRW:              // Invalid Miss Read-Write
		  begin
		     if(state == `S) // If state is Shared
		      begin
			 if(invalidate) begin next_state = `I;update = 1; end 
			 // Invalidate = Write, update to I
			 else begin next_state = state; update = 0; end
		      end // if (state == S)
		     else if(state == `D) // If state is Dirty
		      begin
			 if(!invalidate) begin next_state = `S; update = 1;end
			 // Not(Invalidate) = Read, Supply info, update to S
			 else begin next_state = `I; update = 1; end
			 // Invalidate = Write, update to I
		      end // if (state == D)
		     else
		      begin
			 next_state = state;
			 update = 0;
		      end // else: !if(state == D) 
		  end // case: IMRW
		 `DMRW:              // Dirty Miss Read/Write
		  begin
		     if(state == `S) // If state is Shared
		      begin
			 if(invalidate) begin next_state = `I;update = 1; end 
			 // Invalidate = Write, update to I
			 else begin next_state = state; update = 0; end
		      end // if (state == S)
		     else if(state == `D) // If state is Dirty
		      begin
			 if(!invalidate) begin next_state = `S; update = 1;end
			 // Not(Invalidate) = Read, Supply info, update to S
			 else begin next_state = `I; update = 1; end
			 // Invalidate = Write, update to I
		      end // if (state == D)
		     else
		      begin
			 next_state = state;
			 update = 0;
		      end // else: !if(state == D) 
		  end // case: DMRW
		 default:
		  begin
		     next_state = state;
		     update = 0;
		  end
	       endcase // case(shared_snoop)
	    end // if (info_avail)
	   else                                    // info NOT available
	    begin
	       if((sh_snp == `SMRW) && (state == `S)) 
		// State is S with sharde snoop request SMRW
		begin
		   if(!all_shared) begin next_state = `D; update = 1; end
		   // Not all processors are in shared state, so update to D
		   else begin next_state = state; update = 0; end
		   // proc. still shares the info with some other processor
		end // if ((sh_snp == SMRW) && (state == S))
	    end // else: !if(info_avail)
	end // if (is_snoop && (!bus_ack))
       
       if(!is_snoop || bus_ack)
	begin
	   if(!bus_ack) 
	    begin 
	       next_state = state;
	       update = 0;
	    end // if (!bus_ack)
	   else
	    begin
	       bus_req = 0;
	       
	       case(shared_snoop)
		 `SHW:
		  begin
		     next_state = `D;
		     update = 1;
		  end // case: SHW
		 `SMRW:
		  begin
		     if(!invalidate)
		      begin
			 if (mem_served )
			  begin
			     next_state = `D;
			     update = 1;
			  end // if (mem_served )
			 else
			  begin
			     next_state = state;
			     update = 0;
			  end // else: !if(mem_served )
		      end // if (read)
		     else
		      begin
			 next_state = state;
			 update = 0;
		      end // else: !if(read)
		  end // case: SMRW
		 `IHRW:
		  begin
		     if(!invalidate)
		      begin
			 if(mem_served)
			  begin
			     next_state = `D;
			     update = 1;
			  end // if (mem_served)
			 else
			  begin
			     next_state = `S;
			     update = 1;
			  end // else: !if(mem_served)
		      end // if (read)
		     else if(invalidate)
		      begin
			 next_state = `D;
			 update = 1;
		      end // if (write)
		     else
		      begin
			 next_state = state;
			 update = 0;
		      end // else: !if(write)
		  end // case: IHRW
		 `IMRW:
		  begin
		     if(!invalidate)
		      begin
			 if(mem_served)
			  begin
			     next_state = `D;
			     update = 1;
			  end // if (mem_served)
			 else
			  begin
			     next_state = `S;
			     update = 1;
			  end // else: !if(mem_served)
		      end // if (read)
		     else
		      begin
			 next_state = state;
			 update = 0;
		      end // else: !if(read)
		  end // case: IMRW
		 `DMRW:
		  begin
		     if(!invalidate)
		      begin
			 if(mem_served)
			  begin
			     next_state = `D;
			     update = 1;
			  end // if (mem_served)
			 else
			  begin
			     next_state = `S;
			     update = 1;
			  end // else: !if(mem_served)
		      end // if (read)
		     else
		      begin
			 next_state = state;
			 update = 0;
		      end // else: !if(read)
		  end // case: DMRW
		 default:
		  begin
		     next_state = state;
		     update = 0;
		  end // case: default
	       endcase // case(snoop_type)
	    end // else: !if(!bus_ack)
	end // if (!is_snoop || bus_ack)

       if(update) 
	begin
	   bus_req = 0;
	end // if (update)
       else bus_req = bus_req; 
       state = next_state;

       if (!valid || update)
	begin
	   read = 0;
	   write = 0;
	   inv_out = 0;
	end // if (!valid || update)
       else if(!bus_req)
	begin
	   hit = hit_miss;
	   miss = !hit_miss;
	   read = proc_req;
	   write = !proc_req;
	   inv_out = write;
	end // if (!bus_req)
       else
	begin
	   hit = hit;
	   miss = !hit;
	   read = read;
	   write = write;
	   inv_out = inv_out;
	end // else: !if(!bus_req)
    end // always @ (posedge clk)
endmodule // pcache



module processor(clk, req_enable,  valid);
//   input r_reg;
   input clk;
   input req_enable;   // Enables request generation
   output valid;       // request valid flag
   /* To model the Read/Write request generation of a processor non-det., base the 
    non-determinism on a count value generated non-det. and decrement count each clock
    cycle if request enable is high
    if not retain count i.e. models a stall. 
    -Issue the request by sending the valid signal on count zero. 
    -Generate non-det count when the previous req. has been issued i.e. on previous 
    cycle count zero
    */
//   wire [31:0] r_reg;
   wire clk;
   wire req_enable;
   reg valid;
   
   reg [0:2] count;
   wire [0:2] nd_count;
   
   initial
    begin
       //       count = $ND(0,1,2,3,4,5,6,7); 
       count = 5;
       valid = 1; 
    end // initial begin
   
  // assign nd_count = r_reg[16:14];
   assign nd_count = $ND(0,1,2,3,4,5,6,7);
   
   always @(posedge clk)
    begin
       if(req_enable)
	begin
	   if(count == 0) 
	    begin
	       valid = 1;
	       count = nd_count;
	    end // if (count == 0)
	   else
	    begin
	       count = count - 1;
	       valid = 0;
	    end // else: !if(count == 0)
	end // if (req_enable)
       else
	begin
	end // else: !if(req_enable)
    end // always @ (posedge clk)
endmodule // processor

module arbiter(clk, bus_reqA, bus_reqB, snoop_typeA, snoop_typeB, 
	       inv_outA, inv_outB, bus_ackA, bus_ackB, is_snoop, 
	       shared_snoop, invalidate);
   input clk;
   input bus_reqA, bus_reqB;
   input snoop_typeA, snoop_typeB;
   input inv_outA, inv_outB;
   output bus_ackA, bus_ackB;
   output is_snoop;
   output shared_snoop;
   output invalidate;
   
   wire clk;
   wire bus_reqA, bus_reqB;
   wire [2:0] snoop_typeA, snoop_typeB;
   wire inv_outA, inv_outB;
   reg bus_ackA, bus_ackB;
   reg is_snoop, invalidate;
   reg [2:0] shared_snoop;
   
   initial
    begin
       is_snoop = 0;
       bus_ackA = 0;
       bus_ackB = 0;
       invalidate = 0;
       shared_snoop = `OTHERS;
    end // initial begin
   
   
   always @(posedge clk)
    begin
       if(bus_reqA)                     // process req. A on bus req. A
	begin
	   bus_ackA = 1;                // send bus ack. to proc. A
	   bus_ackB = 0;
	   is_snoop = 1;                // notify all proc. that of a snoop
	   shared_snoop = snoop_typeA;  // route snoop state of proc. A
	   invalidate = inv_outA;       // invalidate on a valid write req. of proc. A
	end // if (bus_reqA)
       else if(bus_reqB)                // process req. B on bus req. B
	begin
	   bus_ackA = 0;
	   bus_ackB = 1;                // send bus ack. to proc. B
	   is_snoop = 1;                // notify all proc. that of a snoop
	   shared_snoop = snoop_typeB;  // route snoop state of proc. B
	   invalidate = inv_outB;       // invalidate on a valid write req. of proc. B 
	end // if (bus_reqB)
       else
	begin
	   bus_ackA = 0;
	   bus_ackB = 0;
	   is_snoop = 0;
	   invalidate = 0;
	   shared_snoop = `OTHERS;
	end // else: !if(bus_reqB)
    end // always @ (posedge clk)
endmodule // arbiter

