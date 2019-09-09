/*Designed by: Minor A. S.

*/
module modbus_Tx_v3(clk,datain,Enable,send,CRC,Tx,DATA,EnableTx,ADM485TX);
input clk;
input send;
input Enable;
input [47:0]datain;
output reg [7:0]DATA=0;
output reg EnableTx=0;
output ADM485TX;
output reg [15:0] CRC;
output reg Tx=0;

reg [7:0] Message [7:0];
reg [4:0]i=1;
reg flag = 0;

reg [15:0] x = 16'hFFFF;
reg [15:0] y = 0;
reg [5:0] n = 0;
reg [5:0] j = 0;
reg Txf = 0;
reg flagCRC = 0;
reg a = 0;
reg flag1 = 0;

assign ADM485TX=(send==0);

//======================================================================
always @(posedge clk) begin
	
	Message[0]=datain[7:0];
	Message[1]=datain[15:8];
	Message[2]=datain[31:24];
	Message[3]=datain[23:16];
	Message[4]=datain[47:40];
	Message[5]=datain[39:32];
	
end
//======================================================================
always @(posedge clk) begin
	
	if(Enable==1) flagCRC=1;
	if(Tx == 1) flagCRC=0;
	
end
//======================================================================
always @(posedge clk) begin
	
	if(Txf==1)Tx=0;
	
	if(flagCRC==1) begin
		x[15:0] = 16'hFFFF;
		x[7:0] = x[7:0] ^ Message[0];
		
		for (j = 0; j < 8; j = j + 1) begin
			if (x & 1) x = (x >> 1) ^ 16'hA001;
			else x = x >> 1;
		end
		
		y = x;
		n = 5;
		while (n) begin
			
			if(n==5)y = y ^ Message[1];
			if(n==4)y = y ^ Message[2];
			if(n==3)y = y ^ Message[3];
			if(n==2)y = y ^ Message[4];
			if(n==1)y = y ^ Message[5];
			
			for (j = 0; j < 8; j = j + 1) begin
				if (y & 1) y = (y >> 1) ^ 16'hA001;
				else y = y >> 1;
			end
			
			n = n - 1;
			
		end
		
		CRC=y;
		Message[6]=y[7:0];
		Message[7]=y[15:8];
		Tx=1;
	end
	
end
//======================================================================
always@(posedge clk) begin
	
	if(EnableTx==1&&send==0) begin
		EnableTx=0;
		flag=0;
	end
	
	if(Tx == 1) Txf = 1;
	
	if((Txf == 1)&&(Enable==0)) begin
		
		if((send==1)&&(flag == 0)) begin
		
				DATA[7:0]=Message[i-1];
				EnableTx=1;
				flag=1;
			
			if(i==8) Txf = 0;
			
			i=i+1;
			if(i==9) i=1;
		end
	end
end

endmodule