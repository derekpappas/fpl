module PosCntr(clk,cnt_en,dir,reset,sample,pos,vel);
    input clk;			//master clock
    input cnt_en;		//enable counter
    input dir;			//fowards or backwards
    input reset;		//clear registers to zero
    input sample; 		//update sample
    output [31:0] pos; 	//position output
    output [15:0] vel;	//velocity output

//-----------------------------------------------------------
// major components of the position register
//
// position counter....16 bits...is used to keep track of
// change in position sample to sample
//
// position diff....differential of position...used to get
// the real change in position and to output the velocity
// all at the same time
//
// position accumulator...this is a 32 bit position
//
//-----------------------------------------------------------
	reg [15:0] counter;
	reg [15:0] vreg1,vreg2;
	reg [15:0] vel;
	wire [31:0] velext;	//sign extend
	reg [31:0] pos;
	reg doadd;

//-----------counter----------------------

always @(posedge clk or posedge reset)
begin
   if (reset)
      counter <= 16'b0;
   else begin
		if (cnt_en)
            if (dir)
               counter <= counter + 1;
            else
               counter <= counter - 1;
  end
end

//-------------differential delay regs-----

always @(posedge clk or posedge reset)
begin
	if(reset)
	begin			    	// reset
		vreg1 <= 16'b0;	//pipe delay 1
		vreg2 <= 16'b0;	//pipe delay 2
	end
	else
	begin		
 		if (sample)	//on sample
		begin
			vreg2 <= vreg1;	//update pipe delay 1	
			vreg1 <= counter;	//update pipe delay 2
		end
	end
end

always @(vreg1 or vreg2)
begin
	vel = vreg1 - vreg2;
end	

//--------this does a sign extend----------

assign velext[31:0] = {vel[15],vel[15],vel[15],vel[15],vel[15],vel[15],vel[15],vel[15],vel[15],vel[15],vel[15],vel[15],vel[15],vel[15],vel[15],vel[15],vel[15:0]};

//----pipe line delay, add vel to position one clock cycle later
always @(posedge clk)
	doadd <= sample;

//----------------------------------------------
// 32 bit accumulator
// add in sign extended velocity or clear to zero
//----------------------------------------------
always @(posedge clk or posedge reset)
begin
	if(reset)
		pos <= 32'b0;	//reset accumulator to zero
	else
	begin
		if(doadd)
			pos <= pos + velext;	//add vel
	end
end
endmodule
