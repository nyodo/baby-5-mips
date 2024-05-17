module sim_rs();
    reg r,s; 
    wire q,qn;
    RS_latch rs(q,qn,r,s);
    initial
    begin 
        r<=0;s<=0;
        #10 r=1;
        #10 r<=0;s<=1;
        #10 r<=1;s<=1;
    end
endmodule
