`timescale 1 ps / 1 ps

module state_data_comparator(clk,
                             reset_,
                             sd_comp_en,
                             sd_vector_out,
                             rf_data,
                             sd_match_cnt,
                             sd_mismatch_cnt
                            );
                            
parameter MEM_WORD_WIDTH    = 1'd0;
parameter WR_RD_DATA_WIDTH  = 1'd0;
parameter SD_MEM_ADDR_WIDTH = 1'd0;

input                                clk            ;
input                                reset_         ;
input                                sd_comp_en     ;
input  [ MEM_WORD_WIDTH    - 1 : 0 ] sd_vector_out  ;
input  [ WR_RD_DATA_WIDTH  - 1 : 0 ] rf_data        ;

output [ SD_MEM_ADDR_WIDTH - 1 : 0 ] sd_match_cnt   ;
output [ SD_MEM_ADDR_WIDTH - 1 : 0 ] sd_mismatch_cnt;

reg    [ SD_MEM_ADDR_WIDTH - 1 : 0 ] sd_match_cnt   ;
reg    [ SD_MEM_ADDR_WIDTH - 1 : 0 ] sd_mismatch_cnt;
reg                                  match          ;


//Match counter gets incremented when sd vector = rf
wire sd_eq_rf = sd_vector_out ==  rf_data;

always @(posedge clk or negedge reset_) begin
    if ( ~reset_ ) begin
        sd_match_cnt <= {SD_MEM_ADDR_WIDTH{1'b0}};
    end else if( sd_comp_en ) begin
        if( sd_eq_rf ) begin
            sd_match_cnt <= sd_match_cnt + 1'b1;
            $display("MATCH: SD vector = %d  RF = %d! sd_match_cnt= %d  at time: %g\n", sd_vector_out, rf_data, sd_match_cnt, $time); 
        end 
    end
end

//Mismatch counter gets incremented when sd vector != rf
always @(posedge clk or negedge reset_) begin
    if ( ~reset_ ) begin
        sd_mismatch_cnt <= {SD_MEM_ADDR_WIDTH{1'b0}};
    end else if( sd_comp_en ) begin
        if( ~sd_eq_rf ) begin
            sd_mismatch_cnt <= sd_mismatch_cnt + 1'b1;
            $display("MISMATCH: SD vector = %d  RF = %d! sd_mismatch_cnt= %d at time: %g\n", sd_vector_out, rf_data, sd_mismatch_cnt, $time); 
        end
    end
end

endmodule             