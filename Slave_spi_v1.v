/*Designed by: Minor A. S.
*/
module Slave_spi_v1(clk, SCK, MOSI, SS, DATAIN, start, 
						  Enable, dataout11, dataout22, dataout33, dataout44,);
input clk;
input SCK;
input MOSI;
input SS;
input start;
input [15:0] DATAIN;
output reg Enable = 0;
output reg [15:0] dataout11;
output reg [15:0] dataout22;
output reg [15:0] dataout33;
output reg [15:0] dataout44;

reg [7:0] countbit = 16;
reg [16:0] data = 0;
reg [5:0] countdata = 0;
reg [15:0] datain [3:0];
reg unsigned [9:0] data1 = 0;

reg [5:0] flag_accepted = 0;
reg EnableOut = 0;
reg flag = 0;
reg flagSS = 0;

//always @(posedge clk) begin
//	if(SS==1) begin
//end

always @(negedge SCK) begin
	
	if(EnableOut == 1) EnableOut = 0;
	
	if((SS == 0)&(flag == 1)) begin
		flag = 0;
		countbit = 0;
		flagSS = 1;
	end
	
	if(SS==1) begin
		flag = 1;
	end
	
	if(flagSS == 1) begin
		if(countbit < 16)begin
//			Enable = 0;
			data[15-countbit] = MOSI;
		end
	end
	if(countbit == 15)begin
		flagSS = 0;
		datain[countdata] = data;
//		data1 = data1+1;
//		if(data1 == 280) data1 = 0;
		
		countdata = countdata + 1;
		
		if(countdata == 4) begin
			countdata = 0;
			EnableOut = 1;
		end
	end
	
	
	if(countbit < 40) countbit = countbit + 1;
	
	if(countbit == 40) begin countdata = 0; end
	
end

always @(posedge clk) begin
	
	if(start == 1) Enable = 0;
//	if(Enable == 1) Enable = 0;
	
	if(EnableOut == 0) flag_accepted = 0;
	if((EnableOut == 1)&(flag_accepted < 3)) begin
		if(flag_accepted == 1) Enable = 1;
//		data1 = data1+1;
//		if(data1 == 251) data1 = 0;
		dataout11 = datain[0];
		dataout22 = datain[1];
		dataout33 = datain[2];
		dataout44 = datain[3];
//		dataout11 = data1;
//		dataout22 = data1;
//		dataout33 = data1;
//		dataout44 = data1;
		
		flag_accepted = flag_accepted + 1;
	end
	
end

endmodule