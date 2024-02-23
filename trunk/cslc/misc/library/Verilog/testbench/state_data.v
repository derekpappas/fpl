`timescale 1 ps / 1 ps

module state_data(clk,
                  reset_,
                  rd_1st_3,
                  valid,
                  ra,
                  vector_out,
                  stop_vec_mtc
                  );

parameter ADDR_WIDTH       = 1'd0;
parameter MEM_WORD_WIDTH   = 1'd0;
parameter VECTOR_ID        = 1'd0;
parameter VERSION          = 1'd0;
parameter ID_ADDR          = 1'd0;
parameter VERSION_ADDR     = 1'd0;
parameter CNT_ADDR         = 1'd0;
parameter CNT_WIDTH        = 1'd0;
parameter MEM_DEPTH        = 1'd0;                  
parameter VECT_NAME        = 1'd0;

input  clk      ;
input  reset_   ;
input  rd_1st_3 ;
input  valid    ;
input  [ ADDR_WIDTH     - 1 : 0 ] ra           ;

output [ MEM_WORD_WIDTH - 1 : 0 ] vector_out   ;
output                            stop_vec_mtc ;
reg    [ MEM_WORD_WIDTH - 1 : 0 ] vector       ;
reg    [ MEM_WORD_WIDTH - 1 : 0 ] mem [1'd0 : MEM_DEPTH];


reg stim_mem_loaded ;
reg exp_mem_loaded  ;
reg sd_mem_loaded   ;

//vectors name predicate
reg is_stim_vector_name = ( VECT_NAME == "Stimulus"  );
reg is_exp_vector_name  = ( VECT_NAME == "Expected"  );   
reg is_sd_vector_name   = ( VECT_NAME == "StateData" );

//delay the valid
wire valid_d;

ff #(.W(1)) 
   ff(.clk ( clk     ),
      .r_  ( reset_  ),
      .d   ( valid   ),
      .q   ( valid_d )
     );

initial begin
   $display("%s MEM depth = %d", VECT_NAME, MEM_DEPTH);
   stim_mem_loaded = 1'b0;    
   exp_mem_loaded  = 1'b0;
   sd_mem_loaded   = 1'b0;    
end

//read from file to MEM //
initial begin   
   if ( is_stim_vector_name ) begin     
      $readmemh ( "E:\\stimulus.vec", mem );
      stim_mem_loaded = 1'b1;
      $display  ( "E:\\stimulus.vec loaded");
   end else if ( is_exp_vector_name ) begin
      $readmemh ( "E:\\expected.vec", mem);
      exp_mem_loaded = 1'b1;
      $display(  "E:\\expected.vec loaded");
      end else if ( is_sd_vector_name ) begin
         $readmemh ( "E:\\state_data.vec", mem );
         sd_mem_loaded = 1'b1;
         $display(  "E:\\state_data.vec loaded");     
      end else begin $display ( "Incorect Vector name" );    
      end
end

  
//task:display the MEM
integer mem_addr; 

task display_mem;
begin
    $display("==================================================");
    $display("VECTOR_FILE =%s initial state",VECT_NAME);
    for (mem_addr = 0; mem_addr <= MEM_DEPTH; mem_addr = mem_addr + 1'b1) begin
           $display ("%s mem[%d] = %b", VECT_NAME, mem_addr, mem[mem_addr]);
    end
    $display("==================================================");    
end
endtask

initial begin
   if ( $test$plusargs("STIM") & stim_mem_loaded ) begin
       display_mem();
   end 
end
    
initial begin
   if ( $test$plusargs("EXP") & exp_mem_loaded ) begin
       display_mem();
   end
end    
   
initial begin    
   if ( $test$plusargs("SD") & sd_mem_loaded ) begin
       display_mem();
   end
end


// read from memory
always @( posedge clk or posedge reset_) begin
    vector = mem [ ra ];
//    $display ("%s vector[%d] = %d", VECT_NAME, ra, mem[ra]);
end

//mux
wire ra_eq_vers_addr = ra == VERSION_ADDR;
wire ra_eq_id_addr   = ra == ID_ADDR;
wire ra_eq_cnt_addr  = ra == CNT_ADDR;
wire  ms = ( is_exp_vector_name | is_sd_vector_name ) ? ( ra_eq_vers_addr  || ra_eq_id_addr || ra_eq_cnt_addr) :( ra_eq_vers_addr  || ra_eq_id_addr || ra_eq_cnt_addr || ~valid_d);
wire  [ MEM_WORD_WIDTH - 1 : 0 ] vector_out = ms ? {MEM_WORD_WIDTH {1'b0}} : vector;

reg stop_vec_mtc;
initial begin
    stop_vec_mtc = 1'b0;
end

// VECTOR_ID checker //
id_vers_checker #(.VECTOR_ID_VERS_ADDR ( ID_ADDR        ),
                  .VECTOR_ID_VERS      ( VECTOR_ID      ),
                  .VECTOR_WIDTH        ( MEM_WORD_WIDTH ),
                  .VECTOR_RA_W         ( ADDR_WIDTH     ),
                  .VECTOR_NAME         ( VECT_NAME      ),
                  .ID_VERS_NAME        ( "ID"           )
                  )
                  vector_id_checker(.rd_1st_3( rd_1st_3 ),
                                    .ra      ( ra       ),
                                    .vector  ( vector   )
                                    );                     
    
// VERSION checker //
id_vers_checker #(.VECTOR_ID_VERS_ADDR ( VERSION_ADDR   ),
                  .VECTOR_ID_VERS      ( VERSION        ),
                  .VECTOR_WIDTH        ( MEM_WORD_WIDTH ),
                  .VECTOR_RA_W         ( ADDR_WIDTH     ),
                  .VECTOR_NAME         ( VECT_NAME      ),
                  .ID_VERS_NAME        ( "VERSION"      )
                  )
                  vector_version_checker(.rd_1st_3( rd_1st_3),
                                         .ra      ( ra      ),
                                         .vector  ( vector  )
                                         );

// CNT extract from file //
wire addr_eq_cnt_addr  = ra == CNT_ADDR;
wire addr_eq_cnt       = addr_eq_cnt_addr && rd_1st_3;
reg  [CNT_WIDTH - 1:0] max_vector_cnt; 
    
always @( posedge clk or negedge reset_ ) begin
   if (~reset_) begin
      max_vector_cnt <= {ADDR_WIDTH {1'b0}};
   end else if(addr_eq_cnt) begin
      max_vector_cnt <= vector;
      $display ("Vector name = %s max vector cnt = %d  ra = %d vector value = %x",
                VECT_NAME, max_vector_cnt, ra, vector);
      end
end
    
// transaction counter //
wire [ADDR_WIDTH - 1 : 0] trans_num;

counter #(.WIDTH( ADDR_WIDTH ))
       transaction_counter(.clk ( clk       ),
                           .r_  ( reset_    ),
                           .en  ( ~ms       ),
                           .q   ( trans_num )
                           );

// max transaction checker  //
wire mvc_gt_tn = max_vector_cnt <  trans_num;

always@ (posedge clk ) begin
   if(mvc_gt_tn) begin
      //DEBUG?
      stop_vec_mtc <= 1'b1;
      //$finish;
   end
end 

`ifdef DEBUG
   always @(posedge clk) begin
       $display("%s max transaction number reached! FILE MAX VECTOR CNT = %d, Curent transactions number = %d Exiting Simulation!", VECT_NAME,  max_vector_cnt,trans_num);
   end
`endif
    
endmodule    