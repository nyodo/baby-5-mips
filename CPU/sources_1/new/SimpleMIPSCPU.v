module SimpleMIPSCPU;
integer i=0;
wire [31:0] instruction;
wire RegWrite, MemtoReg, MemWrite, ALUSrc, Branch, Jump,RegDst;
wire PCsrc;
wire CF,SF,PF,OF,Zero;
wire [2:0] ALUControl;
wire [31:0] SrcA,SrcB;
reg [5:0] opcode;
reg [4:0] rs, rt, rd,WriteToReg;
reg [5:0] Funct;
wire [31:0] immediate;
wire [31:0] alu_result;
wire [31:0] Data,regWDst;
wire [31:0] PC,PC_in,pcp4;
reg [31:0] result;
reg clk,rst;
initial begin 
    clk=0; rst=0; 
end
//The ALUsrc here is used to control the sign-extend immediate expansion component,
//which means that for all non I-type instructions, immediate expansion is not required. 
//At this point, the value of this component (ALUsrc) is 0, and for I-type instructions, its value is 1
always #10 clk=~clk;
ALU_8 alu (
    .A(SrcA),
    .B(ALUSrc ? immediate:SrcB),
    .OP(ALUControl),
    .F(alu_result),
    .ZF(Zero),
    .CF(CF),
    .SF(SF),
    .PF(PF),
    .OF(OF)
);

Controller ctrl (
    .Op(opcode),
    .Funct(Funct),
    .RegWrite(RegWrite),
    .MemToReg(MemtoReg),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegDst(RegDst),
    .Branch(Branch),
    .Jump(Jump),
    .ALUControl(ALUControl)
);

assign Data=(MemWrite)?SrcB:32'bz;
RAM_4Kx32_inout Dmem (
    .Addr(alu_result),
    .Data(Data),
    .R_W(~MemWrite),
    .RST(rst),
    .CLK(clk)
);

always @* WriteToReg=RegDst?rd:rt;
assign regWDst=MemtoReg?Data:alu_result;
RegFile Register_1(
    .CLK(clk),
    .WE3(RegWrite),
    .RA1(rs),
    .RA2(rt),
    .WA3(WriteToReg),
    .WD3(regWDst),
    .RD1(SrcA),
    .RD2(SrcB),
    .RST(rst)
);


assign immediate = { { 16{instruction[15]} } ,instruction[15:0]};


always @(*) begin
    opcode <= instruction[31:26];
    rs <= instruction[25:21];
    rt <= instruction[20:16];
    rd <= instruction[15:11];
    Funct <= instruction[5:0];
end

// rst
always @(posedge clk or posedge rst) begin
    if (rst) begin
        result <= 32'b0;
    end else begin
        result <= MemtoReg ? result : alu_result;
    end
end

IMem L1I_cache(
    .A(PC),
    .RD(instruction)
);

pcreg PC_1(
    .clk(clk),
    .rst(rst),
    .PC_in(PC_in),
    .PC_out(PC)
);
assign PCsrc=Zero&Branch;
assign pcp4=PC+4;
assign PC_in=Jump?{pcp4[31:28],{instruction[25:0],2'b00}}:(PCsrc?pcp4+(immediate<<2):pcp4 );


endmodule







