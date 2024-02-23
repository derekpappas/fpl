`timescale 1 ps / 1 ps

//################## Design Under Test (DUT) ##################################
// DUT(Design Under Test) generates the vectors for sd and exp comparators    #
// when rd_en is 1 the DUT generates data for exp comparator                  #
// when sd_cmp_event is 1 the DUT generates data for SD comparator            # 
// the input data from stimulus MEM is hold inside a rf                    #
//#############################################################################

// define dut module
module dut(clk,
           reset_,
           wr_data,
           wr_addr,
           wr_en,
           rd0_data,
           rd0_addr,
           rd_en,
           rd_v,
           sd_cmp_event
           );
            
parameter WR_RD_DATA_WIDTH   = 1'd0 ;
parameter WR_RD_ADDR_WIDTH   = 1'd0 ;
parameter SD_MEM_ADDR_WIDTH  = 1'd0 ;

input                             clk      ;
input                             reset_   ;
input [WR_RD_DATA_WIDTH - 1 : 0 ] wr_data  ;
input [WR_RD_ADDR_WIDTH - 1 : 0 ] wr_addr  ;
input                             wr_en    ;
input [WR_RD_ADDR_WIDTH - 1 : 0 ] rd0_addr ;
input                             rd_en    ;

output[WR_RD_DATA_WIDTH - 1 : 0 ] rd0_data ;
output                            rd_v     ;
output                            sd_cmp_event ;

wire  [WR_RD_DATA_WIDTH - 1 : 0 ] rd0_data ; 

// State Data Compare Event(sd_cmp_event) is 1 when wr_en is 1
wire sd_cmp_event;

ff #(.W( 1 ) )
     sd_cmp_event_ff(.clk ( clk          ),
                     .r_  ( reset_       ),
                     .d   ( wr_en        ), 
                     .q   ( sd_cmp_event )
                     );
    
    
//always @(posedge clk or negedge reset_) begin
//    if (~reset_) begin
//        sd_cmp_event <= 1'b0;
//    end else begin
//        sd_cmp_event <= wr_en;
//    end
//end

//module instanciations
rf #(.MEM_WORD_WIDTH  ( WR_RD_DATA_WIDTH  ),
     .MEM_ADDR_WIDTH  ( WR_RD_ADDR_WIDTH  )
    )
   rf(.clk     ( clk      ),
      .reset_  ( reset_   ),
      .wr_data ( wr_data  ),
      .wr_addr ( wr_addr  ),
      .wr_en   ( wr_en    ),
      .rd0_data( rd0_data ),
      .rd0_addr( rd0_addr ),
      .rd_en   ( rd_en    )
      );
      
ff #(.W(1))  // add reset signal
   ff(.clk ( clk    ),
      .r_  ( reset_ ),
      .d   ( rd_en  ),
      .q   ( rd_v   )
      );

endmodule