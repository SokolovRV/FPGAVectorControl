module define_vector (input clk,
					  input synchr_clk,
					  input [3:0] number_sector,
					  input [13:0] T1,
					  input [13:0] T2,
					  input [13:0] T0,
					  input [15:0] pwm_triangle,
					  input enable,
					  input change,
					  input broke_phase,
						output reg [2:0] vector,
						output reg K1_A_H,
						output reg K2_A_L,
						output reg K3_B_H,
						output reg K4_B_L,
						output reg K5_C_H,
						output reg K6_C_L);


reg [13:0] t1;
reg [13:0] t2;
reg [13:0] t0;
reg [13:0] T1_pwm;
reg [13:0] T2_pwm;
reg [13:0] T3_pwm;
reg [3:0] sector;
reg [2:0] v1;
reg [2:0] v2;
reg [2:0] v3;
					
initial begin
	vector = 3'b000;
	t1 = 0;
	t2 = 0;
	t0 = 0;
	T1_pwm = 0;
	T2_pwm = 0;
	T3_pwm = 0;
	sector = 0;
	v1 = 3'b000;
	v2 = 3'b000;
	v3 = 3'b000;
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
	if(change == 1) begin
	if(T1 == 0 || T2 == 0) begin
		case(number_sector)		
		1: sector <= 2;
		2: sector <= 1;
		3: sector <= 4;
		4: sector <= 3;
		5: sector <= 6;
		6: sector <= 5;
		7: sector <= 8;
		8: sector <= 7;
		9: sector <= 10; 
		10: sector <= 9;
		11: sector <= 12;
		12: sector <= 11;
	endcase
	end
	else sector <= number_sector;
	end
	else sector <= number_sector;
end

always @(posedge clk) begin

	case(sector)		
		1:  begin T1_pwm <= t1; T2_pwm <= t2; T3_pwm <= t0; v1 <= 3'b100; v2 <= 3'b110; v3 <= 3'b111; end
		2:  begin T1_pwm <= t2; T2_pwm <= t1; T3_pwm <= t0; v1 <= 3'b110; v2 <= 3'b100; v3 <= 3'b000; end
		3:  begin T1_pwm <= t1; T2_pwm <= t2; T3_pwm <= t0; v1 <= 3'b110; v2 <= 3'b010; v3 <= 3'b000; end
		4:  begin T1_pwm <= t2; T2_pwm <= t1; T3_pwm <= t0; v1 <= 3'b010; v2 <= 3'b110; v3 <= 3'b111; end
		5:  begin T1_pwm <= t1; T2_pwm <= t2; T3_pwm <= t0; v1 <= 3'b010; v2 <= 3'b011; v3 <= 3'b111; end
		6:  begin T1_pwm <= t2; T2_pwm <= t1; T3_pwm <= t0; v1 <= 3'b011; v2 <= 3'b010; v3 <= 3'b000; end
		7:  begin T1_pwm <= t1; T2_pwm <= t2; T3_pwm <= t0; v1 <= 3'b011; v2 <= 3'b001; v3 <= 3'b000; end
		8:  begin T1_pwm <= t2; T2_pwm <= t1; T3_pwm <= t0; v1 <= 3'b001; v2 <= 3'b011; v3 <= 3'b111; end
		9:  begin T1_pwm <= t1; T2_pwm <= t2; T3_pwm <= t0; v1 <= 3'b001; v2 <= 3'b101; v3 <= 3'b111; end
		10: begin T1_pwm <= t2; T2_pwm <= t1; T3_pwm <= t0; v1 <= 3'b101; v2 <= 3'b001; v3 <= 3'b000; end
		11: begin T1_pwm <= t1; T2_pwm <= t2; T3_pwm <= t0; v1 <= 3'b101; v2 <= 3'b100; v3 <= 3'b000; end
		12: begin T1_pwm <= t2; T2_pwm <= t1; T3_pwm <= t0; v1 <= 3'b100; v2 <= 3'b101; v3 <= 3'b111; end
	endcase
	
if(sector > 0 && enable && !(t1 <= 0 && t2 <= 0)) begin
	
	if(pwm_triangle <= T1_pwm && pwm_triangle >= 0 && T1_pwm) vector <= v1;
	else
		if(pwm_triangle <= (T2_pwm + T1_pwm) && pwm_triangle > T1_pwm && T2_pwm > 0) vector <= v2;
		else
			if(pwm_triangle > (T1_pwm+T2_pwm) && T3_pwm > 0) vector <= v3;

				
if(broke_phase) begin
K1_A_H <= 1;
K2_A_L <= 1;
K3_B_H <= ~vector[1];
K4_B_L <= vector[1];
K5_C_H <= ~vector[0];
K6_C_L <= vector[0];
end
else begin
K1_A_H <= ~vector[2];
K2_A_L <= vector[2];
K3_B_H <= ~vector[1];
K4_B_L <= vector[1];
K5_C_H <= ~vector[0];
K6_C_L <= vector[0];
end

end
else begin 
	vector <= 3'b000;
	K1_A_H <= 1;
	K2_A_L <= 1;
	K3_B_H <= 1;
	K4_B_L <= 1;
	K5_C_H <= 1;
	K6_C_L <= 1;
end


 
end
endmodule