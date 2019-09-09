
module crc_16_rtu_rx_32_w (
				   	  input 	     clk,
				   	  input 	     start,
				   	  input [7:0] byte_in,
				   	  input       reset,
				   	  						     output reg [15:0] crc_16,
				   	  						     output reg        busy
																			);

localparam [15:0] polinom          = 16'hA001;

localparam [3:0]  IDLE             =  4'b0000;
localparam [3:0]  STAGE_0          =  4'b0001;
localparam [3:0]  STAGE_1          =  4'b0010;
localparam [3:0]  STAGE_2          =  4'b0011;
localparam [3:0]  STAGE_3          =  4'b0100;
localparam [3:0]  STAGE_4          =  4'b0101;
localparam [3:0]  STAGE_5          =  4'b0110;
localparam [3:0]  STAGE_6          =  4'b0111;
localparam [3:0]  STAGE_7          =  4'b1000;

	   reg [3:0]  state            =  4'b0000;

	   reg [15:0] crc              = 16'hFFFF;
	   reg        previous_strb    =  1'b0;
	   reg strb_bf = 1'b0;

always @(posedge clk) begin
	strb_bf <= start;
	previous_strb <= strb_bf;
	
	if(reset) begin
		crc <= 16'hFFFF;
		state <= IDLE;
		busy <= 1'b0;
	end
	else begin
		
		case(state)

			IDLE: begin
				if(strb_bf && !previous_strb) begin
					state <= STAGE_0;
					crc[7:0] <= crc[7:0] ^ byte_in[7:0];
					busy <= 1'b1;
				end
				else begin
					state <= IDLE;
				end
			end

			STAGE_0: begin
				if(crc & 16'h0001)
					crc <= (crc >> 16'h0001) ^ polinom;
				else
					crc <= crc >> 16'h0001;

				state <= STAGE_1;
			end

			STAGE_1: begin
				if(crc & 16'h0001)
					crc <= (crc >> 16'h0001) ^ polinom;
				else
					crc <= crc >> 16'h0001;

				state <= STAGE_2;
			end

			STAGE_2: begin
				if(crc & 16'h0001)
					crc <= (crc >> 16'h0001) ^ polinom;
				else
					crc <= crc >> 16'h0001;

				state <= STAGE_3;
			end

			STAGE_3: begin
				if(crc & 16'h0001)
					crc <= (crc >> 16'h0001) ^ polinom;
				else
					crc <= crc >> 16'h0001;

				state <= STAGE_4;
			end

			STAGE_4: begin
				if(crc & 16'h0001)
					crc <= (crc >> 16'h0001) ^ polinom;
				else
					crc <= crc >> 16'h0001;

				state <= STAGE_5;
			end

			STAGE_5: begin
				if(crc & 16'h0001)
					crc <= (crc >> 16'h0001) ^ polinom;
				else
					crc <= crc >> 16'h0001;

				state <= STAGE_6;
			end

			STAGE_6: begin
				if(crc & 16'h0001)
					crc <= (crc >> 16'h0001) ^ polinom;
				else
					crc <= crc >> 16'h0001;

				state <= STAGE_7;
			end

			STAGE_7: begin
				if(crc & 16'h0001) begin
					crc <= (crc >> 16'h0001) ^ polinom;
					crc_16 <= (crc >> 16'h0001) ^ polinom;
				end
				else begin
					crc <= crc >> 16'h0001;
					crc_16 <= crc >> 16'h0001;
				end
				
				busy <= 1'b0;
				state <= IDLE;
			end
			
			default begin
				state <= IDLE;
			end
			
		endcase
	end
end

endmodule			