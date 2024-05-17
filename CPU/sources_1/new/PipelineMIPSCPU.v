module PipelineMIPSCPU;
reg clk,rst;

wire [31:0] instruction;

wire CF,SF,PF,OF,Zero;

wire [5:0] opcode;
wire [4:0] rs, rt, rd;
wire [5:0] Funct;
wire [31:0] Data;
wire [31:0] PCF,PC_in,pcp4F,PCbranchD;


wire [31:0] ResultW;
wire stallF,stallD,flushE;
wire [1:0] forwardAE,forwardBE,forwardAD,forwardBD;


wire [31:0] SrcA,SrcB;
wire [31:0] pcp4D,IR;

wire RegWriteD, MemtoRegD, MemWriteD, ALUSrcD, RegDstD, BranchD,JumpD;
wire EqualD,PCSrcD;
wire [2:0] ALUControlD;
wire [31:0] Imm_extend;

wire RegWriteE, MemtoRegE, MemWriteE, ALUSrcE, RegDstE;
wire [2:0] ALUControlE;
wire [31:0] RD1E,RD2E,ImmE;
wire [4:0] rsE,rtE,rdE;

wire [31:0] SrcAE,SrcBE,alu_result,WriteDataE;

wire [4:0] WriteRegM,WriteRegE;
wire [31:0] ALUOutM,WriteDataM;
wire RegWriteM,MemtoRegM,MemWriteM;

wire [31:0] ReadDataW,ALUOutW;
wire [4:0] WriteRegW;
wire MemtoRegW,RegWriteW;
initial begin 
    clk=0; rst=0; 
end
always #10 clk=~clk;

assign PC_in=PCSrcD?PCbranchD:pcp4F;
PCreg PC_1(
    .clk(clk),
    .rst(rst),
    .pc(PCF),
    .pc_in(PC_in),
    .stall(stallF)
);
assign pcp4F=PCF+4;
assign PCbranchD=JumpD?IR[25:0]:(Imm_extend<<2)+pcp4D;
IMem L1I_cache(
    .A(PCF>>2),
    .RD(instruction)
);

IF_ID IF_IDreg(
    .clk(clk),
    .rst(rst),
    .In_pc(pcp4F),
    .In_Ins(instruction),
    .stall(stallD),
    .clr(PCSrcD),
    .out_pc(pcp4D),
    .out_Ins(IR)
);

assign    opcode = IR[31:26];
assign    rs = IR[25:21];
assign    rt = IR[20:16];
assign    rd = IR[15:11];
assign    Funct = IR[5:0];




RegFile Register_1(
    .CLK(clk),
    .WE3(RegWriteW),
    .RA1(rs),
    .RA2(rt),
    .WA3(WriteRegW),
    .WD3(ResultW),
    .RD1(SrcA),
    .RD2(SrcB),
    .RST(rst)
);

/*Control_Unit ctrl (
    .op(opcode),
    .funct(Funct),
    .RegWriteD(RegWriteD),
    .MemtoRegD(MemtoRegD),
    .MemWriteD(MemWriteD),
    .AluSrcD(ALUSrcD),
    .RegDstD(RegDstD),
    .BranchD(BranchD),
    .ALUControlD(ALUControlD)
);*/
Controller ctrl (
    .Op(opcode),
    .Funct(Funct),
    .RegWrite(RegWriteD),
    .MemToReg(MemtoRegD),
    .MemWrite(MemWriteD),
    .ALUSrc(ALUSrcD),
    .RegDst(RegDstD),
    .Branch(BranchD),
    .Jump(JumpD),
    .ALUControl(ALUControlD)
);
assign EqualD=( ( forwardAD==(2'b10)?ResultW:(forwardAD==(2'b01)?ALUOutM:SrcA))
            == 
            ( forwardBD==(2'b10)?ResultW:(forwardBD==(2'b01)?ALUOutM:SrcB)) );
assign PCSrcD=((BranchD|JumpD)&EqualD);
assign Imm_extend={ {16{IR[15]}},IR[15:0] };
ID_EX ID_EXreg(
    .clk(clk),
    .clr(flushE),
    
    .RD1((RegWriteW&&rs==WriteRegW)?ResultW:SrcA),
    .RD2((RegWriteW&&rt==WriteRegW)?ResultW:SrcB),
    .ImmD(Imm_extend),
    .rsD(rs),
    .rtD(rt),
    .rdD(rd),
    .RegWriteD(RegWriteD), .MemtoRegD(MemtoRegD), .MemWriteD(MemWriteD), 
    .ALUSrcD(ALUSrcD), .RegDstD(RegDstD),
    .ALUControlD(ALUControlD),
    
    .rsE(rsE),.rtE(rtE),.rdE(rdE),
    .RD1E(RD1E),.RD2E(RD2E),.ImmE(ImmE),
    .RegWriteE(RegWriteE), .MemtoRegE(MemtoRegE), .MemWriteE(MemWriteE), 
    .ALUSrcE(ALUSrcE), .RegDstE(RegDstE),
    .ALUControlE(ALUControlE)
);


//The ALUsrc here is used to control the sign-extend immediate expansion component,
//which means that for all non I-type instructions, immediate expansion is not required. 
//At this point, the value of this component (ALUsrc) is 0, and for I-type instructions, its value is 1


ALU_Forward alu_forward_1(
    .forwardAE(forwardAE),.forwardBE(forwardBE),
    .ALUSrcE(ALUSrcE),
    .ALUOutM(ALUOutM),.ResultW(ResultW),
    .RD1E(RD1E),.RD2E(RD2E),.SignlmmE(ImmE),

    .SrcAE(SrcAE),.SrcBE(SrcBE),.WriteDataE(WriteDataE)
);


ALU_8 alu (
    .A(SrcAE),
    .B(SrcBE),
    .OP(ALUControlE),
    .F(alu_result),
    .ZF(Zero),
    .CF(CF),
    .SF(SF),
    .PF(PF),
    .OF(OF)
);

assign WriteRegE=RegDstE?rdE:rtE;
EX_MEM EX_MEMreg(
    .alu_output(alu_result),.WriteDataE(WriteDataE),
    .WriteRegE(WriteRegE),
    .clk(clk),.rst(rst),
    .RegWriteE(RegWriteE),.MemtoRegE(MemtoRegE),.MemWriteE(MemWriteE),
    
    .ALUOutM(ALUOutM),.WriteDataM(WriteDataM),
    .WriteRegM(WriteRegM),
    .RegWriteM(RegWriteM),.MemtoRegM(MemtoRegM),.MemWriteM(MemWriteM)
);
Dmemory Dmem_1 (
    .Addr(ALUOutM),
    .Data_in(WriteDataM),
    .R_W(MemWriteM),
    .Data_out(Data),
    .clk(clk)
);


MEM_WB MEM_WBreg(
    .ALUOutM(ALUOutM),.ReadDataM(MemWriteM?32'b0:Data),
    .clk(clk),.rst(rst),
    .WriteRegM(WriteRegM),
    .RegWriteM(RegWriteM),.MemtoRegM(MemtoRegM),
   
    .ReadDataW(ReadDataW),.ALUOutW(ALUOutW),
    .WriteRegW(WriteRegW),
    .RegWriteW(RegWriteW),.MemtoRegW(MemtoRegW)
);


assign ResultW=MemtoRegW?ReadDataW:ALUOutW;

Hazard_unit HZ(
    .rsD(rs),.rtD(rt),
    .rsE(rsE),.rtE(rtE),
    .BranchD(BranchD|JumpD),
    .MemtoRegE(MemtoRegE),.RegWriteE(RegWriteE),
    .MemtoRegM(MemtoRegM),.RegWriteM(RegWriteM),
    .RegWriteW(RegWriteW),
    .WriteRegE(WriteRegE),.WriteRegM(WriteRegM),.WriteRegW(WriteRegW),
    
    .stallF(stallF),.stallD(stallD),
    .forwardAD(forwardAD),.forwardBD(forwardBD),.flushE(flushE),
    .forwardAE(forwardAE),.forwardBE(forwardBE)
);
/*HazardUnit hz(.StallF(stallF),.StallD(stallD),

.BranchD(BranchD|JumpD),.ForwardAD(forwardAD),
.ForwardBD(forwardBD),.ForwardAE(forwardAE),.ForwardBE(forwardBE),

.RsD(rs),.RtD(rt),.RsE(rsE),.RtE(rtE),.FlushE(flushE),
.RegWriteE(RegWriteE),.MemtoRegE(MemtoRegE),
.WriteRegE(WriteRegE),.WriteRegM(WriteRegM),.WriteRegW(WriteRegW),
.RegWriteM(RegWriteM),.RegWriteW(RegWriteW),.MemtoRegM(MemtoRegM));*/

endmodule







