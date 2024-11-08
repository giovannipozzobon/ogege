`LOGIC_9 sbc_a_src; assign sbc_a_src = uext_a_9 - uext_src_9 - uext_nc_9;
logic sbc_a_src_n; assign sbc_a_src_n = sbc_a_src[7];
logic sbc_a_src_v; assign sbc_a_src_v = sbc_a_src[8] ^ sbc_a_src[7];
logic sbc_a_src_z; assign sbc_a_src_z = (sbc_a_src`VB == `ZERO_8) ? 1 : 0;
logic sbc_a_src_c; assign sbc_a_src_c = sbc_a_src[8];

`LOGIC_33 sbc_ea_src; assign sbc_ea_src = uext_ea_33 - uext_esrc_33 - uext_nc_33;
logic sbc_ea_src_n; assign sbc_ea_src_n = sbc_ea_src[31];
logic sbc_ea_src_v; assign sbc_ea_src_v = sbc_ea_src[32] ^ sbc_ea_src[31];
logic sbc_ea_src_z; assign sbc_ea_src_z = (sbc_ea_src`VW == `ZERO_32) ? 1 : 0;
logic sbc_ea_src_c; assign sbc_ea_src_c = sbc_ea_src[32];

`LOGIC_9 sbc_a_var; assign sbc_a_var = uext_a_9 - uext_var_9 - uext_nc_9;
logic sbc_a_var_n; assign sbc_a_var_n = sbc_a_var[7];
logic sbc_a_var_v; assign sbc_a_var_v = sbc_a_var[8] ^ sbc_a_var[7];
logic sbc_a_var_z; assign sbc_a_var_z = (sbc_a_var`VB == `ZERO_8) ? 1 : 0;
logic sbc_a_var_c; assign sbc_a_var_c = sbc_a_var[8];

`LOGIC_33 sbc_ea_var; assign sbc_ea_var = uext_ea_33 - uext_evar_33 - uext_nc_33;
logic sbc_ea_var_n; assign sbc_ea_var_n = sbc_ea_var[31];
logic sbc_ea_var_v; assign sbc_ea_var_v = sbc_ea_var[32] ^ sbc_ea_var[31];
logic sbc_ea_var_z; assign sbc_ea_var_z = (sbc_ea_var`VW == `ZERO_32) ? 1 : 0;
logic sbc_ea_var_c; assign sbc_ea_var_c = sbc_ea_var[32];
