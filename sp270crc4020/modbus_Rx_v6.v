/*Designed by: Minor A. S.

*/
module modbus_Rx_v6(clk,datain,Enable,
		Reg340,Reg341,Reg342,Reg343,Reg344,Reg345,Reg346,Reg347,Reg348,Reg349);
input clk;
input [7:0] datain;
input Enable;
output reg [15:0] Reg340;
output reg [15:0] Reg341;
output reg [15:0] Reg342;
output reg [15:0] Reg343;
output reg [15:0] Reg344;
output reg [15:0] Reg345;
output reg [15:0] Reg346;
output reg [15:0] Reg347;
output reg [15:0] Reg348;
output reg [15:0] Reg349;

reg [15:0] x = 16'hFFFF;
reg [15:0] y = 0;
reg [15:0] CRC = 0;
reg [5:0] n = 0;
reg [5:0] j = 0;
reg Txf = 0;

reg [7:0] Message [24:0];//massive message
reg [5:0] i = 0;
reg flag = 0;
reg flagCRC = 0;
reg flagEnable = 0;

//========================================
always@(posedge clk) begin

	if((Enable == 1)&&(flag == 0))flag = 1;
	
	if(flag == 1) begin
		
		Message [i] = datain[7:0];
		if(Message[0] == 2) i = i + 1;
		if(Message[1] != 3) begin if(i == 7) i = 0; end
		if(i == 25) begin flagCRC = 1; end
		flag = 0;
		
	end
	
	
	if(flagCRC == 1) begin
		x[15:0] = 16'hFFFF;
		x[7:0] = x[7:0] ^ Message[0];
		
		for (j = 0; j < 8; j = j + 1) begin
			if (x & 1) x = (x >> 1) ^ 16'hA001;
			else x = x >> 1;
		end
		
		y = x;
		n = 1;
		while (n < 23) begin
			
			y = y ^ Message[n];
			
			for (j = 0; j < 8; j = j + 1) begin
				if (y & 1) y = (y >> 1) ^ 16'hA001;
				else y = y >> 1;
			end
			
			n = n + 1;
			
		end
		
		CRC[7:0]=Message[n];
		n = n + 1;
		CRC[15:8]=Message[n];
		
		if(y==CRC) flagEnable = 1;
		flagCRC = 0;
		
	end
	

	if(flagEnable == 1)begin
			
		Reg340[15:8]=Message[3];
		Reg340[7:0]=Message[4];
		
		Reg341[15:8]=Message[5];
		Reg341[7:0]=Message[6];
		
		Reg342[15:8]=Message[7];
		Reg342[7:0]=Message[8];
		
		Reg343[15:8]=Message[9];
		Reg343[7:0]=Message[10];
		
		Reg344[15:8]=Message[11];
		Reg344[7:0]=Message[12];
		
		Reg345[15:8]=Message[13];
		Reg345[7:0]=Message[14];
		
		Reg346[15:8]=Message[15];
		Reg346[7:0]=Message[16];
		
		Reg347[15:8]=Message[17];
		Reg347[7:0]=Message[18];
		
		Reg348[15:8]=Message[19];
		Reg348[7:0]=Message[20];
		
		Reg349[15:8]=Message[21];
		Reg349[7:0]=Message[22];
		
		flagEnable = 0;
	end
end

endmodule