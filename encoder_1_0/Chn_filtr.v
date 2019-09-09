module Chn_filtr (input Chn_in, input clk, output reg Chn_out=0);

reg [7:0] cnt_u=0, cnt_d=0, filtr_const = 80;
initial 
begin
	Chn_out=0;
	cnt_u=0;
	cnt_d=0;
	filtr_const = 80;
end

always @ (negedge clk) 
begin
	if (Chn_in > 0) 	
		begin cnt_u = cnt_u + 1; cnt_d = 0; end
	else 			
		begin cnt_d = cnt_d + 1; cnt_u = 0; end	
	if (cnt_u > filtr_const) 		
		begin cnt_u = filtr_const; Chn_out = 1; end
	else if (cnt_d > filtr_const) 	
		begin cnt_d = filtr_const; Chn_out = 0; end
end
endmodule