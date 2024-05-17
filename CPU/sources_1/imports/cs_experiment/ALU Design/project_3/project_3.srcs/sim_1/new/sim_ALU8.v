module sim_ALU8;
    parameter N=32;
    reg [N-1:0] A,B;
    reg [3:0] OP;
    wire [N-1:0] F;
    wire CF,ZF,OF,SF,PF; 
    integer i,j,k;
    initial begin
        A<=32'b0;B<=32'b0;OP<=4'b0;i<=0;j<=0;k<=0;
    end
    ALU_8 alu8(F,CF,A,B,OP,OF,SF,PF,ZF);
    always begin #30 i=i+1;OP=i[3:0];end
    always begin #10 j=j+1;A=j[N-1:0];end
    always begin #15 k=k+1;B=k[N-1:0];end
    always begin #300 j<=k;k<=j;end
        
endmodule
