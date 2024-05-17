module Control_Unit(

input [5:0]op,
input [5:0]funct,

output reg RegWriteD,
output reg RegDstD,
output reg AluSrcD,
output reg BranchD,
output reg MemWriteD,
output reg MemtoRegD,
output reg[2:0]ALUControlD
);
always@(*) begin

    case (op)

    6'b000000:begin
        case (funct)
        6'b100000:begin RegWriteD<=1;RegDstD<=1;AluSrcD<=0;BranchD<=0;MemWriteD<=0;MemtoRegD<=0;ALUControlD<=3'b010;end//add
        6'b100001:begin RegWriteD<=1;RegDstD<=1;AluSrcD<=0;BranchD<=0;MemWriteD<=0;MemtoRegD<=0;ALUControlD<=3'b110;end//sub
        6'b100100:begin RegWriteD<=1;RegDstD<=1;AluSrcD<=0;BranchD<=0;MemWriteD<=0;MemtoRegD<=0;ALUControlD<=3'b000;end//and
        6'b100101:begin RegWriteD<=1;RegDstD<=1;AluSrcD<=0;BranchD<=0;MemWriteD<=0;MemtoRegD<=0;ALUControlD<=3'b001;end//or
        6'b101010:begin RegWriteD<=1;RegDstD<=1;AluSrcD<=0;BranchD<=0;MemWriteD<=0;MemtoRegD<=0;ALUControlD<=3'b111;end//slt
        6'b111111:begin RegWriteD<=1;RegDstD<=1;AluSrcD<=0;BranchD<=0;MemWriteD<=0;MemtoRegD<=0;ALUControlD<=3'b011;end//div
        default: begin RegWriteD <= 0;RegDstD <= 0;AluSrcD <= 0;BranchD <= 0;MemWriteD<= 0;MemtoRegD <= 0;ALUControlD <= 3'b000;end //NOP
        endcase
    end    
        
    6'b100011:begin RegWriteD<=0;RegDstD<=0;AluSrcD<=1;BranchD<=0;MemWriteD<=1;MemtoRegD<=0;ALUControlD<=3'b010;end //sw
    6'b101011:begin RegWriteD<=1;RegDstD<=0;AluSrcD<=1;BranchD<=0;MemWriteD<=0;MemtoRegD<=1;ALUControlD<=3'b010;end //lw
    6'b001000:begin RegWriteD<=1;RegDstD<=0;AluSrcD<=1;BranchD<=0;MemWriteD<=0;MemtoRegD<=0;ALUControlD<=3'b010;end //addi
    6'b001000:begin RegWriteD<=1;RegDstD<=0;AluSrcD<=1;BranchD<=0;MemWriteD<=0;MemtoRegD<=0;ALUControlD<=3'b110;end //subi
    6'b000100:begin RegWriteD<=0;RegDstD<=0;AluSrcD<=0;BranchD<=1;MemWriteD<=0;MemtoRegD<=0;ALUControlD<=3'b110;end //beq
    6'b000101:begin RegWriteD<=0;RegDstD<=0;AluSrcD<=0;BranchD<=1;MemWriteD<=0;MemtoRegD<=0;ALUControlD<=3'b110;end //bne
    default: begin RegWriteD <=0;RegDstD <= 0;AluSrcD <= 0;BranchD <= 0;MemWriteD <= 0;MemtoRegD<= 0;ALUControlD <= 3'b000;end //NOP
    endcase

end

endmodule
