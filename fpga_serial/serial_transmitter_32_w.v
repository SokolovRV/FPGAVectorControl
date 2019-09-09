
module serial_transmitter_32_w (clk, byte_in, start, reset, tx, ready);

input 		clk, start, reset;
input [7:0] byte_in;

output reg  tx, ready;

localparam [3:0] IDLE = 4'b0000;
localparam [3:0] ST_0 = 4'b0001;
localparam [3:0] ST_1 = 4'b0010;
localparam [3:0] ST_2 = 4'b0011;
localparam [3:0] ST_3 = 4'b0100;
localparam [3:0] ST_4 = 4'b0101;
localparam [3:0] ST_5 = 4'b0110;
localparam [3:0] ST_6 = 4'b0111;
localparam [3:0] ST_7 = 4'b1000;
localparam [3:0] STOP = 4'b1001;

reg [3:0] state     = 4'b0000;
reg [7:0] byte_bf   = 8'h00;

reg pre_strb 	  = 1'b0;

always @(posedge clk) begin
	pre_strb <= start;
	
	if(reset) begin
		state <= IDLE;
		tx <= 1'b1;
		ready <= 1'b1;
	end
	else begin
		case(state)
			IDLE: begin
				if(start && !pre_strb) begin
					tx <= 1'b0;	
					state <= ST_0;
					byte_bf <= byte_in;
					ready <= 1'b0;
				end
				else begin
					tx <= 1'b1;
					ready <= 1'b1;
				end
			end
			ST_0: begin tx <= byte_bf[0]; state <= ST_1; end
			ST_1: begin tx <= byte_bf[1]; state <= ST_2; end
			ST_2: begin tx <= byte_bf[2]; state <= ST_3; end
			ST_3: begin tx <= byte_bf[3]; state <= ST_4; end
			ST_4: begin tx <= byte_bf[4]; state <= ST_5; end
			ST_5: begin tx <= byte_bf[5]; state <= ST_6; end
			ST_6: begin tx <= byte_bf[6]; state <= ST_7; end
			ST_7: begin tx <= byte_bf[7]; state <= STOP; ready <= 1'b1; end
			STOP: begin tx <= 1'b1; state <= IDLE;  end
			default: begin 
				tx <= 1'b0;
				ready <= 1'b0;
				state <= IDLE;  
			end
		endcase
	end
end
endmodule