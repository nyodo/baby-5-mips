`timescale 1ns / 1ps
module D_ff(Q,QN,D,EN,RST,CLK);
    output reg Q,QN;
    input D;
    input EN,RST,CLK;
    
    //always @(posedge CLK) begin
    always @(posedge CLK, posedge RST) begin // asynchronous reset
        if(RST) begin Q<=1'b0;QN<=1'b1;end
        else if(EN) begin Q<=D;QN<=~D;end
    end
endmodule
