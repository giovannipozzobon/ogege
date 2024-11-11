// 65832 cycle 1

if (am_PCR_r) begin
    `eSRC0 <= i_bus_data;
    `ePC <= inc_epc;
end
