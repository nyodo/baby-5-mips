module add4bit(x,y,c0,c4,S,Gm,Pm);
    input [4:1] x;
    input [4:1] y;
    input c0;
    output c4,Gm,Pm;
    output [4:1] S;
    wire p1,p2,p3,p4,g1,g2,g3,g4;
    wire c1,c2,c3;
    assign p1=x[1]^y[1],
           p2=x[2]^y[2],
           p3=x[3]^y[3],
           p4=x[4]^y[4];
    assign g1=x[1]&y[1],
           g2=x[2]&y[2],
           g3=x[3]&y[3],
           g4=x[4]&y[4];
    assign Pm=p1&p2&p3&p4,
           Gm=g4^(p4&g3)^(p4&p3&g2)^(p4&p3&p2&g1);
    CLA cla4(c0,c1,c2,c3,c4,p1,p2,p3,p4,g1,g2,g3,g4);
    fulladder add1(.X(x[1]),.Y(y[1]),.Cin(c0),.F(S[1]),.Cout());
    fulladder add2(.X(x[2]),.Y(y[2]),.Cin(c1),.F(S[2]),.Cout());
    fulladder add3(.X(x[3]),.Y(y[3]),.Cin(c2),.F(S[3]),.Cout());
    fulladder add4(.X(x[4]),.Y(y[4]),.Cin(c3),.F(S[4]),.Cout());
    
endmodule
