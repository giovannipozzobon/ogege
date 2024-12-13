`wire_8 not_a; assign not_a = ~`A;
wire not_a_n; assign not_a_n = not_a[7];
wire not_a_z; assign not_a_z = (not_a == `ZERO_8) ? 1 : 0;

`wire_32 not_ea; assign not_ea = ~`eA;
wire not_ea_n; assign not_ea_n = not_ea[31];
wire not_ea_z; assign not_ea_z = (not_ea == `ZERO_32) ? 1 : 0;

`wire_8 not_var; assign not_var = ~wire_data_byte_0;
wire not_var_n; assign not_var_n = not_var[7];
wire not_var_z; assign not_var_z = (not_var == `ZERO_8) ? 1 : 0;

`wire_32 not_evar; assign not_evar = ~wire_data_word;
wire not_evar_n; assign not_evar_n = not_evar[31];
wire not_evar_z; assign not_evar_z = (not_evar == `ZERO_32) ? 1 : 0;
