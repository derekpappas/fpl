module rnd_data_generator(opcode,alu_x,alu_y,clk);

parameter width = 32;

output [4:0] opcode;
output [width-1:0] alu_x,alu_y;
input clk;


integer i;
integer seed_op,seed_x,seed_y;
reg [4:0] opcode;
reg [width-1:0] alu_x,alu_y;

initial
        begin
     
        i = 0;
        $display("OPCODE(dec)\t\t\tALU_X(hex)\t\t\tALU_Y(hex)\t\t\tTIME");
        $display("=====================================================================================");
        end

always  @(posedge clk)
        begin        

                #(5);
                opcode = $random;
                while ((opcode > 14) && (opcode < 31))
                   opcode = $random;   
                alu_x = $random;
                alu_y = $random;
                $display("-I-%d\t\t\t%h\t\t\t%h\t%d",opcode,alu_x,alu_y,$time);
                i = i+1;
                // if (i == 17)
                //    $stop;
          
               
        end

endmodule



