`wire_8 and_a_src; assign and_a_src = `A & `SRC;
wire and_a_src_n; assign and_a_src_n = and_a_src[7];
wire and_a_src_v; assign and_a_src_v = and_a_src[6];
wire and_a_src_z; assign and_a_src_z = (and_a_src == `ZERO_8) ? 1 : 0;

`wire_32 and_ea_src; assign and_ea_src = `eA & `eSRC;
wire and_ea_src_n; assign and_ea_src_n = and_ea_src[31];
wire and_ea_src_v; assign and_ea_src_v = and_ea_src[30];
wire and_ea_src_z; assign and_ea_src_z = (and_ea_src == `ZERO_32) ? 1 : 0;

`wire_8 and_not_a_src; assign and_not_a_src = ~`A & `SRC;
wire and_not_a_src_n; assign and_not_a_src_n = and_not_a_src[7];
wire and_not_a_src_v; assign and_not_a_src_v = and_not_a_src[6];
wire and_not_a_src_z; assign and_not_a_src_z = (and_not_a_src == `ZERO_8) ? 1 : 0;

`wire_32 and_not_ea_src; assign and_not_ea_src = ~`eA & `eSRC;
wire and_not_ea_src_n; assign and_not_ea_src_n = and_not_ea_src[31];
wire and_not_ea_src_v; assign and_not_ea_src_v = and_not_ea_src[30];
wire and_not_ea_src_z; assign and_not_ea_src_z = (and_not_ea_src == `ZERO_32) ? 1 : 0;

`wire_8 and_a_var; assign and_a_var = `A & reg_data_byte;
wire and_a_var_n; assign and_a_var_n = and_a_var[7];
wire and_a_var_v; assign and_a_var_v = and_a_var[6];
wire and_a_var_z; assign and_a_var_z = (and_a_var == `ZERO_8) ? 1 : 0;

`wire_32 and_ea_var; assign and_ea_var = `eA & reg_data_word;
wire and_ea_var_n; assign and_ea_var_n = and_ea_var[31];
wire and_ea_var_v; assign and_ea_var_v = and_ea_var[30];
wire and_ea_var_z; assign and_ea_var_z = (and_ea_var == `ZERO_32) ? 1 : 0;

`wire_8 and_not_a_var; assign and_not_a_var = ~`A & reg_data_byte;
wire and_not_a_var_n; assign and_not_a_var_n = and_not_a_var[7];
wire and_not_a_var_v; assign and_not_a_var_v = and_not_a_var[6];
wire and_not_a_var_z; assign and_not_a_var_z = (and_not_a_var == `ZERO_8) ? 1 : 0;

`wire_32 and_not_ea_var; assign and_not_ea_var = ~`eA & reg_data_word;
wire and_not_ea_var_n; assign and_not_ea_var_n = and_not_ea_var[31];
wire and_not_ea_var_v; assign and_not_ea_var_v = and_not_ea_var[30];
wire and_not_ea_var_z; assign and_not_ea_var_z = (and_not_ea_var == `ZERO_32) ? 1 : 0;
