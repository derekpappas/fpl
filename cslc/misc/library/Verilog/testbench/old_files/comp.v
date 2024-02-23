//07 September 2007
//andreim

module FF(FF_in, clk, FF_out);
    parameter width = 5;
    input [width:0] FF_in;
    input clk;
    output [width:0] FF_out;
    
    reg [width:0] FF_out;
    always @(posedge clk) begin
        FF_out = FF_in;
        $display("FF = %d", FF_out);
    end
endmodule

module add(a,b,clk,out);
    parameter width = 5;
    input [width-1:0] a;
    input [width-1:0] b;
    input clk;
    output [width:0] out;
    
    wire [width:0] out;
    reg [width:0] tmp_out;
    initial begin
        tmp_out = a+b;
    end
    always@ (posedge clk) begin
        tmp_out = a + b;
        $display("add_a=%d, add_b=%d add_sum_module=%d",a,b,tmp_out);
    end  
    FF FF_add(.FF_in(tmp_out),.clk(clk),.FF_out(out));  
endmodule
    
module counter(c_in_comp,c_in_add, clk, miss, match);
    parameter width = 5;
    input [width:0] c_in_comp;
    input [width:0] c_in_add;
    input clk;
    output [width-2:0] miss;
    output [width-2:0] match;
   
    reg [width-2:0] miss;
    reg [width-2:0] match;
    initial begin
        miss = -2;
        match = 4'b0000;
    end
    always @(posedge clk) begin
        $display("sum_mem=%d  sum_add=%d",c_in_comp, c_in_add);
        if( c_in_comp == c_in_add) begin
            match = match + 4'b0001;
            $display("match=%d",match);
        end
        else begin
            miss = miss + 4'b0001;
            $display("miss=%d", miss);
        end
    end
endmodule

module add_memory(wa,wd,ra,clk,rd);
    parameter width = 7;
    input [width:0] wa;
    input [width:0] wd;
    input [width:0] ra;
    input clk;
    output [width-2:0] rd;
    reg [width:0] st_addr;
    reg [width:0] stop_addr;
    reg [width-2:0] val_file;
    
    reg [width-2:0] rd;
    reg [width-2:0] sum_memory[0:255];
    initial begin
        st_addr = 8'b 10000000;
        stop_addr = 8'b 11000000;       
        rd = 6'b 000000;
        $readmemb("read_from_me.dat", sum_memory,st_addr,stop_addr);
        $display("data from file%d",sum_memory[st_addr]);
    end
    
    always@(posedge clk) begin
        $display("wa=%d,wd=%d,ra=%d",wa,wd,ra);
        sum_memory[wa] = wd;
        rd = sum_memory[ra];
        $display("rd=%d",rd);
    end   
endmodule

module comp();
    parameter width = 7;
    reg clk;
    reg [width-3:0] a;
    reg [width-3:0] b;
    reg [width:0] mem_val;
    reg [width:0] mem_addr;
    wire [width-2:0] result;
    wire [width-2:0] result_add;
    wire [width-2:0] delay1;
    wire [width-2:0] delay2;
    wire [width-4:0] miss_w;
    wire [width-4:0] match_w;
    wire [width-2:0] mem_out;
    initial begin
        clk = 0;
        a = 5'b 00001;
        b = 5'b 00010;
        mem_val = a+b;
        mem_addr = 8'b 00000000;
    end
    
    always #10 begin
        clk = ~clk;
    end
    
    add_memory add_mem(.wa(mem_addr),.wd(mem_val),.ra(mem_addr),.clk(clk),.rd(mem_out));    
    add add_comp(.a(a),.b(b),.clk(clk),.out(result_add));
    FF FF_delay1(.FF_in(mem_out),.clk(clk),.FF_out(delay1));
    //FF FF_delay2(.FF_in(delay1),.clk(clk),.FF_out(delay2));
    counter counter_comp(.c_in_comp(delay1),.c_in_add(result_add),.clk(clk),.miss(miss_w),.match(match_w));
        
    always @(posedge clk) begin
        $display("-----------------------------------------");
        mem_addr = mem_addr + 8'b 00000001;
        a = a+5'b00001;
        b = b+5'b00001;
        mem_val = a+b;
        $display("a=%d  |  b=%d and sum for mem=%d",a,b,mem_val);
    end
endmodule