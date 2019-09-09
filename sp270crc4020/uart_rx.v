/*Designed by: Minor A. S.
This block takes a byte to an external device protocol UART
*/
module uart_rx(clk,Rx,ledEn,dataout,EnableOut);
input clk;
input Rx;
output reg EnableOut;
output reg ledEn = 0;
output reg [7:0] dataout= 8'b00000000;

reg [1:0]RxEnable = 1'b0; //priem razreshon
reg Enabledata=0;
reg [20:0]count = 0;
reg [9:0]data = 1'b0;
reg [4:0]i= 0;
reg [15:0] speed=427;//10416-->4800 bot; 5208-->9600 bot; 2604-->19200 bot; 868-->57600 bot; 434-->115200 bot

//assign EnableOut=(Enabledata==1)&&(RxEnable==0);

always @ (posedge clk)
begin

if(EnableOut==1) EnableOut <= 0;


if((Rx==0)&&(i==0)) begin //esli na vhode 0, znachit poshel start bit
RxEnable = 1;
ledEn <= 1;
end

	if(RxEnable == 1) begin //esli priem razreshon
		count = count + 1;
		
		if((count==(speed/2))&&(i==0)) begin //kogda dostigli seredinu start bit
			i = 1; //perekluchaem na 0 bit
			count = 0;
		end
		
		if((i > 0)&&(count == speed)) begin
			data[i] = Rx;
			count = 0;
			i = i + 1;
			if(i>9) begin //bit prinyatu
			  i = 0;
			  RxEnable = 0;
			  ledEn <= 0;
			  dataout[7:0]=data[8:1];
			  EnableOut <= 1;
			end
		end
	end
	
	
end
endmodule