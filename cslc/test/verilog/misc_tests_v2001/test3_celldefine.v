`celldefine
module inv_1(op, ip);
    output op;
    input ip;
    specify
    specparam ip_op = 0;
    (ip=>op)=(ip_op);
    endspecify
    not(op, ip);
endmodule
`endcelldefine

`celldefine
module dp_2(q, ck, ip);
    output q;
    input ck, ip;
    specify
    specparam ck_q = 0;
    specparam temp = 0;
    (ck=>q)= (ck_q);
    $setup(edge[01] ip, edge[01] ck, temp);
    $setup(edge[10] ip, edge[01] ck, temp);
    $hold(edge[01] ck, ip, temp);
    $width(negedge ck, temp);
    $width(posedge ck, temp);
    endspecify
    prim_dff U1(q,ck,ip);
endmodule
`endcelldefine

primitive prim_dff(q,cp,d);
output q;
reg q;
input cp,d;
table
/* user defined primitive "prim_dff" as a table --useful for
accelerated simulation and compiling a synthesis library */
// cp d : q : q+
// clocking data on the rising edge
r 1 : ? : 1;
r 0 : ? : 0;
// ignoring the falling edge of the clock
n ? : ? : -;
// ignoring the edges on data
* 0 : 0 : 0;
* 1 : 1 : 1;
? * : ? : -;
endtable
endprimitive