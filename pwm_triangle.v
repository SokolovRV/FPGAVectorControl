/* 5 kHz for 40 Mhz clk */

module pwm_triangle (input clk,
					 input enable,
					 output reg new_cycle,
					 output reg data_capture,
					 output reg [15:0] triangle_count);
					 
reg [15:0] base_count;
reg flag_down;
					 
initial begin
	new_cycle = 0;
	triangle_count = 0;
	base_count = 0;
	flag_down = 0;
	data_capture = 0;
end

always @(posedge clk) begin
	
	if(enable) begin
	
		if(base_count >= 7999)
			flag_down <= 1;

		
		if(base_count <= 1) begin
			flag_down <= 0;
			new_cycle <= 1;
		end
		else
			new_cycle <= 0;
			
		if(flag_down)
			base_count <= base_count - 1;
		else
			base_count <= base_count + 1;
			
		if(flag_down && base_count < 100)
			data_capture <= 1;
		else 
			data_capture <= 0;
			
		triangle_count <= base_count;
	end
	else begin
		new_cycle <= 0;
		triangle_count <=0;
		flag_down <= 0;
		base_count <= 0;
	end

end
endmodule
