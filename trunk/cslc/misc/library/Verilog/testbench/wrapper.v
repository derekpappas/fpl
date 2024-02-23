`timescale 1 ps / 1 ps

//################################ Wrapper ####################################
// The wrapper module contains the stim, exp, sd MEM and control logic     #
// Its purpose is to avoid glitches and optimize the control logic            #
// The wrapper is used by expected and state data comparators from testbench  # 
//#############################################################################

module wrapper (tb_clk,
                sd_clk,
                reset_,
                rd_1st_3,
                sd_cmp_event,
                cmp_on,
                ctrans,
                valid,
                sd_ra,
                stim_vector_out,
                exp_vector_out,
                sd_vector_out,
                cmp_done,
                stop_vec_mtc
                );
                
parameter WR_RD_ADDR_WIDTH    = 1'd0;

parameter VECTOR_ID           = 1'd0;
parameter VECTOR_VERSION      = 1'd0;

parameter ID_ADDR             = 1'd0;
parameter VERSION_ADDR        = 1'd0;
parameter CNT_ADDR            = 1'd0;
parameter CNT_WIDTH           = 1'd0;

parameter EXP_MEM_DEPTH       = 1'd0;
parameter EXP_MEM_ADDR_WIDTH  = 1'd0;
parameter EXP_MEM_WORD_WIDTH  = 1'd0;

parameter SD_MEM_ADDR_WIDTH   = 1'd0;
parameter SD_img_size         = 1'd0;
parameter SD_MEM_DEPTH        = 1'd0;
parameter SD_MEM_WORD_WIDTH   = 1'd0;

parameter STIM_MEM_DEPTH      = 1'd0;
parameter STIM_MEM_ADDR_WIDTH = 1'd0;
parameter STIM_MEM_WORD_WIDTH = 1'd0;

               
input     tb_clk;
input     sd_clk;
input     reset_;
input     rd_1st_3;
input     sd_cmp_event;
input     cmp_on;
input     ctrans;
input     valid;

output [ SD_MEM_ADDR_WIDTH   - 1 : 0 ] sd_ra;
output [ STIM_MEM_WORD_WIDTH - 1 : 0 ] stim_vector_out;
output [ EXP_MEM_WORD_WIDTH  - 1 : 0 ] exp_vector_out;
output [ SD_MEM_WORD_WIDTH   - 1 : 0 ] sd_vector_out;
output                                 cmp_done;
output stop_vec_mtc;
wire   stop_vec_mtc;

//##################################################
//#           stimulus control logic               #
//##################################################

wire [ STIM_MEM_WORD_WIDTH - 1 : 0 ] stim_vector_out;
wire [ STIM_MEM_ADDR_WIDTH - 1 : 0 ] stim_ra;

//increment stim_ra when the valid or rd_1st_3 signal is enabled
wire addr_incr =  rd_1st_3 | valid;

counter #(.WIDTH( STIM_MEM_ADDR_WIDTH )) 
   counter_ (.clk ( tb_clk    ),
             .r_  ( reset_    ), 
             .en  ( addr_incr ),
             .q   ( stim_ra   )
             );

state_data  #(.ADDR_WIDTH        ( STIM_MEM_ADDR_WIDTH ),
              .MEM_WORD_WIDTH    ( STIM_MEM_WORD_WIDTH ),
              .VECTOR_ID         ( VECTOR_ID           ),
              .VERSION           ( VECTOR_VERSION      ),
              .ID_ADDR           ( ID_ADDR             ),
              .VERSION_ADDR      ( VERSION_ADDR        ),
              .CNT_ADDR          ( CNT_ADDR            ),
              .CNT_WIDTH         ( CNT_WIDTH           ),
              .MEM_DEPTH         ( STIM_MEM_DEPTH      ),
              .VECT_NAME         ( "Stimulus"          )
              )
              stim_mem_  (.clk           ( tb_clk          ),
                          .reset_        ( reset_          ),
                          .rd_1st_3      ( rd_1st_3        ),
                          .valid         ( valid           ),
                          .ra            ( stim_ra         ),
                          .vector_out    ( stim_vector_out ),
                          .stop_vec_mtc  ( stop_vec_mtc    )
                          );
                 

    //############ expected control logic ##############
    //the exp ra is incremented when cmp_on is 1 and   #
    //there is a valid transaction from DUT or when    #
    //rd_1st_3 is enabled                              #
    //##################################################
       
    wire exp_valid    = cmp_on    & ctrans;
    wire exp_valid_in = exp_valid | rd_1st_3; 
   
    //increment exp_ra when exp_valid_in is enabled
    wire  [ EXP_MEM_ADDR_WIDTH - 1 : 0 ] exp_ra;
    
    counter #(.WIDTH( EXP_MEM_ADDR_WIDTH )) 
    counter_exp (.clk ( tb_clk       ),
                 .r_  ( reset_       ), 
                 .en  ( exp_valid_in ),
                 .q   ( exp_ra       )
                );
    
    wire [ EXP_MEM_WORD_WIDTH    - 1 : 0 ] exp_vector_out;
    
    state_data   #(.ADDR_WIDTH     ( EXP_MEM_ADDR_WIDTH ),
                   .MEM_WORD_WIDTH ( EXP_MEM_WORD_WIDTH ),
                   .VECTOR_ID      ( VECTOR_ID          ),
                   .VERSION        ( VECTOR_VERSION     ),
                   .ID_ADDR        ( ID_ADDR            ),
                   .VERSION_ADDR   ( VERSION_ADDR       ),
                   .CNT_ADDR       ( CNT_ADDR           ),
                   .CNT_WIDTH      ( CNT_WIDTH          ),                
                   .MEM_DEPTH      ( EXP_MEM_DEPTH      ),
                   .VECT_NAME      ( "Expected"         )
                   )
                 exp_mem_   (.clk           ( tb_clk         ),
                             .reset_        ( reset_         ),
                             .rd_1st_3      ( rd_1st_3       ),
                             .valid         ( valid          ),
                             .ra            ( exp_ra         ),
                             .vector_out    ( exp_vector_out ),
                             .stop_vec_mtc  ( stop_vec_mtc   )
                              );  
    
    
//##################################################
//#           state data control logic             #
//##################################################
                                     
// TB Figure 2.2 from application_notes/production/csl_testbench.fm file

// state data control block
wire [SD_MEM_WORD_WIDTH - 1 : 0 ] sd_vector_out;

reg  [SD_MEM_ADDR_WIDTH - 1 : 0 ] sd_img_size_add;
wire [SD_MEM_ADDR_WIDTH - 1 : 0 ] mux_out = rd_1st_3 ? 2 : SD_img_size;
wire [SD_MEM_ADDR_WIDTH - 1 : 0 ] ld       ; 
wire  [SD_MEM_ADDR_WIDTH - 1 : 0 ] sd_ra_add; 

// ADDR comparator and ld control
// when the incremented sd_img_size_add is equal with
// sd_ra_add the ld hold the current sd_img_size_add
wire cmp_done_en  = (sd_img_size_add == sd_ra_add);

reg [ SD_MEM_ADDR_WIDTH - 1 : 0 ] sd_ra;

always @( posedge sd_clk or negedge reset_ ) begin
   if ( ~reset_) begin
       sd_ra <= { SD_MEM_ADDR_WIDTH {1'b0} };
   end else if (~cmp_done_en) begin
       sd_ra <= sd_ra + 1'b1;
   end
end

reg cmp_done;
always @(posedge sd_clk or negedge reset_) begin
    if ( ~reset_ ) begin
        cmp_done <= 1'b0;
    end else if( cmp_done_en ) begin
        $display ("CMP_DONE: mux_out( %d ) + ld (%d) == sd_ra_add ( %d )-> comp_done = 1", mux_out,ld , sd_ra_add);
        cmp_done <= 1'b1;
    end else begin
        cmp_done <= 1'b0;
    end
end

//reset the sd_ra if cmp_done is 1
always @( posedge sd_clk) begin
   if ( cmp_done ) begin
       sd_ra <=  { SD_MEM_ADDR_WIDTH {1'b0}} +1'b1;
   end
end

//delay the mux out
wire [SD_MEM_ADDR_WIDTH - 1 : 0 ] sd_img_size_add_d1;

ff #(.W(SD_MEM_ADDR_WIDTH))
  ff_img_size (.clk ( sd_clk             ),
               .r_  ( reset_             ),
               .d   ( sd_img_size_add    ),
               .q   ( sd_img_size_add_d1 )
               );

// set the ld when cmp_done is 1 and on reset_
ff_en #(.W(SD_MEM_ADDR_WIDTH))
  ff_ld (.clk ( cmp_done           ),
         .r_  ( reset_             ),
         .en  ( cmp_done           ),
         .d   ( sd_img_size_add_d1 ),
         .q   ( ld                 )
         );
       
// reset or increment the sd_img_size_add
//ff_en #(.W(SD_MEM_ADDR_WIDTH))
//  ff_sd_img_size_add
//        (.clk(sd_clk),
//         .r_(reset_),
//         .en(1'b1),
//         .d(mux_out + ld),
//         .q(sd_img_size_add)
//         );

always @( posedge sd_clk or negedge reset_ ) begin
   if (~reset_) begin
      sd_img_size_add <= {SD_MEM_ADDR_WIDTH{2'b10}}; 
   end else begin 
       sd_img_size_add <= mux_out + ld;
   end
end

// increment the sd_ra_add
ff_en #(.W(SD_MEM_ADDR_WIDTH))
  ff_sd_ra (.clk ( ~cmp_done          ),
            .r_  ( reset_             ),
            .en  ( ~cmp_done          ),
            .d   ( sd_ra + ld  + 1'b1 ),
            .q   ( sd_ra_add          )
           );
   
   state_data    #(.ADDR_WIDTH     ( SD_MEM_ADDR_WIDTH ),
                   .MEM_WORD_WIDTH ( SD_MEM_WORD_WIDTH ),
                   .VECTOR_ID      ( VECTOR_ID         ),
                   .VERSION        ( VECTOR_VERSION    ),
                   .ID_ADDR        ( ID_ADDR           ),
                   .VERSION_ADDR   ( VERSION_ADDR      ),
                   .CNT_ADDR       ( CNT_ADDR          ),
                   .CNT_WIDTH      ( CNT_WIDTH         ),                   
                   .MEM_DEPTH      ( SD_MEM_DEPTH      ),
                   .VECT_NAME      ( "StateData"       )
                   )
                 state_data_(.clk           ( sd_clk        ),
                             .reset_        ( reset_        ),
                             .rd_1st_3      ( rd_1st_3      ),
                             .valid         ( valid         ),
                             .ra            ( sd_ra_add     ),
                             .vector_out    ( sd_vector_out ),
                             .stop_vec_mtc  ( stop_vec_mtc  )
                            ); 
                              
endmodule                