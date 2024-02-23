`timescale 1 ps / 1 ps

//defines here

`define ID_ADDR                 0
`define VERSION_ADDR            `ID_ADDR + 1 
`define CNT_ADDR                `VERSION_ADDR + 1
`define CNT_WIDTH               8

`define VECTOR_ID               4
`define VECTOR_VERSION          1

`define WR_RD_DATA_WIDTH        8
`define WR_RD_ADDR_WIDTH        3

`define SD_IMG_SIZE             5
`define TIME_OUT_CHECKER_VAL    50

`define RESET_P1                10
`define RESET_P0                5
`define CLK_T                   10

`define WR_DATA_UP              23
`define WR_DATA_LO              16
`define WR_ADDR_UP              14
`define WR_ADDR_LO              12
`define WR_EN_UP_LO             8
`define RD0_ADDR_UP             6
`define RD0_ADDR_LO             4
`define RD_EN_UP_LO             0

`define STIM_MEM_WORD_WIDTH     24 //6 digits in hexadecimal * 4 bits = 24 bits requiered
`define STIM_MEM_ADDR_WIDTH     5
`define STIM_MEM_DEPTH          ( 1'b1 << `STIM_MEM_ADDR_WIDTH ) - 1

`define EXP_MEM_WORD_WIDTH      `WR_DATA_UP - `WR_DATA_LO + 1 // = stim wr_data signal width
`define EXP_MEM_ADDR_WIDTH      4
`define EXP_MEM_DEPTH           ( 1'b1 << `EXP_MEM_ADDR_WIDTH  ) - 1

`define SD_MEM_WORD_WIDTH       `WR_RD_DATA_WIDTH
`define SD_MEM_ADDR_WIDTH       `STIM_MEM_ADDR_WIDTH
`define SD_MEM_DEPTH            ( 1'b1 << `SD_MEM_ADDR_WIDTH  ) - 1



//Testbench declaration
module testbench();
       
    //--- control signals
    reg  clk;
    reg  reset_;
    reg  start_sim;
    reg  rd_1st_3;
    reg  stall;
    reg  cmp_on;
    wire ctrans;    
    wire exp_en  = (cmp_on & ctrans) | rd_1st_3;
    //--- end control signals
    
    
    //-- clock generator --//
    // Toggle clock every `CLK_T ticks
    initial begin
       clk = 1;
       forever begin
          #`CLK_T clk = ~clk;
       end
    end

    //-- initializing control signals
    integer d;
   
    initial begin
        clk        = 1'b0;
        reset_     = 1'b1;
        start_sim  = 1'b0;
        stall      = 1'b0;
        rd_1st_3   = 1'b0;      
        cmp_on     = 1'b0;
        start_sim  = 1'b1;
        
        //-- reset control
        
        // RESET OFF for `RESET_P1 cycles
        for (d = 0; d < `RESET_P1; d = d + 1) begin
           @(posedge clk) reset_  = 1'b1;
        end
        
        // RESET ON for `RESET_P0 cycles
        for (d = 0; d < `RESET_P0; d = d + 1) begin
           @(posedge clk) reset_  = 1'b0;
        end
        
        //RESET SHUT OFF
        reset_ = 1'b1;
        //-- end reset control
        
        @(posedge clk) cmp_on   = 1'b0;
                       rd_1st_3 = 1'b1;      
        @(posedge clk) rd_1st_3 = 1'b1;      
        @(posedge clk) rd_1st_3 = 1'b1;
        @(posedge clk) rd_1st_3 = 1'b0;
        @(posedge clk) cmp_on   = 1'b1;
    end
    //-- end initializing control signals    
    
    // generate random value that will be assigned to valid_off
    reg random_val;

    always @(posedge clk) begin
       random_val <= $random;
    end
    
    //############################### valid_off ####################################
    //  valid_off is used to enable the increment of stim ra                       #
    //  random_gen = output of the AND gate between cmp_on, ~stall, start_sim      #
    //  if random_gen_en is 1 then valid_off has a random value                    #
    //##############################################################################
    wire random_gen_en = cmp_on & ~stall & start_sim;
    wire valid_off     = random_gen_en ? random_val : 1;
    wire valid         = ~valid_off;

    //########################### clock control FSM  ###############################
    // used to control the testbench clock and state data clock depending by       #
    // current state, control signals input vectors. There are 4 states:           #
    // 1.  IDLE_ST     = Idle state tb clk and sd clk are disabled                 #
    // 2.  SD_TB_EN_ST = Both clocks are enabled (when rd_1st_e is enabled)        #
    // 3.  TB_EN_ST    = Only testbench clk is enabled  (sd clk is disabled)       #
    // 4.  SD_EN_ST    = Only statedata clk is enabled  (tb clk is disabled)       #
    //##############################################################################
    parameter [1:0] IDLE_ST     = 0,
                    SD_TB_EN_ST = 1,
                    TB_EN_ST    = 2,
                    SD_EN_ST    = 3;
    
    reg [1:0] CurrentState, NextState;
    wire cmp_done;
    wire sd_cmp_event;
    reg tb_clk_en;
    reg sd_clk_en;
    
   //rd_1st_3, valid, sd_cmp_event, cmp_done - depends by control unit and input vectors
    always@(rd_1st_3 or valid or cmp_done or sd_cmp_event)
       begin: COMB
       NextState = CurrentState; //default case
       
       case (CurrentState)
           IDLE_ST:begin
              if(valid) begin
                  NextState = TB_EN_ST; 
              end else if(rd_1st_3) begin
                  NextState = SD_TB_EN_ST;
              end
           end
                  
           SD_TB_EN_ST:begin
              if(~rd_1st_3 & ~valid) begin
                  NextState = IDLE_ST;
              end else if(~rd_1st_3 & valid) begin
                  NextState = TB_EN_ST;
              end
           end

           TB_EN_ST:begin
              if( sd_cmp_event ) begin
                  NextState = SD_EN_ST;
              end else if( ~valid ) begin
                  NextState = IDLE_ST;
              end
           end
           
           SD_EN_ST:begin
              if(cmp_done) begin
                  NextState = TB_EN_ST;
              end
           end
       endcase 
   end
   
   always@ ( posedge clk or negedge reset_ )
   begin: SEQ
      if(~reset_)begin
         CurrentState <= IDLE_ST;
         NextState <= IDLE_ST;
     end else
         CurrentState <= NextState;
   end
                  


   always@ ( CurrentState )
   begin: OUT_LOGIC
   //TODO: ASK mr.Haba about the 2'nd STATE MACHINE!!!
      
      case ( CurrentState )
          IDLE_ST:     begin 
                         sd_clk_en = 1'b0; 
                       end
          SD_TB_EN_ST: begin
                         tb_clk_en = 1'b1;
                         sd_clk_en = 1'b1;
                       end
          TB_EN_ST:    begin 
                         tb_clk_en = 1'b1;
                       end
          SD_EN_ST:    begin
                         sd_clk_en = 1'b1;
                       end
      endcase
    end       
    //end clock control FSM
    
    //############################## TB, SD Clocks #################################
    // Depending by one of the 4 state from Clock FSM, the TB and SD clocks are    #
    // generated                                                                   #   
    //##############################################################################

    //generate tb and sd clk 
    wire tb_clk = tb_clk_en & clk;
    wire sd_clk = sd_clk_en & clk;
   
    // clock cycle contor
    integer cycle_cnt;
    
    always @(posedge sd_clk or posedge tb_clk or negedge reset_) begin
       if (~reset_) begin
          cycle_cnt <= 0;
       end
       else begin
          cycle_cnt <= cycle_cnt +1;
       end 
    end
    //end clock cycle contor
    
    //modules instanciations
   
   //wrapper module 
   wire [ `STIM_MEM_WORD_WIDTH - 1 : 0 ] stim_vector_out;
   wire [ `SD_MEM_ADDR_WIDTH   - 1 : 0 ] sd_ra          ;
   wire [ `EXP_MEM_WORD_WIDTH  - 1 : 0 ] exp_vector_out ; 
   wire [ `SD_MEM_WORD_WIDTH   - 1 : 0 ] sd_vector_out  ;
   wire                                  stop_vec_mtc   ;
   
   wrapper # (.WR_RD_ADDR_WIDTH      ( `WR_RD_ADDR_WIDTH    ), 
              .VECTOR_ID             ( `VECTOR_ID           ),
              .VECTOR_VERSION        ( `VECTOR_VERSION      ),

              .ID_ADDR               ( `ID_ADDR             ),
              .VERSION_ADDR          ( `VERSION_ADDR        ),
              .CNT_ADDR              ( `CNT_ADDR            ),
              .CNT_WIDTH             ( `CNT_WIDTH           ),
                         
              .EXP_MEM_DEPTH         ( `EXP_MEM_DEPTH       ),
              .EXP_MEM_ADDR_WIDTH    ( `EXP_MEM_ADDR_WIDTH  ),
              .EXP_MEM_WORD_WIDTH    ( `EXP_MEM_WORD_WIDTH  ),                      

              .SD_MEM_ADDR_WIDTH     ( `SD_MEM_ADDR_WIDTH   ),
              .SD_img_size           ( `SD_IMG_SIZE         ),
              .SD_MEM_DEPTH          ( `SD_MEM_DEPTH        ),
              .SD_MEM_WORD_WIDTH     ( `SD_MEM_WORD_WIDTH   ),
    
              .STIM_MEM_DEPTH        ( `STIM_MEM_DEPTH      ),
              .STIM_MEM_ADDR_WIDTH   ( `STIM_MEM_ADDR_WIDTH ),
              .STIM_MEM_WORD_WIDTH   ( `STIM_MEM_WORD_WIDTH )  
              )
              
          wrapper_ (.tb_clk          ( tb_clk          ),
                    .sd_clk          ( sd_clk          ),
                    .reset_          ( reset_          ),
                    .rd_1st_3        ( rd_1st_3        ),
                    .sd_cmp_event    ( sd_cmp_event    ),
                    .cmp_on          ( cmp_on          ),
                    .ctrans          ( ctrans          ),
                    .valid           ( valid           ),
                    .sd_ra           ( sd_ra           ),
                    .stim_vector_out ( stim_vector_out ),
                    .exp_vector_out  ( exp_vector_out  ),
                    .sd_vector_out   ( sd_vector_out   ),
                    .cmp_done        ( cmp_done        ),
                    .stop_vec_mtc    ( stop_vec_mtc    )
                    );

    //##################################### dut #######################################   
    // The stim vector out contains the wr_data, wr_addr, wr_en, rd_addr, rd_en bits: #
    //    8        3       1       3       1                                          #
    // wr_data__wr_addr__wr_en__rd_addr__rd_en                                        #
    //#################################################################################
       
    wire [ `WR_RD_DATA_WIDTH - 1 : 0 ] wr_data  = stim_vector_out [ `WR_DATA_UP  : `WR_DATA_LO  ];
    wire [ `WR_RD_ADDR_WIDTH - 1 : 0 ] wr_addr  = stim_vector_out [ `WR_ADDR_UP  : `WR_ADDR_LO  ];
    wire                               wr_en    = stim_vector_out [ `WR_EN_UP_LO : `WR_EN_UP_LO ];
    wire [ `WR_RD_ADDR_WIDTH - 1 : 0 ] rd0_addr = stim_vector_out [ `RD0_ADDR_UP : `RD0_ADDR_LO ];
    wire                               rd_en    = stim_vector_out [ `RD_EN_UP_LO : `RD_EN_UP_LO ];

    wire [ `WR_RD_DATA_WIDTH - 1 : 0 ] rd0_data;  
    
    dut       #(.WR_RD_DATA_WIDTH  ( `WR_RD_DATA_WIDTH  ),
                .WR_RD_ADDR_WIDTH  ( `WR_RD_ADDR_WIDTH  ),
                .SD_MEM_ADDR_WIDTH ( `SD_MEM_ADDR_WIDTH )
               )   
                 dut_  (.clk           ( tb_clk       ),
                        .reset_        ( reset_       ),
                        .wr_data       ( wr_data      ),
                        .wr_addr       ( wr_addr      ),
                        .wr_en         ( wr_en        ),
                        .rd0_data      ( rd0_data     ),
                        .rd0_addr      ( rd0_addr     ),
                        .rd_en         ( rd_en        ),
                        .rd_v          ( ctrans       ),
                        .sd_cmp_event  ( sd_cmp_event )
                        ); 
                        
    //#######################################################################
    //             COMPARATOR: DUT OUT AND EXPECTED VECTORS                 #
    // The dut out and expected vectors are compared when cmp_on an ctrans  #
    // are enabled. After a comparison, depending on result, the match_cnt  #
    // or mismatch_cnt is incremented                                       #
    //#######################################################################
        
    wire [`CNT_WIDTH - 1:0] mismatch_cnt ;
    wire [`CNT_WIDTH - 1:0] match_cnt;
    
    // the comparator is enabled when the cmp_on and ctrans are both valid
    wire                           comparator_enable = cmp_on & ctrans;
    wire                           comparator_enable_d1;
    wire [`WR_RD_DATA_WIDTH  - 1:0] dut_out_vec_d1;
    
    //syncronize the dut out vectors and the enable
    //signal of comparator with the expected vectors
    ff #(.W(1) )
        ff(.clk ( clk                  ),
           .r_  ( reset_               ),
           .d   ( comparator_enable    ),
           .q   ( comparator_enable_d1 )
           );
           
    ff #(.W ( `WR_RD_DATA_WIDTH )) 
       ff_(.clk ( clk            ),
           .r_  ( reset_         ), 
           .d   ( rd0_data       ), 
           .q   ( dut_out_vec_d1 )
           );
    
    //write DUT_out_vec and Exp_vec to file 
    //mcd = multi_channel_descriptor
    integer vectors_mcd;
    
    initial begin
        vectors_mcd = $fopen("vectors.txt");
        if( vectors_mcd == 0)begin
            $display("Error opening vectors.txt file");
            $finish;
        end
        $fdisplay (vectors_mcd, "DUT and Expected Vectors:\n");
    end
    
    //write to file every time when a comparison occurs
    always@ (posedge clk)begin
        if(comparator_enable_d1)begin
           $fdisplay (vectors_mcd,"   dut_out_vec = %b\n", dut_out_vec_d1,
                                  "   exp_vec_out = %b\n",exp_vector_out,
                                  "   -----------------");
        end
    end
     
    //Match counter gets incremented when exp vector = dut vector
    wire exp_eq_dut = exp_vector_out == dut_out_vec_d1;
    wire match_counter_en = comparator_enable_d1 & exp_eq_dut;
    counter # ( .WIDTH( `CNT_WIDTH) )
          match_counter(.clk ( clk              ), 
                        .r_  ( reset_           ),
                        .en  ( match_counter_en ),
                        .q   ( match_cnt        )
                        );
    
    //Mismatch counter gets incremented when exp vector != dut vector 
    wire mismatch_counter_en = comparator_enable_d1 & ~exp_eq_dut;
    counter # ( .WIDTH( `CNT_WIDTH) )
          mismatch_counter(.clk ( clk                 ), 
                           .r_  ( reset_              ),
                           .en  ( mismatch_counter_en ),
                           .q   ( mismatch_cnt        )
                           );   
  
  
  
    //#######################################################################
    //          STATE DATA COMPARATOR: RF AND STATE DATA VECTORS            #
    // The dut out and State Data vectors are compared when rd_1st_3,       #
    // cmp_done are disabled and cmp_on and sd_cmp_event are enabled.       #
    // After a comparison, depending on result, the sd_match_cnt            #
    // or sd_mismatch_cnt is incremented                                    #
    //####################################################################### 
    
   //sd comparator enable
   wire cmp_on_ct  = cmp_on & sd_cmp_event; //sd_cmp_event is wr_en;
   wire sd_comp_en = ~rd_1st_3 & cmp_on_ct & ~cmp_done;

   //read from rf
   reg [`WR_RD_DATA_WIDTH - 1 : 0 ] rf_rd_sd;
   always@ (posedge sd_clk or negedge reset_) begin
      if ( ~reset_ ) begin
          rf_rd_sd <= {`WR_RD_DATA_WIDTH {1'd0}};
      end else if ( sd_comp_en ) begin
         rf_rd_sd <= dut_.rf.rf_memory[sd_ra -1];      
         $display ("rd_MEM_sd[%d] = %d", wrapper_.state_data_.ra, sd_vector_out);
     end
   end

   wire [ `SD_MEM_ADDR_WIDTH - 1 : 0 ] sd_match_cnt   ;
   wire [ `SD_MEM_ADDR_WIDTH - 1 : 0 ] sd_mismatch_cnt;
  
   //Match counter is incremented when sd vectors = rf vectors
   wire sd_eq_rf = sd_vector_out ==  rf_rd_sd;
   wire sd_match_counter_en = sd_comp_en & sd_eq_rf;
   counter # ( .WIDTH( `SD_MEM_ADDR_WIDTH) )
         sd_match_counter(.clk ( clk                 ), 
                          .r_  ( reset_              ),
                          .en  ( sd_match_counter_en ),
                          .q   ( sd_match_cnt        )
                          );
   
   //Mismatch counter gets incremented when sd vector != rf
   wire sd_mismatch_counter_en = sd_comp_en & ~sd_eq_rf;
   counter # ( .WIDTH( `SD_MEM_ADDR_WIDTH) )
         sd_mismatch_counter(.clk ( clk                    ), 
                             .r_  ( reset_                 ),
                             .en  ( sd_mismatch_counter_en ),
                             .q   ( sd_mismatch_cnt        )
                             );    
           
//error detector



//end error detector           
  
  
//time out checker
wire stop_sim_time_out = (cycle_cnt >= `TIME_OUT_CHECKER_VAL);
         
                                                 
//report generator
integer rg_mcd;

initial begin
    rg_mcd = $fopen("report_generator.txt");
end

wire miss_cnt_gt_0 = mismatch_cnt > 0;
wire sd_mismatch_cnt_gt_0 = sd_mismatch_cnt > 0;
always@ (posedge sd_clk or posedge tb_clk)begin
    if(stop_sim_time_out) begin
       $fdisplay (rg_mcd, "\n       Testbench Report Generator    \n   Simulation time:",$time,"\n");
       $fdisplay (rg_mcd, "\n   Total number of vector passed:  ", match_cnt, "\n   Total number of vector failed:  ", mismatch_cnt,"  \n");
       if( miss_cnt_gt_0 ) begin
           $fdisplay (rg_mcd, "\n   Overall vector Status: Failed\n   -----------------------------------\n");
       end else
           $fdisplay (rg_mcd, "\n   Overall vector Status: Passed\n   -----------------------------------\n");
           $fdisplay (rg_mcd, "\n   Total number of SD passed:  ", sd_match_cnt, "\n   Total number of SD failed:  ",sd_mismatch_cnt,"  \n");
       if( sd_mismatch_cnt_gt_0 ) begin
              $fdisplay (rg_mcd, "\n   Overall SD Status:  Failed\n   -----------------------------------\n");
       end else
           $fdisplay (rg_mcd, "\n   Overall SD Status:  Passed\n   -----------------------------------\n");
           $fdisplay (rg_mcd, "\n   Total number of vectors:  ",match_cnt+mismatch_cnt,"\n   Total number of SD:  ", sd_match_cnt +  sd_mismatch_cnt," \n");

    //to scrren
    $display (rg_mcd, "\n   Testbench Report Generator    \n   Simulation time:",$time,"\n");
       $display (rg_mcd, "\n   Total number of vector passed:  ", match_cnt, "\n   Total number of vector failed:  ", mismatch_cnt,"  \n");
       if( miss_cnt_gt_0 ) begin
           $display (rg_mcd, "\n   Overall vector Status: Failed\n   -----------------------------------\n");
       end else
           $display (rg_mcd, "\n   Overall vector Status: Passed\n   -----------------------------------\n");
           $display (rg_mcd, "\n   Total number of SD passed:  ", sd_match_cnt, "\n   Total number of SD failed:  ",sd_mismatch_cnt,"  \n");
       if( sd_mismatch_cnt_gt_0 ) begin
           $display (rg_mcd, "\n   Overall SD Status:  Failed\n   -----------------------------------\n");
       end else
           $display (rg_mcd, "\n   Overall SD Status:  Passed\n   -----------------------------------\n");
           $display (rg_mcd, "\n   Total number of vectors:  ",match_cnt+mismatch_cnt,"\n   Total number of SD:  ", sd_match_cnt +  sd_mismatch_cnt," \n");
       end
end

//end report generator

//stop simulation when ID/VERS don't match or max cycles has been reached
always@ ( posedge sd_clk or posedge tb_clk )begin
   if( stop_sim_time_out )begin
       $display("Simulation stopped because time out checker = %d has just reached max cycles = %d .Exiting Simulation!", cycle_cnt, `TIME_OUT_CHECKER_VAL);
       $finish;
   end
end
 
 always@ ( posedge sd_clk or posedge tb_clk )begin  
   if ( stop_vec_mtc )begin
       $display("Simulation stopped because ID/VERS didn't match. Exiting Simulation!");
       $finish;
   end
end

//end stop simulation
endmodule