module decoder_38(
    input [2:0] data_i,            
    output reg [7:0] data_o 
);
    always @(*) begin
        case (data_i)
            3'b000: data_o = 8'b0000_0001;
            3'b001: data_o = 8'b0000_0010;
            3'b010: data_o = 8'b0000_0100;
            3'b011: data_o = 8'b0000_1000;
            3'b100: data_o = 8'b0001_0000;
            3'b101: data_o = 8'b0010_0000;
            3'b110: data_o = 8'b0100_0000;
            3'b111: data_o = 8'b1000_0000;
        endcase
    end
endmodule
