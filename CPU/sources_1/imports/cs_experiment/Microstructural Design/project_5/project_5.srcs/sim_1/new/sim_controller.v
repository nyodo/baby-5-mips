module sim_controller;
    reg [5:0] Funct,Op;
    reg Zero;
    wire MemToReg,MemWrite;
    wire PCSrc,ALUSrc;
    wire RegDst,RegWrite;
    wire Jump;
    wire [2:0] ALUControl;
    initial begin
        Funct=6'b0;Op=6'b0;Zero=1;
        #10 Op=6'b000000;
            #10 Funct=6'b100000;
            #10 Funct=6'b100010;
            #10 Funct=6'b100100;
            #10 Funct=6'b100101;
            #10 Funct=6'b101010;
        #10 Op=6'b100011;
            #10 Funct=6'b100000;
            #10 Funct=6'b100010;
            #10 Funct=6'b100100;
            #10 Funct=6'b100101;
            #10 Funct=6'b101010;
        #10 Op=6'b101011;
            #10 Funct=6'b100000;
            #10 Funct=6'b100010;
            #10 Funct=6'b100100;
            #10 Funct=6'b100101;
            #10 Funct=6'b101010;
        #10 Op=6'b000100;//BEQ
            #10 Zero=0;
            #10 Zero=1;
            #10 Funct=6'b100000;
            #10 Funct=6'b100010;
            #10 Funct=6'b100100;
            #10 Funct=6'b100101;
            #10 Funct=6'b101010;
        #10 Op=6'b001000;
            #10 Funct=6'b100000;
            #10 Funct=6'b100010;
            #10 Funct=6'b100100;
            #10 Funct=6'b100101;
            #10 Funct=6'b101010;
        #10 Op=6'b000010;
            #10 Funct=6'b100000;
            #10 Funct=6'b100010;
            #10 Funct=6'b100100;
            #10 Funct=6'b100101;
            #10 Funct=6'b101010;
        #10 Op=6'b111011;Funct=6'b101100;Zero=1'b0;
        #10 Zero=1;
    end
    
    Controller Controller_1(Op,Funct,Zero,MemToReg,MemWrite,PCSrc,ALUSrc,RegDst,RegWrite,Jump,ALUControl);
    
endmodule
