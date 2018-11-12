module tb_assembly();
	//----------Processor-----------------
	logic clk,reset,MemWrite;
	logic [7:0] KB_CODE=0;
	logic [31:0] PC = 0, Instruction, ReadData,DataAddr,WriteData;
	instruction_memory dut1(PC, Instruction); 
	ARMV4 dut2(clk, reset,Instruction,ReadData,MemWrite,PC, DataAddr, WriteData);
	//----------RAM------------------------
	logic [31:0] memory [31:0];
	initial 
		$readmemh("C:\\Users\\Chris\\Documents\\TEC\\Taller\\Proyecto\\Processor\\ARMv4_Processor\\ARMV4\\instructions\\RAM.mem",memory);
	
	always_ff@(posedge clk)
		if(MemWrite)
			memory[DataAddr[31:2]] <= WriteData;
		else
			memory[1] <= KB_CODE;
			
	assign ReadData = memory[DataAddr[31:2]];
	assign offset_ARM = memory[0];
	//--------------------------------------
	// initialize test
	initial begin
		reset <=0;
		clk <= 0;
	end
	always 
		begin 
			clk <= 1; 
			# 5;
			clk <= 0; 
			# 5;
		end
	 always
		begin
			#60
			KB_CODE <= 8'h23;
			#60
			KB_CODE <= 8'h23;
			#60
			KB_CODE <= 8'h23;
			#60
			KB_CODE <= 8'h23;
			#60
			KB_CODE <= 8'h23;
		end

endmodule
