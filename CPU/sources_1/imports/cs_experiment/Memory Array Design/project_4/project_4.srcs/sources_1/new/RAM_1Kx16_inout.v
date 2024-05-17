module RAM_1Kx16_inout(Data,Addr,RST,R_W,CS,CLK);
    parameter Addr_Width=10;
    parameter Data_Width=16;
    parameter SIZE=2**Addr_Width;
    inout [Data_Width-1:0] Data;
    input [Addr_Width-1:0] Addr;
    input RST;
    input R_W;
    input CS;
    input CLK;
    
    integer i;
    reg [Data_Width-1:0] Data_i;
    reg [Data_Width-1:0] RAM [SIZE-1:0];
    
    assign Data=(R_W)?Data_i:16'bz;
    initial begin 
        for(i=0;i<SIZE;i=i+1) RAM[i]=16'b0;
    end
    always @(posedge CLK) begin
//always @(*) begin
        casex({CS,RST,R_W})
            3'bx1x: for(i=0;i<=SIZE-1;i=i+1) RAM[i]=0;
            3'b101: Data_i<=RAM[Addr]; //r
            3'b100: RAM[Addr]<=Data; //w
            default: Data_i=16'bz;
        endcase
    end
endmodule
