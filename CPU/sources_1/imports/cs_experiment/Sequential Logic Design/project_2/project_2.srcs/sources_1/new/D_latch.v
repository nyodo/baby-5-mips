`timescale 1ns / 1ps
module D_latch(Q,QN,D,EN,RST);
    output reg Q,QN;
    input D;
    input EN,RST;
    
    always @(EN,RST,D) begin
        if(RST) begin
            Q<=0;
            QN<=1;
        end
        else if(EN) begin
            Q<=D;
            QN<=~D;
        end
    end
endmodule
