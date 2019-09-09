/*Sokolov R.V.*/
/* version: 1.0 */


module calculate_speed (input clk, 
						input s00, 
						input s90,
						input [24:0] div_result,
						input div_ready,
							output reg div_start,
							output reg [24:0] num,
							output reg [23:0] denum,
							output reg signed [15:0] speed,
							output reg update );
							
reg old_s00;
reg [24:0] count;
reg flag_stop;
reg [23:0] base_speed;
reg [7:0] impulse_count;
reg [7:0] accuracy;
reg wait_flag;
reg [24:0] base_div_result;
reg [24:0] base_num;
reg sign;
reg [7:0] delay_count;
reg old_ready;
reg start_delay;

initial begin
	div_start = 0;
	num = 960_000;
	denum = 0;
	speed = 0;
	update = 0;
	old_s00 = 0;
	count = 0;
	flag_stop = 0;
	impulse_count = 1;
	accuracy = 1;
	wait_flag = 1;
	base_num = 0;
	base_div_result = 0;
	sign = 0;
	delay_count = 0;
	old_ready = 0;
	start_delay = 0;
end


always @(posedge clk) begin

	if(flag_stop) begin
		denum <= count;
		count <= 0;
		div_start <= 1;
		update <= 0;
	end
	else begin 
		count <= count + 1;
		div_start <= 0;
		if (count > 960_000) begin
			wait_flag <= 1;
		end
		else begin end
	end


	if(!old_s00 && s00) begin
		wait_flag <= 0;
		sign <= s90;
		if(impulse_count >= accuracy) begin
			flag_stop <= 1;
			impulse_count <= 1;
		end
		else impulse_count <= impulse_count + 1;
	end
	else 
	begin
		flag_stop <= 0;
	end
	
	
	
	
	if(base_div_result <= 800) begin
		accuracy <= 1;
		num <= 960_000;
	end
	else if(base_div_result <= 1600) begin
		accuracy <= 3;
		num <= 2_880_000;
	end
	else if(base_div_result <= 2400) begin
		accuracy <= 7;
		num <= 6_720_000;
	end
	else if(base_div_result <= 3200) begin
		accuracy <= 12;
		num <= 11_520_000;
	end
	else begin
		accuracy <= 18;
		num <= 17_280_000;
	end

	
	if((div_ready && !old_ready) && div_result >= 0 && div_result <= 4000 && !wait_flag) begin
		base_div_result = div_result;
		start_delay <= 1;
		if(sign)
			speed <= div_result * (-1);
		else
			speed <= div_result;
	end
	else begin end
	
	if(start_delay) begin
		if(delay_count >= 150) begin
			update <= 1;
			delay_count <= 0;
			start_delay <= 0;
		end
		else delay_count <= delay_count + 1;
	end
	else begin
	end
	
	if(wait_flag) begin
			div_start <= 0;
			num <= 960_000;
			denum <= 0;
			speed <= 0;
			update <= 0;
			count <= 0;
			flag_stop <= 0;
			impulse_count <= 1;
			accuracy <= 1;
			base_num <= 0;
			base_div_result = 0;
			delay_count <= 0;
			start_delay <= 0;
	end
	else begin end
	
	old_ready <= div_ready;
	old_s00 <= s00;
end
endmodule