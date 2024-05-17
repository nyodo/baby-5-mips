module ALU_Forward(
    input[1:0]forwardAE,forwardBE,
    input ALUSrcE,
    input[31:0] ALUOutM,ResultW,RD1E,RD2E,SignlmmE,

    output reg[31:0] SrcAE,SrcBE,WriteDataE
);
    always@(*) begin
        case(forwardAE)
            2'b00:SrcAE<=RD1E;
            2'b01:SrcAE<=ResultW;
            2'b10:SrcAE<=ALUOutM;
        endcase

        case(forwardBE)
            2'b00:WriteDataE<=RD2E;
            2'b01:WriteDataE<=ResultW;
            2'b10:WriteDataE<=ALUOutM;
        endcase

        if(ALUSrcE)
            SrcBE<=SignlmmE;
        else
            SrcBE<=WriteDataE;
    end

endmodule
