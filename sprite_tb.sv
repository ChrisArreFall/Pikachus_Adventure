module sprite_tb();
			logic [9:0] pos_x = 4,pos_y = 4,x=0,y=0,diff_x,diff_y;
			logic enable=0,clk;
			logic [7:0] r,g,b;
			
			// instantiate device to be tested 
			pikachu dut(x,y,pos_x,pos_y,enable,r,g,b);
			// generate clock to sequence tests 
			always 
				begin 
					clk <= 1; # 5; 
					clk <= 0; # 5; 
				end
			
			always_ff@(posedge clk)
				begin
					if(y<40)
						begin
							if(x<40)
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
						
					diff_x = x-pos_x;
					diff_y = y-pos_y;
					
					if(diff_x<22 && diff_y<14)
						enable <= 1;
					else
						enable <= 0;
				end
			
endmodule 
