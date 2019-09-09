/*Designed by: Minor A. S.

*/
module modbus_Rx_v5(clk,datain,Enable,
		Reg310,Reg311,Reg312,Reg313,Reg314,Reg315,Reg316,Reg317,Reg318,Reg319);
input clk;
input [7:0] datain;
input Enable;
output reg [15:0] Reg310;
output reg [15:0] Reg311;
output reg [15:0] Reg312;
output reg [15:0] Reg313;
output reg [15:0] Reg314;
output reg [15:0] Reg315;
output reg [15:0] Reg316;
output reg [15:0] Reg317;
output reg [15:0] Reg318;
output reg [15:0] Reg319;

reg [7:0] Message [24:0];//massive message
reg [5:0] i = 0;
reg flag = 0;

//========================================
always@(posedge clk) begin

	
	if((Enable == 1)&&(flag == 0))flag = 1;

	if(flag == 1)begin
	
		Message [i] = datain[7:0];
		
		if(Message[0] == 2) i = i + 1;
		
		if(i == 8) begin
			if(Message[1] == 6) begin
				Message[0] = 0;
				Message[1] = 0;
				Message[2] = 0;
				Message[3] = 0;
				Message[4] = 0;
				Message[5] = 0;
				Message[6] = 0;
				Message[7] = 0;
				i = 0;
			end
		end
		
		if(i == 25) begin
			
			Reg310[15:8]=Message[3];
			Reg310[7:0]=Message[4];
			
			Reg311[15:8]=Message[5];
			Reg311[7:0]=Message[6];
			
			Reg312[15:8]=Message[7];
			Reg312[7:0]=Message[8];
			
			Reg313[15:8]=Message[9];
			Reg313[7:0]=Message[10];
			
			Reg314[15:8]=Message[11];
			Reg314[7:0]=Message[12];
			
			Reg315[15:8]=Message[13];
			Reg315[7:0]=Message[14];
			
			Reg316[15:8]=Message[15];
			Reg316[7:0]=Message[16];
			
			Reg317[15:8]=Message[17];
			Reg317[7:0]=Message[18];
			
			Reg318[15:8]=Message[19];
			Reg318[7:0]=Message[20];
			
			Reg319[15:8]=Message[21];
			Reg319[7:0]=Message[22];
			i = 0;
		end
		
		flag = 0;
	end
end

endmodule