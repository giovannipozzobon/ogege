`LOGIC_8 not_a; assign not_a = ~`A;
logic not_a_n; assign not_a_n = not_a[7];
logic not_a_z; assign not_a_z = (not_a == `ZERO_8) ? 1 : 0;

`LOGIC_32 not_ea; assign not_ea = ~`eA;
logic not_ea_n; assign not_ea_n = not_ea[31];
logic not_ea_z; assign not_ea_z = (not_ea == `ZERO_32) ? 1 : 0;

`LOGIC_8 not_var; assign not_var = ~reg_data_byte;
logic not_var_n; assign not_var_n = not_var[7];
logic not_var_z; assign not_var_z = (not_var == `ZERO_8) ? 1 : 0;

`LOGIC_32 not_evar; assign not_evar = ~reg_data_word;
logic not_evar_n; assign not_evar_n = not_evar[31];
logic not_evar_z; assign not_evar_z = (not_evar == `ZERO_32) ? 1 : 0;
