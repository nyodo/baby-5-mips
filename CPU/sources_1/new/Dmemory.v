module Dmemory(Data_out,clk,R_W,Addr,Data_in);
    output [31:0] Data_out;
    input clk;
    input R_W;
    input [31:0] Addr;
    input [31:0] Data_in;
    reg [31:0] data_memory[1023:0];
    integer i;
    initial begin
        for(i=0;i<1024;i=i+1) data_memory[i]=32'b0;
    end
    assign Data_out = R_W?32'b0:data_memory[Addr];
    
    always@(posedge clk) begin
        if(R_W)
            data_memory[Addr] <= Data_in;
    end
endmodule
