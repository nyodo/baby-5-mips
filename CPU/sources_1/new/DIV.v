module DIV(FW,A,B,EN);
    parameter N=32;
    input [N-1:0] A,B;
    input EN;
    output reg [N-1:0] FW;
    
    always @(A,B,EN) begin
        if(EN==1) FW<=A/B;
        else FW<=32'bz;
    end
endmodule
