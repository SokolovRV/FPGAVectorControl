module delay_clk_posedge (input clk, input a,
//input [15:0] dead_clk,
output reg b
/*output reg [15:0] count,
output reg flag_timer_start,
output reg flag_change,
output reg flag_a*/
/*output reg [0:0] flag_timer_start,
output reg [0:0] flag_change,
output reg [15:0] count*/);

reg [15:0] dead_clk;
reg [15:0] count;
reg flag_timer_start;
reg flag_change;
reg flag_a;

initial 
begin 
dead_clk=500;
count=0;
b=0;
flag_timer_start=0;
flag_change=0;
flag_a=0;
end

always @ (posedge clk) 
begin

	if(a && !flag_a)
	begin
	flag_a=1;
	flag_timer_start=1;
	end
	else
	;
	
	if(!a && flag_a)
	begin
	flag_a=0;
	flag_timer_start=0;
	flag_change=0;
	count=0;
	b<=a;
	end
	else
	;
	
	if ((flag_change==1) && (a!=b))
	begin
	//flag_timer_start=1;
	flag_change=0;
	b<=a;
	end
	
	if (count >= dead_clk && flag_a)
	begin
	flag_timer_start=0;
	flag_change=1;
	count=0;
	end
	
	if (flag_timer_start)
	begin
	count=count+1;
	end 

end
endmodule



	













