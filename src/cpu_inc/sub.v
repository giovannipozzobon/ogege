`wire_9 sub_a_src; assign sub_a_src = uext_a_9 - uext_src_9;
wire sub_a_src_n; assign sub_a_src_n = sub_a_src[7];
wire sub_a_src_v; assign sub_a_src_v = sub_a_src[8] ^ sub_a_src[7];
wire sub_a_src_z; assign sub_a_src_z = (sub_a_src`VB == `ZERO_8) ? 1 : 0;
wire sub_a_src_c; assign sub_a_src_c = sub_a_src[8];

`wire_33 sub_ea_src; assign sub_ea_src = uext_ea_33 - uext_esrc_33;
wire sub_ea_src_n; assign sub_ea_src_n = sub_ea_src[31];
wire sub_ea_src_v; assign sub_ea_src_v = sub_ea_src[32] ^ sub_ea_src[31];
wire sub_ea_src_z; assign sub_ea_src_z = (sub_ea_src`VW == `ZERO_32) ? 1 : 0;
wire sub_ea_src_c; assign sub_ea_src_c = sub_ea_src[32];

`wire_9 sub_a_var; assign sub_a_var = uext_a_9 - uext_var_9;
wire sub_a_var_n; assign sub_a_var_n = sub_a_var[7];
wire sub_a_var_v; assign sub_a_var_v = sub_a_var[8] ^ sub_a_var[7];
wire sub_a_var_z; assign sub_a_var_z = (sub_a_var`VB == `ZERO_8) ? 1 : 0;
wire sub_a_var_c; assign sub_a_var_c = sub_a_var[8];

`wire_33 sub_ea_var; assign sub_ea_var = uext_ea_33 - uext_evar_33;
wire sub_ea_var_n; assign sub_ea_var_n = sub_ea_var[31];
wire sub_ea_var_v; assign sub_ea_var_v = sub_ea_var[32] ^ sub_ea_var[31];
wire sub_ea_var_z; assign sub_ea_var_z = (sub_ea_var`VW == `ZERO_32) ? 1 : 0;
wire sub_ea_var_c; assign sub_ea_var_c = sub_ea_var[32];

`wire_9 sub_x_var; assign sub_x_var = uext_x_9 - uext_var_9;
wire sub_x_var_n; assign sub_x_var_n = sub_x_var[7];
wire sub_x_var_v; assign sub_x_var_v = sub_x_var[8] ^ sub_x_var[7];
wire sub_x_var_z; assign sub_x_var_z = (sub_x_var`VB == `ZERO_8) ? 1 : 0;
wire sub_x_var_c; assign sub_x_var_c = sub_x_var[8];

`wire_33 sub_ex_var; assign sub_ex_var = uext_ex_33 - uext_evar_33;
wire sub_ex_var_n; assign sub_ex_var_n = sub_ex_var[31];
wire sub_ex_var_v; assign sub_ex_var_v = sub_ex_var[32] ^ sub_ex_var[31];
wire sub_ex_var_z; assign sub_ex_var_z = (sub_ex_var`VW == `ZERO_32) ? 1 : 0;
wire sub_ex_var_c; assign sub_ex_var_c = sub_ex_var[32];

`wire_9 sub_y_var; assign sub_y_var = uext_y_9 - uext_var_9;
wire sub_y_var_n; assign sub_y_var_n = sub_y_var[7];
wire sub_y_var_v; assign sub_y_var_v = sub_y_var[8] ^ sub_y_var[7];
wire sub_y_var_z; assign sub_y_var_z = (sub_y_var`VB == `ZERO_8) ? 1 : 0;
wire sub_y_var_c; assign sub_y_var_c = sub_y_var[8];

`wire_33 sub_ey_var; assign sub_ey_var = uext_ey_33 - uext_evar_33;
wire sub_ey_var_n; assign sub_ey_var_n = sub_ey_var[31];
wire sub_ey_var_v; assign sub_ey_var_v = sub_ey_var[32] ^ sub_ey_var[31];
wire sub_ey_var_z; assign sub_ey_var_z = (sub_ey_var`VW == `ZERO_32) ? 1 : 0;
wire sub_ey_var_c; assign sub_ey_var_c = sub_ey_var[32];
