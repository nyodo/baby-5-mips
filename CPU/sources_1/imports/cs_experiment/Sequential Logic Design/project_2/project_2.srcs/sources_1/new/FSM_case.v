`timescale 1ns / 1ps
module FSM_case(input CLK,input RST,output u);
    reg[2:0] state,nextstate;
    
    always @(posedge CLK,posedge RST) begin
        if(RST) begin state=3'b001;
            case(state)
                3'b001: nextstate=3'b010;
                3'b010: nextstate=3'b100;
                3'b100: nextstate=3'b001;
                default: nextstate=3'b001;
            endcase
        end
        else begin state=nextstate;   
            case(state)
                3'b001: nextstate=3'b010;
                3'b010: nextstate=3'b100;
                3'b100: nextstate=3'b001;
                default: nextstate=3'b001;
            endcase
        end
    end
    assign u=(state==3'b001);
endmodule
