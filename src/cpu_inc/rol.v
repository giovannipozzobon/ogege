`LOGIC_8 rol_a; assign rol_a = {`A[6:0], `C};
logic rol_a_n; assign rol_a_n = rol_a[7];
logic rol_a_z; assign rol_a_z = (rol_a == `ZERO_8) ? 1 : 0;
logic rol_a_c; assign rol_a_c = `A[7];

`LOGIC_32 rol_ea; assign rol_ea = {`eA[30:0], `eC};
logic rol_ea_n; assign rol_ea_n = rol_ea[31];
logic rol_ea_z; assign rol_ea_z = (rol_ea == `ZERO_32) ? 1 : 0;
logic rol_ea_c; assign rol_ea_c = `eA[31];

`LOGIC_8 rol_var; assign rol_var = {i_bus_data[6:0], `C};
logic rol_var_n; assign rol_var_n = rol_var[7];
logic rol_var_z; assign rol_var_z = (rol_var == `ZERO_8) ? 1 : 0;
logic rol_var_c; assign rol_var_c = i_bus_data[7];

`LOGIC_32 rol_evar; assign rol_evar = {reg_data_word[30:0], `eC};
logic rol_evar_n; assign rol_evar_n = rol_evar[31];
logic rol_evar_z; assign rol_evar_z = (rol_evar == `ZERO_32) ? 1 : 0;
logic rol_evar_c; assign rol_evar_c = reg_data_word[31];
