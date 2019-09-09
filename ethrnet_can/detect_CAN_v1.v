module detect_CAN_v1 (cs, byteFromEth, data1, data2, data3, data4, data5, data6, data7);

input 				cs;
input [15:0] 		byteFromEth;

output reg [15:0] data1 = 0, data2 = 0, data3 = 100, data4 = 0, data5 = 0, data6 = 0, data7 = 175;

reg [0:0] 	flag1 = 0, flag2 = 0, flag3 = 0, flag4 = 0;
reg [3:0]	cnt;

parameter reg [15:0] id1 = 513;
parameter reg [15:0] id2 = 514;
parameter reg [15:0] id3 = 515;
parameter reg [15:0] id4 = 520;

always @ (posedge cs) 
begin
	if (byteFromEth == /*id1*/513)
		begin
			flag1 = 1; flag2 = 0; flag3 <= 0; flag4 = 0;
			//cnt <= 0;
		end
		
	if (byteFromEth == /*id2*/514)
		begin
			flag1 = 0; flag2 = 1; flag3 <= 0; flag4 = 0;
			//cnt <= 0;
		end	
		
		
	if (byteFromEth == /*id3*/515)
		begin
			flag1 = 0; flag2 = 0; flag3 <= 1; flag4 = 0;
			//cnt <= 0;
		end		
	if (byteFromEth == id4)
		begin
			flag1 = 0; flag2 = 0; flag3 <= 0; flag4 = 1;
			//cnt <= 0;
		end		
		
		
		
	if (flag1==1) 
		begin
			if (byteFromEth[13:12] == 1)
				begin
					data1 <= byteFromEth[11:0];
					//cnt <= cnt + 1;
					//flag1 = 0;
				end
				else 
					begin
						if (byteFromEth[13:12] == 2)
							begin
								data2 <= byteFromEth[11:0];
								//cnt <= cnt + 1;
							end
							else if (byteFromEth[13:12] == 3)
								begin
									data3 <= byteFromEth[11:0];
									//cnt <= cnt + 1;
									flag1 = 0;
								end
					end
		end
/*		cnt <= cnt + 1;
		if (cnt >= 3)
			flag1 = 0;*/



if (flag2==1) 
		begin
			if (byteFromEth[13:12] == 1)
			begin
				data4 <= byteFromEth[11:0]; 
			end
			if (byteFromEth[13:12] == 2)
			begin
				data5 <= byteFromEth[11:0]; 
			end
			if (byteFromEth[13:12] == 3)
			begin
				data6 <= byteFromEth[11:0]; flag2 = 0;
			end
end


if (flag3==1) 
		begin
		/*	if (byteFromEth[13:12] == 1)
			begin*/
				data7 <= byteFromEth[15:0]; flag3 <= 0;
			/*end
			/*if (byteFromEth[13:12] == 2)
			begin
				data7 = byteFromEth[11:0]; flag3 = 0;
			end
			if (byteFromEth[13:12] == 3)
			begin
				data7 = byteFromEth[11:0]; flag3 = 0;
			end*/
			
		end
/*
if (flag4==1) 
		begin
			if (byteFromEth[13:12] == 1)
			begin
				data4 = byteFromEth[11:0]; flag4 = 0;
			end
		end
*/			
end
endmodule

