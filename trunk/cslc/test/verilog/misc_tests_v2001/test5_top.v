module top();
    
wire data_path,clock,enable,data_in,data_out;
ff ff1(.clk(clock),.enable(enable),.data(data_in),.q(data_path));
ff ff2(.clk(clock),.enable(enable),.data(data_path),.q(data_out));

endmodule