`wire_9 neg_a; assign neg_a = `ZERO_9 - uext_a_9;
wire neg_a_n; assign neg_a_n = neg_a[7];
wire neg_a_v; assign neg_a_v = neg_a[8] ^ neg_a[7];
wire neg_a_z; assign neg_a_z = (neg_a`VB == `ZERO_8) ? 1 : 0;
wire neg_a_c; assign neg_a_c = neg_a[8];

`wire_33 neg_ea; assign neg_ea = `ZERO_33 - uext_ea_33;
wire neg_ea_n; assign neg_ea_n = neg_ea[31];
wire neg_ea_v; assign neg_ea_v = neg_ea[32] ^ neg_ea[31];
wire neg_ea_z; assign neg_ea_z = (neg_ea`VW == `ZERO_32) ? 1 : 0;
wire neg_ea_c; assign neg_ea_c = neg_ea[32];

`wire_8 neg_var; assign neg_var = `ZERO_8 - reg_data_byte;
wire neg_var_n; assign neg_var_n = neg_var[7];
wire neg_var_z; assign neg_var_z = (neg_var == `ZERO_8) ? 1 : 0;

`wire_32 neg_evar; assign neg_evar = `ZERO_32 - reg_data_word;
wire neg_evar_n; assign neg_evar_n = neg_evar[31];
wire neg_evar_z; assign neg_evar_z = (neg_evar == `ZERO_32) ? 1 : 0;
