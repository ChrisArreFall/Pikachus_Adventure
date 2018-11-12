module block_repeater_tb();
			logic [9:0] pos_x = 4,pos_y = 4,x=0,y=0;
			logic clk;
			logic [7:0] r,g,b;
			
			// instantiate device to be tested 
			block_repeater dut(clk,x,y,r,g,b);
			// generate clock to sequence tests 
			always 
				begin 
					clk <= 1; # 5; 
					clk <= 0; # 5; 
				end
			
			always_ff@(posedge clk)
				begin
					if(y<480)
						begin
							if(x<640)
								begin
									x <= x+1;
								end
							else
								begin
									x <= 0;
									y <= y+1;
								end
						end
					else
						y <= 0;
						
				end
			
endmodule 
