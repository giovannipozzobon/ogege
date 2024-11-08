`LOGIC_8 and_a_src; assign and_a_src = `A & `SRC;
logic and_a_src_n; assign and_a_src_n = and_a_src[7];
logic and_a_src_v; assign and_a_src_v = and_a_src[6];
logic and_a_src_z; assign and_a_src_z = (and_a_src == `ZERO_8) ? 1 : 0;

`LOGIC_32 and_ea_src; assign and_ea_src = `eA & `eSRC;
logic and_ea_src_n; assign and_ea_src_n = and_ea_src[31];
logic and_ea_src_v; assign and_ea_src_v = and_ea_src[30];
logic and_ea_src_z; assign and_ea_src_z = (and_ea_src == `ZERO_32) ? 1 : 0;

`LOGIC_8 and_not_a_src; assign and_not_a_src = ~`A & `SRC;
logic and_not_a_src_n; assign and_not_a_src_n = and_not_a_src[7];
logic and_not_a_src_v; assign and_not_a_src_v = and_not_a_src[6];
logic and_not_a_src_z; assign and_not_a_src_z = (and_not_a_src == `ZERO_8) ? 1 : 0;

`LOGIC_32 and_not_ea_src; assign and_not_ea_src = ~`eA & `eSRC;
logic and_not_ea_src_n; assign and_not_ea_src_n = and_not_ea_src[31];
logic and_not_ea_src_v; assign and_not_ea_src_v = and_not_ea_src[30];
logic and_not_ea_src_z; assign and_not_ea_src_z = (and_not_ea_src == `ZERO_32) ? 1 : 0;

`LOGIC_8 and_a_var; assign and_a_var = `A & reg_data_byte;
logic and_a_var_n; assign and_a_var_n = and_a_var[7];
logic and_a_var_v; assign and_a_var_v = and_a_var[6];
logic and_a_var_z; assign and_a_var_z = (and_a_var == `ZERO_8) ? 1 : 0;

`LOGIC_32 and_ea_var; assign and_ea_var = `eA & reg_data_word;
logic and_ea_var_n; assign and_ea_var_n = and_ea_var[31];
logic and_ea_var_v; assign and_ea_var_v = and_ea_var[30];
logic and_ea_var_z; assign and_ea_var_z = (and_ea_var == `ZERO_32) ? 1 : 0;

`LOGIC_8 and_not_a_var; assign and_not_a_var = ~`A & reg_data_byte;
logic and_not_a_var_n; assign and_not_a_var_n = and_not_a_var[7];
logic and_not_a_var_v; assign and_not_a_var_v = and_not_a_var[6];
logic and_not_a_var_z; assign and_not_a_var_z = (and_not_a_var == `ZERO_8) ? 1 : 0;

`LOGIC_32 and_not_ea_var; assign and_not_ea_var = ~`eA & reg_data_word;
logic and_not_ea_var_n; assign and_not_ea_var_n = and_not_ea_var[31];
logic and_not_ea_var_v; assign and_not_ea_var_v = and_not_ea_var[30];
logic and_not_ea_var_z; assign and_not_ea_var_z = (and_not_ea_var == `ZERO_32) ? 1 : 0;
