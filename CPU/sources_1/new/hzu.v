module HazardUnit(StallF,StallD,
BranchD,ForwardAD,ForwardBD,ForwardAE,ForwardBE,
RsD,RtD,RsE,RtE,FlushE,RegWriteE,MemtoRegE,
WriteRegE,WriteRegM,RegWriteM,RegWriteW,WriteRegW,
MemtoRegM);
input RegWriteE,RegWriteM,RegWriteW,MemtoRegE,MemtoRegM,BranchD;

input[4:0] RsD,RtD,RsE,RtE,WriteRegE,WriteRegM,WriteRegW;

output reg [1:0] ForwardAE,ForwardBE;

output reg ForwardAD,ForwardBD,StallF,StallD,FlushE;

reg lwstall,branchstall;

always @(*)begin
    if( (RsE != 0)&& (RsE ==WriteRegM) && RegWriteM) 
        ForwardAE= 2'b10;
    else if ((RsE != 0)&& (RsE ==WriteRegW) && RegWriteW) 
        ForwardAE = 2'b01;
    else ForwardAE= 2'b00;

    if((RtE != 0)&&(RtE == WriteRegM)&& RegWriteM)
        ForwardBE <= 2'b10; 
    else if ( (RtE != 0)&&(RtE ==WriteRegW) && (RegWriteW))
        ForwardBE <= 2'b01;
    else ForwardBE <= 2'b00;

    ForwardAD <= (RsD != 0)&&(RsD==WriteRegM)&& RegWriteM;
    ForwardBD <= (RtD != 0)&&(RtD==WriteRegM)&& RegWriteM;

    branchstall <= (BranchD &&RegWriteE && (WriteRegE == RsD || WriteRegE == RtD) )
                    || (BranchD && MemtoRegM&& (WriteRegM == RsD || WriteRegM == RtD));

    lwstall <= ((RsD==RtE) || (RtD==RtE))&& MemtoRegE;
    StallF <= lwstall || branchstall;
    StallD <= StallF;
    FlushE <= StallD;

end

endmodule
