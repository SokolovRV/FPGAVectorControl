/* amplitude us from 0 to 8000 --> 0 to 1*/
/* phase from 0 to 5760 --> 0 to 360 deg  (*16) */
/* synchr_clk - clk from pwm_triangle */

module define_vectors_time ( input clk, 
					   input synchr_clk,
					   input enable, 
					   input [15:0] amplitude, 
					   input [15:0] phase,
					   input [15:0] sin_u1,
					   input [15:0] sin_u2, 
						output reg [9:0] sin_t1,
						output reg [9:0] sin_t2,
						output reg [3:0] number_sector,
						output reg [13:0] T1,
						output reg [13:0] T2,
						output reg [13:0] T0);
						 
reg [31:0] vector_amplitude;
reg [15:0] t1_base;
reg [15:0] t2_base;		
reg [15:0] t0_base;	
reg [15:0] t1;
reg [15:0] t2;		
reg [15:0] t0;						 
reg [15:0] phase_buff;
reg [2:0] duty_count;
reg old_synchr; 
						 
initial begin
	sin_t1 = 0;
	sin_t2 = 0;
	vector_amplitude = 0;
	number_sector = 0;
	phase_buff = 0;
	T1 = 0;
	T2 = 0;
	T0 = 0;
	t1_base = 0;
	t2_base = 0;
	t0_base = 0;
	t1 = 0;
	t2 = 0;
	t0 = 0;
	duty_count = 0;
	old_synchr = 0;
end

always @(posedge synchr_clk) begin
	if(amplitude >= 0 && amplitude <= 8000)
		vector_amplitude <= amplitude;
	else begin end
	if(phase >=0 && phase < 5760)
		phase_buff <= phase;
	else begin end	
end

always @(posedge clk) begin

if(old_synchr == 1 && synchr_clk == 0 && duty_count < 3)
	duty_count <= duty_count + 1;
else begin end

old_synchr <= synchr_clk;

if(enable == 0)
	duty_count <= 0;
else begin end
	
if(enable && duty_count >= 1) begin
	if(phase_buff >= 0 && phase_buff < 960) begin 	/* 60 deg * 16 = 960 */
		sin_t2 <= phase_buff;
		if(sin_t2 < 480) number_sector <= 1; else number_sector <= 2 ;
	end
	else if(phase_buff >= 960 && phase_buff < 1920) begin
			sin_t2 <= phase_buff - 960;
			if(sin_t2 < 480) number_sector <=3; else number_sector <= 4 ;
		 end
		 else if(phase_buff >= 1920 && phase_buff < 2880) begin
				sin_t2 <= phase_buff - 1920;
				if(sin_t2 < 480) number_sector <= 5; else number_sector <= 6 ;
			  end
			  else if(phase_buff >= 2880 && phase_buff < 3840) begin
					sin_t2 <= phase_buff - 2880;
					if(sin_t2 < 480) number_sector <= 7; else number_sector <= 8 ;
				   end
				   else if(phase_buff >= 3840 && phase_buff < 4800) begin
							sin_t2 <= phase_buff - 3840;
							if(sin_t2 < 480) number_sector <= 9; else number_sector <= 10 ;
					    end
					    else if(phase_buff >= 4800 && phase_buff < 5760) begin
								sin_t2 <= phase_buff - 4800;
								if(sin_t2 < 480) number_sector <= 11; else number_sector <= 12 ;
							 end
	sin_t1 <= 960 - sin_t2;
	
	t1_base <= (vector_amplitude * sin_u1) >> 15;
	t2_base <= (vector_amplitude * sin_u2) >> 15;
	t0_base <= 8000 - t1_base - t2_base;	
	

	if(t1_base < 100 && t2_base < 100) begin
		t1 <= 0;
		t2 <= 0;
		t0 <= 8000;
	end
	else if(t0_base < 100) begin
		t1 <= t1_base + (t0_base >> 1);
		t2 <= t2_base + (t0_base >> 1);
		t0 <= 0;
	end
	else if(t1_base < 100) begin
			t2 <= t2_base + (t1_base >> 1);
			t0 <= t0_base + (t1_base >> 1);
			t1 <= 0;
	end
	else if(t2_base < 100) begin
			t1 <= t1_base + (t2_base >> 1);
			t0 <= t0_base + (t2_base >> 1);
			t2 <= 0;
	end
	else begin
		t1 <= t1_base;
		t2 <= t2_base;
		t0 <= t0_base;
	end
	T0 <= t0;
	T1 <= t1;
	T2 <= t2;

end
else begin
	T1 <= 0;
	T2 <= 0;
	T0 <= 0;
	number_sector <= 0;
	sin_t1 <= 0;
	sin_t2 <= 0;
end

end
endmodule
	