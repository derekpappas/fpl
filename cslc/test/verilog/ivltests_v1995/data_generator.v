module data_generator(opcode,alu_x,alu_y,clk);

parameter width = 32;

output [4:0] opcode;
output [width-1:0] alu_x,alu_y;
input clk;

integer input_file;
integer i;
reg [4:0] opcode;
reg [width-1:0] alu_x,alu_y;
reg header;
initial
        begin
        i = 0;
        input_file = $fopen("./test_vectors","r");
        $display("OPCODE\t\t\tALU_X\t\t\tALU_Y\t\t\tTIME");
        if (input_file == 0)
                   $stop;
        end

always  @(posedge clk)
        begin        

                #(5);
                i = $fscanf(input_file, "%b\t\t\t%h\t\t\t%h",opcode,alu_x,alu_y); 
                if(i == -1)
                     $stop;
                $display("-I-%h\t\t\t%h\t\t\t%h\t\t\t%d",opcode,alu_x,alu_y,$time);
      
        end

endmodule



