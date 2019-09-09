
module serial_receiver_32_w (clk, rx, byte_out, ready, timeout);

input clk, rx;

output reg [7:0] byte_out;
output reg       ready, timeout;

localparam [3:0] IDLE      = 4'b0000;
localparam [3:0] START_BIT = 4'b0001;
localparam [3:0] BIT_0     = 4'b0010;
localparam [3:0] BIT_1     = 4'b0011;
localparam [3:0] BIT_2     = 4'b0101;
localparam [3:0] BIT_3     = 4'b0110;
localparam [3:0] BIT_4     = 4'b0111;
localparam [3:0] BIT_5     = 4'b1000;
localparam [3:0] BIT_6     = 4'b1001;
localparam [3:0] BIT_7     = 4'b1010;
localparam [3:0] STOP_BIT  = 4'b1011;

reg [7:0] byte_bf        = 8'h00;
reg [3:0] state          = 4'b0000;
reg [2:0] delay_cnt_hi   = 3'b000;
reg [2:0] delay_cnt_lo   = 3'b000;
reg [1:0] data_strb_cnt  = 2'b01;

reg lo_cnt_done     = 1'b0;
reg recieve_flag    = 1'b0;

always @(posedge clk) begin

	delay_cnt_lo <= delay_cnt_lo + 3'b001;
	lo_cnt_done <= (delay_cnt_lo == 3'b110);
	if(lo_cnt_done)
		delay_cnt_hi <= delay_cnt_hi + 3'b001;
	else begin end
	if(!rx || timeout) begin
		delay_cnt_hi <= 3'b000;
		delay_cnt_lo <= 3'b000;
	end
	else begin end

	if(recieve_flag)
		data_strb_cnt <= data_strb_cnt + 2'b01;
	else
		data_strb_cnt <= 2'b00;

	if(!data_strb_cnt) begin
		case(state)
			IDLE: begin
				if(!rx) begin
					recieve_flag <= 1'b1;
					state <= START_BIT;
				end
				else begin
					recieve_flag <= 1'b0;
					state <= IDLE;
				end
			end
			START_BIT: begin  state <= BIT_0; end
			BIT_0: begin byte_bf[0] <= rx; state <= BIT_1; ready <= 1'b0; timeout <= 1'b0; end
			BIT_1: begin byte_bf[1] <= rx; state <= BIT_2; end
			BIT_2: begin byte_bf[2] <= rx; state <= BIT_3; end
			BIT_3: begin byte_bf[3] <= rx; state <= BIT_4; end
			BIT_4: begin byte_bf[4] <= rx; state <= BIT_5; end
			BIT_5: begin byte_bf[5] <= rx; state <= BIT_6; end
			BIT_6: begin byte_bf[6] <= rx; state <= BIT_7; end
			BIT_7: begin byte_bf[7] <= rx; state <= STOP_BIT; end
			STOP_BIT: begin
				byte_out <= byte_bf; 
				ready <= 1'b1;
				recieve_flag <= 1'b0; 
				state <= IDLE; 
			end
			default: begin end
		endcase
	end
	else begin end

	if(delay_cnt_hi == 3'b101) begin
		timeout <= 1'b1;
		recieve_flag <= 1'b0;
		state <= IDLE;
	end
	else begin end
		
end
endmodule