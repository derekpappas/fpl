module tb();
    parameter INPUT_WIDTH=4;
    parameter OUTPUT_WIDTH=2;
    parameter MEM_DEPTH=8;
    
    reg [INPUT_WIDTH-1: 0] stim_vector0;
    reg [INPUT_WIDTH-1: 0] stim_mem[0: MEM_DEPTH-1];
    wire [INPUT_WIDTH-1: 0] input_ifc;
    wire [OUTPUT_WIDTH-1: 0] output_ifc;
    wire vec_update_event;
    integer i=0; 
    
    A dut_A(input_ifc, output_ifc);
    
    //connect vector to DUT's input interface
    assign input_ifc=stim_vector0;
    
    initial begin
        $readmem("stimulus.vec", stim_mem);
        stim_vector0=stim_mem[0];
    end 
    //update the vector on vec_update_event
    always@(posedge vec_update_event) begin
        if(i<MEM_DEPTH) begin
            stim_vector0=stim_mem[i];
            i=i+1;
        end
    end 
    
endmodule