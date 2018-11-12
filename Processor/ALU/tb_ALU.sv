module tb_ALU();
	logic [3:0] A, B;
	logic [3:0] ALUControl;
	logic [3:0] flags;
	logic [3:0] RESULT;
	ALU_N_bits#(4) dut(A, B,ALUControl,flags,RESULT);
	
	initial 
		begin  
			A <= 0;
			B <= 0;
			ALUControl <= 0;
			# 10;
		end
	always
		begin
			A <= 4'b0111;
			B <= 4'b0011;
			ALUControl <= 4'b01;
			# 10;
			A <= 4'b0000;
			B <= 4'b0011;
			ALUControl <= 4'b01;
			# 10;
		
		end

endmodule

