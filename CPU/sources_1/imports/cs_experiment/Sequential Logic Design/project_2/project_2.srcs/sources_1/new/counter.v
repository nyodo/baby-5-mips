module counter(CEP,CET,PE,CLK,CLR,D,UP,Q);
    parameter N=8;
    parameter M=70;
    input CEP,CET,PE,CLK,CLR;
    input [N-1:0] D;
    output reg UP;
    output reg [N-1:0] Q;
    
    wire CE;
    assign CE=CEP&CET;
    always @(posedge CLK,negedge CLR)
        if(~CLR) begin Q<=0;UP=0; end
        else if(~PE) Q<=D;
        else if(CE) begin
            if(Q==M-1) begin
                UP<=1;
                Q<=0;
            end
            else Q<=Q+1;
        end
        else Q<=Q;
endmodule
