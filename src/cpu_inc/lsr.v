`LOGIC_8 lsr_a; assign lsr_a = {1'b0, `A[7:1]};
logic lsr_a_n; assign lsr_a_n = lsr_a[7];
logic lsr_a_z; assign lsr_a_z = (lsr_a == `ZERO_8) ? 1 : 0;
logic lsr_a_c; assign lsr_a_c = `A[0];

`LOGIC_8 lsr_var; assign lsr_var = {1'b0, i_bus_data[7:1]};
logic lsr_var_n; assign lsr_var_n = lsr_var[7];
logic lsr_var_z; assign lsr_var_z = (lsr_var == `ZERO_8) ? 1 : 0;
logic lsr_var_c; assign lsr_var_c = i_bus_data[0];
