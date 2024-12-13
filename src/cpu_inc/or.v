`wire_8 or_a_src; assign or_a_src = `A | `DATA;
wire or_a_src_n; assign or_a_src_n = or_a_src[7];
wire or_a_src_z; assign or_a_src_z = (or_a_src == `ZERO_8) ? 1 : 0;

`wire_32 or_ea_src; assign or_ea_src = `eA | `eDATA;
wire or_ea_src_n; assign or_ea_src_n = or_ea_src[31];
wire or_ea_src_z; assign or_ea_src_z = (or_ea_src == `ZERO_32) ? 1 : 0;

`wire_8 or_a_var; assign or_a_var = `A | wire_data_byte_0;
wire or_a_var_n; assign or_a_var_n = or_a_var[7];
wire or_a_var_z; assign or_a_var_z = (or_a_var == `ZERO_8) ? 1 : 0;

`wire_32 or_ea_var; assign or_ea_var = `eA | wire_data_word;
wire or_ea_var_n; assign or_ea_var_n = or_ea_var[31];
wire or_ea_var_z; assign or_ea_var_z = (or_ea_var == `ZERO_32) ? 1 : 0;
