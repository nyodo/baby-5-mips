module encoder83_assign(I,Y);
	input I;
	output Y;
	wire[7:0] I;
	wire[2:0] Y;
	
	assign Y[0]=I[1]|I[3]|I[5]|I[7], Y[1]=I[2]|I[3]|I[6]|I[7],Y[2]=I[4]|I[5]|I[6]|I[7];
endmodule