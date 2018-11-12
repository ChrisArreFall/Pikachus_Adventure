module color_mux(input logic clk,move,
					  input logic [9:0] x,y,offset_ARM,
					  output logic [7:0] r,g,b);
					logic enable_pikachu,enable_block,par;
					logic [7:0] pika_r=0,pika_g=0,pika_b=0,block_r=0,block_g=0,block_b=0;
					
					
					pikachu pikachu_unit(x,y,304,336,enable_pikachu,offset_ARM[0],pika_r,pika_g,pika_b);
					block_repeater block_repeater_unit(clk,move,x,y,offset_ARM,block_r,block_g,block_b);
					
					
					always_ff@(posedge clk)
							if(y<352&&y>336)
									if(x>304&&x<336)
										enable_pikachu <= 1;
									else 
										enable_pikachu <= 0;
										
					always_ff@(posedge move)
						par <= ~par;
							
					assign r = (enable_pikachu) ? pika_r : block_r;
					assign g = (enable_pikachu) ? pika_g : block_g;
					assign b = (enable_pikachu) ? pika_b : block_b;
endmodule
