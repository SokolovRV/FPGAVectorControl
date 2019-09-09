
/*
	Developer: Sokolov R.V.
	Revision: 1.0

	Max clk freq: 600 MHz
	Max data rate: 150 Mbit/s ( Max clk freq / 4 )
	Data packet length [bit]: 32 + (20 * n_words) 

	If 'reset' port not use: connect 'reset' port to GND.
	If 'start' port not use: connect 'ready' port to 'start' port (for non-stop data transmit). 
	Start transmit: posedge signal on 'start' port.
	End transmit: posedge signal on 'ready' port.

	Add this file and all dependent files to project and
	create symbol from this file.

	Dependent files:
		- data_mux_32_w.v
		- serial_tx_ctrl_32_w.v
		- crc_16_rtu_tx_32_w.v
		- serial_transmitter_32_w.v
*/


module serial_transmitter_main_32_w(
	clk,
	data_0,
	data_1,
	data_2,
	data_3,
	data_4,
	data_5,
	data_6,
	data_7,
	data_8,
	data_9,
	data_10,
	data_11,
	data_12,
	data_13,
	data_14,
	data_15,
	data_16,
	data_17,
	data_18,
	data_19,
	data_20,
	data_21,
	data_22,
	data_23,
	data_24,
	data_25,
	data_26,
	data_27,
	data_28,
	data_29,
	data_30,
	data_31,
	start,
	reset,

	tx,
	ready
);


input wire	clk;
input wire	[15:0] data_0;
input wire	[15:0] data_1;
input wire	[15:0] data_2;
input wire	[15:0] data_3;
input wire	[15:0] data_4;
input wire	[15:0] data_5;
input wire	[15:0] data_6;
input wire	[15:0] data_7;
input wire	[15:0] data_8;
input wire	[15:0] data_9;
input wire	[15:0] data_10;
input wire	[15:0] data_11;
input wire	[15:0] data_12;
input wire	[15:0] data_13;
input wire	[15:0] data_14;
input wire	[15:0] data_15;
input wire	[15:0] data_16;
input wire	[15:0] data_17;
input wire	[15:0] data_18;
input wire	[15:0] data_19;
input wire	[15:0] data_20;
input wire	[15:0] data_21;
input wire	[15:0] data_22;
input wire	[15:0] data_23;
input wire	[15:0] data_24;
input wire	[15:0] data_25;
input wire	[15:0] data_26;
input wire	[15:0] data_27;
input wire	[15:0] data_28;
input wire	[15:0] data_29;
input wire	[15:0] data_30;
input wire	[15:0] data_31;
input wire	start;
input wire	reset;
output wire	tx;
output wire	ready;

wire	[7:0] byte_out;
reg	clk_dev_4;
wire	[15:0] crc_16;
wire	[7:0] data_delect;
wire	data_lock;
wire	main_reset;
wire	reset_crc;
wire	start_tx;
wire	transmit_done;
wire	tx_done;
wire	SYNTHESIZED_WIRE_0;
reg	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_1;
wire	[15:0] SYNTHESIZED_WIRE_2;





serial_transmitter_32_w	b2v_inst(
	.clk(clk_dev_4),
	.start(start_tx),
	.reset(main_reset),
	.byte_in(byte_out),
	.tx(tx),
	.ready(tx_done));


always@(posedge clk)
begin
	begin
	SYNTHESIZED_WIRE_3 <= SYNTHESIZED_WIRE_0;
	end
end


always@(posedge SYNTHESIZED_WIRE_3)
begin
	begin
	clk_dev_4 <= SYNTHESIZED_WIRE_1;
	end
end

assign	SYNTHESIZED_WIRE_1 =  ~clk_dev_4;

assign	SYNTHESIZED_WIRE_0 =  ~SYNTHESIZED_WIRE_3;


serial_tx_ctrl_32_w	b2v_inst5(
	.clk(clk_dev_4),
	.start(start),
	.tx_done(tx_done),
	.reset(main_reset),
	.crc_16(crc_16),
	.data_in(SYNTHESIZED_WIRE_2),
	.reset_crc(reset_crc),
	.start_tx(start_tx),
	.ready(transmit_done),
	.data_lock(data_lock),
	.byte_out(byte_out),
	.data_select(data_delect));
	defparam	b2v_inst5.n_word = 32;


crc_16_rtu_tx_32_w	b2v_inst6(
	.clk(clk_dev_4),
	.start(start_tx),
	.reset(reset_crc),
	.byte_in(byte_out),
	
	.crc_16(crc_16));


data_mux_32_w	b2v_inst7(
	.clk(clk_dev_4),
	.data_lock(data_lock),
	.reset(main_reset),
	.data_0(data_0),
	.data_1(data_1),
	.data_2(data_2),
	.data_3(data_3),
	.data_4(data_4),
	.data_5(data_5),
	.data_6(data_6),
	.data_7(data_7),
	.data_8(data_8),
	.data_9(data_9),
	.data_10(data_10),
	.data_11(data_11),
	.data_12(data_12),
	.data_13(data_13),
	.data_14(data_14),
	.data_15(data_15),
	.data_16(data_16),
	.data_17(data_17),
	.data_18(data_18),
	.data_19(data_19),
	.data_20(data_20),
	.data_21(data_21),
	.data_22(data_22),
	.data_23(data_23),
	.data_24(data_24),
	.data_25(data_25),
	.data_26(data_26),
	.data_27(data_27),
	.data_28(data_28),
	.data_29(data_29),
	.data_30(data_30),
	.data_31(data_31),
	.selector(data_delect),
	.data_out(SYNTHESIZED_WIRE_2));

assign	main_reset = reset;
assign	ready = transmit_done;

endmodule