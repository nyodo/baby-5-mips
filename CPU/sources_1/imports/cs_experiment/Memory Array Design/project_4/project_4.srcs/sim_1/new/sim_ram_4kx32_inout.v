module sim_ram_4kx32_inout;
    parameter Addr_Width=12;
    parameter Data_Width=32;
    wire [Data_Width-1:0] Data;
    reg [Data_Width-1:0] data;
    reg [Addr_Width-1:0] Addr;
    reg RST,R_W,CLK,CS;
    integer i=0;
    initial begin
        RST=0;R_W=0;CLK=0;CS=1;
        repeat(2**12) #20 begin data=i; Addr=i; i=i+1; end
        i=0; R_W=1;
        repeat(2**12) #20 begin Addr=i; i=i+1; end
        RST=1;
        #5 RST=0;
        repeat(2**12) #20 begin Addr=i; i=i+1; end
    end
    assign Data=(R_W)?32'bz:data;
    always #10 CLK=~CLK;
    
    RAM_4Kx32_inout RAM_4Kx32_inout_r(Data,Addr,RST,R_W,CS,CLK);
    
endmodule
