module checker(data_out,data_in,address,write);

parameter width = 32;

input [width-1:0] data_out,data_in,address;
input write;
reg[width-1:0] ref_mem[0:128];
reg [width-1:0] ref_read;

initial
  begin
        $readmemh("initialize.dat",ref_mem); 
  end
always @(write or data_in or address or data_out)
       begin
       #(20);
        // Store value on writes
        if (write == 1)
           begin
                ref_mem[address] = data_in[31:24];
                ref_mem[address+1] = data_in[23:16];
                ref_mem[address+2] = data_in[15:8];
                ref_mem[address+3] = data_in[7:0];
                $display("Updating Reference memory");                                                 
           end
           
        // Check value on reads   
        if (write == 0)
          begin
                ref_read[31:24] = ref_mem[address];
                ref_read[23:16] = ref_mem[address+1];
                ref_read[15:8] = ref_mem[address+2];
                ref_read[7:0] = ref_mem[address+3];
                if (ref_read == data_out)
                   $display("Verified: Read value matches Reference value.");
                else
                   begin     
                     $display("-E-Reference value: %h  did not match read value %h",
                              ref_read,data_out);             
                     $stop;
                   end
          end    
       end
endmodule






