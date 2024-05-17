`timescale 1ns / 1ps
module RS_latch(Q,QN,R,S);
    output  Q,QN;
    input R,S;
    wire WQ,WQN;
    
    nand nd1(WQ,S,WQN),nd2(WQN,R,WQ);
    assign Q=WQ;
    assign QN=WQN;
endmodule
