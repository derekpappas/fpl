//defines here
`define STIM_DMW 8   //Defined Stimulus  Memory Width
`define STIM_DAW 3   //Defined Stimulus Address Width
`define EXP_DMW  2   //Defined Expected Memory Width 
`define EXP_DAW  3   //Defined Expected Address Width  
`define SD_DMW   4   //Defined State Data Memory Width
`define SD_DAW   4   //Defined State Data Address Width
`define STIM_VECTOR_VERSION    1   //Defined Version
`define STIM_VECTOR_ID         2   //Defined ID
`define EXPECT_VECTOR_VERSION  1   //Defined Version
`define EXPECT_VECTOR_ID       3   //Defined ID
`define SD_VECTOR_VERSION      1   //Defined Version
`define SD_VECTOR_ID           6   //Defined ID
`define CNT           3   //Defined counter width
`define DMD           9   //Defined Memory Depth
`define MTC           6   //Defined Maximum Transaction Checker
`define ID_ADDR       0   //Defined ID Addr
`define VERSION_ADDR  1   //Defined Version Addr

//`timescale 1 ns / 100 ps
`timescale 1 ps / 1 ps

////modules declaration
////Define FF declaration
//module ff(clk,in,out);
//    parameter W = 0;
//    input                 clk;
//    input    [W-1:0]       in;
//    output   [W-1:0]      out;
//    reg      [W-1:0]      out;
//    
//    always@(posedge clk) begin
//        out <= in;
//    end
//endmodule

//define miss/match comparator
//module comparator(clk,
//                  reset_,
//                  cmp_on,
//                  exp_vec_out,
//                  dut_out_vec,
//                  miss_cnt,match_cnt
//                  );
//    parameter              EXP_MW  = 0 ;//expected memory width
//    parameter              STIM_MW = 0 ;//stimulus Memory width  
//    parameter              CNT = 0     ; 
//        
//    input                  clk         ;
//    input                  reset_      ;    
//    input                  cmp_on      ;
//    input  [EXP_MW  - 1:0] exp_vec_out ;
//    input  [STIM_MW - 1:0] dut_out_vec ;
//    
//    output [CNT -1:0]      match_cnt   ;
//    output [CNT -1:0]      miss_cnt    ;
//    
//    reg    [CNT -1:0]      match_cnt   ;
//    reg    [CNT -1:0]      miss_cnt    ;
//    
//    initial begin
//        match_cnt = 0;
//        miss_cnt  = 0;
//    end
//    
//    always@(posedge clk or negedge reset_) begin
//        if ( ~reset_ ) begin
//            match_cnt <= {CNT{1'b0}};
//            miss_cnt  <= {CNT{1'b0}};
//        end else begin
//        if ( cmp_on ) begin
//            if ( exp_vec_out == dut_out_vec ) begin
//                match_cnt <= match_cnt + 1;
//                $display(" expected vector = %x  dut_out_vect = %x! match_cnt=%d", exp_vec_out, dut_out_vec, match_cnt);
//            end
//        end
//        else begin
//            miss_cnt <= miss_cnt +1;
//            $display(" expected vector = %x  dut_out_vect = %x!  miss_cnt=%d", exp_vec_out, dut_out_vec,  miss_cnt); 
//            end
//        end
//    end
//endmodule

//module rf(clk,rd_addr,rd_data,wr_data,wr_addr,wr_en);
//    parameter              STIM_AW = 0;
//    parameter              STIM_MW = 0;
//    
//    input                  clk     ;
//    input                  wr_en   ;
//    input  [STIM_AW - 1:0] rd_addr ;
//    input  [STIM_AW - 1:0] wr_addr ;
//    input  [STIM_MW - 1:0] wr_data ;
//    output [STIM_MW - 1:0] rd_data ;
//    
//    reg    [STIM_MW - 1:0] rd_data ;
//    reg    [STIM_MW - 1:0] rf_memory [0:(1'b1<<STIM_AW)-1];
//    //rf_memory depth = 1 left shifted with the address width minus 1
//    
//    always@(posedge clk) begin
//        if(wr_en)begin
//           rf_memory[wr_addr] = wr_data;
//        end
//           rd_data = rf_memory[rd_addr];
//    end
//endmodule

//// define dut module
//module dut(clk,
//           en,
//           dut_stim_vec,
//           dut_out_vec,
//           dut_out_valid,
//           stop_clk
//           );
//            
//parameter              STIM_MW = 0;
//parameter              CNT     = 0;
//parameter              STIM_AW = 0;
//
//input                  clk         ;
//input                  en          ;
//input  [STIM_MW - 1:0] dut_stim_vec;
//
//output [STIM_MW - 2:0] dut_out_vec  ;
//output                 dut_out_valid;
//output                 stop_clk     ;
//
//input [STIM_MW -1:0]     wr_data ;
//input [STIM_AW -1:0]     wr_addr ;
//input                    wr_en   ;
//input                    rd_en   ;
//input [STIM_DW -1:0]     rd_data ;
//input [STIM_AW -1:0]     rd_addr ;
//
//wire[STIM_MW - 1:0]    dut_out_vec; 
//
////modules instanciations
//rf #(.STIM_MW ( `STIM_DMW ),
//     .STIM_AW ( `STIM_DAW )
//     ) 
//   rf(.clk    ( clk )        ,
//      .rd_addr( rd_addr )    ,
//      .rd_data( dut_out_vec ),
//      .wr_data( dut_stim_vec),
//      .wr_addr( wr_addr )    ,
//      .wr_en  ( en)
//      );
//      
//ff #(.W(1)) 
//   ff(.clk    ( clk ),
//      .in     ( en ) ,
//      .out    ( dut_out_valid )
//      );   
//
//endmodule

//module stim_mem(clk,
//                reset_,
//                rd_1st_3,
//                valid,
//                stim_vec_out,
//                stop_sim_mtc_stim
//                );
//                
//    parameter STIM_AW   = 1'd0;
//    parameter STIM_MW   = 1'd0;
//    parameter MEM_DEPTH = ( 1'b1 << STIM_AW ) -1;  
//    
//    input     clk     ;
//    input     reset_  ;
//    input     rd_1st_3;
//    input     valid   ;
//    output [STIM_MW - 1:0] stim_vec_out     ;
//    output                 stop_sim_mtc_stim;
//    
//    reg    [STIM_MW - 1:0] stim_vec         ;
//    reg                    stop_sim_mtc_stim;
//    reg    [STIM_MW - 1:0] mem [1'd0:MEM_DEPTH];
//    
//   
//    reg    [STIM_AW - 1:0] ra;
// wire    [STIM_AW - 1:0] ra_c = ra + 1'b1;
//
//    always@(posedge clk or negedge reset_) begin
//        if(~reset_) begin
//            ra <= {STIM_AW {1'b0}};
//        end 
//        else begin
//        if(valid | rd_1st_3) begin
// //           ra <= ra + 1'b1;
//             ra <= ra_c;
//        end 
//            stim_vec <= mem[ra]; 
//        end
//    end
//        
//
//
// //mux to dut    
//    wire  zero_mux = (ra == `VERSION_ADDR  || ra == `ID_ADDR);   
//    wire  ms = zero_mux | ~valid ;
//    wire  [STIM_MW - 1:0] stim_vec_out = ms ? {STIM_MW {1'b0}}:stim_vec;   
//
//    wire addr_eq_id_addr     = ra == `ID_ADDR;
//    wire addr_eq_id          = addr_eq_id_addr  & rd_1st_3;
//    wire stim_vec_id_correct = (stim_vec == `STIM_VECTOR_ID);
//    reg stim_vec_id_match;
//    always@(addr_eq_id or stim_vec_id_correct) begin
//       stim_vec_id_match = 1'b0;
//       if (addr_eq_id) begin 
//        if (stim_vec_id_correct ) begin 
//           stim_vec_id_match = 1'b1;
//           $display("Stim vector id matched! continuing simulation! tb ra = %x id = %x file id = %x", ra, `STIM_VECTOR_ID, stim_vec);
//       end 
//        else begin 
//           stim_vec_id_match = 1'b0;
//           $display("Stim vector id mismatch!   Exiting simulation! tb ra = %x id = %x file id = %x", ra, `STIM_VECTOR_ID, stim_vec);
//          // $finish;
//        end
//      end
//    end
//    
//    wire addr_eq_version_addr = ra == `VERSION_ADDR;
//    wire addr_eq_version = addr_eq_version_addr & rd_1st_3;
//    wire stim_vec_version_correct = (stim_vec == `STIM_VECTOR_VERSION);
//    reg stim_vec_version_match;
// 
//    always@(posedge clk) begin
//       stim_vec_version_match = 1'b0;
//       if (addr_eq_version) begin 
//        if (stim_vec_version_correct ) begin 
//          stim_vec_version_match = 1'b1;
//          $display("Stim vector version matched! continuing simulation! tb ra = %x version = %x file version = %x", ra,`STIM_VECTOR_VERSION, stim_vec);
//        end 
//        else begin 
//          stim_vec_version_match = 1'b0;
//          $display("Stim vector version mismatch!   Exiting simulation! tb ra = %x version = %x file version = %x", ra,`STIM_VECTOR_VERSION, stim_vec);
//          //$finish;
//         end
//      end
//    end
//
//endmodule    


//module SD_mem(clk,ra,SD_vec_out,stop_sim_mtc_SD);
//    parameter              SD_AW   = 1'd0, 
//                           SD_MW   = 1'd0,
//                           MEM_DEPTH = (1'b1 << SD_AW) -1;
//    input                  clk;
//    input  [SD_AW -1:0]    ra;
//    output [SD_MW - 1:0]   SD_vec_out;
//    output                 stop_sim_mtc_SD;
//    reg    [SD_MW - 1:0]   SD_vec;
//    reg                    stop_sim_mtc_SD;
//    reg    [SD_MW - 1:0]   mem [1'd0:MEM_DEPTH];
//    wire   [SD_MW - 1:0]   version        = `VER;
//    wire   [SD_MW - 1:0]   id             = `VECTOR_ID;
//    wire                   version_assert = (SD_vec == version);
//    wire                   id_assert      = (SD_vec == id);
//    
//    //mux to SD  
//    wire                   zero_mux   = (ra == `ID_ADDR || ra == 2);   
//    wire   [SD_MW - 1:0]   SD_vec_out = (zero_mux ? {SD_MW{1'b0}}:SD_vec);   
//    
//    initial begin
//        SD_vec          = mem[ra];
//        stop_sim_mtc_SD = 1'b0   ;
//    end
//    
//    always@(posedge clk) begin
//        SD_vec <= mem[ra];
//        if(ra==0)begin
//           if(~version_assert)begin
//                $display("SD Vector version mismatch! Exiting simulation!");
//                $finish;
//           end 
//           else begin $display("SD vect version matched! continuing simulation!");
//                end
//        end
//        if(ra==1)begin
//           if(~id_assert) begin
//                $display("SD Vector Id mismatch! Exiting simulation");
//                $finish;
//           end 
//           else begin 
//                $display("SD id matched! continuing simulation!");
//           end
//        end
//     end
//endmodule

//Testbench declaration
module testbench();
    parameter STIM_MEM_DEPTH = (1'b1 << `STIM_DAW) -1;
    parameter EXP_MEM_DEPTH  = (1'b1 << `EXP_DAW)  -1;
    
    //integer   mem_addr;
    
    //---control signals
    reg  clk;
    reg  reset_;
    reg  start_sim;
    reg  rd_1st_3;
    reg  stall;
    reg cmp_on;
    wire valid;
    wire stop_sim_mtc_stim;
    wire stop_sim_mtc_exp;
    //wire stop_sim_mtc_SD;
    wire stop_sim = (stop_sim_mtc_stim | stop_sim_mtc_exp);
    wire dut_out_valid;
    wire dut_v  = ~rd_1st_3 & ~stall & valid;    
    wire ctrans  = dut_out_valid & 1;    
    wire exp_en  = ( (cmp_on & ctrans) | rd_1st_3);
    //---end control signals
    
    wire [`STIM_DMW - 1:0] dut_out_vec                  ;
    // wire [`SD_DMW - 1:0]   SD_vec_out                   ;
    wire [`CNT - 1:0]      miss_cnt                     ;
    wire [`CNT - 1:0]      match_cnt                    ;
    wire [`EXP_DMW - 1:0]  exp_vec_out                  ;
    wire [`STIM_DMW - 1:0] stim_vec_out                 ;
    reg  [`STIM_DAW - 1:0] nr_valid_trans               ;

    integer   d;
   
    initial begin
        clk             = 1'b0;
        reset_          = 1'b1;
        start_sim       = 1'b0;
        stall           = 1'b0;
        rd_1st_3        = 1'b0;      
        cmp_on          = 1'b0;
        @(posedge clk) start_sim  = 1'b1;
       
        for (d = 0; d < 10; d = d + 1) begin
           @(posedge clk) reset_  = 1'b1;
        end

        for (d = 0; d < 5; d = d + 1) begin
           @(posedge clk) reset_  = 1'b0;
        end

        for (d = 0; d < 1; d = d + 1) begin
           @(posedge clk) reset_ = 1'b1;
        end
        @(posedge clk) cmp_on   = 1'b0;
                       rd_1st_3 = 1'b1;      
        @(posedge clk) rd_1st_3 = 1'b1;      
        @(posedge clk) rd_1st_3 = 1'b1;
        @(posedge clk) rd_1st_3 = 1'b0;
        @(posedge clk) cmp_on   = 1'b1;
    end

    //clock generator
    //always clk = #100 ~clk;

initial begin
clk = 1;
forever begin
#20 clk = ~clk;
end
end


    wire   stop_clk;  // output from SD memory      
    //wire   tb_clk = clk & ~stop_clk;
    //wire   sd_clk = clk &  stop_clk;
    //end clock generator
    
    reg [0:0] random_val;
    always @(posedge clk) begin
      random_val = $random;
    end
  
    wire random_gen_en = (cmp_on & ~stall & start_sim);  
    wire random_mux    = ~(random_gen_en ? random_val : 0);
    assign valid       = cmp_on & random_mux;
        
    integer cycle_cnt;
    initial cycle_cnt = 0;
    
    always @(posedge clk or negedge reset_) begin
      if (~reset_) begin
        cycle_cnt <= 0;
      end
      else begin
        cycle_cnt <= cycle_cnt +1;
      end 
    end
    
    wire cycle_zero = cycle_cnt == 0;
    wire cycle_one  = cycle_cnt == 1;
    wire cycle_1st_2 = cycle_zero || cycle_one;
    
    reg                    stim_memory_loaded;
    reg                    exp_memory_loaded ;
    reg  [`SD_DAW - 1:0]   SD_ra;
        
    initial begin        
         $readmemb ("E:\\expected.vec",  expected_mem_.mem);
         exp_memory_loaded = 1'b1;
         $display(  "E:\\expected.vec loaded");
        
        $readmemb ( "E:\\stimulus.vec",      stim_mem_.mem);
        stim_memory_loaded = 1'b1;
        $display(   "E:\\stimulus.vec loaded");
 
        //$readmemb ("E:\\SD_mem_list",   SD_mem.mem);
    end
    
    integer mem_addr;
    
    initial begin
        @stim_memory_loaded; 
       // put in a plusarg here to display the memory contents
       if ($test$plusargs("STIM_MEM"))
         $display("==================================================");
         $display("VECTOR_FILE =%s initial state", "E:\\stim_mem_list");
         for (mem_addr = 0; mem_addr <= STIM_MEM_DEPTH; mem_addr = mem_addr + 1'b1) begin
            $display ("mem[%d] = %b", mem_addr, stim_mem_.mem[mem_addr]);
            stim_memory_loaded = 1'b0;
       end
       $display("==================================================");
    end
     
   initial begin
       @exp_memory_loaded;
       if ($test$plusargs("EXP_MEM"))
         $display("==================================================");
         $display("VECTOR_FILE =%s initial state", "E:\\exp_mem_list");
         for (mem_addr = 0; mem_addr <= EXP_MEM_DEPTH; mem_addr = mem_addr + 1'b1) begin
            $display ("mem[%d] = %b", mem_addr,expected_mem_.mem[mem_addr] );
            exp_memory_loaded = 1'b0;
       end
       $display("==================================================");
    end
    
   
// replacewith addresses and data in the stim vector file

    //modules instanciations
    stim_mem     #(.STIM_AW(`STIM_DAW),
                   .STIM_MW(`STIM_DMW)
                 )
                 stim_mem_    (.clk              (clk),
                              .reset_            (reset_),
                              .rd_1st_3          (rd_1st_3),
                              .valid             (valid),
                              .stim_vec_out      (stim_vec_out),
                              .stop_sim_mtc_stim (stop_sim_mtc_stim)
                              );
                              
    wire exp_valid    = cmp_on    & ctrans;
    wire exp_valid_in = exp_valid & exp_valid; 
    
    stim_mem     #(.STIM_AW(`EXP_DAW),
                   .STIM_MW(`EXP_DMW)
                 )
                 expected_mem_(.clk              (clk),
                              .reset_            (reset_),
                              .rd_1st_3          (rd_1st_3),
                              .valid             (exp_valid_in),
                              .stim_vec_out       (exp_vec_out),
                              .stop_sim_mtc_stim  (stop_sim_mtc_exp)
                              );                              



    dut          #(.STIM_MW(`STIM_DMW),
                   .CNT    (`CNT),
                   .STIM_AW(`STIM_DAW)
                   )
                 dut_        (.clk               (clk),
                              .en                (dut_v),
                              .dut_stim_vec      (stim_vec_out),
                              .dut_out_vec       (dut_out_vec),
                              .dut_out_valid     (dut_out_valid),
                              .stop_clk          (stop_clk)
                              );  
//                              
//    SD_mem       #(.SD_AW(`SD_DAW),.SD_MW(`SD_DMW))
//                 SD_mem      (.clk(clk),
//                              .ra(SD_ra),
//                              .SD_vec_out(SD_vec_out),
//                              .stop_sim_mtc_SD(stop_sim_mtc_SD));
//    
//    comparator   #(.EXP_MW (`EXP_DMW),
//                   .STIM_MW(`STIM_DMW),
//                   .CNT    (`CNT)
//                   )
//                 comparator  (.clk               (clk),
//                              .reset_            (reset_),
//                              .cmp_on            (cmp_on & ctrans),
//                              .exp_vec_out       (exp_vec_out),
//                              .dut_out_vec       (dut_out_vec),
//                              .miss_cnt          (miss_cnt),
//                              .match_cnt         (match_cnt)
//                              );

// expected vector comparison



//max transactions checker
always @(posedge clk or negedge reset_ or dut_out_valid) begin
    if (~reset_) begin
        nr_valid_trans = {`STIM_DAW{1'b0}};
    end
    else begin
        if(dut_out_valid) begin
            if(nr_valid_trans > `MTC) begin
                $display("max transaction overflow!Exiting simulation!");
                $finish; 
            end
            else begin
                nr_valid_trans = nr_valid_trans + 1'b1;
            end
        end
    end        
end

endmodule