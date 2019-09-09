module SystemCtrlModule (clk, mainEnable, algorithmRun, mkTimeOut, panelTimeOut, encoder, ADC0, ADC1, ADC2, driverErr, reset,
										algorithmEnable, SVMEnable, ADCErr, IGBTErr);

input clk, mainEnable, algorithmRun, mkTimeOut, panelTimeOut, reset;
input [3:0] driverErr;
input [15:0] encoder, ADC0, ADC1, ADC2;

output reg algorithmEnable, SVMEnable;
output reg [2:0] ADCErr;
output reg [3:0] IGBTErr;

parameter [15:0] ADC0_high_limit = 2800;
parameter [15:0] ADC0_low_limit = 1300;
parameter [15:0] ADC1_high_limit = 2800;
parameter [15:0] ADC1_low_limit = 1300;
parameter [15:0] ADC2_high_limit = 3250;
parameter [15:0] ADC2_low_limit = 850;

reg ErrFlag    = 1'b0;
reg pre_strb_0 = 1'b0;

always @(posedge clk) begin

	pre_strb_0 <= mainEnable;
	if(mainEnable && !pre_strb_0 && !ErrFlag && !encoder && !reset)
		algorithmEnable <= 1'b1;
	else begin end
	
	if(!mainEnable || ErrFlag) begin 
		algorithmEnable <= 1'b0;
		SVMEnable <= 1'b0;
	end
	else begin end
	
	if(algorithmEnable && algorithmRun)
		SVMEnable <= 1'b1;
	else begin end
	
	if(mkTimeOut || panelTimeOut) begin
		ErrFlag <= 1'b1;
		SVMEnable <= 1'b0;
	end
	else begin end
	
	if(driverErr!=4'hF && !ErrFlag) begin
		ErrFlag <= 1'b1;
		SVMEnable <= 1'b0;
		IGBTErr <= driverErr;
	end
	else begin end
	
	if( ((ADC0 > ADC0_high_limit) || (ADC0 < ADC0_low_limit)) && !ErrFlag ) begin
		ErrFlag <= 1'b1;
		SVMEnable <= 1'b0;
		ADCErr[0] <= 1'b1;
	end
	else begin end
	
	if( ((ADC1 > ADC1_high_limit) || (ADC1 < ADC1_low_limit)) && !ErrFlag ) begin
		ErrFlag <= 1'b1;
		SVMEnable <= 1'b0;
		ADCErr[1] <= 1'b1;
	end
	else begin end
	
	if( ((ADC2 > ADC2_high_limit) || (ADC2 < ADC2_low_limit)) && !ErrFlag ) begin
		ErrFlag <= 1'b1;
		SVMEnable <= 1'b0;
		ADCErr[2] <= 1'b1;
	end
	else begin end
	
	if(reset) begin
		IGBTErr <= 4'hF;
		ADCErr <= 3'b000;
		SVMEnable <= 1'b0;
		algorithmEnable <= 1'b0;
		ErrFlag <= 1'b0;
	end
	else begin end
	
end
endmodule
