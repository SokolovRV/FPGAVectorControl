module SPI_ADC (input clk, input miso, input measure_start, output reg sck = 1, output reg cs = 1, output reg [15:0] data_out = 0, output reg enable = 0);

reg [15:0] count = 0;
reg [5:0] countsck = 0;
reg [5:0] countdatai = 0;
reg [5:0] i = 0;
reg [15:0] datain = 0;
reg flag_d = 0;
reg flagsck = 0;
reg flag = 1;

initial flag = 1;

always @ (posedge clk) 
begin	
	if(measure_start == 1) begin flag = 1; /*enable = 0;*/ end	
	if(flag == 1) 
		begin
			count = count + 1;		
			if (count == 100)
				begin
					cs = 0;
					sck = 1;
					enable = 0;
				end		
			if(cs == 0) 
				begin
					if ((countsck == 4) && (flag_d == 0)) 
						begin 
							flag_d = 1; 
							countsck = 0; 
							sck = 0;
							i = i + 1;
						end			
					if ((countsck == 4) && (flag_d == 1)) 
						begin
							if(sck == 0) 
								begin
									sck = 1; 
									flagsck = 1;
								end
								else 
									begin
										if (i < 16) sck = 0;
										i = i + 1;
									end
								countsck = 0;
						end
					if ((sck == 0) && (flagsck == 1) && (i > 4) && (i < 17) && (countsck == 1)) 
						begin
							datain[11 - countdatai] = miso; 
							countdatai = countdatai + 1;
							flagsck = 0;
						end
					countsck = countsck + 1;			
					if (i == 17) 
						begin
							cs = 1; 
							count = 0; 
							sck = 1; 
							flagsck = 0; 
							countsck = 0; 
							countdatai = 0;
							flag_d = 0;
							data_out[15:0] <= datain[15:0];
							enable = 1;
							datain = 0;
							i = 0;
							flag = 0;
						end
				end
		end
end
endmodule