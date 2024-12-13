`wire_8 rol_a; assign rol_a = {`A[6:0], `C};
wire rol_a_n; assign rol_a_n = rol_a[7];
wire rol_a_z; assign rol_a_z = (rol_a == `ZERO_8) ? 1 : 0;
wire rol_a_c; assign rol_a_c = `A[7];

`wire_32 rol_ea; assign rol_ea = {`eA[30:0], `eC};
wire rol_ea_n; assign rol_ea_n = rol_ea[31];
wire rol_ea_z; assign rol_ea_z = (rol_ea == `ZERO_32) ? 1 : 0;
wire rol_ea_c; assign rol_ea_c = `eA[31];

`wire_8 rol_var; assign rol_var = {wire_data_byte_0[6:0], `C};
wire rol_var_n; assign rol_var_n = rol_var[7];
wire rol_var_z; assign rol_var_z = (rol_var == `ZERO_8) ? 1 : 0;
wire rol_var_c; assign rol_var_c = wire_data_byte_0[7];

`wire_32 rol_evar; assign rol_evar = {wire_data_word[30:0], `eC};
wire rol_evar_n; assign rol_evar_n = rol_evar[31];
wire rol_evar_z; assign rol_evar_z = (rol_evar == `ZERO_32) ? 1 : 0;
wire rol_evar_c; assign rol_evar_c = wire_data_word[31];
