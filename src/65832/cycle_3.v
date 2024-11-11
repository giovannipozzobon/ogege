// 65832 cycle 3

if (am_PCR_r) begin
    `eSRC2 <= i_bus_data;
    `ePC <= inc_epc;
    am_PCR_r <= 0;
end
