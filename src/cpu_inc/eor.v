`LOGIC_8 eor_a_src; assign eor_a_src = `A ^ `SRC;
logic eor_a_src_n; assign eor_a_src_n = eor_a_src[7];
logic eor_a_src_z; assign eor_a_src_z = (eor_a_src == `ZERO_8) ? 1 : 0;

`LOGIC_32 eor_ea_src; assign eor_ea_src = `eA ^ `eSRC;
logic eor_ea_src_n; assign eor_ea_src_n = eor_ea_src[31];
logic eor_ea_src_z; assign eor_ea_src_z = (eor_ea_src == `ZERO_32) ? 1 : 0;

`LOGIC_8 eor_a_var; assign eor_a_var = `A ^ reg_data_byte;
logic eor_a_var_n; assign eor_a_var_n = eor_a_var[7];
logic eor_a_var_z; assign eor_a_var_z = (eor_a_var == `ZERO_8) ? 1 : 0;

`LOGIC_32 eor_ea_var; assign eor_ea_var = `eA ^ reg_data_word;
logic eor_ea_var_n; assign eor_ea_var_n = eor_ea_var[31];
logic eor_ea_var_z; assign eor_ea_var_z = (eor_ea_var == `ZERO_32) ? 1 : 0;
