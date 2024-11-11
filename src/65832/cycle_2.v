// 65832 cycle 2

if (am_PCR_r) begin
    `eSRC1 <= i_bus_data;
    `ePC <= inc_epc;
end
