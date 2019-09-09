/* amplitude us from 0 to 8000 --> 0 to 1*/
/* phase from 0 to 5760 --> 0 to 360 deg  (*16) */
/* synchr_clk - clk from pwm_triangle */

module sector_define ( input clk, 
					   input synchr_clk, 
					   input [15:0] amplitude, 
					   input [15:0] phase, 
						 output reg [9:0] sin_t1,
						 output reg [9:0] sin_t2,
						 output reg [15:0] vector_amplitude,
						 output reg [3:0] number_sector );
						 
reg [15:0] phase_buff;
reg [15:0] sector_deg;
						 
initial begin
	sin_t1 = 0;
	sin_t2 = 0;
	vector_amplitude = 0;
	number_sector = 0;
	phase_buff = 0;
	sector_deg = 0;
end

always @(negedge synchr_clk) begin
	vector_amplitude <= amplitude;
	phase_buff <= phase;
end

always @(posedge clk) begin

	if(phase_buff >= 0 && phase_buff < 960) begin 	/* 60 deg * 16 = 960 */
		sin_t2 <= phase_buff;
		number_sector <= 1;
	end
	else if(phase_buff >= 960 && phase_buff < 1920) begin
			sin_t2 <= phase_buff - 960;
			number_sector <= 2;
		 end
		 else if(phase_buff >= 1920 && phase_buff < 2880) begin
				sin_t2 <= phase_buff - 1920;
				number_sector <= 3;
			  end
			  else if(phase_buff >= 2880 && phase_buff < 3840) begin
					sin_t2 <= phase_buff - 2880;
					number_sector <= 4;
				   end
				   else if(phase_buff >= 3840 && phase_buff < 4800) begin
							sin_t2 <= phase_buff - 3840;
							number_sector <= 5;
					    end
					    else if(phase_buff >= 4800 && phase_buff < 5760) begin
								sin_t2 <= phase_buff - 4800;
								number_sector <= 6;
							 end
							 
	sin_t1 <= 960 - sin_t2;


end
endmodule
	