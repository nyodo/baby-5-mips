module sim_fsmcase;
    reg clk,reset;
    wire y;
    FSM_case fa(clk,reset,y);
    initial begin
        clk=0;reset=0;
    end
    always #5 clk<=~clk;
    always begin #70 reset=1;#5 reset<=0;end
endmodule
