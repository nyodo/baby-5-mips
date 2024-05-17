// Control Hazard Handling in IF Stage (Instruction Fetch)
module InstructionFetchStage (
    input clk,rst,
    input wire [31:0] pc,
    input wire branch,
    input wire branch_taken,
    output reg [31:0] next_pc
);
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            next_pc <= 32'b0;
        end else begin
            
            next_pc <= branch ? (branch_taken ? target_address : pc + 4) : pc + 4;
        end
    end
endmodule