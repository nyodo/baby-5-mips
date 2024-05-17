`define DATA_WIDTH 32 
module IMem(
    input [31:0] A,
    output [31:0] RD);
    
    parameter IMEM_SIZE=256;
    reg [`DATA_WIDTH-1:0] RAM[IMEM_SIZE-1:0];
    initial 
        $readmemh("C:/Users/nyodo/Desktop/cnt.txt",RAM);
    assign RD=RAM[A];
  
endmodule


