module ADC_in (clk, sclk,cs,sdata,out,mean_value);

input clk,sdata;
output reg sclk,cs;
output reg unsigned [11:0] out;
output reg unsigned [15:0] mean_value;

//reg signed [31:0] mean_value_temp;
reg unsigned [11:0]  temp, aaa;
reg unsigned [11:0] temp2 [0:10]; 
reg unsigned [31:0] sum;
reg [7:0] n;
reg [7:0] k;
reg flag_init;
reg [7:0] m;
 
initial
begin  
n=0;
sclk=0;
cs=0;
k=0;
m=0;
flag_init=1;
mean_value=4095;
out=4095;
temp2[0] = 1000; temp2[1] = 1000; temp2[2] = 1000; temp2[3] = 1000; temp2[4] = 1000; temp2[5] = 1000; temp2[6] = 1000; temp2[7] = 1000;
sum = 8000;
end

always @ (posedge clk)
begin

	if (n>=1 &&  n<2)
		cs=1;
	else 
		cs=0;

	if (n>=0 && n<=2)
		sclk=1;
	else if (n>=3 && n<36)
		sclk=~sclk;

	if (n%2<1 && n>11 && n<36)
	begin
		temp[11-k]=sdata;
		k=k+1;
	end
	else if (n==36/*68*/)
	begin
		sum = sum - temp2[m];
		temp2[m] = temp;
		sum = sum + temp ;
		m=m+1;
		//sum = sum - aaa;
		//sum = sum + temp ;
		if (flag_init==0)
			begin
			mean_value=sum/8;
			//mean_value=mean_value_temp;
			end
		else
			begin
			mean_value=sum/8;
			//mean_value=mean_value_temp;	
			end
		if(m==8)
		begin
			flag_init=0;
			m=0;
		end	
		k=0;
		out=temp;
		n=0;
		sclk=1;
	end

	n=n+1;
end

endmodule