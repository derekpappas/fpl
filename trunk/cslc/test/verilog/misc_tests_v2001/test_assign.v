module test_assign;
    integer a,b,c,d;
    integer m,n,o,p;
    
    initial begin
	    a = 67;
	    m = 67;
	    #10;
	    a <= 4;
	    m =4;
	    c <= #15 a;
	    o = #15 m;
	    d <= #10 9;
	    p = #10 9;
	    b <= 3;
	    n = 3;
    end
always
    $display("At t=%t a=%d ,m=%d ,b=%d ,n=%d ,c=%d ,o=%d ,d=%d ,p=%d ",$time a,m,b,n,c,o,d,p);
endmodule
