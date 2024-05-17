module sim_register;
    reg [7:0] D;
    wire [7:0] Q;
    reg oe,clk;
    integer i;
    register r(Q,D,oe,clk);
    initial begin
        D<=8'b0000_0000;oe<=0;clk<=0;
    end
    always #5 clk=~clk;
    always begin #5 oe<=0; #50 oe<=1; end
    always begin
        for(i=0;i<256;i=i+1)#8 D=i;
    end
endmodule
