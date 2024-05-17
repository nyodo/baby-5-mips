module Dmem(
    input clk,we,
    input [31:0] addr,wd,
    output [31:0] rd
);
    reg [31:0] RAM[1023:0];
    integer i;
    initial begin
        for(i=0;i<1024;i=i+1) RAM[i]=32'b0;
    end
    assign rd=RAM[addr];
    always @(posedge clk)
        if(we)
            RAM[addr]<=wd;
    
endmodule
