
module RegFile(CLK,WE3,RA1,RA2,WA3,WD3,RD1,RD2,RST);
    parameter ADDR_SIZE=5;
    input CLK,WE3;
    input [ADDR_SIZE-1:0] RA1,RA2,WA3;
    input [31:0] WD3;
    output [31:0] RD1,RD2;
    input RST;
    //regfile
    reg [31:0] rf[2**ADDR_SIZE-1:0];
    //data in
    integer i;
    initial begin for(i=0;i<32;i=i+1) rf[i]<=32'b0; end
    always @(posedge CLK,posedge RST) begin
        if(RST) for(i=0;i<2**ADDR_SIZE;i=i+1) rf[i]<=0;
        else if(WE3) rf[WA3]<=WD3;
    end
    
    //data rdout
    
    assign RD1=(RA1!=0)?rf[RA1]:32'b0;
    assign RD2=(RA2!=0)?rf[RA2]:32'b0;
endmodule
