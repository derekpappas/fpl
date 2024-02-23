// r_pc program counter Verilog code
   reg [15:0] addr_in;
    
    always @ (posedge p_clock or negedge p_reset)
       begin
           if(!p_reset) 
              begin
                p_addr_out=0;
                p_addr_in=0;
             end
           else 
           if(p_enable) begin
              case ( p_sel )
                  0: p_addr_out = addr_in +1;
                  1: p_addr_out = p_br_addr;
              default : p_addr_out =0;
              endcase
              p_addr_in=p_addr_out;
              end
         end
