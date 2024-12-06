`wire_9 uext_a_9; assign uext_a_9 = { 1'd0, `A};
`wire_32 uext_a_32; assign uext_a_32 = { `ZERO_24, `A};
`wire_33 uext_a_33; assign uext_a_33 = { `ZERO_25, `A};
`wire_33 uext_ea_33; assign uext_ea_33 = { 1'd0, `eA};

`wire_8 uext_c_8; assign uext_c_8 = { `ZERO_7, `C};
`wire_9 uext_c_9; assign uext_c_9 = { `ZERO_8, `C};
`wire_32 uext_c_32; assign uext_c_32 = { `ZERO_31, `C};
`wire_33 uext_c_33; assign uext_c_33 = { `ZERO_32, `C};

`wire_8 uext_nc_8; assign uext_nc_8 = { `ZERO_7, `NC};
`wire_9 uext_nc_9; assign uext_nc_9 = { `ZERO_8, `NC};
`wire_32 uext_nc_32; assign uext_nc_32 = { `ZERO_31, `NC};
`wire_33 uext_nc_33; assign uext_nc_33 = { `ZERO_32, `NC};

`wire_17 uext_pc_17; assign uext_pc_17 = { 1'd0, `PC};
`wire_32 uext_pc_32; assign uext_pc_32 = { `ZERO_16, `PC};
`wire_33 uext_pc_33; assign uext_pc_33 = { `ZERO_17, `PC};
`wire_33 uext_epc_33; assign uext_epc_33 = { 1'd0, `ePC};

`wire_17 uext_sp_17; assign uext_sp_17 = { 1'd0, `SP};
`wire_32 uext_sp_32; assign uext_sp_32 = { `ZERO_16, `SP};
`wire_33 uext_sp_33; assign uext_sp_33 = { `ZERO_17, `SP};
`wire_33 uext_esp_33; assign uext_esp_33 = { 1'd0, `eSP};

`wire_9 uext_src_9; assign uext_src_9 = { 1'd0, `SRC};
`wire_16 uext_src_16; assign uext_src_16 = { `ZERO_8, `SRC};
`wire_32 uext_src_32; assign uext_src_32 = { `ZERO_24, `SRC};
`wire_33 uext_src_33; assign uext_src_33 = { `ZERO_25, `SRC};
`wire_33 uext_esrc_33; assign uext_esrc_33 = { 1'd0, `eSRC};

`wire_9 uext_x_9; assign uext_x_9 = { 1'd0, `X};
`wire_16 uext_x_16; assign uext_x_16 = { `ZERO_8, `X};
`wire_32 uext_x_32; assign uext_x_32 = { `ZERO_24, `X};
`wire_33 uext_x_33; assign uext_x_33 = { `ZERO_25, `X};
`wire_33 uext_ex_33; assign uext_ex_33 = { 1'd0, `eX};

`wire_9 uext_y_9; assign uext_y_9 = { 1'd0, `Y};
`wire_16 uext_y_16; assign uext_y_16 = { `ZERO_8, `Y};
`wire_32 uext_y_32; assign uext_y_32 = { `ZERO_24, `Y};
`wire_33 uext_y_33; assign uext_y_33 = { `ZERO_25, `Y};
`wire_33 uext_ey_33; assign uext_ey_33 = { 1'd0, `eY};

`wire_9 uext_var_9; assign uext_var_9 = { 1'd0, reg_data_byte};
`wire_16 uext_var_16; assign uext_var_16 = { `ZERO_8, reg_data_byte};
`wire_32 uext_var_32; assign uext_var_32 = { `ZERO_24, reg_data_byte};
`wire_33 uext_var_33; assign uext_var_33 = { `ZERO_25, reg_data_byte};
`wire_33 uext_evar_33; assign uext_evar_33 = { 1'd0, reg_data_word};
