/*Designed by: Minor A. S.

*/
module forming_data_v4(clk,Reg300,Reg301,Reg302,Reg303,Reg304,Reg305,Reg306,Reg307,Reg308,Reg309,
									Reg310,Reg311,Reg312,Reg313,Reg314,Reg315,Reg316,Reg317,Reg318,Reg319,
									Reg320,Reg321,Reg322,Reg323,Reg324,Reg325,Reg326,Reg327,Reg328,Reg329,
									Reg330,Reg331,Reg332,Reg333,Reg334,Reg335,Reg336,Reg337,Reg338,Reg339,
									data,EnableTx);
input clk;
input [15:0]Reg300;
input [15:0]Reg301;
input [15:0]Reg302;
input [15:0]Reg303;
input [15:0]Reg304;
input [15:0]Reg305;
input [15:0]Reg306;
input [15:0]Reg307;
input [15:0]Reg308;
input [15:0]Reg309;
input [15:0]Reg310;
input [15:0]Reg311;
input [15:0]Reg312;
input [15:0]Reg313;
input [15:0]Reg314;
input [15:0]Reg315;
input [15:0]Reg316;
input [15:0]Reg317;
input [15:0]Reg318;
input [15:0]Reg319;
input [15:0]Reg320;
input [15:0]Reg321;
input [15:0]Reg322;
input [15:0]Reg323;
input [15:0]Reg324;
input [15:0]Reg325;
input [15:0]Reg326;
input [15:0]Reg327;
input [15:0]Reg328;
input [15:0]Reg329;
input [15:0]Reg330;
input [15:0]Reg331;
input [15:0]Reg332;
input [15:0]Reg333;
input [15:0]Reg334;
input [15:0]Reg335;
input [15:0]Reg336;
input [15:0]Reg337;
input [15:0]Reg338;
input [15:0]Reg339;
output reg [47:0] data;
output reg EnableTx = 0;

reg [15:0]Reg = 300;
reg [40:0]count=0;
reg [40:0]count1=0;
reg [31:0]delay=0;
reg flag = 0;
reg flagRead [10:0];
reg flagReadoff=0;
reg [15:0] i = 0;
reg [15:0] n = 1;

initial begin
	
	i = 0;
	n = 1;
	
end

always@(posedge clk) begin
	
	if(count == 0) EnableTx = 0;
	
	count = count + 1;
	
	if(count == 80000*15) begin
		EnableTx = 1;
		count = 0;
//		n = n + 1;
		i = i + 1;
		
		if(i == 1)begin
//			delay = (80000*2);
			data[7:0] = 2;
			data[15:8] = 6;
			data[31:16] = Reg;
			data[47:32] = Reg300;
			Reg = Reg + 1;
		end
		
		else if(i == 2)begin
			data[31:16] = Reg;
			data[47:32] = Reg301;
			Reg = Reg + 1;
		end
		
		else if(i == 3)begin
			data[31:16] = Reg;
			data[47:32] = Reg302;
			Reg = Reg + 1;
		end
		
		else if(i == 4)begin
			data[31:16] = Reg;
			data[47:32] = Reg303;
			Reg = Reg + 1;
		end
		
		else if(i == 5)begin
			data[31:16] = Reg;
			data[47:32] = Reg304;
			Reg = Reg + 1;
		end
		
		else if(i == 6)begin
			data[31:16] = Reg;
			data[47:32] = Reg305;
			Reg = Reg + 1;
		end
		
		else if(i == 7)begin
			data[31:16] = Reg;
			data[47:32] = Reg306;
			Reg = Reg + 1;
		end
		
		else if(i == 8)begin
			data[31:16] = Reg;
			data[47:32] = Reg307;
			Reg = Reg + 1;
		end
		
		else if(i == 9)begin
			data[31:16] = Reg;
			data[47:32] = Reg308;
			Reg = Reg + 1;
		end
		
		else if(i == 10)begin
			data[31:16] = Reg;
			data[47:32] = Reg309;
			Reg = Reg + 1;
		end
		
		else if(i == 11)begin
			data[31:16] = Reg;
			data[47:32] = Reg310;
			Reg = Reg + 1;
		end
		
		else if(i == 12)begin
			data[31:16] = Reg;
			data[47:32] = Reg311;
			Reg = Reg + 1;
		end
		
		else if(i == 13)begin
			data[31:16] = Reg;
			data[47:32] = Reg312;
			Reg = Reg + 1;
		end
		
		else if(i == 14)begin
			data[31:16] = Reg;
			data[47:32] = Reg313;
			Reg = Reg + 1;
		end
		
		else if(i == 15)begin
			data[31:16] = Reg;
			data[47:32] = Reg314;
			Reg = Reg + 1;
		end
		
		else if(i == 16)begin
			data[31:16] = Reg;
			data[47:32] = Reg315;
			Reg = Reg + 1;
		end
		
		else if(i == 17)begin
			data[31:16] = Reg;
			data[47:32] = Reg316;
			Reg = Reg + 1;
		end
		
		else if(i == 18)begin
			data[31:16] = Reg;
			data[47:32] = Reg317;
			Reg = Reg + 1;
		end
		
		else if(i == 19)begin
			data[31:16] = Reg;
			data[47:32] = Reg318;
			Reg = Reg + 1;
		end
		
		else if(i == 20)begin
			data[31:16] = Reg;
			data[47:32] = Reg319;
			Reg = Reg + 1;
		end
		
		else if(i == 21)begin
			data[31:16] = Reg;
			data[47:32] = Reg320;
			Reg = Reg + 1;
		end
		
		else if(i == 22)begin
			data[31:16] = Reg;
			data[47:32] = Reg321;
			Reg = Reg + 1;
		end
		
		else if(i == 23)begin
			data[31:16] = Reg;
			data[47:32] = Reg322;
			Reg = Reg + 1;
		end
		
		else if(i == 24)begin
			data[31:16] = Reg;
			data[47:32] = Reg323;
			Reg = Reg + 1;
		end
		
		else if(i == 25)begin
			data[31:16] = Reg;
			data[47:32] = Reg324;
			Reg = Reg + 1;
		end
		
		else if(i == 26)begin
			data[31:16] = Reg;
			data[47:32] = Reg325;
			Reg = Reg + 1;
		end
		
		else if(i == 27)begin
			data[31:16] = Reg;
			data[47:32] = Reg326;
			Reg = Reg + 1;
		end
		
		else if(i == 28)begin
			data[31:16] = Reg;
			data[47:32] = Reg327;
			Reg = Reg + 1;
		end
		
		else if(i == 29)begin
			data[31:16] = Reg;
			data[47:32] = Reg328;
			Reg = Reg + 1;
		end
		
		else if(i == 30)begin
			data[31:16] = Reg;
			data[47:32] = Reg329;
			Reg = Reg + 1;
		end
		
		else if(i == 31)begin
			data[31:16] = Reg;
			data[47:32] = Reg330;
			Reg = Reg + 1;
		end
		
		else if(i == 32)begin
			data[31:16] = Reg;
			data[47:32] = Reg331;
			Reg = Reg + 1;
		end
		
		else if(i == 33)begin
			data[31:16] = Reg;
			data[47:32] = Reg332;
			Reg = Reg + 1;
		end
		
		else if(i == 34)begin
			data[31:16] = Reg;
			data[47:32] = Reg333;
			Reg = Reg + 1;
		end
		
		else if(i == 35)begin
			data[31:16] = Reg;
			data[47:32] = Reg334;
			Reg = Reg + 1;
		end
		
		else if(i == 36)begin
			data[31:16] = Reg;
			data[47:32] = Reg335;
			Reg = Reg + 1;
		end
		
		else if(i == 37)begin
			data[31:16] = Reg;
			data[47:32] = Reg336;
			Reg = Reg + 1;
		end
		
		else if(i == 38)begin
			data[31:16] = Reg;
			data[47:32] = Reg337;
			Reg = Reg + 1;
		end
		
		else if(i == 39)begin
			data[31:16] = Reg;
			data[47:32] = Reg338;
			Reg = Reg + 1;
		end
		
		else if(i == 40)begin
			data[31:16] = Reg;
			data[47:32] = Reg339;
			Reg = Reg + 1;
		end
//=============================================================================================
		else if(i == 41)begin
//			delay = (80000*3);
			data[7:0] = 2;
			data[15:8] = 3;
			data[31:16] = Reg;
			data[47:32] = 10;
			Reg = 350;
		end
		else if(i == 42)begin
//			delay = (80000*3);
			data[7:0] = 2;
			data[15:8] = 3;
			data[31:16] = Reg;
			data[47:32] = 10;
			Reg = 300;
			i=0;
		end
	end
	
end
endmodule