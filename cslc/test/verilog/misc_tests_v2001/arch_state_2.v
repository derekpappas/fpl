//arch_state
module ffa_fifo(data_in, pop, data_out, push, full, empty, not_ready, clk, reset, stall, as_mem0, as_mem1, as_mem2);
    parameter FW=16;
    parameter FH=3;
    
    input [FW-1:0] data_in;
    input pop, push, stall, clk, reset;
    output [FW-1:0] data_out, as_mem0, as_mem1, as_mem2;
    output full, empty, not_ready;
    
    reg [FW-1:0] data_out;
    reg [FW-1:0] as_mem[0:FH-1];
    wire full, empty, en1, en2;
    reg [FW-1:0]fifo_reg_0, fifo_reg_1, fifo_reg_2;
    reg v0, v1, v2;
    
    assign full=(v0 && v1 && v2);
    assign empty=!(v0 || v1 || v2);
    assign not_ready=!v2;
    
    assign en1=v0 && !(v1 && v2 && pop && stall);
    assign en2=v1 && !(v2 && pop && stall);
    
    assign as_mem0=fifo_reg_0;
    assign as_mem1=fifo_reg_1;
    assign as_mem2=fifo_reg_2;
    
    always@(reset) begin
        if(!reset) begin
           fifo_reg_0<=0;
            v0<=0;
            fifo_reg_1<=0;
            v1<=0;
            fifo_reg_2<=0;
            v2<=0;
            data_out<=0;
        end
    end
    always@(posedge clk)
    begin
       if((push && !stall && !full) || (push && !stall && full && pop && !not_ready)) begin
          fifo_reg_0<=data_in;
          v0<=1;
       end
       else v0<=0;
       if(pop && !stall && !not_ready) begin
          data_out<=fifo_reg_2;
          fifo_reg_2<=fifo_reg_1;
          fifo_reg_1<=fifo_reg_0;
          v1<=v0;
          v2<=v1;
       end
       else begin
          data_out<=0;
       end
       if(en1) begin
          fifo_reg_1<=fifo_reg_0;
          v1<=v0;
       end
       if(en2) begin
          fifo_reg_2<=fifo_reg_1;
          v1<=v0;
          v2<=v1;
       end
    end
endmodule

//tb_arch_state
module tb_ffa_fifo;
    parameter FW=16;
    parameter FH=3;
    parameter DN=8;
    
    reg [FW-1:0] data_in;
    reg pop, push, stall, clk, reset;
    wire [FW-1:0] data_out, as_mem0, as_mem1, as_mem2;
    wire full, empty;
    
    reg [FW-1:0] stim_mem[0:DN];
    reg [FW-1:0] arch_state_mem[0:(DN+1)*FH-1];
    reg [FW-1:0] arch_state[0:FH-1];
    integer i=0;
    
    ffa_fifo #(FW, FH)FIFO(data_in, pop, data_out, push, full, empty, not_ready, clk, reset, stall, as_mem0, as_mem1, as_mem2);
    
    initial begin
        reset=0;
        clk=0;
        $readmemb("stimulus_as.vec", stim_mem);
        $readmemb("expected.as", arch_state_mem);
        data_in=stim_mem[i];
        arch_state[i]=arch_state_mem[i];
        arch_state[i+1]=arch_state_mem[i+1];
        arch_state[i+2]=arch_state_mem[i+2];
        stall=0;
        push=1;
        pop=1;
        #4;
        reset=1;
    end
    
    always@(posedge clk) begin
       if(i<=DN) begin
          
          if(arch_state_mem[3*i]==as_mem0 && arch_state_mem[3*i+1]==as_mem1 && arch_state_mem[3*i+2]==as_mem2) begin
              $display("arch_state no. %2d \n %b   %b  \n %b   %b \n %b   %b \nPASSED!", i, as_mem0, arch_state_mem[3*i], as_mem1, arch_state_mem[3*i+1], as_mem2, arch_state_mem[3*i+2]);
          end
          else begin
              $display("arch_state no. %2d \n %b   %b  \n %b   %b \n %b   %b \nFAILED!", i, as_mem0, arch_state_mem[3*i], as_mem1, arch_state_mem[3*i+1], as_mem2, arch_state_mem[3*i+2]);
          end
          i=i+1;
          data_in=stim_mem[i];
          
          
      end
    end
    
    always #5 clk=~clk;
    
endmodule