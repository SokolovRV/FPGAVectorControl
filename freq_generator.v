module freq_generator (input clk_40_mhz,
					   input enable,
					   input signed [15:0] input_freq,
					   input [15:0] shift_deg, 
							output reg [15:0] phase,
							output reg [15:0] phase_shift);

reg [16:0] count;
reg signed [15:0] freq;
reg signed [15:0] freq_0;
reg [15:0] phase_inc;
reg [15:0] mod_freq;
reg [15:0] mult_shift;
reg [15:0] shift;

initial begin
	count = 0;
	freq = 0;
	phase_inc = 0;
	mod_freq = 0;
	phase_shift = 0;
	mult_shift = 0;
	shift = 0;
	freq_0 = 0;
end

always @(posedge clk_40_mhz) begin

if(enable && input_freq != 0) begin
		
	if(input_freq >= -500 && input_freq <= 500)
		if(input_freq < 0) freq <= input_freq * (-1);
		else freq <= input_freq;

	if(freq < 10)
		freq <= 10;
	
	mult_shift <= shift_deg * 16;
	
	if(count <= (69440/freq)) begin
		count <= count + 1;
	end
	else begin
	
		count <= 0;
		
		if(input_freq > 0) begin
			if(phase_inc < 5759) phase_inc <= phase_inc + 1;
			else phase_inc <= 0;
		end
		else begin
			if(phase_inc > 0) phase_inc <= phase_inc - 1;
			else phase_inc <= 5759;
		end

	end
	
	
	shift <= phase_inc + mult_shift;
	
	if(shift > 5759) phase_shift <= shift - 5760;
	else phase_shift <= shift;
	
	phase <= phase_inc;
	
end
else begin 
count <= 0;
phase <= 0;
phase_shift <= 0;
phase_inc <= 0;
shift <= 0;
mult_shift <= 0;
end	
end
endmodule