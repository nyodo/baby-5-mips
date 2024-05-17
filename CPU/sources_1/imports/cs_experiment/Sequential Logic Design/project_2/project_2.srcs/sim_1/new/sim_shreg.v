module sim_shreg;
    reg s1,s2,dl,dr,clk,clr;
    reg [3:0] d;
    wire [3:0] q;
    integer i;
    shift_register sr(s2,s1,d,dl,dr,q,clk,clr);
    initial begin
        d<=4'b0110;s1<=0;s2<=0;dl<=0;dr<=0;clk<=0;clr<=0;
        #8 clr=1;
        #8 s1=1;
        #8 s2=1;
        #8 s1=0;clr=0;
    end
    always begin
        #8 s1<=0;s2<=0;
        #8 s2<=1;
        #8 s1<=1;s2<=0;
        #8 s1<=1;s2<=1;
    end
    always #5 clk=~clk;
    always #15 dl=~dl;
    always #10 dr=~dr;
    always begin
        for(i=0;i<256;i=i+1)#20 d=i;
    end
endmodule
