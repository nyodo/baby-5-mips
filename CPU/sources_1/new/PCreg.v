module pcreg(
    input clk,
    input rst,
    input [31:0] PC_in,
    output [31:0] PC_out
);
    
    reg [31:0] data=32'b0;

    always @(posedge clk or posedge rst) begin
        if(rst) data<=32'b0;        //reset key
        else data<=PC_in;        //enable ,input 
    end
    
    assign PC_out = data;
    
endmodule