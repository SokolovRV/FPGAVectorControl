module SignalChangeTimeOut (clk, SignalIn, 
													TimeOut);

input clk, SignalIn;
output reg TimeOut;

parameter [7:0] clkFreqIn_MHz = 40;
parameter [11:0] TimeOutIn_ms = 1;

localparam [31:0] PR = clkFreqIn_MHz * (1000 * TimeOutIn_ms);

reg [31:0] Cnt = 32'h00000000;

reg pre_strb_0 = 1'b0;

always @(posedge clk) begin
	pre_strb_0 <= SignalIn;

	if(SignalIn != pre_strb_0) begin
		Cnt <= 32'h00000000;
		TimeOut <= 1'b0;
	end
	else
		Cnt <= Cnt + 32'h00000001;
	if(Cnt == PR)
		TimeOut <= 1'b1;
	else begin end

end
endmodule

	