module tb;
    reg clk, in_sgn;
    wire out_sgn;
    unit_a DUT(out_sgn, in_sgn);
    sim_tr_timeout_cnt CNT_ERR(clk, out_sgn);
    
    initial begin
        clk=0;
        in_sgn=0;
        #50 in_sgn=1;
        #100 in_sgn=0;
    end
    always #5 clk=~clk; 
endmodule

//create the unit_a used as DUT
module unit_a(out_sgn, in_sgn);
    input in_sgn;
    output out_sgn;
    reg out_sgn;
    always@(in_sgn)
      out_sgn=~in_sgn;
endmodule
//create the simulation and transaction timeout count
module sim_tr_timeout_cnt(clk, sgn);
    parameter MAX_TR_CNT=10;
    parameter MAX_SIM_CNT=100;

    input clk, sgn;
    reg tr_err, sim_err;
    integer tr, sim;
    initial begin
        tr=0;
        sim=0;
    end
    always@(sgn)
      begin
          tr=0;
      end
    always@(posedge clk)
      begin
          tr=tr+1;
          sim=sim+1;
          if(sim>=MAX_SIM_CNT) begin
              $display("Transaction timeout!");
		              $finish;
          end
          else if(tr>=MAX_TR_CNT) begin
              $display("Simulation timeout!");
              $finish;
          end
      end
endmodule