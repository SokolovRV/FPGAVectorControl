/*Designed by: Minor A. S.
This blok sends bytes to the external device protocol UART
*/
module uart_tx(clk,Tx,data,Enable,ledTx, send);
input clk;
input Enable;
input [7:0]data;
output send;
output reg Tx=1'b1;
output reg ledTx=1'b0;

reg [9:0] dataout = 10'b1111111111;//data out
reg TxEnable=0;//razreshenie peredachi data
reg [17:0]count = 1'b0;//schetchik
reg [4:0]i= 1'b0;
reg send_b=1;
reg [15:0] speed=427;//10416-->4800 bot; 5208-->9600 bot; 2604-->19200 bot; 868-->57600 bot; 434-->115200 bot

assign send=(Enable==0)&(send_b==1);

always @ (posedge clk)
begin
	
	if(Enable==1) begin //razreshenie peredachi
		TxEnable=1;
		dataout = {1'b1,data,1'b0};
		send_b=0; //blok UART_TX busy
	end
	
	if(send_b==1) TxEnable=0;
	
 if(TxEnable==1) begin //nachalo peredachi
	
	ledTx=1;
	count <= count + 1;
	
	if(count==speed)
	begin
	
	  Tx <= dataout[i];//send bit
	  count <= 0;
	  i <= i + 1;
	   if(i>=9)//count bit
	   begin
	     i <= 0;
	     Tx <=1'b1;
		  ledTx=0;
		  TxEnable=0;//data transfer is prohibited
		  send_b=1;//port UART_TX not busy
	   end
	end
	
 end

end
endmodule