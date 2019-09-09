module detect_CMD_V5(cs, byteFromEth, data, dNumber);

input 				cs;
input [15:0] 		byteFromEth;

output reg [15:0] data;
output reg [7:0] 	dNumber = 0;				// number of incoming byte

reg [7:0] 			f_CM = 0;

parameter reg [15:0] CM_command = 17229;
parameter reg [15:0] register_max = 50;


always @ (posedge cs) 
begin                     								// at the end of transmition o?� SPI data begin:
	if (byteFromEth == CM_command) begin					// in SP270 'CM' = 19779 = 4D43; 
		dNumber = 0;										// if 'CM' reset data counter
      f_CM = 1;                               	// set 'CM' flag to '1'
	end 
	
    if (f_CM>0) begin                             // if 'CM' flag = '1'
        data = byteFromEth;                     // send data to output
        dNumber = dNumber + 1;                  // dNumber++
    end

    if (f_CM>0 && dNumber >= register_max) begin            // reset on 50th register
        f_CM = 0;                               // reset flag 'CM'                         
    end	
end
endmodule
