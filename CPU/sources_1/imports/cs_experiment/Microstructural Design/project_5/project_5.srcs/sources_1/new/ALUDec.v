module ALUDec(
    input [5:0] Funct,
    input [1:0] ALUOp,
    output reg [2:0] ALUControl);
    
    always @(*)
        case(ALUOp)
            2'b00:ALUControl <= 3'b010;// add for lw/sw/addi
            2'b01:ALUControl <= 3'b110;//sub for beq
            default: case(Funct)
                6'b100000: ALUControl <=3'b010; //add 2
                6'b100010: ALUControl <=3'b110; //sub 6
                6'b100100: ALUControl <=3'b000; //and 0
                6'b100101: ALUControl <=3'b001; //or 1
                6'b101010: ALUControl <=3'b111; //slt,cmp 7
                6'b100110: ALUControl <=3'b011; //xor 3
                6'b100111: ALUControl <=3'b100; //nor 4 
                6'b000000: ALUControl <=3'b101; //sll 5 
                default:   ALUControl <=3'bxxx; //no idea 
            endcase
        endcase
endmodule
