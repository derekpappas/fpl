// r_caddr address counter Verilog code
   reg [15:0] s_addr_in;
    
    always @ (posedge p_clock or negedge p_reset)
       begin
           if(!p_reset) 
              begin
                p_addr_out=0;
                s_addr_in=0;
             end
           else 
           if(p_enable) begin
              case ( p_sel )
                  0: if (p_cnt_dir) p_addr_out = s_addr_in +1;
                  else p_addr_out = s_addr_in -1;
                  1: p_addr_out = p_br_addr;
              default : p_addr_out =0;
              endcase
              s_addr_in=p_addr_out;
              end
         end
