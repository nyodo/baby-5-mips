//ADD add1(FW,CF,A,B,EN[4]);
module ADD(sum,CF,A,B,en);
    input [32:1] A;
    input [32:1] B;
    input en;
    output reg[32:1] sum;
    output reg CF;
    wire px1,gx1,px2,gx2;
    wire c16,C32;
    wire [32:1] S;
    
    CLA16 D_octa1(
            .A(A[16:1]),
            .B(B[16:1]),
            .c0(0),
            .S(S[16:1]),
            .px(px1),
            .gx(gx1)
          );
    assign c16=gx1^(px1&&0);
    CLA16 D_octa2(
            .A(A[32:17]),
            .B(B[32:17]),
            .c0(c16),
            .S(S[32:17]),
            .px(px2),
            .gx(gx2)
          );
    assign C32=gx2^(px2&&c16);
    always @(A,B,en) begin
        if(en==1) begin sum<=S;CF<=C32; end
        else begin sum<=32'bz; CF<=1'bz;end
    end
endmodule
