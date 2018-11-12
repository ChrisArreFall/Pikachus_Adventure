module game_memory(input logic [5:0] address,data_in,
						 input logic write,
						 output logic [5:0] data_out);
		logic [5:0] mem [0:31];

		initial begin
		  // Load memory from file
		  $readmemb("game.mem", mem);   
		end
		always_comb
			if(write)
				mem[address] = data_in;
			else
				data_out = mem[address];
endmodule
