`wire_8 eor_a_src; assign eor_a_src = `A ^ `DATA;
wire eor_a_src_n; assign eor_a_src_n = eor_a_src[7];
wire eor_a_src_z; assign eor_a_src_z = (eor_a_src == `ZERO_8) ? 1 : 0;

`wire_32 eor_ea_src; assign eor_ea_src = `eA ^ `eDATA;
wire eor_ea_src_n; assign eor_ea_src_n = eor_ea_src[31];
wire eor_ea_src_z; assign eor_ea_src_z = (eor_ea_src == `ZERO_32) ? 1 : 0;

`wire_8 eor_a_var; assign eor_a_var = `A ^ wire_data_byte_0;
wire eor_a_var_n; assign eor_a_var_n = eor_a_var[7];
wire eor_a_var_z; assign eor_a_var_z = (eor_a_var == `ZERO_8) ? 1 : 0;

`wire_32 eor_ea_var; assign eor_ea_var = `eA ^ wire_data_word;
wire eor_ea_var_n; assign eor_ea_var_n = eor_ea_var[31];
wire eor_ea_var_z; assign eor_ea_var_z = (eor_ea_var == `ZERO_32) ? 1 : 0;
