module color_mux(input logic clk,move,en_C,
					  input logic [3:0] number1,number2,
					  input logic [9:0] x,y,offset_ARM,
					  output logic [7:0] r,g,b);
					logic enable_pikachu,enable_block,enable_coin,enable_cloud,enable_number;
					logic [7:0] pika_r=0,pika_g=0,pika_b=0,block_r=0,block_g=0,block_b=0,r_cloud1,g_cloud1,b_cloud1,r_cloud2,g_cloud2,b_cloud2,r_cloud3,g_cloud3,b_cloud3,r_coin,g_coin,b_coin,r_number1,g_number1,b_number1,r_number2,g_number2,b_number2;
					
				
					
					always_ff@(posedge clk)
						begin
							if(y<352&&y>336)
								begin
									if(x>304&&x<336)
										enable_pikachu <= 1;
									else 
										enable_pikachu <= 0;
								end
							else 
									enable_pikachu <= 0;
							if(y>=120&&y<184)
									if(x>=50&&x<114||x>=164&&x<228||x>=278&&x<342)
										enable_cloud <= 1;
									else
										enable_cloud <= 0;
							else
									enable_cloud <= 0;
							if(y<352&&y>320)
									if(x>=500&&x<532)
										enable_coin <= 1;
									else
										enable_coin <= 0;
							else
									enable_coin <= 0;
							if(y>=20&&y<52)
									if((x>=600&&x<616)||(x>=620&&x<636))
										enable_number <= 1;
									else
										enable_number <= 0;
							else
									enable_number <= 0;
						end
						
					pikachu pikachu_unit(x,y,304,336,enable_pikachu,offset_ARM[0],pika_r,pika_g,pika_b);
					block_repeater block_repeater_unit(clk,move,x,y,offset_ARM,block_r,block_g,block_b);
					cloud cloud_unit1(x,y,50,50,enable_cloud,r_cloud1,g_cloud1,b_cloud1);
					cloud cloud_unit2(x,y,164,120,enable_cloud,r_cloud2,g_cloud2,b_cloud2);
					cloud cloud_unit3(x,y,278,50,enable_cloud,r_cloud3,g_cloud3,b_cloud3);
					pokecoin pokecoin_unit(x,y,500,320,en_C,enable_coin,r_coin,g_coin,b_coin);
					numbers numbers_unit1(x,y,600,20,enable_number,number1,r_number1,g_number1,b_number1);
					numbers numbers_unit2(x,y,620,20,enable_number,number2,r_number2,g_number2,b_number2);
					
					always_comb
						begin
							if(enable_pikachu)
								begin
									r = pika_r;
									g = pika_g;
									b = pika_b;
								end
							else if (enable_coin)
								begin
									r = r_coin;
									g = g_coin;
									b = b_coin;
								end
							else if (enable_cloud)
								begin
									if(x>=50&&x<114)
										begin
											r = r_cloud1;
											g = g_cloud1;
											b = b_cloud1;
										end
									else if(x>=164&&x<228)
										begin
											r = r_cloud3;
											g = g_cloud3;
											b = b_cloud3;
										end
									else
										begin
											r = r_cloud2;
											g = g_cloud2;
											b = b_cloud2;
										end
								end
							else if (enable_number)
								begin
									if(x>619)
										begin
											r = r_number2;
											g = g_number2;
											b = b_number2;
										end
									else
										begin
											r = r_number1;
											g = g_number1;
											b = b_number1;
										end
								end
							else
								begin
									r = block_r;
									g = block_g;
									b = block_b;
								end
					end
						
					
endmodule
