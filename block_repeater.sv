module block_repeater(input logic clk,move,
							 input logic [9:0] x,y,offset_ARM,
							 output logic [7:0] r,g,b);
				//0
				logic [9:0] offset_x = 0;//esto es offset en 0 del primer cuadro y va de 0 - 31 
				logic [9:0] pos_x =0;	 //esto es la posicion de la separacion entre cuadros, por ejemplo 0,32,64,96,128 y 
				logic [9:0] diff_x,diff_y,pos_y = 352,counter=0,R=0;
				logic enable=0;
				
				assign diff_x = x-pos_x + R;//esto es la posicion en x dentro del cuadro que quiero pintar va de 0 - 32
				assign diff_y = y-pos_y;	 //esto es la posicion en y dentro del cuadro que quiero pintar va de 0 - 32
 				block block_unit(x,y,diff_x,diff_y,pos_x,pos_y,enable,r,g,b);
				//obtengo el movimiento de memoria
				assign offset_x = 32 - offset_ARM;
				always_ff@(posedge clk)															//
					begin
					if(diff_y<128)																	// 128 para dibujar 4 filas de 32 bits que serian los cuadros
									begin
										enable <= 1;												// permite dibujar
										if(x<32-offset_x)										// si 
											R = offset_x;										//
										else															//
											R=0;														//
										if(diff_x > 31 || (x==31-offset_x))		//
											pos_x <= x;												//
										else if(x>639)												//
											pos_x <= 0;												//

											
										if(diff_y > 31)											//
											pos_y <= y;												//
										else if(y>479)												//
											pos_y <= 352;											//
									end
					else	
							enable <= 0;															//
					end
					
endmodule 
