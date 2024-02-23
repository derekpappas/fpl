`timescale 1 ps / 1 ps

module stim_exp_mem(clk,
                    reset_,
                    rd_1st_3,
                    valid,
                    vector_out
                    );
                
    parameter ADDRESS_WIDTH        = 1'd0;
    parameter MEMORY_WORD_WIDTH    = 1'd0;
    parameter ID                   = 1'd0;
    parameter VERSION              = 1'd0;
    parameter ID_ADDR              = 1'd0;
    parameter VERSION_ADDR         = 1'd0;
    parameter CNT_ADDR             = 1'd0;
    parameter MEM_DEPTH            = 1'd0;
    parameter VECT_NAME            = ""  ;

     
    input     clk     ;
    input     reset_  ;
    input     rd_1st_3;
    input     valid   ;
    
    output [MEMORY_WORD_WIDTH - 1:0]    vector_out;
    
    reg    [MEMORY_WORD_WIDTH - 1:0]    max_vector_cnt; 
    reg    [MEMORY_WORD_WIDTH - 1:0]    vector;
    reg    [MEMORY_WORD_WIDTH - 1:0]    mem [1'd0 : MEM_DEPTH];
    
    reg stim_memory_loaded;
    reg exp_memory_loaded ;
    reg stim_vector_name = ( VECT_NAME == "Stimulus"  );
    reg exp_vector_name  = ( VECT_NAME == "Expected"  );   
    reg sd_vector_name   = ( VECT_NAME == "StateData" ); 
    
    initial begin
       $display("%s memory depth = %d", VECT_NAME, MEM_DEPTH);
       stim_memory_loaded = 1'b0;    
       exp_memory_loaded  = 1'b0;  
    end
    
    // read from file into memory
    initial begin 
          if ( stim_vector_name ) begin     
          $readmemh ( "E:\\stimulus.vec", mem);
          stim_memory_loaded = 1'b1;
          $display(  "E:\\stimulus.vec loaded");
      end else if ( exp_vector_name ) begin
          $readmemh ( "E:\\expected.vec", mem);
          exp_memory_loaded = 1'b1;
          $display(  "E:\\expected.vec loaded");
      end else $display ( "Incorect Vector name" );
  end        
    
    integer mem_addr;
    
    //wire stim_en = ($test$plusargs("STIM") & stim_memory_loaded);
    
    initial begin
         if ( $test$plusargs("STIM") & stim_memory_loaded ) begin
         $display("==================================================");
         $display("VECTOR_FILE =%s initial state", "E:\\stimulus.vec");
         for (mem_addr = 0; mem_addr <= MEM_DEPTH; mem_addr = mem_addr + 1'b1) begin
            $display ("%s mem[%d] = %b", VECT_NAME, mem_addr, mem[mem_addr]);
            stim_memory_loaded = 1'b0;
         end
         $display("==================================================");
      end 
    end
    
    initial begin
         if ( $test$plusargs("EXP") & exp_memory_loaded ) begin
         $display("==================================================");
         $display("VECTOR_FILE =%s initial state", "E:\\expected.vec");
         for (mem_addr = 0; mem_addr <= MEM_DEPTH; mem_addr = mem_addr + 1'b1) begin
            $display ("%s mem[%d] = %b", VECT_NAME, mem_addr, mem[mem_addr]);
            exp_memory_loaded = 1'b0;
         end
         $display("==================================================");
     end
   end


// to be moved in testbench    
    reg    [ADDRESS_WIDTH - 1:0] ra;
   
    //increment ra 
    always@( posedge clk or negedge reset_) begin
        if(~reset_) begin
           ra      = -1;//{ ADDRESS_WIDTH {1'b0}};
        end  
        else if(valid | rd_1st_3) begin
           ra      = ra + 1'b1; // fix later-bug
        end 
        vector = mem[ra]; 
    end    
// end moved to testbench

    //mux    
    wire  zero_mux = (ra == VERSION_ADDR  || ra == ID_ADDR || ra == CNT_ADDR);
    wire  ms = (VECT_NAME == "Stimulus") ? (zero_mux | ~valid) : zero_mux;
    wire  [MEMORY_WORD_WIDTH - 1:0] vector_out = ms ? {MEMORY_WORD_WIDTH {1'b0}}:vector;   

    // ID checker
    wire addr_eq_id_addr     = ra == ID_ADDR;
    wire addr_eq_id          = addr_eq_id_addr  & rd_1st_3;
    wire vector_id_correct   = (vector == ID);
    reg vector_id_match;
    
    always@(posedge addr_eq_id or posedge vector_id_correct) begin
       vector_id_match = 1'b0;
       if (addr_eq_id) begin 
        if (vector_id_correct ) begin 
           vector_id_match = 1'b1;
           $display("ID MATCHED      for %s vector ! Continuing simulation! tb ra = %d Defined ID = %d file id = %d", VECT_NAME, ra, ID, vector);
       end else begin 
           vector_id_match = 1'b0;
           $display("ID MISMATCH     for %s vector ! Exiting    simulation! tb ra = %d Defined ID = %d file id = %d", VECT_NAME, ra, ID, vector);
          // $finish;
        end
      end
    end
    
    //VERSION checker
    wire addr_eq_version_addr     = ra == VERSION_ADDR;
    wire addr_eq_version          = addr_eq_version_addr & rd_1st_3;
    wire vector_version_correct   = (vector == VERSION);
    reg vector_version_match;
 
    always@(posedge addr_eq_version or posedge vector_version_correct) begin
       vector_version_match = 1'b0;
       if (addr_eq_version) begin 
        if (vector_version_correct ) begin 
          vector_version_match = 1'b1;
          $display("VERSION MATCHED   for %s vector ! Continuing simulation! tb ra = %d Defined VERSION = %d file version = %d", VECT_NAME, ra,VERSION, vector);
        end else begin 
          vector_version_match = 1'b0;
          $display("VERSION MISMATCH  for %s vector ! Exiting    simulation! tb ra = %d Defined VERSION = %d file version = %d", VECT_NAME, ra,VERSION, vector);
          //$finish;
         end
      end
    end
    
    // CNT extract from file
    wire addr_eq_cnt_addr = ra == CNT_ADDR;
    wire addr_eq_cnt      = addr_eq_cnt_addr && rd_1st_3;

    always @(negedge reset_ or posedge addr_eq_cnt) begin
        if (~reset_) begin
            max_vector_cnt = {ADDRESS_WIDTH {3'b100}};// bug need to be fixed
        end
        else if(addr_eq_cnt) begin
           max_vector_cnt = vector;
           $display ("%s FILE MAX VECTOR CNT = %d readed on ra = %d vector value = %d", VECT_NAME, max_vector_cnt, ra, vector);
        end
    end
    
    //transaction counter
    reg [ADDRESS_WIDTH - 1 : 0] trans_num;
    always @( posedge clk or negedge reset_ or valid) begin
       if (~reset_) begin
          trans_num <= {ADDRESS_WIDTH {1'b0}};            
       end
       else if( valid ) begin
          trans_num <= trans_num +1'b1;
       end
    end
    
    //max transaction checker
    wire mvc_gt_tn = max_vector_cnt <  trans_num;
    always@ (posedge clk) begin
        if(mvc_gt_tn) begin
            $display("%s max transaction number reached! FILE MAX VECTOR CNT = %d, Curent transactions number = %d Exiting Simulation!", VECT_NAME,  max_vector_cnt,trans_num);
            $finish;
        end
    end    

endmodule  