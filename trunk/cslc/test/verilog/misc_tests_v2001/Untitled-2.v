module trans;
    wire x,y;
    sender snd(x,y);
    receiver rcv(x,y);
endmodule
module sender(tx,cmd);
    output tx;
    input cmd;
endmodule
module receiver(rx,cmd);
    input rx;
    output cmd;
endmodule