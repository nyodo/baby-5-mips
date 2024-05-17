module decoder_24_sim ();
reg [1:0] data_in;
    wire [3:0] data_out;
    decoder_24 U_dec24_0(.data_i (data_in),.data_o (data_out));
    initial begin

        #5 begin data_in = 2'b00; end
        #5 begin data_in = 2'b01; end
        #5 begin data_in = 2'b10; end
        #5 begin data_in = 2'b11; end

    end
endmodule
