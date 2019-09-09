module adc (input clk_80_mhz, 
			input data, 
			input sclk_in,			
			output reg cs, 
			output reg sclk, 
			output reg [15:0] adc_value,
			output reg test_data,
			output reg test_sclk);
			
reg [11:0] freq_count;
reg [11:0] adc_data;
reg [6:0] n_bit;
reg data_buff1_into;
reg data_buff2;
reg [8:0] cnt_u1, cnt_d1, filtr_const1;
reg [8:0] cnt_u3, cnt_d3, filtr_const3;
reg sclk_out;
reg data_filtered;
reg old_sclk;

initial begin
	freq_count = 0;
	cs = 1;
	sclk = 1;
	adc_value = 0;
	n_bit = 1;
	data_buff1_into = 0;
	data_buff2 = 0;
	cnt_u1 = 0;
	cnt_u3 = 0;
	cnt_d1 = 0;
	cnt_d3 = 0;
	filtr_const1 = 200;
	filtr_const3 = 210;
	adc_data = 0;
	sclk_out = 1;
	data_filtered = 0;
	old_sclk = 1;	
end

always @(posedge clk_80_mhz) data_buff1_into <= data;

always @(posedge clk_80_mhz) begin

	data_buff2 <= data_buff1_into;

	test_data<=data_filtered;
	test_sclk<=sclk_out;
	
	if (data_buff2 > 0) 	
		begin cnt_u1 = cnt_u1 + 1; cnt_d1 = 0; end
	else 			
		begin cnt_d1 = cnt_d1 + 1; cnt_u1 = 0; end	
	if (cnt_u1 > filtr_const1) 		
		begin cnt_u1 = filtr_const1; data_filtered <= 1; end
	else if (cnt_d1 > filtr_const1) 	
		begin cnt_d1 = filtr_const1; data_filtered <= 0; end


	if (sclk_in > 0) 	
		begin cnt_u3 = cnt_u3 + 1; cnt_d3 = 0; end
	else 			
		begin cnt_d3 = cnt_d3 + 1; cnt_u3 = 0; end	
	if (cnt_u3 > filtr_const3) 		
		begin cnt_u3 = filtr_const3; sclk_out <= 1; end
	else if (cnt_d3 > filtr_const3) 	
		begin cnt_d3 = filtr_const3; sclk_out <= 0; end
		
	if(old_sclk == 0 && sclk_out == 1) begin
		if(n_bit > 9 && n_bit < 33)
			adc_data[11-(((n_bit-10)>>1))] <= data_filtered;
		if(n_bit == 34)
			adc_value <= adc_data;
	end
	else begin end
		
	if(freq_count >= 460) begin
		
		if(n_bit >= 34)
			n_bit = 1;
		else
			n_bit = n_bit + 1;
		
		if(n_bit > 2 && n_bit < 34)
			sclk <= ~sclk;
		else
			sclk <= 1;
	
		if(n_bit == 1)
			cs <= 1;
		else
			cs <= 0;
	
		freq_count <= 0;		
		end
		else
			freq_count <= freq_count + 1;
	
	old_sclk <= sclk_out;
		
end

endmodule
