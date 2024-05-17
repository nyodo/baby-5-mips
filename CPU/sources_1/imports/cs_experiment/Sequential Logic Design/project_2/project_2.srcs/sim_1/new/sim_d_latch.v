module sim_d_latch;
    reg d,en,rst;
    wire q,qn;
    D_latch d_latch(q,qn,d,en,rst);
    initial begin
        d<=0;en<=0;rst<=0;
        #10 d<=1;
        en<=1;
        fork
            repeat(20) begin #50 rst<=1; #5 rst<=0; end
            repeat(20) #5 d<=~d;
        join
    end
endmodule
