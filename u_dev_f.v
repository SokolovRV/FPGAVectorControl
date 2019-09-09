module u_dev_f (input clk_40_mhz, input enable, input direction, input [15:0]input_freq, output reg [15:0] amplitude, output reg signed [15:0] phase);

reg [23:0] base_count;
reg [23:0] max_count;
reg signed [15:0] freq;
reg signed [15:0] mod_freq;
reg signed [15:0] mod_freq_last;
reg signed [15:0] freq_out;
reg clk1;
reg [15:0] us;

initial begin
	base_count = 0;
	phase = 0;
	amplitude = 0;
	clk1 = 0;
	freq_out = 0;
	freq = 0;
	us = 0;
	max_count = 800_000;
end

always @(posedge clk_40_mhz) if(base_count < max_count) begin base_count <= base_count + 1; clk1 <= 0;end 
												 else begin base_count <= 0; clk1 <= 1; end
always @(posedge clk1) begin
	
	if(enable)
	
	if(direction) freq <= input_freq * (-10);
	else freq <= input_freq * 10;
	else freq <= 0;

	if(freq_out < freq) freq_out <= freq_out + 1;
	else if(freq_out > freq) freq_out <= freq_out - 1;
		else freq_out <= freq; 
	
	if(freq_out < 0) mod_freq <= freq_out * (-1);
	else mod_freq <= freq_out;	
	
	if(mod_freq < 20 || !enable) us <= 0;
	else us <= 1000 + (mod_freq * 14);
	
	if(mod_freq < mod_freq_last) max_count <= 2_400_000;
	else max_count <= 800_000;
	
	amplitude <= us;
	phase <= freq_out;
	
	mod_freq_last <= mod_freq;

end
endmodule
	