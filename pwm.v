module pwm (input clk, input enable, input [15:0] duty, output reg gate);

reg [15:0] base_count = 0;
reg [15:0] duty_buff = 0;

initial begin
	gate = 1;
end

always @(posedge clk) begin

	if(enable) begin
	
		if(duty > 96 && duty < 100)
			duty_buff <= 16_000;
		else
			if(duty < 4)
				duty_buff <= 0;
			else
				duty_buff <= duty * 160;
		
		if(base_count < duty_buff)
			gate <= 0;
		else
			gate <= 1;
			
		if(base_count >= 15_999)
			base_count <= 0;
		else
			base_count <= base_count + 1;
	
	end
	else begin
		gate <= 1;
		base_count <= 0;
		duty_buff <= 0;
	end

end

endmodule