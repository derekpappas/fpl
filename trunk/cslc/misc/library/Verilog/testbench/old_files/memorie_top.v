`define DMW 6 //Defined Memory Width  = 6
`define DAW 3 //Defined Memory addres Width  = 3
module ff(clk,in,out);
    parameter AW = 1;
    input                    clk;
    input    [AW - 1:0]      in ;
    output   [AW - 1:0]      out;
    reg      [AW - 1:0]      out;
    
    always@(posedge clk) begin
        out <= in;
    end
endmodule

//define RF
module rf(clk,ra,rd,re,wd,wa,we);
    parameter AW = 0;
    parameter MW = 0;
    input                  we,re,clk;
    input  [AW - 1:0]             ra;
    input  [AW - 1:0]             wa;
    input  [MW - 1:0]             wd;
    output [MW - 1:0]             rd;
    reg    [MW - 1:0]             rd;
    reg [MW-1:0] my_memory[0:(1'b1<<AW)-1];
    
    always@(posedge clk) begin
        if(we)begin
        my_memory[wa]= wd;
    end
        if(re)begin
        rd=my_memory[ra];
    end
end
endmodule

//define counter
module counter(clk,en,rst,cnt);
    parameter AW = 0;
    input             clk;
    input         rst,en;
    output [AW - 1:0] cnt;
    reg    [AW - 1:0] cnt;
    
    initial begin
        cnt = 0;
    end
    always@(posedge clk) begin
        if(en) begin
            cnt <= cnt+1;
        end
        if(rst)begin
            cnt <=0;
        end
    end
endmodule
//define TOP
module memory_top(clk,valid,reset,wd,rd,wa,we);
input clk,we;
output valid;
input reset;
input [`DMW:0] wd;
output [`DMW-1:0] rd;
input [`DAW-1:0] wa;
    wire [`DAW-1:0] top_ra1;
    wire [`DAW-1:0] top_ra2;
    wire [`DAW-1:0] ra;
    reg re=1;
    counter    #(.AW(`DAW)) counter2(.clk(clk),.en(re),.rst(reset),.cnt(ra));
    rf         #(.AW(`DAW),.MW(`DMW)) rf(.clk(clk),.ra(top_ra1),.rd(rd),.re(re),.wd(wd[6:1]),.wa(wa),.we(we));
   //ff         #(.AW(`DAW)) ff1(.clk(clk),.in(wa),.out(top_wa1));
    ff         #(.AW(`DAW)) ff2(.clk(clk),.in(ra),.out(top_ra1));
   // ff         #(.AW(`DAW)) ff3(.clk(clk),.in(top_wa1),.out(top_wa2));
    //ff         #(.AW(`DAW)) ff4(.clk(clk),.in(top_ra1),.out(top_ra2));
    ff         ff5(.clk(clk),.in(wd[0]),.out(valid));

endmodule
module  tb();
    reg rst,clk;
    wire [`DMW-1:0] rd;
    reg [`DMW:0] wd;
    wire [`DAW-1:0] wa;
    wire [`DAW-1:0] wa1;
    wire valid;
    reg we=1;
    reg [`DMW:0] rf_mem[0:(1'b1<<`DAW)-1];
    counter    #(.AW(`DAW)) counter1(.clk(clk),.en(we),.rst(rst),.cnt(wa));
    memory_top memory_top(.clk(clk),.valid(valid),.reset(rst),.wd(wd),.rd(rd),.wa(wa1),.we(we));
    ff         #(.AW(`DAW)) ff1(.clk(clk),.in(wa),.out(wa1));
initial begin
       $readmemb("mem_list.txt",rf_mem);
       clk = 1'b0;
       rst = 1'b0;
    end
   
    always clk = #2 ~clk;
    always @(posedge clk) begin
        wd <=rf_mem[wa];
    end
endmodule
        
        
    
    
    
    
    
    
    
