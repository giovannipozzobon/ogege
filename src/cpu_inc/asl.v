`LOGIC_8 asl_a; assign asl_a = {`A[6:0], 1'b0};
logic asl_a_n; assign asl_a_n = asl_a[7];
logic asl_a_z; assign asl_a_z = (asl_a == `ZERO_8) ? 1 : 0;
logic asl_a_c; assign asl_a_c = `A[7];

`LOGIC_32 asl_ea; assign asl_ea = {`eA[30:0], 1'b0};
logic asl_ea_n; assign asl_ea_n = asl_ea[31];
logic asl_ea_z; assign asl_ea_z = (asl_ea == `ZERO_32) ? 1 : 0;
logic asl_ea_c; assign asl_ea_c = `eA[31];

`LOGIC_8 asl_var; assign asl_var = {i_bus_data[6:0], 1'b0};
logic asl_var_n; assign asl_var_n = asl_var[7];
logic asl_var_z; assign asl_var_z = (asl_var == `ZERO_8) ? 1 : 0;
logic asl_var_c; assign asl_var_c = i_bus_data[7];

`LOGIC_32 asl_evar; assign asl_evar = {reg_data_word[30:0], 1'b0};
logic asl_evar_n; assign asl_evar_n = asl_evar[31];
logic asl_evar_z; assign asl_evar_z = (asl_evar == `ZERO_32) ? 1 : 0;
logic asl_evar_c; assign asl_evar_c = reg_data_word[31];
