module define_vector (input clk,
					  input synchr_clk,
					  input [3:0] number_sector,
					  input [13:0] T1,
					  input [13:0] T2,
					  input [13:0] T0,
					  input [15:0] pwm_triangle,
					  input enable,
						output reg [2:0] vector,
						output reg K1_A_H,
						output reg K2_A_L,
						output reg K3_B_H,
						output reg K4_B_L,
						output reg K5_C_H,
						output reg K6_C_L );


reg [13:0] t1;
reg [13:0] t2;
reg [13:0] t0;
reg [3:0] sector;
reg [2:0] v1;
reg [2:0] v2;
					
initial begin
	vector = 3'b000;
	t1 = 0;
	t2 = 0;
	t0 = 0;
	sector = 0;
	v1 = 3'b000;
	v2 = 3'b000;
	K1_A_H <= 0;
	K2_A_L <= 0;
	K3_B_H <= 0;
	K4_B_L <= 0;
	K5_C_H <= 0;
	K6_C_L <= 0;
end

always @(posedge synchr_clk) begin
	t1 <= T1;
	t2 <= T2;
	t0 <= T0;
	sector <= number_sector;
end

always @(posedge clk) begin
	
	case(sector)
		1: begin v1 <= 3'b100; v2 <= 3'b110; end
		2: begin v2 <= 3'b110; v1 <= 3'b010; end
		3: begin v1 <= 3'b010; v2 <= 3'b011; end
		4: begin v2 <= 3'b011; v1 <= 3'b001; end
		5: begin v1 <= 3'b001; v2 <= 3'b101; end
		6: begin v2 <= 3'b101; v1 <= 3'b100; end
	endcase
if(sector > 0 && enable) begin	
	if(pwm_triangle <= t0 && pwm_triangle >= 0 && t0 > 0) vector <= 3'b000;
	else 
		if(pwm_triangle <= (t1+t0) && pwm_triangle > t0 && t1 > 0) vector <= v1;
		else 
			if(pwm_triangle <= (8000-t0) && pwm_triangle > (t1+t0) && t2 > 0) vector <= v2;
			else 
				if(pwm_triangle <= 8000 && pwm_triangle > (8000-t0) && t0 > 0) vector <= 3'b111;
				else begin end
				
K1_A_H <= vector[2];
K2_A_L <= ~vector[2];
K3_B_H <= vector[1];
K4_B_L <= ~vector[1];
K5_C_H <= vector[0];
K6_C_L <= ~vector[0];

end
else begin 
	vector <= 3'b000;
	K1_A_H <= 0;
	K2_A_L <= 0;
	K3_B_H <= 0;
	K4_B_L <= 0;
	K5_C_H <= 0;
	K6_C_L <= 0;
end


 
end
endmodule