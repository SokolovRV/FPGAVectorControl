/*Designed by: Minor A. S.

*/
module forming_data_v3(clk,Reg300,Reg301,Reg302,Reg303,Reg304,Reg305,Reg306,Reg307,Reg308,Reg309,data,EnableTx);
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
output reg [47:0] data;
output reg EnableTx = 0;

reg [40:0]count=0;
reg [40:0]count1=0;
reg flag = 0;
reg flagRead [10:0];
reg flagReadoff=0;
reg [7:0] i = 0;
reg [15:0] n = 0;

always@(posedge clk) begin
	
	if(count == 0) EnableTx = 0;
	
	count = count + 1;
	
	if(count == 80000*2) begin
		EnableTx = 1;
		count=0;
		n = n + 1;
		i = i + 1;
		
		if(i == 1)begin
			data[7:0] = 2;
			data[15:8] = 6;
			data[31:16] = 300;
			data[47:32] = Reg300;
		end
		
		if(i == 2)begin
			data[31:16] = 301;
			data[47:32] = Reg301;
		end
		
		if(i == 3)begin
			data[31:16] = 302;
			data[47:32] = Reg302;
		end
		
		if(i == 4)begin
			data[31:16] = 303;
			data[47:32] = Reg303;
		end
		
		if(i == 5)begin
			data[31:16] = 304;
			data[47:32] = Reg304;
		end
		
		if(i == 6)begin
			data[31:16] = 305;
			data[47:32] = Reg305;
		end
		
		if(i == 7)begin
			data[7:0] = 2;
			data[15:8] = 6;
			data[31:16] = 306;
			data[47:32] = Reg306;
		end
		
		if(i == 8)begin
			data[31:16] = 307;
			data[47:32] = Reg307;
		end
		
		if(i == 9)begin
			data[31:16] = 308;
			data[47:32] = Reg308;
		end
		
		if(i == 10)begin
			data[31:16] = 309;
			data[47:32] = Reg309;
		end
//=============================================================================================
		if(i == 11)begin
			data[7:0] = 2;
			data[15:8] = 3;
			data[31:16] = 310;
			data[47:32] = 1;
		end
		if(i == 12)begin
			data[31:16] = 311;
		end
		if(i == 13)begin
			data[31:16] = 312;
		end
		if(i == 14)begin
			data[31:16] = 313;
		end
		if(i == 15)begin
			data[31:16] = 314;
		end
		if(i == 16)begin
			data[31:16] = 315;
		end
		if(i == 17)begin
			data[31:16] = 316;
		end
		if(i == 18)begin
			data[31:16] = 317;
		end
		if(i == 19)begin
			data[31:16] = 318;
		end
		if(i == 20)begin
			data[31:16] = 319;
			i=0; n=0;
		end
/*		if(flagRead[0]==1) begin i=11; flagReadoff=1; end
		if(i == 11)begin
			data[7:0] = 2;
			data[15:8] = 3;
			data[31:16] = 310;
			data[47:32] = 1;
			flagRead[0]=1;
		end
		if(flagReadoff==1) begin flagRead[0]=0; flagReadoff=0; end
		
		if(flagRead[1]==1) begin i=12; flagReadoff=1; end
		if(i == 12)begin
			data[7:0] = 2;
			data[15:8] = 3;
			data[31:16] = 311;
			data[47:32] = 1;
			flagRead[1]=1;
		end
		if(flagReadoff==1) begin flagRead[1]=0; flagReadoff=0; end
		
		if(flagRead[2]==1) begin i=13; flagReadoff=1; end
		if(i == 13)begin
			data[7:0] = 2;
			data[15:8] = 3;
			data[31:16] = 312;
			data[47:32] = 1;
			flagRead[2]=1;
		end
		if(flagReadoff==1) begin flagRead[2]=0; flagReadoff=0; end
		
		if(flagRead[3]==1) begin i=14; flagReadoff=1; end
		if(i == 14)begin
			data[7:0] = 2;
			data[15:8] = 3;
			data[31:16] = 313;
			data[47:32] = 1;
			flagRead[3]=1;
		end
		if(flagReadoff==1) begin flagRead[3]=0; flagReadoff=0; end
		
		if(flagRead[4]==1) begin i=15; flagReadoff=1; end
		if(i == 15)begin
			data[7:0] = 2;
			data[15:8] = 3;
			data[31:16] = 314;
			data[47:32] = 1;
			flagRead[4]=1;
		end
		if(flagReadoff==1) begin flagRead[4]=0; flagReadoff=0; end
		
		if(flagRead[5]==1) begin i=16; flagReadoff=1; end
		if(i == 16)begin
			data[7:0] = 2;
			data[15:8] = 3;
			data[31:16] = 315;
			data[47:32] = 1;
			flagRead[5]=1;
		end
		if(flagReadoff==1) begin flagRead[5]=0; flagReadoff=0; end
		
		if(flagRead[6]==1) begin i=17; flagReadoff=1; end
		if(i == 17)begin
			data[7:0] = 2;
			data[15:8] = 3;
			data[31:16] = 316;
			data[47:32] = 1;
			flagRead[6]=1;
		end
		if(flagReadoff==1) begin flagRead[6]=0; flagReadoff=0; end
		
		if(flagRead[7]==1) begin i=18; flagReadoff=1; end
		if(i == 18)begin
			data[7:0] = 2;
			data[15:8] = 3;
			data[31:16] = 317;
			data[47:32] = 1;
			flagRead[7]=1;
		end
		if(flagReadoff==1) begin flagRead[7]=0; flagReadoff=0; end
		
		if(flagRead[8]==1) begin i=19; flagReadoff=1; end
		if(i == 19)begin
			data[7:0] = 2;
			data[15:8] = 3;
			data[31:16] = 318;
			data[47:32] = 1;
			flagRead[8]=1;
		end
		if(flagReadoff==1) begin flagRead[8]=0; flagReadoff=0; end
		
		if(flagRead[9]==1) begin i=20; flagReadoff=1; end
		if(i == 20)begin
			data[7:0] = 2;
			data[15:8] = 3;
			data[31:16] = 319;
			data[47:32] = 1;
			flagRead[9]=1;
		end
		if(flagReadoff==1) begin flagRead[9]=0; flagReadoff=0; i=0; n=0; end*/
	end
	
end
endmodule