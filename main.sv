module main(input  logic clk, reset,
				input logic PS2_CLK,PS2_DATA,
				output logic hsync, vsync, n_sync, n_blanc, n25MHZCLK,
				output logic [7:0] r,g,b,
				output logic [6:0] hex1,hex0,
				output logic [3:0] led_x,led_Y,
				output logic flag);
			logic [7:0] temp_r = 0,temp_g = 0,temp_b = 0,KB_CODE = 0;
			logic [9:0] x,y,offset_ARM=0;
			logic move=0;
				
			//----------Keyboard---------------
			keyboard_controller keyboard_controller_F (.PS2_CLK(PS2_CLK),.PS2_DATA(PS2_DATA),.KB_CODE(KB_CODE),.FLAG(flag));
			sevenSegmentDisplay sevenSegmentDisplay_F_1 (offset_ARM[3:0],hex0);
			sevenSegmentDisplay sevenSegmentDisplay_F_2 (offset_ARM[7:4],hex1);
			
			assign led_Y[0] = (flag) ? ((KB_CODE == 8'h23) ? 1 : 0) : 0;
			assign move = (flag) ? ((KB_CODE == 8'h23) ? 1 : 0) : 0;
			
			//------------VGA------------------
			VGA_Controller VGA_Controller_Unit(.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync), .enable(video_on), .clk_out(n25MHZCLK), .x(x), .y(y));
			
			//----------Sprites-------------------
			color_mux color_mux_unit(n25MHZCLK,move,1'b1,0,1,x,y,offset_ARM,temp_r,temp_g,temp_b);
			
			//----------Processor-----------------
			logic [31:0] PC = 0, Instruction, ReadData,DataAddr,WriteData;
			instruction_memory instruction_memory_unit(PC, Instruction); 
			ARMV4 ARMV4_unit(n25MHZCLK, reset,Instruction,ReadData,MemWrite,PC, DataAddr, WriteData);
			//----------RAM------------------------
			logic [31:0] memory [31:0];
			initial 
				$readmemh("C:\\Users\\Chris\\Documents\\TEC\\Taller\\Proyecto\\Processor\\ARMv4_Processor\\ARMV4\\instructions\\RAM.mem",memory);
			
			always_ff@(negedge n25MHZCLK)
				if(MemWrite)
					memory[DataAddr[31:2]] <= WriteData;
				else
					memory[1] <= (flag) ? KB_CODE : 32'b0;
					
				
			assign ReadData = memory[DataAddr[31:2]];
			assign offset_ARM = memory[0];
			assign led_x[0] = memory[3];
			assign led_x[1] = memory[6];
			//--------------------------------------
	
			assign r = (video_on) ? temp_r : 8'b0;
			assign g = (video_on) ? temp_g : 8'b0;
			assign b = (video_on) ? temp_b : 8'b0;

			assign n_sync  =  1'b0;
			assign n_blanc =  1'b1;
		
				
endmodule 