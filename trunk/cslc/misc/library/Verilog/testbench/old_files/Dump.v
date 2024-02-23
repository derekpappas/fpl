module a(in_a,out_a);
    input in_a;
    output out_a;
    
endmodule
module  aa(x,y);
input x;
output y;
assign y = x;
endmodule
module b(in_b, out_b);
    input in_b;
    output out_b;
   
    aa aa0(.x(in_b), .y(out_b));
endmodule
module dump();
  reg  s2;
  wire s3;  
  
  reg x1,x2;
    initial  begin
        x1 = 0;
        x2 = 0;
        s2 = 0;
    end
        
       b b0(.in_b(s2), .out_b(s3));
reg clock;
initial begin 
//$dumpfile("verilog.dump");
//$dumpfile("verilog1.dump");
//$dumpvars (0,dump);
//$dumpvars (1,dump);
//$dumpfile("verilog2.dump");
//$dumpvars(0,dump.b0);
//$dumpfile("verilog3.dump");
//$dumpvars(1,dump.b0);
//$dumpfile("verilog4.dump");
//$dumpvars(0,b0.aa0.y);
$dumpfile("verilog5.dump");
$dumpvars(1,dump.clock);
$dumpall;
$dumpon; 
clock=0;
end

always 
begin

repeat (500) @(posedge clock); 

end

always #5 clock=~clock;
endmodule