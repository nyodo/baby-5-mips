module fsmmcf;
    reg clk,rst,a;
    wire u;
    FSM_mcf f(clk,rst,a,u);
    initial begin
        clk=0;rst=0;a=0;
    end
    always #5 clk<=~clk;
    always begin #70 rst=1;#5 rst<=0;end
    always begin
        #5 a=1;
        #5 a=0;
        #15 a=1;
        #15 a=0;
        #10 a=1;
        #5 a=0;
    end//10111000110...
endmodule
