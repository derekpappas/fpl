`timescale 1 ps / 1 ps

module comparator(clk,
                  reset_,
                  cmp_on,
                  ctrans,
                  exp_vec_out,
                  dut_out_vec,
                  miss_cnt,
                  match_cnt
                  );
    parameter  EXP_DATA_OUT_WIDTH = 1'd0 ;
    parameter  DUT_DATA_OUT_WIDTH = 1'd0 ;
    parameter  CNT                = 1'd0 ; 
    parameter  CNT_WIDTH          = 1'd0 ;
        
    input   clk    ;
    input   reset_ ;    
    input   cmp_on ;
    input   ctrans ;
    input  [EXP_DATA_OUT_WIDTH  - 1 : 0 ] exp_vec_out ;
    input  [DUT_DATA_OUT_WIDTH  - 1 : 0 ] dut_out_vec ;
    
    output [CNT_WIDTH           - 1 : 0 ] match_cnt   ;
    output [CNT_WIDTH           - 1 : 0 ] miss_cnt    ;
    
    reg    [CNT_WIDTH            -1 : 0 ] match_cnt   ;
    reg    [CNT_WIDTH            -1 : 0 ] miss_cnt    ;
    
    wire comparator_enable = cmp_on & ctrans;
    wire comparator_enable_d1;
    wire [DUT_DATA_OUT_WIDTH  - 1:0] dut_out_vec_d1;
    
    //delays
    ff #(.W(1)) ff(.clk(clk), .reset_(reset_), .en(1'b1), .in(comparator_enable),.out(comparator_enable_d1));
    ff #(.W(DUT_DATA_OUT_WIDTH)) ff_(.clk(clk), .reset_(reset_), .en(1'b1), .in(dut_out_vec), .out(dut_out_vec_d1));
    //end delays
    
    //write DUT_out_vec and Exp_vec to file 
    integer vectors_mcd; //mcd = multi_channel_descriptor
    initial begin
        vectors_mcd = $fopen("vectors.txt");
        if( vectors_mcd == 0)begin
            $display("Error opening vectors.txt file");
            $finish;
        end
        $fdisplay (vectors_mcd, "The vectors from DUT and Expected File:\n");
    end
    
    always@ (posedge clk)begin
        if(comparator_enable_d1)begin
           $fdisplay (vectors_mcd,"   dut_out_vec = %b", dut_out_vec_d1, 
                                  "\n   exp_vec_out = %b",exp_vec_out,
                                  "\n   -----------------");
        end
    end
    //end write DUT_out_vec and Exp_vec to file
     
    //Match counter gets incremented when exp vector = dut vector 
    wire exp_eq_dut = exp_vec_out == dut_out_vec_d1;
    
    always@(posedge clk or negedge reset_) begin
        if ( ~reset_ ) begin
            match_cnt <= { CNT{1'b0} };
        end else if ( comparator_enable_d1 ) begin 
           if ( exp_eq_dut ) begin
              match_cnt <= match_cnt + 1;
              $display("MATCH: Expected vector = %d  Dut_out_vect = %d! match_cnt= %d time = %g ", exp_vec_out, dut_out_vec_d1, match_cnt, $time);
           end
        end
    end
    
    //Mismatch counter gets incremented when exp vector != dut vector    
    always@ (posedge clk or negedge reset_) begin
        if ( ~reset_ ) begin
            miss_cnt  <= { CNT{1'b0} };
        end else if ( comparator_enable_d1 ) begin 
           if ( ~exp_eq_dut ) begin
               miss_cnt <= miss_cnt +1;
               $display(  "MISMATCH: Expected vector = %d  Dut_out_vect = %d! miss_cnt = %d time = %g ", exp_vec_out, dut_out_vec_d1,  miss_cnt, $time); 
           end
        end
    end
    
endmodule