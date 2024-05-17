module shift_register(S1,S0,D,Dl,Dr,Q,CLK,CLR);
    parameter N=4;
    input S0,S1;    //control input
    input Dl,Dr;  //input of l or r
    input CLK,CLR;  //clock and async clear
    input [N-1:0] D;
    output reg [N-1:0] Q;
    
    always @(posedge CLK,posedge CLR)
        if(CLR)
            Q<=0;
        else 
            case({S1,S0})
                2'b00: Q<=Q;
                2'b01: Q<={Dr,Q[N-1:1]};
                2'b10: Q<={Q[N-2:0],Dl};
                2'b11: Q<=D;
            endcase
endmodule
