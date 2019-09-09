module chooseCMD (isData, SPI_data, N, CMD1, CMD2, Eth_I_max, Eth_I_min, Eth_Temp_max, Eth_I_work, Eth_kor, Eth_Imp_time, Eth_Start, Eth_Full_stop, Eth_Calibr, Eth_Ch_num);

input               isData;
input       [15:0] SPI_data;
input       [7:0]  N;

output reg  [15:0] CMD1;
output reg  [15:0] CMD2;
output reg  [15:0] Eth_I_max, Eth_I_min, Eth_Temp_max, Eth_I_work, Eth_kor, Eth_Imp_time, Eth_Start, Eth_Full_stop, Eth_Calibr, Eth_Ch_num;
/*output reg  [15:0] Eth_A;
output reg  [15:0] Eth_T1;
output reg  [15:0] Eth_T2;
output reg  [15:0] Eth_T3;
output reg  [15:0] Eth_T4;
output reg  [15:0] Eth_ref;*/

always @ (posedge isData) 
begin
    case (N)
        1: CMD1 = SPI_data;
        2: CMD2 = SPI_data;
        3: Eth_I_max = SPI_data;
        4: Eth_I_min = SPI_data;
        5: Eth_Temp_max = SPI_data;
        6: Eth_I_work = SPI_data;
        7: Eth_kor = SPI_data;
        8: Eth_Imp_time = SPI_data;
        9: Eth_Start = SPI_data;
        10: Eth_Full_stop = SPI_data;
        11: Eth_Calibr = SPI_data;
        12: Eth_Ch_num = SPI_data;
        default: ;
    endcase
end
endmodule
