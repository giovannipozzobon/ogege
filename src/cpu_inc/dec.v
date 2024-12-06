`wire_8 dec_a; assign dec_a = `A - `ONE_8;
wire dec_a_n; assign dec_a_n = dec_a[7];
wire dec_a_z; assign dec_a_z = (dec_a == `ZERO_8) ? 1 : 0;

`wire_32 dec_ea; assign dec_ea = `eA - `ONE_32;
wire dec_ea_n; assign dec_ea_n = dec_ea[31];
wire dec_ea_z; assign dec_ea_z = (dec_ea == `ZERO_32) ? 1 : 0;

`wire_8 dec_pc; assign dec_pc = `PC - `ONE_8;

`wire_32 dec_epc; assign dec_epc = `ePC - `ONE_32;

`wire_8 dec_sp; assign dec_sp = `SP - `ONE_8;

`wire_32 dec_esp; assign dec_esp = `eSP - `ONE_32;

`wire_8 dec_x; assign dec_x = `X - `ONE_8;
wire dec_x_n; assign dec_x_n = dec_x[7];
wire dec_x_z; assign dec_x_z = (dec_x == `ZERO_8) ? 1 : 0;

`wire_32 dec_ex; assign dec_ex = `eX - `ONE_32;
wire dec_ex_n; assign dec_ex_n = dec_ex[31];
wire dec_ex_z; assign dec_ex_z = (dec_ex == `ZERO_32) ? 1 : 0;

`wire_8 dec_y; assign dec_y = `Y - `ONE_8;
wire dec_y_n; assign dec_y_n = dec_y[7];
wire dec_y_z; assign dec_y_z = (dec_y == `ZERO_8) ? 1 : 0;

`wire_32 dec_ey; assign dec_ey = `eY - `ONE_32;
wire dec_ey_n; assign dec_ey_n = dec_ey[31];
wire dec_ey_z; assign dec_ey_z = (dec_ey == `ZERO_32) ? 1 : 0;

`wire_8 dec_var; assign dec_var = reg_data_byte - `ONE_8;
wire dec_var_n; assign dec_var_n = dec_var[7];
wire dec_var_z; assign dec_var_z = (dec_var == `ZERO_8) ? 1 : 0;

`wire_32 dec_evar; assign dec_evar = reg_data_word - `ONE_32;
wire dec_evar_n; assign dec_evar_n = dec_evar[31];
wire dec_evar_z; assign dec_evar_z = (dec_evar == `ZERO_32) ? 1 : 0;
