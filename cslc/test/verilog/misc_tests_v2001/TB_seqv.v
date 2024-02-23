//sequentional DUT
//mod=0 serial shift left and insert s_in to the right;
//mod=1 paralel load;
module shift_reg(Q_out, D_in, s_in, mod, clk, reset);
    input [7:0] D_in;
    input s_in, mod, clk, reset;
    output [7:0] Q_out;
    
    reg [7:0] Q_out;
    
    always@(reset, posedge clk)
      begin
          if(reset==0)
             Q_out=0;
          else
            begin
                if(mod==0)
                  begin
                      Q_out[31:1]=Q_out[30:0];
                      Q_out[0]=s_in;
                  end
                else
                  begin
                      Q_out=D_in;
                  end
            end
    end 
endmodule

//testbench

module TB_secv;
    wire [7:0] Q_out;
    reg [7:0] D_in;
    reg s_in, mod, clk, reset;
    
    shift_reg SR(Q_out, D_in, s_in, mod, clk, reset);
    
    reg [10:0] stimul[10:0];
    reg [7:0] expected[10:0];
    
    
    integer test;
    reg [10:0] test_stim;//one line of the memory
    reg [7:0] test_exp;//----//----
    
    initial begin
        $readmemb( "vect_stim.list" , stimul);
        $readmemb( "vect_exp.list" , expected);
        
        test_stim=stimul[0];                                                                                                     
        test_exp=expected[0];
        /*D_in=test_stim[10:3];
        s_in=test_stim[2];
        mod=test_stim[1];
        reset=test_stim[0];*/
        {D_in, s_in, mod, reset} = stimul[0];
        test=0;
        clk=0;        
    end 
    always #5 clk=~clk;
    
    always@(posedge clk)
      begin
          if(test<9)
            begin
                test_exp=expected[test];
                /*test_stim=stimul[test];
                D_in=test_stim[10:3];
                s_in=test_stim[2];
                mod=test_stim[1];
                reset=test_stim[0];*/
                {D_in, s_in, mod, reset} = stimul[test];
                if(Q_out==test_exp)
                  $display("D_in=%b s_in=%b mod= %b reset=%b Q_out=%b exp_Q_out=%b. Test %2d match.", D_in, s_in, mod, reset, Q_out, test_exp, test);
                else
                  $display("D_in=%b s_in=%b mod= %b reset=%b Q_out=%b exp_Q_out=%b. Test %2d UNMATCH!.", D_in, s_in, mod, reset, Q_out, test_exp, test);
                
                test=test+1;
            end
    end
    
endmodule