module sim_counter;
    reg cep,cet,pe,clk,clr;
    reg [7:0] d;
    wire up;
    wire [7:0] q;
    counter c(cep,cet,pe,clk,clr,d,up,q);
    initial begin
        d=8'b0000_0000;cep=0;cet=0;pe=0;clk=0;clr=1;
        #5 clr=0;
        #5 clr<=1;
        pe<=0;
        #5 d=127;
        #5 d=328;
        #5 d=144;
        pe<=1;
    end
    always #5 clk=~clk;
    always begin
        #8 cep<=0;cet<=0;
        #8 cep<=1;
        #8 cep<=1;cet<=0;
        #8 cep<=1;cet<=1;
    end
    always begin #5000 clr<=0;#5 clr<=1;end
endmodule
