module TxCycleCtrl (clk, mkReady, txReady, 
											txStart);

input clk, mkReady, txReady;
output reg  txStart;

parameter [7:0] FreqInMHz = 40;
parameter [15:0] FreqOutHz = 5000;

localparam [15:0] PR = ((1000000 * FreqInMHz) / FreqOutHz) - 1;

reg [15:0] Cnt = 16'h0000;

always @(posedge clk) begin
	if(!txReady)
		txStart <= 1'b0;
	if(mkReady) begin
		if(Cnt < PR)
			Cnt <= Cnt + 16'h0001;
		else begin
			txStart <= 1'b1;
			Cnt <= 0;
		end	
	end
	else begin end
end
endmodule