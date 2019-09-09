/*Designed by: Minor A. S.

*/
module modbus_Rx_v4(clk,datain,Enable,dataRx,accepte);
input clk;
input [7:0] datain;
input Enable;
output reg accepte;
output reg [63:0] dataRx;

reg [7:0] Message [7:0];//massive message
reg [5:0] i = 0;
reg flag = 0;

//========================================
always@(posedge clk) begin
	
	if(i == 7) begin
		i = 0;
	end
	accepte = 0;
	
	if((Enable == 1)&&(flag == 0))flag = 1;

	if(flag == 1)begin
	
		Message [i] = datain[7:0];
		
		if(Message[0] == 2) i = i + 1;
		
		if(i == 7) begin
				dataRx[7:0]=Message[0];
				dataRx[15:8]=Message[1];
				dataRx[23:16]=Message[2];
				dataRx[31:24]=Message[3];
				dataRx[39:32]=Message[4];
				dataRx[47:40]=Message[5];
				dataRx[55:48]=Message[6];
				dataRx[63:56]=Message[7];
				
				Message[0] = 0;
				Message[1] = 0;
				Message[2] = 0;
				Message[3] = 0;
				Message[4] = 0;
				Message[5] = 0;
				Message[6] = 0;
				Message[7] = 0;
				accepte = 1;
		end
		
//		a = 0;
		flag = 0;
	end
end

endmodule