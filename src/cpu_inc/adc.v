`LOGIC_9 adc_a_src; assign adc_a_src = uext_a_9 + uext_src_9 + uext_c_9;
logic adc_a_src_n; assign adc_a_src_n = adc_a_src[7];
logic adc_a_src_v; assign adc_a_src_v = adc_a_src[8] ^ adc_a_src[7];
logic adc_a_src_z; assign adc_a_src_z = (adc_a_src`VB == `ZERO_8) ? 1 : 0;
logic adc_a_src_c; assign adc_a_src_c = adc_a_src[8];

`LOGIC_33 adc_ea_src; assign adc_ea_src = uext_ea_33 + uext_esrc_33 + uext_c_33;
logic adc_ea_src_n; assign adc_ea_src_n = adc_ea_src[31];
logic adc_ea_src_v; assign adc_ea_src_v = adc_ea_src[32] ^ adc_ea_src[31];
logic adc_ea_src_z; assign adc_ea_src_z = (adc_ea_src`VW == `ZERO_32) ? 1 : 0;
logic adc_ea_src_c; assign adc_ea_src_c = adc_ea_src[32];

`LOGIC_9 adc_a_var; assign adc_a_var = uext_a_9 + uext_var_9 + uext_c_9;
logic adc_a_var_n; assign adc_a_var_n = adc_a_var[7];
logic adc_a_var_v; assign adc_a_var_v = adc_a_var[8] ^ adc_a_var[7];
logic adc_a_var_z; assign adc_a_var_z = (adc_a_var`VB == `ZERO_8) ? 1 : 0;
logic adc_a_var_c; assign adc_a_var_c = adc_a_var[8];

`LOGIC_33 adc_ea_var; assign adc_ea_var = uext_ea_33 + uext_evar_33 + uext_c_33;
logic adc_ea_var_n; assign adc_ea_var_n = adc_ea_var[31];
logic adc_ea_var_v; assign adc_ea_var_v = adc_ea_var[32] ^ adc_ea_var[31];
logic adc_ea_var_z; assign adc_ea_var_z = (adc_ea_var`VW == `ZERO_32) ? 1 : 0;
logic adc_ea_var_c; assign adc_ea_var_c = adc_ea_var[32];
