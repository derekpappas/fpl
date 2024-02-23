module tb_events();
    parameter WIDTH=4;
    
    reg [WIDTH-1:0] vec_name0, DUT_inputs;
    wire vec_csim_event, vec_tb_event;
    wire [WIDTH-1:0] DUT_outputs;
    
    unit_a DUT(DUT_inputs, DUT_outputs);
    
    //write the vector
    always@(posedge vec_csim_event) begin
        vec_name0=$csim_vec_update;
    end
    //read the vector
    always@(posedge vec_tb_event) begin
        DUT_inputs=vec_name0;
    end
endmodule