module register(Q,D,OE,CLK);
    parameter N=8;
    output reg [N-1:0] Q;
    input [N-1:0] D;
    input OE,CLK;
    
    always @(posedge CLK, posedge OE)
        if(OE) Q<=8'bzzzz_zzzz;
        else Q<=D;
endmodule
