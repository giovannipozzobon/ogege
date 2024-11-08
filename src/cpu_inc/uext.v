`LOGIC_9 uext_a_9; assign uext_a_9 = { 1'd0, `A};
`LOGIC_32 uext_a_32; assign uext_a_32 = { `ZERO_24, `A};
`LOGIC_33 uext_a_33; assign uext_a_33 = { `ZERO_25, `A};
`LOGIC_33 uext_ea_33; assign uext_ea_33 = { 1'd0, `eA};

`LOGIC_8 uext_c_8; assign uext_c_8 = { `ZERO_7, `C};
`LOGIC_9 uext_c_9; assign uext_c_9 = { `ZERO_8, `C};
`LOGIC_32 uext_c_32; assign uext_c_32 = { `ZERO_31, `C};
`LOGIC_33 uext_c_33; assign uext_c_33 = { `ZERO_32, `C};

`LOGIC_8 uext_nc_8; assign uext_nc_8 = { `ZERO_7, `NC};
`LOGIC_9 uext_nc_9; assign uext_nc_9 = { `ZERO_8, `NC};
`LOGIC_32 uext_nc_32; assign uext_nc_32 = { `ZERO_31, `NC};
`LOGIC_33 uext_nc_33; assign uext_nc_33 = { `ZERO_32, `NC};

`LOGIC_17 uext_pc_17; assign uext_pc_17 = { 1'd0, `PC};
`LOGIC_32 uext_pc_32; assign uext_pc_32 = { `ZERO_16, `PC};
`LOGIC_33 uext_pc_33; assign uext_pc_33 = { `ZERO_17, `PC};
`LOGIC_33 uext_epc_33; assign uext_epc_33 = { 1'd0, `ePC};

`LOGIC_17 uext_sp_17; assign uext_sp_17 = { 1'd0, `SP};
`LOGIC_32 uext_sp_32; assign uext_sp_32 = { `ZERO_16, `SP};
`LOGIC_33 uext_sp_33; assign uext_sp_33 = { `ZERO_17, `SP};
`LOGIC_33 uext_esp_33; assign uext_esp_33 = { 1'd0, `eSP};

`LOGIC_9 uext_src_9; assign uext_src_9 = { 1'd0, `SRC};
`LOGIC_16 uext_src_16; assign uext_src_16 = { `ZERO_8, `SRC};
`LOGIC_32 uext_src_32; assign uext_src_32 = { `ZERO_24, `SRC};
`LOGIC_33 uext_src_33; assign uext_src_33 = { `ZERO_25, `SRC};
`LOGIC_33 uext_esrc_33; assign uext_esrc_33 = { 1'd0, `eSRC};

`LOGIC_9 uext_x_9; assign uext_x_9 = { 1'd0, `X};
`LOGIC_16 uext_x_16; assign uext_x_16 = { `ZERO_8, `X};
`LOGIC_32 uext_x_32; assign uext_x_32 = { `ZERO_24, `X};
`LOGIC_33 uext_x_33; assign uext_x_33 = { `ZERO_25, `X};
`LOGIC_33 uext_ex_33; assign uext_ex_33 = { 1'd0, `eX};

`LOGIC_9 uext_y_9; assign uext_y_9 = { 1'd0, `Y};
`LOGIC_16 uext_y_16; assign uext_y_16 = { `ZERO_8, `Y};
`LOGIC_32 uext_y_32; assign uext_y_32 = { `ZERO_24, `Y};
`LOGIC_33 uext_y_33; assign uext_y_33 = { `ZERO_25, `Y};
`LOGIC_33 uext_ey_33; assign uext_ey_33 = { 1'd0, `eY};

`LOGIC_9 uext_var_9; assign uext_var_9 = { 1'd0, reg_data_byte};
`LOGIC_16 uext_var_16; assign uext_var_16 = { `ZERO_8, reg_data_byte};
`LOGIC_32 uext_var_32; assign uext_var_32 = { `ZERO_24, reg_data_byte};
`LOGIC_33 uext_var_33; assign uext_var_33 = { `ZERO_25, reg_data_byte};
`LOGIC_33 uext_evar_33; assign uext_evar_33 = { 1'd0, reg_data_word};
