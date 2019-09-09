module ethStart (
  clk, eStart, refStart
);

input               clk;
input       [15:0]  eStart;         // command from ASU ('CMDP')
output reg  [1:0]   refStart;       // data for trap.ref module (A.Yurkin)

always @ (posedge clk) begin
  if (eStart == 101) begin
    refStart = 1;
  end
  else if (eStart == 66) begin
    refStart = 2;
  end 
end
endmodule // ethStart 