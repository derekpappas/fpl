module testcc(a,c,z,n,v,result);
	
	parameter gatedelay = 3;
	
	input [3:0] a;
	input c,z,n,v;
	output result;

	wire w1,w2,w3,w4,w5,w6,w7,w8,w9,w11;
	wire w12,w13,w14,w15,w16,w17,w18,w19,w20;
	wire w21,w22,w23,w24,w25;
	wire result;
	
	not #(gatedelay) not1(w1,a[0]);
	not #(gatedelay) not2(w2,a[1]);
	not #(gatedelay) not3(w3,a[2]);
	not #(gatedelay) not4(w4,a[3]);
	not #(gatedelay) not5(w5,c);
	not #(gatedelay) not6(w6,n);
	not #(gatedelay) not7(w7,z);
	not #(gatedelay) not8(w8,v);
	
	and #(gatedelay) and1(w9,w1,w2,w3,w4);
	and #(gatedelay) and2(w11,w4,w3,w2,a[0],w5);
	and #(gatedelay) and3(w12,a[3],w2,w3,a[0],c);
	and #(gatedelay) and4(w13,w4,w3,a[1],w1,w8);
	and #(gatedelay) and5(w14,a[3],w3,a[1],w1,v);
	and #(gatedelay) and6(w15,w4,w3,a[1],a[0],z);
	and #(gatedelay) and7(w16,a[3],w3,a[1],a[0],w7);
	
	xor #(gatedelay) xor11(w17,n,v);
	not #(gatedelay) not12(w18,w17);
	and #(gatedelay) and13(w19,w4,a[2],w2,w1,w18);
	and #(gatedelay) and14(w20,a[3],a[2],w2,w1,w17);
	and #(gatedelay) and15(w21,w4,a[2],w2,a[0],w7,w18);
	
	or #(gatedelay) or16(w22,z,w17);
	and #(gatedelay) and17(w23,a[3],a[2],w2,a[0],w22);
	and #(gatedelay) and18(w24,w4,a[2],a[1],w1,w6);
	and #(gatedelay) and19(w25,a[3],a[2],a[1],w1,n);
	
	or #(gatedelay) or20(result,w9,w11,w12,w13,w14,w15,w16,w19,w20,w21,w23,w24,w25);

	

endmodule

	


