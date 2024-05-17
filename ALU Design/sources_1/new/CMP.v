module CMP(FW,A,B,EN);
    parameter N=32;
    input [N:1] A,B;
    input EN;
    output reg [N:1] FW;
    wire [N:1] C;
    wire px1,gx1,px2,gx2;
    wire c16,C32;
    wire [32:1] S;
    assign C=~B+1;

    CLA16 D_octa1(
            .A(A[16:1]),
            .B(C[16:1]),
            .c0(0),
            .S(S[16:1]),
            .px(px1),
            .gx(gx1)
          );
    assign c16=gx1^(px1&&0);
    CLA16 D_octa2(
            .A(A[32:17]),
            .B(C[32:17]),
            .c0(c16),
            .S(S[32:17]),
            .px(px2),
            .gx(gx2)
          );
    assign C32=gx2^(px2&&c16);
   always @(A,B,EN) begin
        if(EN==1) begin FW<={31'b0,~C32};end
        else begin FW<=32'bz;end
    end
    
     
endmodule
