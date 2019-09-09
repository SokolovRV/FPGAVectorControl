module div (clk, iNum, iDeNom, iStart, oDiv, oRem, oRdy, Cnt);
parameter n=25; // Wire width of numerator
parameter m=24; // Wire width of denomenator
 
input [n-1:0]iNum; // Numerator
input [m-1:0]iDeNom; // Denomenator
input iStart; // Launch of division
input clk; // Clock
 
output reg [n-1:0]oDiv; // Result
output reg [m-1:0]oRem; // Remainder
output reg oRdy; // Readiness of division
 
reg Init; // Flag of working operation
reg [n-1:0]Div; // Internal register for result storage
reg [n+m-1:0]Num; // Internal register for numerator storage
reg [m-1:0]DeNom; // Internal register for denominator storage
 
wire [m-1:0]NomNil=0; // Zeros' wire to append internal numerator at launch
 
output reg [m-1:0]Cnt; // Counter of iterations between launch and finish
 
// Immediate result of substraction
// [m:0] because with [m-1:0] there are possible situations
// when numerator in window lesser than denominator, but
// at the next cycle higher bit will step out from window
wire Carry; // Carry flag
wire [m:0]Sub; // Substraction result
assign {Carry, Sub}={1'b0, Num[n+m-1:n-1]}-{2'b0, DeNom};
 
 /*initial 
begin 
oDiv=0;
oRem=0;
end*/
 // Event processing
 always @(posedge clk)
 begin
  // At launch
  if(iStart) 
    Init<=1; // Enter division cycle
  else if (Init & Cnt==n) 
    Init<=0; // Exit divsion cycle
 
  if(iStart) 
    Num<={NomNil, iNum}; // If new assignment than store numerator at input
  else if(~Carry) // If carry flag is not set
   begin
    Num[n:0]<={Num[n-2:0], 1'b0}; // Shift lower part of numerator to the left  
    Num[n+m-1:n]<=Sub; // Shift substraction result to the left and store at numerator
   end 
  else 
    Num[n+m-1:0]<={Num[n+m-2:0], 1'b0}; // Shift numerator to the left
 
  if(iStart) 
    DeNom[m-1:0]<=iDeNom; // If new assignment than store denomenator at input
 
  if(iStart) 
    Cnt<=0; // Reset counter at launch
  else if(Init)
    Cnt<=Cnt+1; // Otherwise count
 
  // At finish
  if( (Init & Cnt==n) || Cnt > n) 
    oRdy<=1; // Set ready flag at finish
  else 
    oRdy<=0;
 
  if(Init & Cnt==n) 
    oDiv<=Div; // Store division result at finish
  if(Init & Cnt==n) 
    oRem<=Num[n+m-1:n]; // Store remainder at finish
 
  // Always
  Div[n-1:1]<=Div[n-2:0]; // Shift result to the left
  Div[0]<=~Carry; // Add new bit to result
 end
 
endmodule