`timescale 1ns / 1ps
module FSM_mcf(input CLK,input RST,input a,output u);
    reg[1:0] state,nextstate;
    
    always @(posedge CLK,posedge RST)begin
        if(RST) begin state=2'b00;
            case(state)
            2'b00: if(a) nextstate=2'b00;
                   else nextstate=2'b01;
            2'b01: if(a) nextstate=2'b10;
                   else nextstate=2'b01;
            2'b10: if(a) nextstate=2'b00;
                   else nextstate=2'b01;
            default: nextstate=2'b00;
            endcase
            end
        else begin 
            case(state)
            2'b00: if(a) nextstate=2'b00;
                   else nextstate=2'b01;
            2'b01: if(a) nextstate=2'b10;
                   else nextstate=2'b01;
            2'b10: if(a) nextstate=2'b00;
                   else nextstate=2'b01;
            default: nextstate=2'b00;
            endcase
            state=nextstate;
            end
    end
    assign u=(state==2'b10);
endmodule
