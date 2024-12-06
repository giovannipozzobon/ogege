`wire_9 sext_a_9; assign sext_a_9 = {`A[7], `A};
`wire_32 sext_a_32; assign sext_a_32 = {`A[7] ? `ONES_24 : `ZERO_24, `A};
`wire_33 sext_a_33; assign sext_a_33 = {`A[7] ? `ONES_25 : `ZERO_25, `A};
`wire_33 sext_ea_33; assign sext_ea_33 = {`eA[31], `eA};

`wire_8 sext_c_8; assign sext_c_8 = `C ? 8'hFF : `ZERO_8;
`wire_9 sext_c_9; assign sext_c_9 = `C ? 9'h1FF : `ZERO_9;
`wire_32 sext_c_32; assign sext_c_32 = `C ? `ONES_32 : `ZERO_32;
`wire_33 sext_c_33; assign sext_c_33 = `C ? `ONES_33 : `ZERO_33;

`wire_9 sext_src_9; assign sext_src_9 = {reg_src_data[7], `SRC};
`wire_16 sext_src_16; assign sext_src_16 = {reg_src_data[7] ? `ONES_8 : `ZERO_8, `SRC};
`wire_32 sext_src_32; assign sext_src_32 = {reg_src_data[7] ? `ONES_24 : `ZERO_24, `SRC};
`wire_33 sext_src_33; assign sext_src_33 = {reg_src_data[7] ? `ONES_25 : `ZERO_25, `SRC};
`wire_33 sext_esrc_33; assign sext_esrc_33 = {reg_src_data[31], `eSRC};

`wire_32 sext_esrc_24_32; assign sext_esrc_24_32 = {reg_src_data[23] ? `ONES_8 : `ZERO_8, reg_src_data[23:0]};
`wire_33 sext_esrc_24_33; assign sext_esrc_24_33 = {reg_src_data[23] ? `ONES_9 : `ZERO_9, reg_src_data[23:0]};
`wire_33 sext_esrc_32_33; assign sext_esrc_32_33 = {reg_src_data[31], `eSRC};

`wire_9 sext_x_9; assign sext_x_9 = {`X[7], `X};
`wire_32 sext_x_32; assign sext_x_32 = {`X[7] ? `ONES_24 : `ZERO_24, `X};
`wire_33 sext_x_33; assign sext_x_33 = {`X[7] ? `ONES_25 : `ZERO_25, `X};
`wire_33 sext_ex_33; assign sext_ex_33 = {`eX[31], `eX};

`wire_9 sext_y_9; assign sext_y_9 = {`Y[7], `Y};
`wire_32 sext_y_32; assign sext_y_32 = {`Y[7] ? `ONES_24 : `ZERO_24, `Y};
`wire_33 sext_y_33; assign sext_y_33 = {`Y[7] ? `ONES_25 : `ZERO_25, `Y};
`wire_33 sext_ey_33; assign sext_ey_33 = {`eY[31], `eY};

`wire_9 sext_var_9; assign sext_var_9 = {i_bus_data[7], reg_data_byte};
`wire_16 sext_var_16; assign sext_var_16 = {i_bus_data[7] ? `ONES_8 : `ZERO_8, reg_data_byte};
`wire_32 sext_var_32; assign sext_var_32 = {i_bus_data[7] ? `ONES_24 : `ZERO_24, reg_data_byte};
`wire_33 sext_var_33; assign sext_var_33 = {i_bus_data[7] ? `ONES_25 : `ZERO_25, reg_data_byte};
`wire_33 sext_evar_33; assign sext_evar_33 = {reg_data_word[31], reg_data_word};

`wire_32 sext_evar_24_32; assign sext_evar_24_32 = {reg_data_word[23] ? `ONES_8 : `ZERO_8, reg_data_word[23:0]};
`wire_33 sext_evar_24_33; assign sext_evar_24_33 = {reg_data_word[23] ? `ONES_9 : `ZERO_9, reg_data_word[23:0]};
`wire_33 sext_evar_32_33; assign sext_evar_24_33 = {reg_data_word[31], reg_data_word};
