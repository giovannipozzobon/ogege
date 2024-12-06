`wire_9 add_a_src; assign add_a_src = uext_a_9 + uext_src_9;
wire add_a_src_n; assign add_a_src_n = add_a_src[7];
wire add_a_src_v; assign add_a_src_v = add_a_src[8] ^ add_a_src[7];
wire add_a_src_z; assign add_a_src_z = (add_a_src`VB == `ZERO_8) ? 1 : 0;
wire add_a_src_c; assign add_a_src_c = add_a_src[8];

`wire_33 add_ea_src; assign add_ea_src = uext_ea_33 + uext_esrc_33;
wire add_ea_src_n; assign add_ea_src_n = add_ea_src[31];
wire add_ea_src_v; assign add_ea_src_v = add_ea_src[32] ^ add_ea_src[31];
wire add_ea_src_z; assign add_ea_src_z = (add_ea_src`VW == `ZERO_32) ? 1 : 0;
wire add_ea_src_c; assign add_ea_src_c = add_ea_src[32];

`wire_16 add_pc_src; assign add_pc_src = `PC + sext_src_16;
`wire_16 add_pc_2; assign add_pc_2 = `PC + `TWO_16;

`wire_16 add_epc_4; assign add_epc_4 = `PC + `FOUR_32;

`wire_32 add_epc_src; assign add_epc_src = `ePC + sext_src_32;
`wire_32 add_epc_src_24; assign add_epc_src_24 = `ePC + sext_esrc_24_32;

`wire_9 add_a_var; assign add_a_var = uext_a_9 + uext_var_9;
wire add_a_var_n; assign add_a_var_n = add_a_var[7];
wire add_a_var_v; assign add_a_var_v = add_a_var[8] ^ add_a_var[7];
wire add_a_var_z; assign add_a_var_z = (add_a_var`VB == `ZERO_8) ? 1 : 0;
wire add_a_var_c; assign add_a_var_c = add_a_var[8];

`wire_33 add_ea_var; assign add_ea_var = uext_ea_33 + uext_evar_33;
wire add_ea_var_n; assign add_ea_var_n = add_ea_var[31];
wire add_ea_var_v; assign add_ea_var_v = add_ea_var[32] ^ add_ea_var[31];
wire add_ea_var_z; assign add_ea_var_z = (add_ea_var`VW == `ZERO_32) ? 1 : 0;
wire add_ea_var_c; assign add_ea_var_c = add_ea_var[32];

`wire_16 add_pc_var; assign add_pc_var = `PC + sext_var_16;

`wire_32 add_epc_var; assign add_epc_var = `ePC + sext_var_32;
`wire_32 add_epc_var_24; assign add_epc_var_24 = `ePC + sext_evar_24_32;
