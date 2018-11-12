module data_memory(input logic clk,WE,
						 input logic [31:0] A,WD,
						 output logic [31:0] RD);
	logic [31:0] memory [31:0];
	initial 
		$readmemh("C:\\Users\\Chris\\Documents\\TEC\\Taller\\Proyecto\\Processor\\ARMv4_Processor\\ARMV4\\instructions\\RAM.mem",memory);
	
	always_ff@(negedge clk)
		if(WE)
			memory[A[31:2]] <= WD;
			
	assign RD = memory[A[31:2]];
			
			
endmodule
