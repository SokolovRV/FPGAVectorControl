module frev_div(clk_80MHz, clk_10MHz, clk_8MHz, clk_4MHz);

input clk_80MHz;

output reg clk_10MHz = 0;
output reg clk_8MHz = 0;
output reg clk_4MHz = 0;

reg[7:0] count1;
reg[7:0] count2;
reg[7:0] count3;

always@(posedge clk_80MHz)begin


	count1 = count1 + 1;
	count2 = count2 + 1;
	count3 = count3 + 1;
	
	if(count1 == 5)begin// 5 10 8 mhz
		clk_8MHz = 1;
	end
	else if(count1 == 10)begin
		clk_8MHz = 0;
		count1 = 0;	
	end
	
	if(count2 == 16)begin
		clk_4MHz = 1;
	end
	else if(count2 == 32)begin
		clk_4MHz = 0;
		count2 = 0;	
	end
	
	if(count3 == 4)begin
		clk_10MHz = 1;
	end
	else if(count3 == 8)begin
		clk_10MHz = 0;
		count3 = 0;	
	end	
	
			
end

endmodule