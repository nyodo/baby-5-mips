module ALU_8(F,CF,A,B,OP,OF,SF,PF,ZF);
    parameter SIZE=32;
    output reg [SIZE-1:0] F;
    output wire CF;
    input [SIZE-1:0] A,B;
    input [3:0] OP;
    output wire OF,SF,PF,ZF;
    parameter ALU_AND=4'b0000;//0
    parameter ALU_OR=4'b0001;//1
    parameter ALU_XOR=4'b0011;//3
    parameter ALU_NOR=4'b0100;//4
    parameter ALU_ADD=4'b0010;//2
    parameter ALU_SUB=4'b0110;//6
    parameter ALU_SLT=4'b0111;//7
    parameter ALU_SLL=4'b0101;//5
    
    wire [7:0] EN;
    wire [SIZE-1:0] FW;
    
    always @(*) begin
        case (OP)
            //ALU_AND: begin F<=FA;end
            //ALU_OR: begin F<=A|B;end
            //ALU_XOR: begin F<=A^B;end
            //ALU_NOR: begin F<=~(A|B);end
            default: F<=FW;
        endcase
    end
    
    decoder38 decoder38_1(OP[2:0],EN);
    NOR nor1(FW,A,B,EN[4]);
    XOR xor1(FW,A,B,EN[3]);
    AND and1(FW,A,B,EN[0]);
    OR  or1(FW,A,B,EN[1]);
    ADD add1(FW,CF,A,B,EN[2]);
    SUB sub1(FW,CF,A,B,EN[6]);
    CMP cmp1(FW,A,B,EN[7]);//slt
    SLL sll1(FW,A,B,EN[5]);
    
    assign ZF=(F==32'b0);//F==0
    assign OF=A[SIZE-1]^B[SIZE-1]^F[SIZE-1]^CF;//overflow
    assign SF=F[SIZE-1];//sign
    assign PF=~^F;//odd or even of F's 1
endmodule