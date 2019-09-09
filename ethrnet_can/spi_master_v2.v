module spi_master_v2(clk_spi, MISO, enable, data, selector, sclk, cs, MOSI, rByte);

input 	clk_spi;
input 	[15:0]	data;
input 	MISO;
input 	enable;

output reg 	sclk 	= 0;
output reg 	cs		= 1;
output reg 	MOSI = 0;
output reg	[15:0] rByte = 0;
output reg 	[4:0]	 selector = 0;
	
reg	[15:0]		count = 0;
reg	[7:0]		mode = 0; // 0 - pause; 1 - write ADC;
reg	[15:0]		tempdata = 0;
reg [15:0]		inputArray = 0;	// array for incomming data

always @(posedge clk_spi) begin
	if (enable == 0) begin
		selector = 0;
		mode <= 0;
		count = 0;
	end

	if (mode == 0 && enable == 1) begin
		//rByte = inputArray;		// send data out of block
		tempdata = data;
		mode <= 1;
	end
	
	if (mode == 1 && enable == 1) begin					// read ADC
		case (count)
			0: begin cs = 1; sclk = 0; end
			1: begin cs = 0; sclk = 0; end
			2: sclk = 0;
			3: sclk = 0;
			4: sclk = 0;
			5: sclk = 0;
			6: begin sclk = 1; MOSI <= tempdata[15]; end
			7: begin inputArray[15] = MISO; sclk = 0; end
			8: begin sclk = 1; MOSI = tempdata[14]; end
			9: begin inputArray[14] = MISO; sclk = 0; end		
			10: begin sclk = 1; MOSI = tempdata[13]; end
			11: begin inputArray[13] = MISO; sclk = 0; end
			12: begin sclk = 1; MOSI = tempdata[12]; end
			13: begin inputArray[12] = MISO; sclk = 0; end
			14: begin sclk = 1; MOSI = tempdata[11]; end
			15: begin inputArray[11] = MISO; sclk = 0; end
			16: begin sclk = 1; MOSI = tempdata[10]; end
			17: begin inputArray[10] = MISO; sclk = 0; end
			18: begin sclk = 1; MOSI = tempdata[9]; end
			19: begin inputArray[9] = MISO; sclk = 0; end
			20: begin sclk = 1; MOSI = tempdata[8]; end
			21: begin inputArray[8] = MISO; sclk = 0; end
			22: begin sclk = 1; MOSI = tempdata[7]; end
			23: begin inputArray[7] = MISO; sclk = 0; end
			24: begin sclk = 1; MOSI = tempdata[6]; end
			25: begin inputArray[6] = MISO; sclk = 0; end
			26: begin sclk = 1; MOSI = tempdata[5]; end
			27: begin inputArray[5] = MISO; sclk = 0; end
			28: begin sclk = 1; MOSI = tempdata[4]; end
			29: begin inputArray[4] = MISO; sclk = 0; end
			30: begin sclk = 1; MOSI = tempdata[3]; end
			31: begin inputArray[3] = MISO; sclk = 0; end
			32: begin sclk = 1; MOSI = tempdata[2]; end
			33: begin inputArray[2] = MISO; sclk = 0; end
			34: begin sclk = 1; MOSI = tempdata[1]; end
			35: begin inputArray[1] = MISO; sclk = 0; end
			36: begin sclk = 1; MOSI = tempdata[0]; end
			37: begin inputArray[0] = MISO; sclk = 0;  rByte = inputArray; end // new line
			//================test_cs_halt====================
			38: begin sclk = 0; MOSI = 0;	end					//
			39: sclk = 0;												//
			40: sclk = 0;												//
			41: sclk = 0; 												//
			42: cs = 1;													//
			43: cs = 1;													//
			44: cs = 1;													//
			45: cs = 1;													//
			46: cs = 1;													//
			47: cs = 1;													//
			48: cs = 1;													//
			49: begin 
					cs = 1; 
					if (selector == 15) begin selector = 0; end//was 6
					else begin selector <= selector + 1; end
				 end 
			50: cs = 1;			
			default: begin cs = 1; sclk = 0; count = 0; mode <=0; end
		endcase
		count = count + 1;
	end
end
endmodule
