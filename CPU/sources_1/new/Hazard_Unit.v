module Hazard_unit(
   input [4:0] rsD,rtD,rsE,rtE,WriteRegE,WriteRegM,WriteRegW,
   input BranchD,MemtoRegE,RegWriteE,MemtoRegM,RegWriteM,RegWriteW,
   output reg stallF,stallD,flushE,
   output reg [1:0] forwardAE,forwardBE,forwardAD,forwardBD
);
    always @(*) begin//priority:M,W,E
        if ((rsE!=0) && (rsE==WriteRegM) && RegWriteM) 
            forwardAE<=2'b10;
        else if ((rsE!=0) && (rsE==WriteRegW) && RegWriteW) 
            forwardAE<=2'b01;
        else forwardAE<=2'b00;
    end
    always @(*) begin
        if ((rtE!=0) && (rtE==WriteRegM) && RegWriteM) 
            forwardBE<=2'b10;
        else if ((rtE!=0) && (rtE==WriteRegW) && RegWriteW) 
            forwardBE<=2'b01;
        else forwardBE<=2'b00;
    end
    wire lwstall,branchstall;
    //handle decode data dependency for branch read regfile
    //result in WB, alu ins MEM,OK
    //result of alu ins in EX, lw in MEM, stall 1 cycle
    always @(*)begin
        if((rsD!=5'b0)&&(rsD==WriteRegM)&&RegWriteM)
            forwardAD<=2'b01;
        else if((rsD!=5'b0)&&(rsD==WriteRegW)&&RegWriteW)
            forwardAD<=2'b10;
        else forwardAD<=2'b00;
    end
    always @(*)begin
        if((rtD!=5'b0)&&(rtD==WriteRegM)&&RegWriteM)
            forwardBD<=2'b01;
        else if((rtD!=5'b0)&&(rtD==WriteRegW)&&RegWriteW)
            forwardBD<=2'b10;
        else forwardBD<=2'b00;
    end
    //lw ins doesn't finish rd data til end of MEM stage 
    //e.g. lw produce $s0 at end of MEM but next and need $s0 at start EX(same cycle) ,STALL!
    //load or branch stall
    assign lwstall=((rsD==rtE)||(rtD==rtE))&&MemtoRegE;
    assign branchstall=(BranchD && RegWriteE && (WriteRegE==rsD || WriteRegE==rtD) )||
                        (BranchD && MemtoRegM  && (WriteRegM==rsD || WriteRegM==rtD) );
    always @(*)begin

        {stallF,stallD,flushE}<={lwstall||branchstall,lwstall||branchstall,lwstall||branchstall};
    end
endmodule
