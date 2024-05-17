`define DATA_WIDTH 32
module sim_regfile;
    parameter ADDR_SIZE=5;
    reg CLK,WE3;
    reg [ADDR_SIZE-1:0] RA1,RA2,WA3;
    reg [`DATA_WIDTH-1:0] WD3;
    wire [`DATA_WIDTH-1:0] RD1,RD2;
    reg RST;
    integer i=0;
    initial begin
        CLK=0;WE3=0;RA1=0;RA2=0;WA3=0;WD3=0;RST=0;
        WE3=1;
        repeat(2**5)#20 begin WA3=i;WD3=2*i;i=i+1;end
        WE3=0;i=0;
        repeat(2**4)#20 begin RA1=i;RA2=2*i;i=i+1;end
        RA1=0;RA2=0;
        RST=1;
        #5 RST=0;
        repeat(2**4)#20 begin RA1=i;RA2=2*i;i=i+1;end
    end
    always #10 CLK=~CLK;
    
    RegFile regfile(CLK,WE3,RA1,RA2,WA3,WD3,RD1,RD2,RST);
endmodule
