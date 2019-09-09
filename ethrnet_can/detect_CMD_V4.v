module detect_CMD_V4(cs, byteFromEth, data, dNumber);

input 				cs;
input [15:0] 		byteFromEth;

output reg [15:0] data;
output reg [7:0] 	dNumber = 0;				// number of incoming byte

reg [7:0] 			f_CM = 0;

always @ (posedge cs) 
begin                     								// at the end of transmition o?� SPI data begin:
	if (byteFromEth == 17229) begin					// in SP270 'CM' = 19779 = 4D43; 
		dNumber = 0;										// if 'CM' reset data counter
      f_CM = 1;                               	// set 'CM' flag to '1'
	end 
	
    if (f_CM) begin                             // if 'CM' flag = '1'
        data = byteFromEth;                     // send data to output
        dNumber = dNumber + 1;                  // dNumber++
    end

    if (f_CM && dNumber == 50) begin            // reset on 50th register
        f_CM = 0;                               // reset flag 'CM'                         
    end	
end
endmodule