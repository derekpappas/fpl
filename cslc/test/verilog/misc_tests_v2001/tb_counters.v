`define MAX_TR_CNT 10
`define MAX_SIM_CNT 100

module cnt_error(tr_err, sim_err, clk, sgn);
    input clk, sgn;
    output tr_err, sim_err;
    
    reg tr_err, sim_err;
    integer tr, sim;
    
    initial begin
        tr=0;
        sim=0;
        tr_err=0;
        sim_err=0;
    end
    always@(sgn)
      begin
          tr=0;
      end
    always@(posedge clk)
      begin
          tr=tr+1;
          sim=sim+1;
          if(sim>=`MAX_SIM_CNT)
            sim_err=1;
          else if(tr>=`MAX_TR_CNT)
            tr_err=1;
      end
endmodule

module tb_cnt_error;
    reg clk, sgn;
    wire tr_err, sim_err;
    
    cnt_error CNT_ERR(tr_err, sim_err, clk, sgn);
    
    initial begin
        clk=0;
        sgn=0;
        #50 sgn=1;
        #100 sgn=0;
        #120 sgn=1;
        #150 sgn=0;
    end
    always #5 clk=~clk; 
endmodule