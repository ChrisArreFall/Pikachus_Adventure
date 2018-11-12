module game_memory_tb();
			logic [5:0] test1,test2,test3,data1=6'b111111,data2=6'b1111111,data_in,address=0;
			game_memory dut1(address,data_in,write,data_out);
			game_memory dut2(address,data_in,write,data_out);

endmodule
