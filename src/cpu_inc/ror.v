`LOGIC_8 ror_a; assign ror_a = {`C, `A[7:1]};
logic ror_a_n; assign ror_a_n = ror_a[7];
logic ror_a_z; assign ror_a_z = (ror_a == `ZERO_8) ? 1 : 0;
logic ror_a_c; assign ror_a_c = `A[0];

`LOGIC_32 ror_ea; assign ror_ea = {`eC, `eA[30:0]};
logic ror_ea_n; assign ror_ea_n = ror_ea[31];
logic ror_ea_z; assign ror_ea_z = (ror_ea == `ZERO_32) ? 1 : 0;
logic ror_ea_c; assign ror_ea_c = `eA[0];

`LOGIC_8 ror_var; assign ror_var = {`C, i_bus_data[7:1]};
logic ror_var_n; assign ror_var_n = ror_var[7];
logic ror_var_z; assign ror_var_z = (ror_var == `ZERO_8) ? 1 : 0;
logic ror_var_c; assign ror_var_c = i_bus_data[0];

`LOGIC_32 ror_evar; assign ror_evar = {`eC, reg_data_word[30:0]};
logic ror_evar_n; assign ror_evar_n = ror_evar[31];
logic ror_evar_z; assign ror_evar_z = (ror_evar == `ZERO_32) ? 1 : 0;
logic ror_evar_c; assign ror_evar_c = reg_data_word[0];
