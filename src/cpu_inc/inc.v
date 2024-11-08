`LOGIC_8 inc_a; assign inc_a = `A + `ONE_8;
logic inc_a_n; assign inc_a_n = inc_a[7];
logic inc_a_z; assign inc_a_z = (inc_a == `ZERO_8) ? 1 : 0;

`LOGIC_32 inc_ea; assign inc_ea = `eA + `ONE_32;
logic inc_ea_n; assign inc_ea_n = inc_ea[31];
logic inc_ea_z; assign inc_ea_z = (inc_ea == `ZERO_32) ? 1 : 0;

`LOGIC_16 inc_addr; assign inc_addr = `ADDR + `ONE_16;

`LOGIC_16 inc_pc; assign inc_pc = `PC + `ONE_16;

`LOGIC_32 inc_epc; assign inc_epc = `ePC + `ONE_32;

`LOGIC_8 inc_sp; assign inc_sp = `SP + `ONE_8;

`LOGIC_32 inc_esp; assign inc_esp = `eSP + `ONE_32;

`LOGIC_8 inc_x; assign inc_x = `X + `ONE_8;
logic inc_x_n; assign inc_x_n = inc_x[7];
logic inc_x_z; assign inc_x_z = (inc_x == `ZERO_8) ? 1 : 0;

`LOGIC_32 inc_ex; assign inc_ex = `eX + `ONE_32;
logic inc_ex_n; assign inc_ex_n = inc_ex[31];
logic inc_ex_z; assign inc_ex_z = (inc_ex == `ZERO_32) ? 1 : 0;

`LOGIC_8 inc_y; assign inc_y = `Y + `ONE_8;
logic inc_y_n; assign inc_y_n = inc_y[7];
logic inc_y_z; assign inc_y_z = (inc_y == `ZERO_8) ? 1 : 0;

`LOGIC_32 inc_ey; assign inc_ey = `eY + `ONE_32;
logic inc_ey_n; assign inc_ey_n = inc_ey[31];
logic inc_ey_z; assign inc_ey_z = (inc_ey == `ZERO_32) ? 1 : 0;

`LOGIC_8 inc_var; assign inc_var = reg_data_byte + `ONE_8;
logic inc_var_n; assign inc_var_n = inc_var[7];
logic inc_var_z; assign inc_var_z = (inc_var == `ZERO_8) ? 1 : 0;

`LOGIC_32 inc_evar; assign inc_evar = reg_data_word + `ONE_32;
logic inc_evar_n; assign inc_evar_n = inc_evar[31];
logic inc_evar_z; assign inc_evar_z = (inc_evar == `ZERO_32) ? 1 : 0;

