/*Designed by: Minor A. S.

*/
module data_processor_v5(clk,datain,Enable,Message,EnableTx,
		Reg310,Reg311,Reg312,Reg313,Reg314,Reg315,Reg316,Reg317,Reg318,Reg319);
input clk;
input Enable;
input EnableTx;
input [63:0] datain;
input [47:0] Message;
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

reg [15:0] data=0;
reg [15:0] Reg=0;
reg [15:0] CRC=0;
reg [7:0] MessageM [5:0];
reg [7:0] Messagein [5:0];
reg buttom = 0;
reg flag = 1;
reg flag1 = 1;
reg flagReg310 = 0;
reg flagReg311 = 0;
reg flagReg312 = 0;
reg flagReg313 = 0;
reg flagReg314 = 0;
reg flagReg315 = 0;
reg flagReg316 = 0;
reg flagReg317 = 0;
reg flagReg318 = 0;
reg flagReg319 = 0;
//======================================================================
always@(posedge clk) begin
	

	
	if((EnableTx==1)&(flag1 == 1)) begin
		MessageM[0]=Message[7:0];
		MessageM[1]=Message[15:8];
		MessageM[2]=Message[23:16];
		MessageM[3]=Message[31:24];
		MessageM[4]=Message[39:32];
		MessageM[5]=Message[47:40];
		flag1 = 0;
	end
//	if(MessageM[1]==6) flag=1;
//	if(MessageM[1]==3) flag=0;
	
	if((Enable==1)&(flag1 == 0)) begin
		Messagein[0]=datain[7:0];
		Messagein[1]=datain[15:8];
		Messagein[2]=datain[23:16];
		Messagein[3]=datain[31:24];
		Messagein[4]=datain[39:32];
		Messagein[5]=datain[47:40];
		CRC = datain[63:48];
	end
	
	if((Enable==1)&(MessageM[1]==3)) begin
		flag1 = 1;
		Reg[15:8]=MessageM[3];
		Reg[7:0]=MessageM[2];
		data[15:8]=Messagein[3];
		data[7:0]=Messagein[4];
		
		if(Reg==310) begin
			Reg310 = data;
		end
		
		if(Reg==311) begin
			Reg311 = data;
		end
		
		if(Reg==312) begin
			Reg312 = data;
		end
		
		if(Reg==313) begin
			Reg313 = data;
		end
		
		if(Reg==314) begin
			Reg314 = data;
		end
		
		if(Reg==315) begin
			Reg315 = data;
		end
		
		if(Reg==316) begin
			Reg316 = data;
		end
		
		if(Reg==317) begin
			Reg317 = data;
		end
		
		if(Reg==318) begin
			Reg318 = data;
		end
		
		if(Reg==319) begin
			Reg319 = data;
		end
		
/*		if(Reg==311) begin
			if (flagReg311 == 1) begin flagReg311 = 0; Reg311 = data; end
			if (Reg310 != data) begin Reg311 = data; flagReg311 = 0; end
			if (Reg310 == data) flagReg311 = 1;
		end
		
		if(Reg==312) begin
			if (flagReg312 == 1) begin flagReg312 = 0; Reg312 = data; end
			if (Reg311 != data) begin Reg312 = data; flagReg312 = 0; end
			if (Reg311 == data) flagReg312 = 1;
		end
		
		if(Reg==313) begin
			if (flagReg313 == 1) begin flagReg313 = 0; Reg313 = data; end
			if (Reg312 != data) begin Reg313 = data; flagReg313 = 0; end
			if (Reg312 == data) flagReg313 = 1;
		end
		
		if(Reg==314) begin
			if (flagReg314 == 1) begin flagReg314 = 0; Reg314 = data; end
			if (Reg313 != data) begin Reg314 = data; flagReg314 = 0; end
			if (Reg313 == data) flagReg314 = 1;
		end
		
		if(Reg==315) begin
			if (flagReg315 == 1) begin flagReg315 = 0; Reg315 = data; end
			if (Reg314 != data) begin Reg315 = data; flagReg315 = 0; end
			if (Reg314 == data) flagReg315 = 1;
		end
		
		if(Reg==316) begin
			if (flagReg316 == 1) begin flagReg316 = 0; Reg316 = data; end
			if (Reg315 != data) begin Reg316 = data; flagReg316 = 0; end
			if (Reg315 == data) flagReg316 = 1;
		end
		
		if(Reg==317) begin
			if (flagReg317 == 1) begin flagReg317 = 0; Reg317 = data; end
			if (Reg316 != data) begin Reg317 = data; flagReg317 = 0; end
			if (Reg316 == data) flagReg317 = 1;
		end
		
		if(Reg==318) begin
			if (flagReg318 == 1) begin flagReg318 = 0; Reg318 = data; end
			if (Reg317 != data) begin Reg318 = data; flagReg318 = 0; end
			if (Reg317 == data) flagReg318 = 1;
		end
		
		if(Reg==319) begin
			if (flagReg319 == 1) begin flagReg319 = 0; Reg319 = data; end
			if (Reg318 != data) begin Reg319 = data; flagReg319 = 0; end
			if (Reg318 == data) flagReg319 = 1;
		end*/
		
		Reg = 0;
		data = 0;
	end
	
	if((Enable==1)&(MessageM[1]==6)) begin
		flag1 = 1;
		Reg[15:8]=MessageM[2];
		Reg[7:0]=MessageM[3];
		data[15:8]=datain[39:32];
		data[7:0]=datain[47:40];
	end
	
end

endmodule