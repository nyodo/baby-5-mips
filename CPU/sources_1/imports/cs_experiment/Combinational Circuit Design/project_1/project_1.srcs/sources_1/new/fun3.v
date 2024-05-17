module decoder_24(
    input [1:0] data_i,            
    output reg [3:0] data_o 
);
    always @(*) begin
        case (data_i)
            2'b00: data_o = 4'b0001;
            2'b01: data_o = 4'b0010;
            2'b10: data_o = 4'b0100;
            2'b11: data_o = 4'b1000;
        endcase
    end
endmodule
