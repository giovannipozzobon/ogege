/*
Text controller

assign am_TXT = (op_33_WTX | op_43_RTX);
*/

if (am_TXT) begin
    if (cycle_0) begin
        if (op_33_WTX) begin
            o_bus_clk <= 1;
            o_bus_addr`VB <= `X;
            o_bus_data <= `A;
            o_bus_we <= 1;
        end
    end else if (cycle_1) begin
        if (op_33_WTX) begin
            o_bus_clk <= 0;
            o_bus_we <= 0;
            reg_cycle <= 0;
        end
    end
end