`define DATA_WIDTH 32
module sim_imem;
    reg [5:0] A;
    wire [`DATA_WIDTH-1:0] RD;
    integer i=0;
    initial begin
        repeat(2**5) #50 begin A=i; i=i+1;end
    end
    IMem imem(A,RD);
endmodule
