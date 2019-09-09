module WordSeparate (clk, WordIn,
								bit0, bit1, bit2, bit3, bit4, bit5, bit6, bit7,
								bit8, bit9, bit10, bit11, bit12, bit13, bit14, bit15);

input clk;
input [15:0] WordIn;
output reg bit0, bit1, bit2, bit3, bit4, bit5, bit6, bit7, 
					  bit8, bit9, bit10, bit11, bit12, bit13, bit14, bit15;

always @(posedge clk) begin
	bit0 <= WordIn[0];
	bit1 <= WordIn[1];
	bit2 <= WordIn[2];
	bit3 <= WordIn[3];
	bit4 <= WordIn[4];
	bit5 <= WordIn[5];
	bit6 <= WordIn[6];
	bit7 <= WordIn[7];
	bit8 <= WordIn[8];
	bit9 <= WordIn[9];
	bit10 <= WordIn[10];
	bit11 <= WordIn[11];
	bit12 <= WordIn[12];
	bit13 <= WordIn[13];
	bit14 <= WordIn[14];
	bit15 <= WordIn[15];
end
endmodule
			
						