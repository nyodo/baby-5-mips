module MultiCycleMIPSCPU(
    input wire clk,    
    input wire rst,    
    input wire [31:0] instruction,  
    output reg [31:0] result  
);

reg [31:0] registers [0:31];

reg RegWrite, MemtoReg, MemWrite, ALUSrc, Branch, Jump, Zero;
reg [1:0] ALUOp;
reg [5:0] opcode;
reg [4:0] rs, rt, rd;

wire [31:0] immediate;
wire [31:0] alu_result;
reg [31:0] memory [0:1023];
reg [31:0] pc;
reg [2:0] state;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        registers <= 32'b0;
        pc <= 32'b0;
        state <= 3'b000;
    end
end

assign immediate = instruction[15:0];

always @* begin
    opcode = instruction[31:26];
    rs = instruction[25:21];
    rt = instruction[20:16];
    rd = instruction[15:11];
    {RegWrite, MemtoReg, MemWrite, ALUSrc, Branch, Jump, ALUOp} = ControlUnit(opcode, state);
    result <= MemtoReg ? result : alu_result;
end

ALU alu (
    .A(registers[rs]),
    .B(ALUSrc ? immediate : registers[rt]),
    .Op(ALUOp),
    .Result(alu_result),
    .Zero(Zero)
);

DataMemory dmem (
    .address(alu_result),
    .write_data(registers[rt]),
    .mem_read(MemWrite),
    .mem_write(MemWrite),
    .read_data(result)
);

always @(posedge clk) begin
    if (state == 3'b000) begin
        pc <= Jump ? {instruction[31:6], 2'b00} : pc + 4;
    end
end

function [6:0] ControlUnit;
    input [5:0] opcode;
    input [2:0] state;
    begin
        case (state)
            3'b000: // IF
                {RegWrite, MemtoReg, MemWrite, ALUSrc, Branch, Jump, ALUOp} = 7'b0000000;
            3'b001: // ID
                {RegWrite, MemtoReg, MemWrite, ALUSrc, Branch, Jump, ALUOp} =
                    opcode == 6'b000000 ? 7'b1000000 : // R-type
                    opcode == 6'b001000 ? 7'b0100000 : // addi
                    opcode == 6'b100011 ? 7'b0100010 : // lw
                    opcode == 6'b101011 ? 7'b1000010 : // sw
                    opcode == 6'b000100 ? 7'b0010000 : // beq
                    opcode == 6'b000010 ? 7'b0000010 : // j
                    7'b0000000; // nop
           3'b010: // EX
                {RegWrite, MemtoReg, MemWrite, ALUSrc, Branch, Jump, ALUOp} =
                    opcode == 6'b000000 ? 7'b1000000 : // R-type
                    opcode == 6'b001000 ? 7'b0100000 : // addi
                    opcode == 6'b100011 ? 7'b0100010 : // lw
                    opcode == 6'b101011 ? 7'b1000010 : // sw
                    opcode == 6'b000100 ? 7'b0010000 : // beq
                    opcode == 6'b000010 ? 7'b0000010 : // j
                    7'b0000000; // nop
          3'b100: // MEM
                {RegWrite, MemtoReg, MemWrite, ALUSrc, Branch, Jump, ALUOp} =
                    opcode == 6'b000000 ? 7'b1000000 : // R-type
                    opcode == 6'b001000 ? 7'b0100000 : // addi
                    opcode == 6'b100011 ? 7'b0100010 : // lw
                    opcode == 6'b101011 ? 7'b1000010 : // sw
                    opcode == 6'b000100 ? 7'b0010000 : // beq
                    opcode == 6'b000010 ? 7'b0000010 : // j
                    7'b0000000; // nop
        
           3'b110: // WB
                {RegWrite, MemtoReg, MemWrite, ALUSrc, Branch, Jump, ALUOp} =
                    opcode == 6'b000000 ? 7'b1000000 : // R-type
                    opcode == 6'b001000 ? 7'b0100000 : // addi
                    opcode == 6'b100011 ? 7'b0100010 : // lw
                    opcode == 6'b101011 ? 7'b1000010 : // sw
                    opcode == 6'b000100 ? 7'b0010000 : // beq
                    opcode == 6'b000010 ? 7'b0000010 : // j
                    7'b0000000; // nop
            default:
                {RegWrite, MemtoReg, MemWrite, ALUSrc, Branch, Jump, ALUOp} = 7'b0000000;
        endcase
    end
endfunction

endmodule
        
                    

















