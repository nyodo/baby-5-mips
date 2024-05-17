module sim_d_ff;
    reg d,en,rst,clk;
    wire q,qn;
    D_ff d_ff(q,qn,d,en,rst,clk);
    initial begin
        d<=0;en<=0;rst<=0;clk<=0;
        #10 d<=1;
        en<=1;
    end
    always #5 clk=~clk;
    always begin
        fork
            repeat(50) begin #65 rst<=1; #10 rst<=0; end
            repeat(50) #10 d<=~d;
        join
    end
    
endmodule
