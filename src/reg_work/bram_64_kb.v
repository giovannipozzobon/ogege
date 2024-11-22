logic rst_or_clk; assign rst_or_clk = i_rst | i_clk;

reg test;

always @(posedge rst_or_clk) begin
    if (i_rst) begin
        test <= 1;
        reg_bram_wea <= 0;
        reg_bram_web <= 0;
        reg_bram_clka <= 0;
        reg_bram_put_byte <= 0;
        reg_bram_dib <= 0;
        reg_bram_addra <= 0;
        wire_bram_addrb <= 0;
        //reg_bram_get_byte;
        //reg_bram_scan_byte;
    end else if (test) begin
        test <= 0;
        reg_bram_addra = `RESET_PC_ADDRESS;
        reg_bram_clka <= 1;
    end else if (reg_bram_clka) begin
        reg_bram_clka <= 0;
    end
end
