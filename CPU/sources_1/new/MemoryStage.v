module MemoryStage (
    input clk,rst,
    input wire [31:0] alu_result,
    input wire [4:0] rs2,
    input wire [1:0] forward_mem,
    output reg [31:0] mem_data
);
 // 数据冒险解决逻辑
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            mem_data <= 32'b0;
        end else begin
          
            mem_data <= (forward_mem == 2'b10) ? alu_result :
                            (forward_mem == 2'b01) ? alu_result :
                            (forward_mem == 2'b00) ? rs2 : 0;
        end
    end
endmodule