/*Designed by: Minor A. S.
	sclk - 214
	mosi - 218
	ss - 203
	synth - 185
	
	80 mhz
	
*/
module Master_spi_v7_10ch(clk, MISO, Enable, DATAIN1, DATAIN2, DATAIN3, DATAIN4, DATAIN5, DATAIN6, DATAIN7, start_eth_fl, SCK, SS, MOSI, DATAOUT, digitallFq, measure_start);
input clk;
input MISO;
input Enable;
input start_eth_fl;
input [15:0] DATAIN1;
input [15:0] DATAIN2;
input [15:0] DATAIN3;
input [15:0] DATAIN4;
input [15:0] DATAIN5;
input [15:0] DATAIN6;
input [15:0] DATAIN7;
//input [15:0] DATAIN8;
//input [15:0] DATAIN9;
//input [15:0] DATAIN10;


output reg SCK = 0;
output reg SS = 1;
output reg MOSI = 0;
output reg [15:0] DATAOUT = 0;
output reg [15:0] digitallFq = 0;
output reg measure_start = 0;

reg [20:0] count = 0;
reg [15:0] digitallfq = 0;
reg [15:0] countSCK = 0;
reg [7:0] countdatao = 0;
reg [7:0] countdatai = 0;
reg [15:0] data = 0;
reg [15:0] measure1 = 0;
reg [15:0] measure2 = 0;
reg [15:0] measure3 = 0;
reg [15:0] measure4 = 0;
reg [15:0] measure5 = 0;
reg [15:0] measure6 = 0;
reg [15:0] measure7 = 0;
//reg [15:0] measure8 = 0;
//reg [15:0] measure9 = 0;
//reg [15:0] measure10 = 0;

reg [15:0] datain = 0;
reg flag_d = 0;
reg flagSCK = 0;
reg flag = 0;
reg [7:0] flagdata = 0;
reg sign = 0;
reg start = 0;
reg startend = 1;
reg digitallflag = 0;
reg [15:0] triangle = 0;

initial begin 
	flag = 1;
	flagdata = 0;
	measure_start = 0;
	startend = 1;
	start = 0;
	SS = 1;
end

always @(posedge clk) begin
	
	if(start_eth_fl == 0) begin 
		start = 0; startend = 1; flagdata = 0;
		SS = 1; count = 0; countdatao = 0; SCK = 0; flagSCK = 0; MOSI = 0; countSCK = 0; countdatai = 0; 
	end
	if(Enable == 0) measure_start <= 0;

//	if(flag == 0) start = 0;
	if((Enable == 1)&(startend == 1)&(start_eth_fl == 1)) begin
		measure1 = DATAIN1;
		measure2 = DATAIN2;
		measure3 = DATAIN3;
		measure4 = DATAIN4;
//		measure5 = DATAIN5;
//		measure6 = DATAIN6;
//		measure7 = DATAIN7;
//		measure8 = DATAIN8;
//		measure9 = DATAIN9;
//		measure10 = DATAIN10;
		startend = 0;
		measure_start <= 1;
		digitallflag = 0;
		digitallFq = digitallfq;
	end
	
	if(digitallflag == 1) digitallfq = digitallfq + 1;
	else digitallfq = 0;
	
	if((startend == 0)&(start==0)&(start_eth_fl == 1)) begin
		if(flagdata == 0) begin
			digitallflag = 1;
//			measure1[15:12] = 0;
//			data = ((measure1-2050-19)*3806)/8192;
			data = measure1;
			flagdata = 1;
		end
		else if(flagdata == 1) begin 
			//measure2[15:12] = 0;
			//data= ((measure2-2050-5)*3828)/8192;
			data = measure2;
			flagdata = 2;
		end
		else if(flagdata == 2) begin		
			//data = ((measure3-2050-16)*3810)/8192;
			data = measure3;
			flagdata = 3;
		end
//		else if(flagdata == 3) begin
//			data = measure4;
//			flagdata = 4;
//		end		
//		else if(flagdata == 4) begin		
//			data = ((measure5-2050+1)*2015)/8192;
////			data = 500;
//			flagdata = 5;
//		end
//		else if(flagdata == 5) begin		
//			data = ((measure6-2050-6)*2015)/8192;
////			data = 600;
//			flagdata = 6;
//		end
//		else if(flagdata == 6) begin		
////			data = measure7;
//			data = 0;
//			flagdata = 7;
//		end
//		else if(flagdata == 7) begin		
////			data = measure8;
//			data = 0;
//			flagdata = 8;
//		end		
//		else if(flagdata == 8) begin		
//			//data = measure9;
//			data = measure4;
//			flagdata = 4;
//		end
		else if(flagdata == 3) begin 
//			measure4[15:12] = 0;
//			data = ((measure7-2050-5)*3828)/8192;
			data = measure4;
			flagdata = 0;
			startend = 1;
		end
		start = 1;
	end
	
//	if(start == 1) flag = 0;
	
	if(start == 1) begin
		count = count + 1;
		if(count == 16) begin
			SS = 0;
	//		data = DATAIN;
		end
		
		if(SS == 0) begin
			if(countSCK == 15) begin flag_d = 1; countSCK = 0; end
			
			if((countSCK == 2)&&(flag_d == 1)) begin
				if(SCK == 0) begin 
					flagSCK = 1;  MOSI = data[15-countdatao]; countdatao = countdatao + 1; //data[15-countdatao]
					if(countdatao <= 16) SCK = 1;
				end
				else begin SCK = 0; end
				countSCK = 0;
			end
			if((SCK == 0) && (flagSCK == 1) && (countSCK == 1)) begin
				datain[15-countdatai] = MISO; countdatai = countdatai + 1;
			end
			countSCK = countSCK + 1;
			
			if(countdatao == 18) begin
				SS = 1; count = 0; countdatao = 0; SCK = 0; flagSCK = 0; MOSI = 0; countSCK = 0; countdatai = 0;
//				flag_d = 0;
				start = 0;
				DATAOUT[15:0] <= datain[15:0];
				datain = 0;
//				flag = 1;
	//			data <= data + 2;
			end
		end
	end
	
end

endmodule