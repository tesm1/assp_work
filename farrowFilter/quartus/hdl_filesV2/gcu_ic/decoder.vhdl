library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.myProssu_globals.all;
use work.myProssu_gcu_opcodes.all;

entity myProssu_decoder is

  port (
    instructionword : in std_logic_vector(INSTRUCTIONWIDTH-1 downto 0);
    pc_load : out std_logic;
    ra_load : out std_logic;
    pc_opcode : out std_logic_vector(0 downto 0);
    lock : in std_logic;
    lock_r : out std_logic;
    clk : in std_logic;
    rstx : in std_logic;
    simm_B1 : out std_logic_vector(31 downto 0);
    simm_cntrl_B1 : out std_logic_vector(0 downto 0);
    simm_B1_1 : out std_logic_vector(31 downto 0);
    simm_cntrl_B1_1 : out std_logic_vector(0 downto 0);
    simm_B1_2 : out std_logic_vector(31 downto 0);
    simm_cntrl_B1_2 : out std_logic_vector(0 downto 0);
    simm_B1_3 : out std_logic_vector(31 downto 0);
    simm_cntrl_B1_3 : out std_logic_vector(0 downto 0);
    simm_B1_4 : out std_logic_vector(31 downto 0);
    simm_cntrl_B1_4 : out std_logic_vector(0 downto 0);
    simm_B1_5 : out std_logic_vector(31 downto 0);
    simm_cntrl_B1_5 : out std_logic_vector(0 downto 0);
    simm_B1_6 : out std_logic_vector(31 downto 0);
    simm_cntrl_B1_6 : out std_logic_vector(0 downto 0);
    socket_lsu_i1_bus_cntrl : out std_logic_vector(2 downto 0);
    socket_lsu_o1_bus_cntrl : out std_logic_vector(6 downto 0);
    socket_lsu_i2_bus_cntrl : out std_logic_vector(2 downto 0);
    socket_RF_i1_bus_cntrl : out std_logic_vector(1 downto 0);
    socket_RF_o1_bus_cntrl : out std_logic_vector(2 downto 0);
    socket_gcu_i1_bus_cntrl : out std_logic_vector(2 downto 0);
    socket_gcu_o1_bus_cntrl : out std_logic_vector(6 downto 0);
    socket_ALU_i1_bus_cntrl : out std_logic_vector(2 downto 0);
    socket_ALU_i2_bus_cntrl : out std_logic_vector(2 downto 0);
    socket_ALU_o1_bus_cntrl : out std_logic_vector(6 downto 0);
    socket_stream_in_i1_bus_cntrl : out std_logic_vector(2 downto 0);
    socket_stream_in_o1_bus_cntrl : out std_logic_vector(6 downto 0);
    socket_stream_in_o2_bus_cntrl : out std_logic_vector(6 downto 0);
    socket_stream_out_i1_bus_cntrl : out std_logic_vector(2 downto 0);
    socket_mul_i1_bus_cntrl : out std_logic_vector(2 downto 0);
    socket_mul_i2_bus_cntrl : out std_logic_vector(2 downto 0);
    socket_mul_o1_bus_cntrl : out std_logic_vector(6 downto 0);
    socket_stream_out_o1_bus_cntrl : out std_logic_vector(6 downto 0);
    socket_gcu_i2_bus_cntrl : out std_logic_vector(2 downto 0);
    socket_add_0_i3_bus_cntrl : out std_logic_vector(2 downto 0);
    socket_add_0_i4_bus_cntrl : out std_logic_vector(2 downto 0);
    socket_add_0_o2_bus_cntrl : out std_logic_vector(6 downto 0);
    socket_RF_2_o1_bus_cntrl : out std_logic_vector(2 downto 0);
    socket_RF_2_i1_bus_cntrl : out std_logic_vector(1 downto 0);
    socket_BOOL_o1_bus_cntrl : out std_logic_vector(2 downto 0);
    socket_BOOL_i1_bus_cntrl : out std_logic_vector(1 downto 0);
    socket_stream_in_1_i1_bus_cntrl : out std_logic_vector(2 downto 0);
    socket_stream_in_1_o1_bus_cntrl : out std_logic_vector(6 downto 0);
    socket_stream_in_1_o2_bus_cntrl : out std_logic_vector(6 downto 0);
    socket_and_ior_i1_bus_cntrl : out std_logic_vector(2 downto 0);
    socket_and_ior_i2_bus_cntrl : out std_logic_vector(2 downto 0);
    socket_and_ior_o1_bus_cntrl : out std_logic_vector(6 downto 0);
    fu_LSU_in1t_load : out std_logic;
    fu_LSU_in2_load : out std_logic;
    fu_LSU_opc : out std_logic_vector(2 downto 0);
    fu_ALU_in1t_load : out std_logic;
    fu_ALU_in2_load : out std_logic;
    fu_ALU_opc : out std_logic_vector(3 downto 0);
    fu_stream_in_in1t_load : out std_logic;
    fu_stream_in_opc : out std_logic_vector(0 downto 0);
    fu_stream_out_in1t_load : out std_logic;
    fu_stream_out_opc : out std_logic_vector(0 downto 0);
    fu_mul_0_in1t_load : out std_logic;
    fu_mul_0_in2_load : out std_logic;
    fu_add_0_in1t_load : out std_logic;
    fu_add_0_in2_load : out std_logic;
    fu_delay_in_in1t_load : out std_logic;
    fu_delay_in_opc : out std_logic_vector(0 downto 0);
    fu_and_ior_in1t_load : out std_logic;
    fu_and_ior_in2_load : out std_logic;
    fu_and_ior_opc : out std_logic_vector(0 downto 0);
    rf_RF_1_wr_load : out std_logic;
    rf_RF_1_wr_opc : out std_logic_vector(2 downto 0);
    rf_RF_1_rd_load : out std_logic;
    rf_RF_1_rd_opc : out std_logic_vector(2 downto 0);
    rf_RF_2_wr_load : out std_logic;
    rf_RF_2_wr_opc : out std_logic_vector(2 downto 0);
    rf_RF_2_rd_load : out std_logic;
    rf_RF_2_rd_opc : out std_logic_vector(2 downto 0);
    rf_BOOL_wr_load : out std_logic;
    rf_BOOL_wr_opc : out std_logic_vector(0 downto 0);
    rf_BOOL_rd_load : out std_logic;
    rf_BOOL_rd_opc : out std_logic_vector(0 downto 0);
    rf_guard_BOOL_0 : in std_logic;
    rf_guard_BOOL_1 : in std_logic;
    glock : out std_logic);

end myProssu_decoder;

architecture rtl_andor of myProssu_decoder is

  -- signals for source, destination and guard fields
  signal src_B1 : std_logic_vector(32 downto 0);
  signal dst_B1 : std_logic_vector(5 downto 0);
  signal grd_B1 : std_logic_vector(2 downto 0);
  signal src_B1_1 : std_logic_vector(32 downto 0);
  signal dst_B1_1 : std_logic_vector(5 downto 0);
  signal grd_B1_1 : std_logic_vector(2 downto 0);
  signal src_B1_2 : std_logic_vector(32 downto 0);
  signal dst_B1_2 : std_logic_vector(5 downto 0);
  signal grd_B1_2 : std_logic_vector(2 downto 0);
  signal src_B1_3 : std_logic_vector(32 downto 0);
  signal dst_B1_3 : std_logic_vector(5 downto 0);
  signal grd_B1_3 : std_logic_vector(2 downto 0);
  signal src_B1_4 : std_logic_vector(32 downto 0);
  signal dst_B1_4 : std_logic_vector(5 downto 0);
  signal grd_B1_4 : std_logic_vector(2 downto 0);
  signal src_B1_5 : std_logic_vector(32 downto 0);
  signal dst_B1_5 : std_logic_vector(5 downto 0);
  signal grd_B1_5 : std_logic_vector(2 downto 0);
  signal src_B1_6 : std_logic_vector(32 downto 0);
  signal dst_B1_6 : std_logic_vector(5 downto 0);
  signal grd_B1_6 : std_logic_vector(2 downto 0);

  -- signals for dedicated immediate slots


  -- squash signals
  signal squash_B1 : std_logic;
  signal squash_B1_1 : std_logic;
  signal squash_B1_2 : std_logic;
  signal squash_B1_3 : std_logic;
  signal squash_B1_4 : std_logic;
  signal squash_B1_5 : std_logic;
  signal squash_B1_6 : std_logic;

  -- socket control signals
  signal socket_lsu_i1_bus_cntrl_reg : std_logic_vector(2 downto 0);
  signal socket_lsu_o1_bus_cntrl_reg : std_logic_vector(6 downto 0);
  signal socket_lsu_i2_bus_cntrl_reg : std_logic_vector(2 downto 0);
  signal socket_RF_i1_bus_cntrl_reg : std_logic_vector(1 downto 0);
  signal socket_RF_o1_bus_cntrl_reg : std_logic_vector(2 downto 0);
  signal socket_gcu_i1_bus_cntrl_reg : std_logic_vector(2 downto 0);
  signal socket_gcu_o1_bus_cntrl_reg : std_logic_vector(6 downto 0);
  signal socket_ALU_i1_bus_cntrl_reg : std_logic_vector(2 downto 0);
  signal socket_ALU_i2_bus_cntrl_reg : std_logic_vector(2 downto 0);
  signal socket_ALU_o1_bus_cntrl_reg : std_logic_vector(6 downto 0);
  signal socket_stream_in_i1_bus_cntrl_reg : std_logic_vector(2 downto 0);
  signal socket_stream_in_o1_bus_cntrl_reg : std_logic_vector(6 downto 0);
  signal socket_stream_in_o2_bus_cntrl_reg : std_logic_vector(6 downto 0);
  signal socket_stream_out_i1_bus_cntrl_reg : std_logic_vector(2 downto 0);
  signal socket_mul_i1_bus_cntrl_reg : std_logic_vector(2 downto 0);
  signal socket_mul_i2_bus_cntrl_reg : std_logic_vector(2 downto 0);
  signal socket_mul_o1_bus_cntrl_reg : std_logic_vector(6 downto 0);
  signal socket_stream_out_o1_bus_cntrl_reg : std_logic_vector(6 downto 0);
  signal socket_gcu_i2_bus_cntrl_reg : std_logic_vector(2 downto 0);
  signal socket_add_0_i3_bus_cntrl_reg : std_logic_vector(2 downto 0);
  signal socket_add_0_i4_bus_cntrl_reg : std_logic_vector(2 downto 0);
  signal socket_add_0_o2_bus_cntrl_reg : std_logic_vector(6 downto 0);
  signal socket_RF_2_o1_bus_cntrl_reg : std_logic_vector(2 downto 0);
  signal socket_RF_2_i1_bus_cntrl_reg : std_logic_vector(1 downto 0);
  signal socket_BOOL_o1_bus_cntrl_reg : std_logic_vector(2 downto 0);
  signal socket_BOOL_i1_bus_cntrl_reg : std_logic_vector(1 downto 0);
  signal socket_stream_in_1_i1_bus_cntrl_reg : std_logic_vector(2 downto 0);
  signal socket_stream_in_1_o1_bus_cntrl_reg : std_logic_vector(6 downto 0);
  signal socket_stream_in_1_o2_bus_cntrl_reg : std_logic_vector(6 downto 0);
  signal socket_and_ior_i1_bus_cntrl_reg : std_logic_vector(2 downto 0);
  signal socket_and_ior_i2_bus_cntrl_reg : std_logic_vector(2 downto 0);
  signal socket_and_ior_o1_bus_cntrl_reg : std_logic_vector(6 downto 0);
  signal simm_B1_reg : std_logic_vector(31 downto 0);
  signal simm_cntrl_B1_reg : std_logic_vector(0 downto 0);
  signal simm_B1_1_reg : std_logic_vector(31 downto 0);
  signal simm_cntrl_B1_1_reg : std_logic_vector(0 downto 0);
  signal simm_B1_2_reg : std_logic_vector(31 downto 0);
  signal simm_cntrl_B1_2_reg : std_logic_vector(0 downto 0);
  signal simm_B1_3_reg : std_logic_vector(31 downto 0);
  signal simm_cntrl_B1_3_reg : std_logic_vector(0 downto 0);
  signal simm_B1_4_reg : std_logic_vector(31 downto 0);
  signal simm_cntrl_B1_4_reg : std_logic_vector(0 downto 0);
  signal simm_B1_5_reg : std_logic_vector(31 downto 0);
  signal simm_cntrl_B1_5_reg : std_logic_vector(0 downto 0);
  signal simm_B1_6_reg : std_logic_vector(31 downto 0);
  signal simm_cntrl_B1_6_reg : std_logic_vector(0 downto 0);

  -- FU control signals
  signal fu_LSU_in1t_load_reg : std_logic;
  signal fu_LSU_in2_load_reg : std_logic;
  signal fu_LSU_opc_reg : std_logic_vector(2 downto 0);
  signal fu_ALU_in1t_load_reg : std_logic;
  signal fu_ALU_in2_load_reg : std_logic;
  signal fu_ALU_opc_reg : std_logic_vector(3 downto 0);
  signal fu_stream_in_in1t_load_reg : std_logic;
  signal fu_stream_in_opc_reg : std_logic_vector(0 downto 0);
  signal fu_stream_out_in1t_load_reg : std_logic;
  signal fu_stream_out_opc_reg : std_logic_vector(0 downto 0);
  signal fu_mul_0_in1t_load_reg : std_logic;
  signal fu_mul_0_in2_load_reg : std_logic;
  signal fu_add_0_in1t_load_reg : std_logic;
  signal fu_add_0_in2_load_reg : std_logic;
  signal fu_delay_in_in1t_load_reg : std_logic;
  signal fu_delay_in_opc_reg : std_logic_vector(0 downto 0);
  signal fu_and_ior_in1t_load_reg : std_logic;
  signal fu_and_ior_in2_load_reg : std_logic;
  signal fu_and_ior_opc_reg : std_logic_vector(0 downto 0);
  signal fu_gcu_pc_load_reg : std_logic;
  signal fu_gcu_ra_load_reg : std_logic;
  signal fu_gcu_opc_reg : std_logic_vector(0 downto 0);

  -- RF control signals
  signal rf_RF_1_wr_load_reg : std_logic;
  signal rf_RF_1_wr_opc_reg : std_logic_vector(2 downto 0);
  signal rf_RF_1_rd_load_reg : std_logic;
  signal rf_RF_1_rd_opc_reg : std_logic_vector(2 downto 0);
  signal rf_RF_2_wr_load_reg : std_logic;
  signal rf_RF_2_wr_opc_reg : std_logic_vector(2 downto 0);
  signal rf_RF_2_rd_load_reg : std_logic;
  signal rf_RF_2_rd_opc_reg : std_logic_vector(2 downto 0);
  signal rf_BOOL_wr_load_reg : std_logic;
  signal rf_BOOL_wr_opc_reg : std_logic_vector(0 downto 0);
  signal rf_BOOL_rd_load_reg : std_logic;
  signal rf_BOOL_rd_opc_reg : std_logic_vector(0 downto 0);

begin

  -- dismembering of instruction
  process (instructionword)
  begin --process
    src_B1 <= instructionword(38 downto 6);
    dst_B1 <= instructionword(5 downto 0);
    grd_B1 <= instructionword(41 downto 39);
    src_B1_1 <= instructionword(80 downto 48);
    dst_B1_1 <= instructionword(47 downto 42);
    grd_B1_1 <= instructionword(83 downto 81);
    src_B1_2 <= instructionword(122 downto 90);
    dst_B1_2 <= instructionword(89 downto 84);
    grd_B1_2 <= instructionword(125 downto 123);
    src_B1_3 <= instructionword(164 downto 132);
    dst_B1_3 <= instructionword(131 downto 126);
    grd_B1_3 <= instructionword(167 downto 165);
    src_B1_4 <= instructionword(206 downto 174);
    dst_B1_4 <= instructionword(173 downto 168);
    grd_B1_4 <= instructionword(209 downto 207);
    src_B1_5 <= instructionword(248 downto 216);
    dst_B1_5 <= instructionword(215 downto 210);
    grd_B1_5 <= instructionword(251 downto 249);
    src_B1_6 <= instructionword(290 downto 258);
    dst_B1_6 <= instructionword(257 downto 252);
    grd_B1_6 <= instructionword(293 downto 291);

  end process;

  -- map control registers to outputs
  fu_LSU_in1t_load <= fu_LSU_in1t_load_reg;
  fu_LSU_in2_load <= fu_LSU_in2_load_reg;
  fu_LSU_opc <= fu_LSU_opc_reg;

  fu_ALU_in1t_load <= fu_ALU_in1t_load_reg;
  fu_ALU_in2_load <= fu_ALU_in2_load_reg;
  fu_ALU_opc <= fu_ALU_opc_reg;

  fu_stream_in_in1t_load <= fu_stream_in_in1t_load_reg;
  fu_stream_in_opc <= fu_stream_in_opc_reg;

  fu_stream_out_in1t_load <= fu_stream_out_in1t_load_reg;
  fu_stream_out_opc <= fu_stream_out_opc_reg;

  fu_mul_0_in1t_load <= fu_mul_0_in1t_load_reg;
  fu_mul_0_in2_load <= fu_mul_0_in2_load_reg;

  fu_add_0_in1t_load <= fu_add_0_in1t_load_reg;
  fu_add_0_in2_load <= fu_add_0_in2_load_reg;

  fu_delay_in_in1t_load <= fu_delay_in_in1t_load_reg;
  fu_delay_in_opc <= fu_delay_in_opc_reg;

  fu_and_ior_in1t_load <= fu_and_ior_in1t_load_reg;
  fu_and_ior_in2_load <= fu_and_ior_in2_load_reg;
  fu_and_ior_opc <= fu_and_ior_opc_reg;

  ra_load <= fu_gcu_ra_load_reg;
  pc_load <= fu_gcu_pc_load_reg;
  pc_opcode <= fu_gcu_opc_reg;
  rf_RF_1_wr_load <= rf_RF_1_wr_load_reg;
  rf_RF_1_wr_opc <= rf_RF_1_wr_opc_reg;
  rf_RF_1_rd_load <= rf_RF_1_rd_load_reg;
  rf_RF_1_rd_opc <= rf_RF_1_rd_opc_reg;
  rf_RF_2_wr_load <= rf_RF_2_wr_load_reg;
  rf_RF_2_wr_opc <= rf_RF_2_wr_opc_reg;
  rf_RF_2_rd_load <= rf_RF_2_rd_load_reg;
  rf_RF_2_rd_opc <= rf_RF_2_rd_opc_reg;
  rf_BOOL_wr_load <= rf_BOOL_wr_load_reg;
  rf_BOOL_wr_opc <= rf_BOOL_wr_opc_reg;
  rf_BOOL_rd_load <= rf_BOOL_rd_load_reg;
  rf_BOOL_rd_opc <= rf_BOOL_rd_opc_reg;
  socket_lsu_i1_bus_cntrl <= socket_lsu_i1_bus_cntrl_reg;
  socket_lsu_o1_bus_cntrl <= socket_lsu_o1_bus_cntrl_reg;
  socket_lsu_i2_bus_cntrl <= socket_lsu_i2_bus_cntrl_reg;
  socket_RF_i1_bus_cntrl <= socket_RF_i1_bus_cntrl_reg;
  socket_RF_o1_bus_cntrl <= socket_RF_o1_bus_cntrl_reg;
  socket_gcu_i1_bus_cntrl <= socket_gcu_i1_bus_cntrl_reg;
  socket_gcu_o1_bus_cntrl <= socket_gcu_o1_bus_cntrl_reg;
  socket_ALU_i1_bus_cntrl <= socket_ALU_i1_bus_cntrl_reg;
  socket_ALU_i2_bus_cntrl <= socket_ALU_i2_bus_cntrl_reg;
  socket_ALU_o1_bus_cntrl <= socket_ALU_o1_bus_cntrl_reg;
  socket_stream_in_i1_bus_cntrl <= socket_stream_in_i1_bus_cntrl_reg;
  socket_stream_in_o1_bus_cntrl <= socket_stream_in_o1_bus_cntrl_reg;
  socket_stream_in_o2_bus_cntrl <= socket_stream_in_o2_bus_cntrl_reg;
  socket_stream_out_i1_bus_cntrl <= socket_stream_out_i1_bus_cntrl_reg;
  socket_mul_i1_bus_cntrl <= socket_mul_i1_bus_cntrl_reg;
  socket_mul_i2_bus_cntrl <= socket_mul_i2_bus_cntrl_reg;
  socket_mul_o1_bus_cntrl <= socket_mul_o1_bus_cntrl_reg;
  socket_stream_out_o1_bus_cntrl <= socket_stream_out_o1_bus_cntrl_reg;
  socket_gcu_i2_bus_cntrl <= socket_gcu_i2_bus_cntrl_reg;
  socket_add_0_i3_bus_cntrl <= socket_add_0_i3_bus_cntrl_reg;
  socket_add_0_i4_bus_cntrl <= socket_add_0_i4_bus_cntrl_reg;
  socket_add_0_o2_bus_cntrl <= socket_add_0_o2_bus_cntrl_reg;
  socket_RF_2_o1_bus_cntrl <= socket_RF_2_o1_bus_cntrl_reg;
  socket_RF_2_i1_bus_cntrl <= socket_RF_2_i1_bus_cntrl_reg;
  socket_BOOL_o1_bus_cntrl <= socket_BOOL_o1_bus_cntrl_reg;
  socket_BOOL_i1_bus_cntrl <= socket_BOOL_i1_bus_cntrl_reg;
  socket_stream_in_1_i1_bus_cntrl <= socket_stream_in_1_i1_bus_cntrl_reg;
  socket_stream_in_1_o1_bus_cntrl <= socket_stream_in_1_o1_bus_cntrl_reg;
  socket_stream_in_1_o2_bus_cntrl <= socket_stream_in_1_o2_bus_cntrl_reg;
  socket_and_ior_i1_bus_cntrl <= socket_and_ior_i1_bus_cntrl_reg;
  socket_and_ior_i2_bus_cntrl <= socket_and_ior_i2_bus_cntrl_reg;
  socket_and_ior_o1_bus_cntrl <= socket_and_ior_o1_bus_cntrl_reg;
  simm_cntrl_B1 <= simm_cntrl_B1_reg;
  simm_B1 <= simm_B1_reg;
  simm_cntrl_B1_1 <= simm_cntrl_B1_1_reg;
  simm_B1_1 <= simm_B1_1_reg;
  simm_cntrl_B1_2 <= simm_cntrl_B1_2_reg;
  simm_B1_2 <= simm_B1_2_reg;
  simm_cntrl_B1_3 <= simm_cntrl_B1_3_reg;
  simm_B1_3 <= simm_B1_3_reg;
  simm_cntrl_B1_4 <= simm_cntrl_B1_4_reg;
  simm_B1_4 <= simm_B1_4_reg;
  simm_cntrl_B1_5 <= simm_cntrl_B1_5_reg;
  simm_B1_5 <= simm_B1_5_reg;
  simm_cntrl_B1_6 <= simm_cntrl_B1_6_reg;
  simm_B1_6 <= simm_B1_6_reg;

  -- generate signal squash_B1
  process (rf_guard_BOOL_0, rf_guard_BOOL_1, grd_B1)
    variable sel : integer;
  begin --process
    sel := conv_integer(unsigned(grd_B1));
    case sel is
      when 1 =>
        squash_B1 <= not rf_guard_BOOL_0;
      when 2 =>
        squash_B1 <= not rf_guard_BOOL_1;
      when 3 =>
        squash_B1 <= rf_guard_BOOL_0;
      when 4 =>
        squash_B1 <= rf_guard_BOOL_1;
      when others =>
        squash_B1 <= '0';
    end case;
  end process;

  -- generate signal squash_B1_1
  process (rf_guard_BOOL_0, rf_guard_BOOL_1, grd_B1_1)
    variable sel : integer;
  begin --process
    sel := conv_integer(unsigned(grd_B1_1));
    case sel is
      when 1 =>
        squash_B1_1 <= not rf_guard_BOOL_0;
      when 2 =>
        squash_B1_1 <= not rf_guard_BOOL_1;
      when 3 =>
        squash_B1_1 <= rf_guard_BOOL_0;
      when 4 =>
        squash_B1_1 <= rf_guard_BOOL_1;
      when others =>
        squash_B1_1 <= '0';
    end case;
  end process;

  -- generate signal squash_B1_2
  process (rf_guard_BOOL_0, rf_guard_BOOL_1, grd_B1_2)
    variable sel : integer;
  begin --process
    sel := conv_integer(unsigned(grd_B1_2));
    case sel is
      when 1 =>
        squash_B1_2 <= not rf_guard_BOOL_0;
      when 2 =>
        squash_B1_2 <= not rf_guard_BOOL_1;
      when 3 =>
        squash_B1_2 <= rf_guard_BOOL_0;
      when 4 =>
        squash_B1_2 <= rf_guard_BOOL_1;
      when others =>
        squash_B1_2 <= '0';
    end case;
  end process;

  -- generate signal squash_B1_3
  process (rf_guard_BOOL_0, rf_guard_BOOL_1, grd_B1_3)
    variable sel : integer;
  begin --process
    sel := conv_integer(unsigned(grd_B1_3));
    case sel is
      when 1 =>
        squash_B1_3 <= not rf_guard_BOOL_0;
      when 2 =>
        squash_B1_3 <= not rf_guard_BOOL_1;
      when 3 =>
        squash_B1_3 <= rf_guard_BOOL_0;
      when 4 =>
        squash_B1_3 <= rf_guard_BOOL_1;
      when others =>
        squash_B1_3 <= '0';
    end case;
  end process;

  -- generate signal squash_B1_4
  process (rf_guard_BOOL_0, rf_guard_BOOL_1, grd_B1_4)
    variable sel : integer;
  begin --process
    sel := conv_integer(unsigned(grd_B1_4));
    case sel is
      when 1 =>
        squash_B1_4 <= not rf_guard_BOOL_0;
      when 2 =>
        squash_B1_4 <= not rf_guard_BOOL_1;
      when 3 =>
        squash_B1_4 <= rf_guard_BOOL_0;
      when 4 =>
        squash_B1_4 <= rf_guard_BOOL_1;
      when others =>
        squash_B1_4 <= '0';
    end case;
  end process;

  -- generate signal squash_B1_5
  process (rf_guard_BOOL_0, rf_guard_BOOL_1, grd_B1_5)
    variable sel : integer;
  begin --process
    sel := conv_integer(unsigned(grd_B1_5));
    case sel is
      when 1 =>
        squash_B1_5 <= not rf_guard_BOOL_0;
      when 2 =>
        squash_B1_5 <= not rf_guard_BOOL_1;
      when 3 =>
        squash_B1_5 <= rf_guard_BOOL_0;
      when 4 =>
        squash_B1_5 <= rf_guard_BOOL_1;
      when others =>
        squash_B1_5 <= '0';
    end case;
  end process;

  -- generate signal squash_B1_6
  process (rf_guard_BOOL_0, rf_guard_BOOL_1, grd_B1_6)
    variable sel : integer;
  begin --process
    sel := conv_integer(unsigned(grd_B1_6));
    case sel is
      when 1 =>
        squash_B1_6 <= not rf_guard_BOOL_0;
      when 2 =>
        squash_B1_6 <= not rf_guard_BOOL_1;
      when 3 =>
        squash_B1_6 <= rf_guard_BOOL_0;
      when 4 =>
        squash_B1_6 <= rf_guard_BOOL_1;
      when others =>
        squash_B1_6 <= '0';
    end case;
  end process;



  -- main decoding process
  process (clk, rstx)
  begin
    if (rstx = '0') then
      socket_lsu_i1_bus_cntrl_reg <= (others => '0');
      socket_lsu_o1_bus_cntrl_reg <= (others => '0');
      socket_lsu_i2_bus_cntrl_reg <= (others => '0');
      socket_RF_i1_bus_cntrl_reg <= (others => '0');
      socket_RF_o1_bus_cntrl_reg <= (others => '0');
      socket_gcu_i1_bus_cntrl_reg <= (others => '0');
      socket_gcu_o1_bus_cntrl_reg <= (others => '0');
      socket_ALU_i1_bus_cntrl_reg <= (others => '0');
      socket_ALU_i2_bus_cntrl_reg <= (others => '0');
      socket_ALU_o1_bus_cntrl_reg <= (others => '0');
      socket_stream_in_i1_bus_cntrl_reg <= (others => '0');
      socket_stream_in_o1_bus_cntrl_reg <= (others => '0');
      socket_stream_in_o2_bus_cntrl_reg <= (others => '0');
      socket_stream_out_i1_bus_cntrl_reg <= (others => '0');
      socket_mul_i1_bus_cntrl_reg <= (others => '0');
      socket_mul_i2_bus_cntrl_reg <= (others => '0');
      socket_mul_o1_bus_cntrl_reg <= (others => '0');
      socket_stream_out_o1_bus_cntrl_reg <= (others => '0');
      socket_gcu_i2_bus_cntrl_reg <= (others => '0');
      socket_add_0_i3_bus_cntrl_reg <= (others => '0');
      socket_add_0_i4_bus_cntrl_reg <= (others => '0');
      socket_add_0_o2_bus_cntrl_reg <= (others => '0');
      socket_RF_2_o1_bus_cntrl_reg <= (others => '0');
      socket_RF_2_i1_bus_cntrl_reg <= (others => '0');
      socket_BOOL_o1_bus_cntrl_reg <= (others => '0');
      socket_BOOL_i1_bus_cntrl_reg <= (others => '0');
      socket_stream_in_1_i1_bus_cntrl_reg <= (others => '0');
      socket_stream_in_1_o1_bus_cntrl_reg <= (others => '0');
      socket_stream_in_1_o2_bus_cntrl_reg <= (others => '0');
      socket_and_ior_i1_bus_cntrl_reg <= (others => '0');
      socket_and_ior_i2_bus_cntrl_reg <= (others => '0');
      socket_and_ior_o1_bus_cntrl_reg <= (others => '0');

      simm_cntrl_B1_reg <= (others => '0');
      simm_B1_reg <= (others => '0');
      simm_cntrl_B1_1_reg <= (others => '0');
      simm_B1_1_reg <= (others => '0');
      simm_cntrl_B1_2_reg <= (others => '0');
      simm_B1_2_reg <= (others => '0');
      simm_cntrl_B1_3_reg <= (others => '0');
      simm_B1_3_reg <= (others => '0');
      simm_cntrl_B1_4_reg <= (others => '0');
      simm_B1_4_reg <= (others => '0');
      simm_cntrl_B1_5_reg <= (others => '0');
      simm_B1_5_reg <= (others => '0');
      simm_cntrl_B1_6_reg <= (others => '0');
      simm_B1_6_reg <= (others => '0');

      fu_LSU_opc_reg <= (others => '0');
      fu_LSU_in1t_load_reg <= '0';
      fu_LSU_in2_load_reg <= '0';
      fu_ALU_opc_reg <= (others => '0');
      fu_ALU_in1t_load_reg <= '0';
      fu_ALU_in2_load_reg <= '0';
      fu_stream_in_opc_reg <= (others => '0');
      fu_stream_in_in1t_load_reg <= '0';
      fu_stream_out_opc_reg <= (others => '0');
      fu_stream_out_in1t_load_reg <= '0';
      fu_mul_0_in1t_load_reg <= '0';
      fu_mul_0_in2_load_reg <= '0';
      fu_add_0_in1t_load_reg <= '0';
      fu_add_0_in2_load_reg <= '0';
      fu_delay_in_opc_reg <= (others => '0');
      fu_delay_in_in1t_load_reg <= '0';
      fu_and_ior_opc_reg <= (others => '0');
      fu_and_ior_in1t_load_reg <= '0';
      fu_and_ior_in2_load_reg <= '0';
      fu_gcu_opc_reg <= (others => '0');
      fu_gcu_pc_load_reg <= '0';
      fu_gcu_ra_load_reg <= '0';

      rf_RF_1_wr_load_reg <= '0';
      rf_RF_1_wr_opc_reg <= (others => '0');
      rf_RF_1_rd_load_reg <= '0';
      rf_RF_1_rd_opc_reg <= (others => '0');
      rf_RF_2_wr_load_reg <= '0';
      rf_RF_2_wr_opc_reg <= (others => '0');
      rf_RF_2_rd_load_reg <= '0';
      rf_RF_2_rd_opc_reg <= (others => '0');
      rf_BOOL_wr_load_reg <= '0';
      rf_BOOL_wr_opc_reg <= (others => '0');
      rf_BOOL_rd_load_reg <= '0';
      rf_BOOL_rd_opc_reg <= (others => '0');


    elsif (clk'event and clk = '1') then
      if (lock = '0') then -- rising clock edge

        --bus control signals for output sockets
        if (conv_integer(unsigned(src_B1(32 downto 28))) = 17 and squash_B1 = '0') then
          socket_lsu_o1_bus_cntrl_reg(0) <= '1';
        else
          socket_lsu_o1_bus_cntrl_reg(0) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_6(32 downto 28))) = 20 and squash_B1_6 = '0') then
          socket_lsu_o1_bus_cntrl_reg(6) <= '1';
        else
          socket_lsu_o1_bus_cntrl_reg(6) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_5(32 downto 28))) = 20 and squash_B1_5 = '0') then
          socket_lsu_o1_bus_cntrl_reg(5) <= '1';
        else
          socket_lsu_o1_bus_cntrl_reg(5) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_4(32 downto 28))) = 20 and squash_B1_4 = '0') then
          socket_lsu_o1_bus_cntrl_reg(4) <= '1';
        else
          socket_lsu_o1_bus_cntrl_reg(4) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_3(32 downto 28))) = 17 and squash_B1_3 = '0') then
          socket_lsu_o1_bus_cntrl_reg(3) <= '1';
        else
          socket_lsu_o1_bus_cntrl_reg(3) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_2(32 downto 28))) = 17 and squash_B1_2 = '0') then
          socket_lsu_o1_bus_cntrl_reg(2) <= '1';
        else
          socket_lsu_o1_bus_cntrl_reg(2) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_1(32 downto 28))) = 17 and squash_B1_1 = '0') then
          socket_lsu_o1_bus_cntrl_reg(1) <= '1';
        else
          socket_lsu_o1_bus_cntrl_reg(1) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_6(32 downto 28))) = 16 and squash_B1_6 = '0') then
          socket_RF_o1_bus_cntrl_reg(2) <= '1';
        else
          socket_RF_o1_bus_cntrl_reg(2) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_5(32 downto 28))) = 16 and squash_B1_5 = '0') then
          socket_RF_o1_bus_cntrl_reg(1) <= '1';
        else
          socket_RF_o1_bus_cntrl_reg(1) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_4(32 downto 28))) = 16 and squash_B1_4 = '0') then
          socket_RF_o1_bus_cntrl_reg(0) <= '1';
        else
          socket_RF_o1_bus_cntrl_reg(0) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1(32 downto 28))) = 18 and squash_B1 = '0') then
          socket_gcu_o1_bus_cntrl_reg(0) <= '1';
        else
          socket_gcu_o1_bus_cntrl_reg(0) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_6(32 downto 28))) = 21 and squash_B1_6 = '0') then
          socket_gcu_o1_bus_cntrl_reg(6) <= '1';
        else
          socket_gcu_o1_bus_cntrl_reg(6) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_5(32 downto 28))) = 21 and squash_B1_5 = '0') then
          socket_gcu_o1_bus_cntrl_reg(5) <= '1';
        else
          socket_gcu_o1_bus_cntrl_reg(5) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_4(32 downto 28))) = 21 and squash_B1_4 = '0') then
          socket_gcu_o1_bus_cntrl_reg(4) <= '1';
        else
          socket_gcu_o1_bus_cntrl_reg(4) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_3(32 downto 28))) = 18 and squash_B1_3 = '0') then
          socket_gcu_o1_bus_cntrl_reg(3) <= '1';
        else
          socket_gcu_o1_bus_cntrl_reg(3) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_2(32 downto 28))) = 18 and squash_B1_2 = '0') then
          socket_gcu_o1_bus_cntrl_reg(2) <= '1';
        else
          socket_gcu_o1_bus_cntrl_reg(2) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_1(32 downto 28))) = 18 and squash_B1_1 = '0') then
          socket_gcu_o1_bus_cntrl_reg(1) <= '1';
        else
          socket_gcu_o1_bus_cntrl_reg(1) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1(32 downto 28))) = 19 and squash_B1 = '0') then
          socket_ALU_o1_bus_cntrl_reg(0) <= '1';
        else
          socket_ALU_o1_bus_cntrl_reg(0) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_6(32 downto 28))) = 22 and squash_B1_6 = '0') then
          socket_ALU_o1_bus_cntrl_reg(6) <= '1';
        else
          socket_ALU_o1_bus_cntrl_reg(6) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_5(32 downto 28))) = 22 and squash_B1_5 = '0') then
          socket_ALU_o1_bus_cntrl_reg(5) <= '1';
        else
          socket_ALU_o1_bus_cntrl_reg(5) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_4(32 downto 28))) = 22 and squash_B1_4 = '0') then
          socket_ALU_o1_bus_cntrl_reg(4) <= '1';
        else
          socket_ALU_o1_bus_cntrl_reg(4) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_3(32 downto 28))) = 19 and squash_B1_3 = '0') then
          socket_ALU_o1_bus_cntrl_reg(3) <= '1';
        else
          socket_ALU_o1_bus_cntrl_reg(3) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_2(32 downto 28))) = 19 and squash_B1_2 = '0') then
          socket_ALU_o1_bus_cntrl_reg(2) <= '1';
        else
          socket_ALU_o1_bus_cntrl_reg(2) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_1(32 downto 28))) = 19 and squash_B1_1 = '0') then
          socket_ALU_o1_bus_cntrl_reg(1) <= '1';
        else
          socket_ALU_o1_bus_cntrl_reg(1) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1(32 downto 28))) = 20 and squash_B1 = '0') then
          socket_stream_in_o1_bus_cntrl_reg(0) <= '1';
        else
          socket_stream_in_o1_bus_cntrl_reg(0) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_6(32 downto 28))) = 23 and squash_B1_6 = '0') then
          socket_stream_in_o1_bus_cntrl_reg(6) <= '1';
        else
          socket_stream_in_o1_bus_cntrl_reg(6) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_5(32 downto 28))) = 23 and squash_B1_5 = '0') then
          socket_stream_in_o1_bus_cntrl_reg(5) <= '1';
        else
          socket_stream_in_o1_bus_cntrl_reg(5) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_4(32 downto 28))) = 23 and squash_B1_4 = '0') then
          socket_stream_in_o1_bus_cntrl_reg(4) <= '1';
        else
          socket_stream_in_o1_bus_cntrl_reg(4) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_3(32 downto 28))) = 20 and squash_B1_3 = '0') then
          socket_stream_in_o1_bus_cntrl_reg(3) <= '1';
        else
          socket_stream_in_o1_bus_cntrl_reg(3) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_2(32 downto 28))) = 20 and squash_B1_2 = '0') then
          socket_stream_in_o1_bus_cntrl_reg(2) <= '1';
        else
          socket_stream_in_o1_bus_cntrl_reg(2) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_1(32 downto 28))) = 20 and squash_B1_1 = '0') then
          socket_stream_in_o1_bus_cntrl_reg(1) <= '1';
        else
          socket_stream_in_o1_bus_cntrl_reg(1) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1(32 downto 28))) = 21 and squash_B1 = '0') then
          socket_stream_in_o2_bus_cntrl_reg(0) <= '1';
        else
          socket_stream_in_o2_bus_cntrl_reg(0) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_6(32 downto 28))) = 24 and squash_B1_6 = '0') then
          socket_stream_in_o2_bus_cntrl_reg(6) <= '1';
        else
          socket_stream_in_o2_bus_cntrl_reg(6) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_5(32 downto 28))) = 24 and squash_B1_5 = '0') then
          socket_stream_in_o2_bus_cntrl_reg(5) <= '1';
        else
          socket_stream_in_o2_bus_cntrl_reg(5) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_4(32 downto 28))) = 24 and squash_B1_4 = '0') then
          socket_stream_in_o2_bus_cntrl_reg(4) <= '1';
        else
          socket_stream_in_o2_bus_cntrl_reg(4) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_3(32 downto 28))) = 21 and squash_B1_3 = '0') then
          socket_stream_in_o2_bus_cntrl_reg(3) <= '1';
        else
          socket_stream_in_o2_bus_cntrl_reg(3) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_2(32 downto 28))) = 21 and squash_B1_2 = '0') then
          socket_stream_in_o2_bus_cntrl_reg(2) <= '1';
        else
          socket_stream_in_o2_bus_cntrl_reg(2) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_1(32 downto 28))) = 21 and squash_B1_1 = '0') then
          socket_stream_in_o2_bus_cntrl_reg(1) <= '1';
        else
          socket_stream_in_o2_bus_cntrl_reg(1) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1(32 downto 28))) = 22 and squash_B1 = '0') then
          socket_mul_o1_bus_cntrl_reg(0) <= '1';
        else
          socket_mul_o1_bus_cntrl_reg(0) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_6(32 downto 28))) = 25 and squash_B1_6 = '0') then
          socket_mul_o1_bus_cntrl_reg(6) <= '1';
        else
          socket_mul_o1_bus_cntrl_reg(6) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_5(32 downto 28))) = 25 and squash_B1_5 = '0') then
          socket_mul_o1_bus_cntrl_reg(5) <= '1';
        else
          socket_mul_o1_bus_cntrl_reg(5) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_4(32 downto 28))) = 25 and squash_B1_4 = '0') then
          socket_mul_o1_bus_cntrl_reg(4) <= '1';
        else
          socket_mul_o1_bus_cntrl_reg(4) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_3(32 downto 28))) = 22 and squash_B1_3 = '0') then
          socket_mul_o1_bus_cntrl_reg(3) <= '1';
        else
          socket_mul_o1_bus_cntrl_reg(3) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_2(32 downto 28))) = 22 and squash_B1_2 = '0') then
          socket_mul_o1_bus_cntrl_reg(2) <= '1';
        else
          socket_mul_o1_bus_cntrl_reg(2) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_1(32 downto 28))) = 22 and squash_B1_1 = '0') then
          socket_mul_o1_bus_cntrl_reg(1) <= '1';
        else
          socket_mul_o1_bus_cntrl_reg(1) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1(32 downto 28))) = 23 and squash_B1 = '0') then
          socket_stream_out_o1_bus_cntrl_reg(0) <= '1';
        else
          socket_stream_out_o1_bus_cntrl_reg(0) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_6(32 downto 28))) = 26 and squash_B1_6 = '0') then
          socket_stream_out_o1_bus_cntrl_reg(6) <= '1';
        else
          socket_stream_out_o1_bus_cntrl_reg(6) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_5(32 downto 28))) = 26 and squash_B1_5 = '0') then
          socket_stream_out_o1_bus_cntrl_reg(5) <= '1';
        else
          socket_stream_out_o1_bus_cntrl_reg(5) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_4(32 downto 28))) = 26 and squash_B1_4 = '0') then
          socket_stream_out_o1_bus_cntrl_reg(4) <= '1';
        else
          socket_stream_out_o1_bus_cntrl_reg(4) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_3(32 downto 28))) = 23 and squash_B1_3 = '0') then
          socket_stream_out_o1_bus_cntrl_reg(3) <= '1';
        else
          socket_stream_out_o1_bus_cntrl_reg(3) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_2(32 downto 28))) = 23 and squash_B1_2 = '0') then
          socket_stream_out_o1_bus_cntrl_reg(2) <= '1';
        else
          socket_stream_out_o1_bus_cntrl_reg(2) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_1(32 downto 28))) = 23 and squash_B1_1 = '0') then
          socket_stream_out_o1_bus_cntrl_reg(1) <= '1';
        else
          socket_stream_out_o1_bus_cntrl_reg(1) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1(32 downto 28))) = 24 and squash_B1 = '0') then
          socket_add_0_o2_bus_cntrl_reg(0) <= '1';
        else
          socket_add_0_o2_bus_cntrl_reg(0) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_6(32 downto 28))) = 27 and squash_B1_6 = '0') then
          socket_add_0_o2_bus_cntrl_reg(6) <= '1';
        else
          socket_add_0_o2_bus_cntrl_reg(6) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_5(32 downto 28))) = 27 and squash_B1_5 = '0') then
          socket_add_0_o2_bus_cntrl_reg(5) <= '1';
        else
          socket_add_0_o2_bus_cntrl_reg(5) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_4(32 downto 28))) = 27 and squash_B1_4 = '0') then
          socket_add_0_o2_bus_cntrl_reg(4) <= '1';
        else
          socket_add_0_o2_bus_cntrl_reg(4) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_3(32 downto 28))) = 24 and squash_B1_3 = '0') then
          socket_add_0_o2_bus_cntrl_reg(3) <= '1';
        else
          socket_add_0_o2_bus_cntrl_reg(3) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_2(32 downto 28))) = 24 and squash_B1_2 = '0') then
          socket_add_0_o2_bus_cntrl_reg(2) <= '1';
        else
          socket_add_0_o2_bus_cntrl_reg(2) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_1(32 downto 28))) = 24 and squash_B1_1 = '0') then
          socket_add_0_o2_bus_cntrl_reg(1) <= '1';
        else
          socket_add_0_o2_bus_cntrl_reg(1) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_6(32 downto 28))) = 17 and squash_B1_6 = '0') then
          socket_RF_2_o1_bus_cntrl_reg(2) <= '1';
        else
          socket_RF_2_o1_bus_cntrl_reg(2) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_5(32 downto 28))) = 17 and squash_B1_5 = '0') then
          socket_RF_2_o1_bus_cntrl_reg(1) <= '1';
        else
          socket_RF_2_o1_bus_cntrl_reg(1) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_4(32 downto 28))) = 17 and squash_B1_4 = '0') then
          socket_RF_2_o1_bus_cntrl_reg(0) <= '1';
        else
          socket_RF_2_o1_bus_cntrl_reg(0) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_6(32 downto 28))) = 18 and squash_B1_6 = '0') then
          socket_BOOL_o1_bus_cntrl_reg(2) <= '1';
        else
          socket_BOOL_o1_bus_cntrl_reg(2) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_5(32 downto 28))) = 18 and squash_B1_5 = '0') then
          socket_BOOL_o1_bus_cntrl_reg(1) <= '1';
        else
          socket_BOOL_o1_bus_cntrl_reg(1) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_4(32 downto 28))) = 18 and squash_B1_4 = '0') then
          socket_BOOL_o1_bus_cntrl_reg(0) <= '1';
        else
          socket_BOOL_o1_bus_cntrl_reg(0) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1(32 downto 28))) = 25 and squash_B1 = '0') then
          socket_stream_in_1_o1_bus_cntrl_reg(0) <= '1';
        else
          socket_stream_in_1_o1_bus_cntrl_reg(0) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_6(32 downto 28))) = 28 and squash_B1_6 = '0') then
          socket_stream_in_1_o1_bus_cntrl_reg(6) <= '1';
        else
          socket_stream_in_1_o1_bus_cntrl_reg(6) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_5(32 downto 28))) = 28 and squash_B1_5 = '0') then
          socket_stream_in_1_o1_bus_cntrl_reg(5) <= '1';
        else
          socket_stream_in_1_o1_bus_cntrl_reg(5) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_4(32 downto 28))) = 28 and squash_B1_4 = '0') then
          socket_stream_in_1_o1_bus_cntrl_reg(4) <= '1';
        else
          socket_stream_in_1_o1_bus_cntrl_reg(4) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_3(32 downto 28))) = 25 and squash_B1_3 = '0') then
          socket_stream_in_1_o1_bus_cntrl_reg(3) <= '1';
        else
          socket_stream_in_1_o1_bus_cntrl_reg(3) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_2(32 downto 28))) = 25 and squash_B1_2 = '0') then
          socket_stream_in_1_o1_bus_cntrl_reg(2) <= '1';
        else
          socket_stream_in_1_o1_bus_cntrl_reg(2) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_1(32 downto 28))) = 25 and squash_B1_1 = '0') then
          socket_stream_in_1_o1_bus_cntrl_reg(1) <= '1';
        else
          socket_stream_in_1_o1_bus_cntrl_reg(1) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1(32 downto 28))) = 26 and squash_B1 = '0') then
          socket_stream_in_1_o2_bus_cntrl_reg(0) <= '1';
        else
          socket_stream_in_1_o2_bus_cntrl_reg(0) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_6(32 downto 28))) = 29 and squash_B1_6 = '0') then
          socket_stream_in_1_o2_bus_cntrl_reg(6) <= '1';
        else
          socket_stream_in_1_o2_bus_cntrl_reg(6) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_5(32 downto 28))) = 29 and squash_B1_5 = '0') then
          socket_stream_in_1_o2_bus_cntrl_reg(5) <= '1';
        else
          socket_stream_in_1_o2_bus_cntrl_reg(5) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_4(32 downto 28))) = 29 and squash_B1_4 = '0') then
          socket_stream_in_1_o2_bus_cntrl_reg(4) <= '1';
        else
          socket_stream_in_1_o2_bus_cntrl_reg(4) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_3(32 downto 28))) = 26 and squash_B1_3 = '0') then
          socket_stream_in_1_o2_bus_cntrl_reg(3) <= '1';
        else
          socket_stream_in_1_o2_bus_cntrl_reg(3) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_2(32 downto 28))) = 26 and squash_B1_2 = '0') then
          socket_stream_in_1_o2_bus_cntrl_reg(2) <= '1';
        else
          socket_stream_in_1_o2_bus_cntrl_reg(2) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_1(32 downto 28))) = 26 and squash_B1_1 = '0') then
          socket_stream_in_1_o2_bus_cntrl_reg(1) <= '1';
        else
          socket_stream_in_1_o2_bus_cntrl_reg(1) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1(32 downto 28))) = 27 and squash_B1 = '0') then
          socket_and_ior_o1_bus_cntrl_reg(0) <= '1';
        else
          socket_and_ior_o1_bus_cntrl_reg(0) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_6(32 downto 28))) = 30 and squash_B1_6 = '0') then
          socket_and_ior_o1_bus_cntrl_reg(6) <= '1';
        else
          socket_and_ior_o1_bus_cntrl_reg(6) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_5(32 downto 28))) = 30 and squash_B1_5 = '0') then
          socket_and_ior_o1_bus_cntrl_reg(5) <= '1';
        else
          socket_and_ior_o1_bus_cntrl_reg(5) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_4(32 downto 28))) = 30 and squash_B1_4 = '0') then
          socket_and_ior_o1_bus_cntrl_reg(4) <= '1';
        else
          socket_and_ior_o1_bus_cntrl_reg(4) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_3(32 downto 28))) = 27 and squash_B1_3 = '0') then
          socket_and_ior_o1_bus_cntrl_reg(3) <= '1';
        else
          socket_and_ior_o1_bus_cntrl_reg(3) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_2(32 downto 28))) = 27 and squash_B1_2 = '0') then
          socket_and_ior_o1_bus_cntrl_reg(2) <= '1';
        else
          socket_and_ior_o1_bus_cntrl_reg(2) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_1(32 downto 28))) = 27 and squash_B1_1 = '0') then
          socket_and_ior_o1_bus_cntrl_reg(1) <= '1';
        else
          socket_and_ior_o1_bus_cntrl_reg(1) <= '0';
        end if;

        --bus control signals for short immediate sockets
        if (conv_integer(unsigned(src_B1(32 downto 32))) = 0 and squash_B1 = '0') then
          simm_cntrl_B1_reg(0) <= '1';
          simm_B1_reg <= sxt(src_B1(31 downto 0), simm_B1_reg'length);
        else
          simm_cntrl_B1_reg(0) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_1(32 downto 32))) = 0 and squash_B1_1 = '0') then
          simm_cntrl_B1_1_reg(0) <= '1';
          simm_B1_1_reg <= sxt(src_B1_1(31 downto 0), simm_B1_1_reg'length);
        else
          simm_cntrl_B1_1_reg(0) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_2(32 downto 32))) = 0 and squash_B1_2 = '0') then
          simm_cntrl_B1_2_reg(0) <= '1';
          simm_B1_2_reg <= sxt(src_B1_2(31 downto 0), simm_B1_2_reg'length);
        else
          simm_cntrl_B1_2_reg(0) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_3(32 downto 32))) = 0 and squash_B1_3 = '0') then
          simm_cntrl_B1_3_reg(0) <= '1';
          simm_B1_3_reg <= sxt(src_B1_3(31 downto 0), simm_B1_3_reg'length);
        else
          simm_cntrl_B1_3_reg(0) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_4(32 downto 32))) = 0 and squash_B1_4 = '0') then
          simm_cntrl_B1_4_reg(0) <= '1';
          simm_B1_4_reg <= sxt(src_B1_4(31 downto 0), simm_B1_4_reg'length);
        else
          simm_cntrl_B1_4_reg(0) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_5(32 downto 32))) = 0 and squash_B1_5 = '0') then
          simm_cntrl_B1_5_reg(0) <= '1';
          simm_B1_5_reg <= sxt(src_B1_5(31 downto 0), simm_B1_5_reg'length);
        else
          simm_cntrl_B1_5_reg(0) <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_6(32 downto 32))) = 0 and squash_B1_6 = '0') then
          simm_cntrl_B1_6_reg(0) <= '1';
          simm_B1_6_reg <= sxt(src_B1_6(31 downto 0), simm_B1_6_reg'length);
        else
          simm_cntrl_B1_6_reg(0) <= '0';
        end if;

        --data control signals for output sockets connected to FUs

        --control signals for RF read ports
        if (conv_integer(unsigned(src_B1_6(32 downto 28))) = 16 and squash_B1_6 = '0') then
          rf_RF_1_rd_load_reg <= '1';
          rf_RF_1_rd_opc_reg <= ext(src_B1_6(2 downto 0), rf_RF_1_rd_opc_reg'length);
        elsif (conv_integer(unsigned(src_B1_5(32 downto 28))) = 16 and squash_B1_5 = '0') then
          rf_RF_1_rd_load_reg <= '1';
          rf_RF_1_rd_opc_reg <= ext(src_B1_5(2 downto 0), rf_RF_1_rd_opc_reg'length);
        elsif (conv_integer(unsigned(src_B1_4(32 downto 28))) = 16 and squash_B1_4 = '0') then
          rf_RF_1_rd_load_reg <= '1';
          rf_RF_1_rd_opc_reg <= ext(src_B1_4(2 downto 0), rf_RF_1_rd_opc_reg'length);
        else
          rf_RF_1_rd_load_reg <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_6(32 downto 28))) = 17 and squash_B1_6 = '0') then
          rf_RF_2_wr_load_reg <= '1';
          rf_RF_2_wr_opc_reg <= ext(src_B1_6(2 downto 0), rf_RF_2_wr_opc_reg'length);
        elsif (conv_integer(unsigned(src_B1_5(32 downto 28))) = 17 and squash_B1_5 = '0') then
          rf_RF_2_wr_load_reg <= '1';
          rf_RF_2_wr_opc_reg <= ext(src_B1_5(2 downto 0), rf_RF_2_wr_opc_reg'length);
        elsif (conv_integer(unsigned(src_B1_4(32 downto 28))) = 17 and squash_B1_4 = '0') then
          rf_RF_2_wr_load_reg <= '1';
          rf_RF_2_wr_opc_reg <= ext(src_B1_4(2 downto 0), rf_RF_2_wr_opc_reg'length);
        else
          rf_RF_2_wr_load_reg <= '0';
        end if;
        if (conv_integer(unsigned(src_B1_6(32 downto 28))) = 18 and squash_B1_6 = '0') then
          rf_BOOL_wr_load_reg <= '1';
          rf_BOOL_wr_opc_reg <= ext(src_B1_6(0 downto 0), rf_BOOL_wr_opc_reg'length);
        elsif (conv_integer(unsigned(src_B1_5(32 downto 28))) = 18 and squash_B1_5 = '0') then
          rf_BOOL_wr_load_reg <= '1';
          rf_BOOL_wr_opc_reg <= ext(src_B1_5(0 downto 0), rf_BOOL_wr_opc_reg'length);
        elsif (conv_integer(unsigned(src_B1_4(32 downto 28))) = 18 and squash_B1_4 = '0') then
          rf_BOOL_wr_load_reg <= '1';
          rf_BOOL_wr_opc_reg <= ext(src_B1_4(0 downto 0), rf_BOOL_wr_opc_reg'length);
        else
          rf_BOOL_wr_load_reg <= '0';
        end if;

        --control signals for IU read ports

        --control signals for FU inputs
        if (conv_integer(unsigned(dst_B1(5 downto 3))) = 2 and squash_B1 = '0') then
          fu_LSU_in1t_load_reg <= '1';
          fu_LSU_opc_reg <= dst_B1(2 downto 0);
          socket_lsu_i1_bus_cntrl_reg <= conv_std_logic_vector(0, socket_lsu_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_6(5 downto 3))) = 2 and squash_B1_6 = '0') then
          fu_LSU_in1t_load_reg <= '1';
          fu_LSU_opc_reg <= dst_B1_6(2 downto 0);
          socket_lsu_i1_bus_cntrl_reg <= conv_std_logic_vector(6, socket_lsu_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_5(5 downto 3))) = 2 and squash_B1_5 = '0') then
          fu_LSU_in1t_load_reg <= '1';
          fu_LSU_opc_reg <= dst_B1_5(2 downto 0);
          socket_lsu_i1_bus_cntrl_reg <= conv_std_logic_vector(5, socket_lsu_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_4(5 downto 3))) = 2 and squash_B1_4 = '0') then
          fu_LSU_in1t_load_reg <= '1';
          fu_LSU_opc_reg <= dst_B1_4(2 downto 0);
          socket_lsu_i1_bus_cntrl_reg <= conv_std_logic_vector(4, socket_lsu_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_3(5 downto 3))) = 2 and squash_B1_3 = '0') then
          fu_LSU_in1t_load_reg <= '1';
          fu_LSU_opc_reg <= dst_B1_3(2 downto 0);
          socket_lsu_i1_bus_cntrl_reg <= conv_std_logic_vector(3, socket_lsu_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_2(5 downto 3))) = 2 and squash_B1_2 = '0') then
          fu_LSU_in1t_load_reg <= '1';
          fu_LSU_opc_reg <= dst_B1_2(2 downto 0);
          socket_lsu_i1_bus_cntrl_reg <= conv_std_logic_vector(2, socket_lsu_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_1(5 downto 3))) = 2 and squash_B1_1 = '0') then
          fu_LSU_in1t_load_reg <= '1';
          fu_LSU_opc_reg <= dst_B1_1(2 downto 0);
          socket_lsu_i1_bus_cntrl_reg <= conv_std_logic_vector(1, socket_lsu_i1_bus_cntrl_reg'length);
        else
          fu_LSU_in1t_load_reg <= '0';
        end if;
        if (conv_integer(unsigned(dst_B1(5 downto 0))) = 35 and squash_B1 = '0') then
          fu_LSU_in2_load_reg <= '1';
          socket_lsu_i2_bus_cntrl_reg <= conv_std_logic_vector(0, socket_lsu_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_6(5 downto 0))) = 53 and squash_B1_6 = '0') then
          fu_LSU_in2_load_reg <= '1';
          socket_lsu_i2_bus_cntrl_reg <= conv_std_logic_vector(6, socket_lsu_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_5(5 downto 0))) = 53 and squash_B1_5 = '0') then
          fu_LSU_in2_load_reg <= '1';
          socket_lsu_i2_bus_cntrl_reg <= conv_std_logic_vector(5, socket_lsu_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_4(5 downto 0))) = 53 and squash_B1_4 = '0') then
          fu_LSU_in2_load_reg <= '1';
          socket_lsu_i2_bus_cntrl_reg <= conv_std_logic_vector(4, socket_lsu_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_3(5 downto 0))) = 35 and squash_B1_3 = '0') then
          fu_LSU_in2_load_reg <= '1';
          socket_lsu_i2_bus_cntrl_reg <= conv_std_logic_vector(3, socket_lsu_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_2(5 downto 0))) = 35 and squash_B1_2 = '0') then
          fu_LSU_in2_load_reg <= '1';
          socket_lsu_i2_bus_cntrl_reg <= conv_std_logic_vector(2, socket_lsu_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_1(5 downto 0))) = 35 and squash_B1_1 = '0') then
          fu_LSU_in2_load_reg <= '1';
          socket_lsu_i2_bus_cntrl_reg <= conv_std_logic_vector(1, socket_lsu_i2_bus_cntrl_reg'length);
        else
          fu_LSU_in2_load_reg <= '0';
        end if;
        if (conv_integer(unsigned(dst_B1(5 downto 4))) = 0 and squash_B1 = '0') then
          fu_ALU_in1t_load_reg <= '1';
          fu_ALU_opc_reg <= dst_B1(3 downto 0);
          socket_ALU_i1_bus_cntrl_reg <= conv_std_logic_vector(0, socket_ALU_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_6(5 downto 4))) = 0 and squash_B1_6 = '0') then
          fu_ALU_in1t_load_reg <= '1';
          fu_ALU_opc_reg <= dst_B1_6(3 downto 0);
          socket_ALU_i1_bus_cntrl_reg <= conv_std_logic_vector(6, socket_ALU_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_5(5 downto 4))) = 0 and squash_B1_5 = '0') then
          fu_ALU_in1t_load_reg <= '1';
          fu_ALU_opc_reg <= dst_B1_5(3 downto 0);
          socket_ALU_i1_bus_cntrl_reg <= conv_std_logic_vector(5, socket_ALU_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_4(5 downto 4))) = 0 and squash_B1_4 = '0') then
          fu_ALU_in1t_load_reg <= '1';
          fu_ALU_opc_reg <= dst_B1_4(3 downto 0);
          socket_ALU_i1_bus_cntrl_reg <= conv_std_logic_vector(4, socket_ALU_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_3(5 downto 4))) = 0 and squash_B1_3 = '0') then
          fu_ALU_in1t_load_reg <= '1';
          fu_ALU_opc_reg <= dst_B1_3(3 downto 0);
          socket_ALU_i1_bus_cntrl_reg <= conv_std_logic_vector(3, socket_ALU_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_2(5 downto 4))) = 0 and squash_B1_2 = '0') then
          fu_ALU_in1t_load_reg <= '1';
          fu_ALU_opc_reg <= dst_B1_2(3 downto 0);
          socket_ALU_i1_bus_cntrl_reg <= conv_std_logic_vector(2, socket_ALU_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_1(5 downto 4))) = 0 and squash_B1_1 = '0') then
          fu_ALU_in1t_load_reg <= '1';
          fu_ALU_opc_reg <= dst_B1_1(3 downto 0);
          socket_ALU_i1_bus_cntrl_reg <= conv_std_logic_vector(1, socket_ALU_i1_bus_cntrl_reg'length);
        else
          fu_ALU_in1t_load_reg <= '0';
        end if;
        if (conv_integer(unsigned(dst_B1(5 downto 0))) = 36 and squash_B1 = '0') then
          fu_ALU_in2_load_reg <= '1';
          socket_ALU_i2_bus_cntrl_reg <= conv_std_logic_vector(0, socket_ALU_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_6(5 downto 0))) = 54 and squash_B1_6 = '0') then
          fu_ALU_in2_load_reg <= '1';
          socket_ALU_i2_bus_cntrl_reg <= conv_std_logic_vector(6, socket_ALU_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_5(5 downto 0))) = 54 and squash_B1_5 = '0') then
          fu_ALU_in2_load_reg <= '1';
          socket_ALU_i2_bus_cntrl_reg <= conv_std_logic_vector(5, socket_ALU_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_4(5 downto 0))) = 54 and squash_B1_4 = '0') then
          fu_ALU_in2_load_reg <= '1';
          socket_ALU_i2_bus_cntrl_reg <= conv_std_logic_vector(4, socket_ALU_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_3(5 downto 0))) = 36 and squash_B1_3 = '0') then
          fu_ALU_in2_load_reg <= '1';
          socket_ALU_i2_bus_cntrl_reg <= conv_std_logic_vector(3, socket_ALU_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_2(5 downto 0))) = 36 and squash_B1_2 = '0') then
          fu_ALU_in2_load_reg <= '1';
          socket_ALU_i2_bus_cntrl_reg <= conv_std_logic_vector(2, socket_ALU_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_1(5 downto 0))) = 36 and squash_B1_1 = '0') then
          fu_ALU_in2_load_reg <= '1';
          socket_ALU_i2_bus_cntrl_reg <= conv_std_logic_vector(1, socket_ALU_i2_bus_cntrl_reg'length);
        else
          fu_ALU_in2_load_reg <= '0';
        end if;
        if (conv_integer(unsigned(dst_B1(5 downto 1))) = 13 and squash_B1 = '0') then
          fu_stream_in_in1t_load_reg <= '1';
          fu_stream_in_opc_reg <= dst_B1(0 downto 0);
          socket_stream_in_i1_bus_cntrl_reg <= conv_std_logic_vector(0, socket_stream_in_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_6(5 downto 1))) = 21 and squash_B1_6 = '0') then
          fu_stream_in_in1t_load_reg <= '1';
          fu_stream_in_opc_reg <= dst_B1_6(0 downto 0);
          socket_stream_in_i1_bus_cntrl_reg <= conv_std_logic_vector(6, socket_stream_in_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_5(5 downto 1))) = 21 and squash_B1_5 = '0') then
          fu_stream_in_in1t_load_reg <= '1';
          fu_stream_in_opc_reg <= dst_B1_5(0 downto 0);
          socket_stream_in_i1_bus_cntrl_reg <= conv_std_logic_vector(5, socket_stream_in_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_4(5 downto 1))) = 21 and squash_B1_4 = '0') then
          fu_stream_in_in1t_load_reg <= '1';
          fu_stream_in_opc_reg <= dst_B1_4(0 downto 0);
          socket_stream_in_i1_bus_cntrl_reg <= conv_std_logic_vector(4, socket_stream_in_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_3(5 downto 1))) = 13 and squash_B1_3 = '0') then
          fu_stream_in_in1t_load_reg <= '1';
          fu_stream_in_opc_reg <= dst_B1_3(0 downto 0);
          socket_stream_in_i1_bus_cntrl_reg <= conv_std_logic_vector(3, socket_stream_in_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_2(5 downto 1))) = 13 and squash_B1_2 = '0') then
          fu_stream_in_in1t_load_reg <= '1';
          fu_stream_in_opc_reg <= dst_B1_2(0 downto 0);
          socket_stream_in_i1_bus_cntrl_reg <= conv_std_logic_vector(2, socket_stream_in_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_1(5 downto 1))) = 13 and squash_B1_1 = '0') then
          fu_stream_in_in1t_load_reg <= '1';
          fu_stream_in_opc_reg <= dst_B1_1(0 downto 0);
          socket_stream_in_i1_bus_cntrl_reg <= conv_std_logic_vector(1, socket_stream_in_i1_bus_cntrl_reg'length);
        else
          fu_stream_in_in1t_load_reg <= '0';
        end if;
        if (conv_integer(unsigned(dst_B1(5 downto 1))) = 14 and squash_B1 = '0') then
          fu_stream_out_in1t_load_reg <= '1';
          fu_stream_out_opc_reg <= dst_B1(0 downto 0);
          socket_stream_out_i1_bus_cntrl_reg <= conv_std_logic_vector(0, socket_stream_out_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_6(5 downto 1))) = 22 and squash_B1_6 = '0') then
          fu_stream_out_in1t_load_reg <= '1';
          fu_stream_out_opc_reg <= dst_B1_6(0 downto 0);
          socket_stream_out_i1_bus_cntrl_reg <= conv_std_logic_vector(6, socket_stream_out_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_5(5 downto 1))) = 22 and squash_B1_5 = '0') then
          fu_stream_out_in1t_load_reg <= '1';
          fu_stream_out_opc_reg <= dst_B1_5(0 downto 0);
          socket_stream_out_i1_bus_cntrl_reg <= conv_std_logic_vector(5, socket_stream_out_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_4(5 downto 1))) = 22 and squash_B1_4 = '0') then
          fu_stream_out_in1t_load_reg <= '1';
          fu_stream_out_opc_reg <= dst_B1_4(0 downto 0);
          socket_stream_out_i1_bus_cntrl_reg <= conv_std_logic_vector(4, socket_stream_out_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_3(5 downto 1))) = 14 and squash_B1_3 = '0') then
          fu_stream_out_in1t_load_reg <= '1';
          fu_stream_out_opc_reg <= dst_B1_3(0 downto 0);
          socket_stream_out_i1_bus_cntrl_reg <= conv_std_logic_vector(3, socket_stream_out_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_2(5 downto 1))) = 14 and squash_B1_2 = '0') then
          fu_stream_out_in1t_load_reg <= '1';
          fu_stream_out_opc_reg <= dst_B1_2(0 downto 0);
          socket_stream_out_i1_bus_cntrl_reg <= conv_std_logic_vector(2, socket_stream_out_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_1(5 downto 1))) = 14 and squash_B1_1 = '0') then
          fu_stream_out_in1t_load_reg <= '1';
          fu_stream_out_opc_reg <= dst_B1_1(0 downto 0);
          socket_stream_out_i1_bus_cntrl_reg <= conv_std_logic_vector(1, socket_stream_out_i1_bus_cntrl_reg'length);
        else
          fu_stream_out_in1t_load_reg <= '0';
        end if;
        if (conv_integer(unsigned(dst_B1(5 downto 0))) = 37 and squash_B1 = '0') then
          fu_mul_0_in1t_load_reg <= '1';
          socket_mul_i1_bus_cntrl_reg <= conv_std_logic_vector(0, socket_mul_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_6(5 downto 0))) = 55 and squash_B1_6 = '0') then
          fu_mul_0_in1t_load_reg <= '1';
          socket_mul_i1_bus_cntrl_reg <= conv_std_logic_vector(6, socket_mul_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_5(5 downto 0))) = 55 and squash_B1_5 = '0') then
          fu_mul_0_in1t_load_reg <= '1';
          socket_mul_i1_bus_cntrl_reg <= conv_std_logic_vector(5, socket_mul_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_4(5 downto 0))) = 55 and squash_B1_4 = '0') then
          fu_mul_0_in1t_load_reg <= '1';
          socket_mul_i1_bus_cntrl_reg <= conv_std_logic_vector(4, socket_mul_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_3(5 downto 0))) = 37 and squash_B1_3 = '0') then
          fu_mul_0_in1t_load_reg <= '1';
          socket_mul_i1_bus_cntrl_reg <= conv_std_logic_vector(3, socket_mul_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_2(5 downto 0))) = 37 and squash_B1_2 = '0') then
          fu_mul_0_in1t_load_reg <= '1';
          socket_mul_i1_bus_cntrl_reg <= conv_std_logic_vector(2, socket_mul_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_1(5 downto 0))) = 37 and squash_B1_1 = '0') then
          fu_mul_0_in1t_load_reg <= '1';
          socket_mul_i1_bus_cntrl_reg <= conv_std_logic_vector(1, socket_mul_i1_bus_cntrl_reg'length);
        else
          fu_mul_0_in1t_load_reg <= '0';
        end if;
        if (conv_integer(unsigned(dst_B1(5 downto 0))) = 38 and squash_B1 = '0') then
          fu_mul_0_in2_load_reg <= '1';
          socket_mul_i2_bus_cntrl_reg <= conv_std_logic_vector(0, socket_mul_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_6(5 downto 0))) = 56 and squash_B1_6 = '0') then
          fu_mul_0_in2_load_reg <= '1';
          socket_mul_i2_bus_cntrl_reg <= conv_std_logic_vector(6, socket_mul_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_5(5 downto 0))) = 56 and squash_B1_5 = '0') then
          fu_mul_0_in2_load_reg <= '1';
          socket_mul_i2_bus_cntrl_reg <= conv_std_logic_vector(5, socket_mul_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_4(5 downto 0))) = 56 and squash_B1_4 = '0') then
          fu_mul_0_in2_load_reg <= '1';
          socket_mul_i2_bus_cntrl_reg <= conv_std_logic_vector(4, socket_mul_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_3(5 downto 0))) = 38 and squash_B1_3 = '0') then
          fu_mul_0_in2_load_reg <= '1';
          socket_mul_i2_bus_cntrl_reg <= conv_std_logic_vector(3, socket_mul_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_2(5 downto 0))) = 38 and squash_B1_2 = '0') then
          fu_mul_0_in2_load_reg <= '1';
          socket_mul_i2_bus_cntrl_reg <= conv_std_logic_vector(2, socket_mul_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_1(5 downto 0))) = 38 and squash_B1_1 = '0') then
          fu_mul_0_in2_load_reg <= '1';
          socket_mul_i2_bus_cntrl_reg <= conv_std_logic_vector(1, socket_mul_i2_bus_cntrl_reg'length);
        else
          fu_mul_0_in2_load_reg <= '0';
        end if;
        if (conv_integer(unsigned(dst_B1(5 downto 0))) = 40 and squash_B1 = '0') then
          fu_add_0_in1t_load_reg <= '1';
          socket_add_0_i3_bus_cntrl_reg <= conv_std_logic_vector(0, socket_add_0_i3_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_6(5 downto 0))) = 58 and squash_B1_6 = '0') then
          fu_add_0_in1t_load_reg <= '1';
          socket_add_0_i3_bus_cntrl_reg <= conv_std_logic_vector(6, socket_add_0_i3_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_5(5 downto 0))) = 58 and squash_B1_5 = '0') then
          fu_add_0_in1t_load_reg <= '1';
          socket_add_0_i3_bus_cntrl_reg <= conv_std_logic_vector(5, socket_add_0_i3_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_4(5 downto 0))) = 58 and squash_B1_4 = '0') then
          fu_add_0_in1t_load_reg <= '1';
          socket_add_0_i3_bus_cntrl_reg <= conv_std_logic_vector(4, socket_add_0_i3_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_3(5 downto 0))) = 40 and squash_B1_3 = '0') then
          fu_add_0_in1t_load_reg <= '1';
          socket_add_0_i3_bus_cntrl_reg <= conv_std_logic_vector(3, socket_add_0_i3_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_2(5 downto 0))) = 40 and squash_B1_2 = '0') then
          fu_add_0_in1t_load_reg <= '1';
          socket_add_0_i3_bus_cntrl_reg <= conv_std_logic_vector(2, socket_add_0_i3_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_1(5 downto 0))) = 40 and squash_B1_1 = '0') then
          fu_add_0_in1t_load_reg <= '1';
          socket_add_0_i3_bus_cntrl_reg <= conv_std_logic_vector(1, socket_add_0_i3_bus_cntrl_reg'length);
        else
          fu_add_0_in1t_load_reg <= '0';
        end if;
        if (conv_integer(unsigned(dst_B1(5 downto 0))) = 41 and squash_B1 = '0') then
          fu_add_0_in2_load_reg <= '1';
          socket_add_0_i4_bus_cntrl_reg <= conv_std_logic_vector(0, socket_add_0_i4_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_6(5 downto 0))) = 59 and squash_B1_6 = '0') then
          fu_add_0_in2_load_reg <= '1';
          socket_add_0_i4_bus_cntrl_reg <= conv_std_logic_vector(6, socket_add_0_i4_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_5(5 downto 0))) = 59 and squash_B1_5 = '0') then
          fu_add_0_in2_load_reg <= '1';
          socket_add_0_i4_bus_cntrl_reg <= conv_std_logic_vector(5, socket_add_0_i4_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_4(5 downto 0))) = 59 and squash_B1_4 = '0') then
          fu_add_0_in2_load_reg <= '1';
          socket_add_0_i4_bus_cntrl_reg <= conv_std_logic_vector(4, socket_add_0_i4_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_3(5 downto 0))) = 41 and squash_B1_3 = '0') then
          fu_add_0_in2_load_reg <= '1';
          socket_add_0_i4_bus_cntrl_reg <= conv_std_logic_vector(3, socket_add_0_i4_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_2(5 downto 0))) = 41 and squash_B1_2 = '0') then
          fu_add_0_in2_load_reg <= '1';
          socket_add_0_i4_bus_cntrl_reg <= conv_std_logic_vector(2, socket_add_0_i4_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_1(5 downto 0))) = 41 and squash_B1_1 = '0') then
          fu_add_0_in2_load_reg <= '1';
          socket_add_0_i4_bus_cntrl_reg <= conv_std_logic_vector(1, socket_add_0_i4_bus_cntrl_reg'length);
        else
          fu_add_0_in2_load_reg <= '0';
        end if;
        if (conv_integer(unsigned(dst_B1(5 downto 1))) = 15 and squash_B1 = '0') then
          fu_delay_in_in1t_load_reg <= '1';
          fu_delay_in_opc_reg <= dst_B1(0 downto 0);
          socket_stream_in_1_i1_bus_cntrl_reg <= conv_std_logic_vector(0, socket_stream_in_1_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_6(5 downto 1))) = 24 and squash_B1_6 = '0') then
          fu_delay_in_in1t_load_reg <= '1';
          fu_delay_in_opc_reg <= dst_B1_6(0 downto 0);
          socket_stream_in_1_i1_bus_cntrl_reg <= conv_std_logic_vector(6, socket_stream_in_1_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_5(5 downto 1))) = 24 and squash_B1_5 = '0') then
          fu_delay_in_in1t_load_reg <= '1';
          fu_delay_in_opc_reg <= dst_B1_5(0 downto 0);
          socket_stream_in_1_i1_bus_cntrl_reg <= conv_std_logic_vector(5, socket_stream_in_1_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_4(5 downto 1))) = 24 and squash_B1_4 = '0') then
          fu_delay_in_in1t_load_reg <= '1';
          fu_delay_in_opc_reg <= dst_B1_4(0 downto 0);
          socket_stream_in_1_i1_bus_cntrl_reg <= conv_std_logic_vector(4, socket_stream_in_1_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_3(5 downto 1))) = 15 and squash_B1_3 = '0') then
          fu_delay_in_in1t_load_reg <= '1';
          fu_delay_in_opc_reg <= dst_B1_3(0 downto 0);
          socket_stream_in_1_i1_bus_cntrl_reg <= conv_std_logic_vector(3, socket_stream_in_1_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_2(5 downto 1))) = 15 and squash_B1_2 = '0') then
          fu_delay_in_in1t_load_reg <= '1';
          fu_delay_in_opc_reg <= dst_B1_2(0 downto 0);
          socket_stream_in_1_i1_bus_cntrl_reg <= conv_std_logic_vector(2, socket_stream_in_1_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_1(5 downto 1))) = 15 and squash_B1_1 = '0') then
          fu_delay_in_in1t_load_reg <= '1';
          fu_delay_in_opc_reg <= dst_B1_1(0 downto 0);
          socket_stream_in_1_i1_bus_cntrl_reg <= conv_std_logic_vector(1, socket_stream_in_1_i1_bus_cntrl_reg'length);
        else
          fu_delay_in_in1t_load_reg <= '0';
        end if;
        if (conv_integer(unsigned(dst_B1(5 downto 1))) = 16 and squash_B1 = '0') then
          fu_and_ior_in1t_load_reg <= '1';
          fu_and_ior_opc_reg <= dst_B1(0 downto 0);
          socket_and_ior_i1_bus_cntrl_reg <= conv_std_logic_vector(0, socket_and_ior_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_6(5 downto 1))) = 25 and squash_B1_6 = '0') then
          fu_and_ior_in1t_load_reg <= '1';
          fu_and_ior_opc_reg <= dst_B1_6(0 downto 0);
          socket_and_ior_i1_bus_cntrl_reg <= conv_std_logic_vector(6, socket_and_ior_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_5(5 downto 1))) = 25 and squash_B1_5 = '0') then
          fu_and_ior_in1t_load_reg <= '1';
          fu_and_ior_opc_reg <= dst_B1_5(0 downto 0);
          socket_and_ior_i1_bus_cntrl_reg <= conv_std_logic_vector(5, socket_and_ior_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_4(5 downto 1))) = 25 and squash_B1_4 = '0') then
          fu_and_ior_in1t_load_reg <= '1';
          fu_and_ior_opc_reg <= dst_B1_4(0 downto 0);
          socket_and_ior_i1_bus_cntrl_reg <= conv_std_logic_vector(4, socket_and_ior_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_3(5 downto 1))) = 16 and squash_B1_3 = '0') then
          fu_and_ior_in1t_load_reg <= '1';
          fu_and_ior_opc_reg <= dst_B1_3(0 downto 0);
          socket_and_ior_i1_bus_cntrl_reg <= conv_std_logic_vector(3, socket_and_ior_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_2(5 downto 1))) = 16 and squash_B1_2 = '0') then
          fu_and_ior_in1t_load_reg <= '1';
          fu_and_ior_opc_reg <= dst_B1_2(0 downto 0);
          socket_and_ior_i1_bus_cntrl_reg <= conv_std_logic_vector(2, socket_and_ior_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_1(5 downto 1))) = 16 and squash_B1_1 = '0') then
          fu_and_ior_in1t_load_reg <= '1';
          fu_and_ior_opc_reg <= dst_B1_1(0 downto 0);
          socket_and_ior_i1_bus_cntrl_reg <= conv_std_logic_vector(1, socket_and_ior_i1_bus_cntrl_reg'length);
        else
          fu_and_ior_in1t_load_reg <= '0';
        end if;
        if (conv_integer(unsigned(dst_B1(5 downto 0))) = 42 and squash_B1 = '0') then
          fu_and_ior_in2_load_reg <= '1';
          socket_and_ior_i2_bus_cntrl_reg <= conv_std_logic_vector(0, socket_and_ior_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_6(5 downto 0))) = 60 and squash_B1_6 = '0') then
          fu_and_ior_in2_load_reg <= '1';
          socket_and_ior_i2_bus_cntrl_reg <= conv_std_logic_vector(6, socket_and_ior_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_5(5 downto 0))) = 60 and squash_B1_5 = '0') then
          fu_and_ior_in2_load_reg <= '1';
          socket_and_ior_i2_bus_cntrl_reg <= conv_std_logic_vector(5, socket_and_ior_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_4(5 downto 0))) = 60 and squash_B1_4 = '0') then
          fu_and_ior_in2_load_reg <= '1';
          socket_and_ior_i2_bus_cntrl_reg <= conv_std_logic_vector(4, socket_and_ior_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_3(5 downto 0))) = 42 and squash_B1_3 = '0') then
          fu_and_ior_in2_load_reg <= '1';
          socket_and_ior_i2_bus_cntrl_reg <= conv_std_logic_vector(3, socket_and_ior_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_2(5 downto 0))) = 42 and squash_B1_2 = '0') then
          fu_and_ior_in2_load_reg <= '1';
          socket_and_ior_i2_bus_cntrl_reg <= conv_std_logic_vector(2, socket_and_ior_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_1(5 downto 0))) = 42 and squash_B1_1 = '0') then
          fu_and_ior_in2_load_reg <= '1';
          socket_and_ior_i2_bus_cntrl_reg <= conv_std_logic_vector(1, socket_and_ior_i2_bus_cntrl_reg'length);
        else
          fu_and_ior_in2_load_reg <= '0';
        end if;
        if (conv_integer(unsigned(dst_B1(5 downto 1))) = 12 and squash_B1 = '0') then
          if (conv_integer(unsigned(dst_B1(0 downto 0))) = 1) then
            fu_gcu_pc_load_reg <= '1';
          fu_gcu_opc_reg <= IFE_JUMP;
          elsif (conv_integer(unsigned(dst_B1(0 downto 0))) = 0) then
            fu_gcu_pc_load_reg <= '1';
          fu_gcu_opc_reg <= IFE_CALL;
          else
            fu_gcu_pc_load_reg <= '0';
          end if;
          socket_gcu_i1_bus_cntrl_reg <= conv_std_logic_vector(0, socket_gcu_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_6(5 downto 1))) = 20 and squash_B1_6 = '0') then
          if (conv_integer(unsigned(dst_B1_6(0 downto 0))) = 1) then
            fu_gcu_pc_load_reg <= '1';
          fu_gcu_opc_reg <= IFE_JUMP;
          elsif (conv_integer(unsigned(dst_B1_6(0 downto 0))) = 0) then
            fu_gcu_pc_load_reg <= '1';
          fu_gcu_opc_reg <= IFE_CALL;
          else
            fu_gcu_pc_load_reg <= '0';
          end if;
          socket_gcu_i1_bus_cntrl_reg <= conv_std_logic_vector(6, socket_gcu_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_5(5 downto 1))) = 20 and squash_B1_5 = '0') then
          if (conv_integer(unsigned(dst_B1_5(0 downto 0))) = 1) then
            fu_gcu_pc_load_reg <= '1';
          fu_gcu_opc_reg <= IFE_JUMP;
          elsif (conv_integer(unsigned(dst_B1_5(0 downto 0))) = 0) then
            fu_gcu_pc_load_reg <= '1';
          fu_gcu_opc_reg <= IFE_CALL;
          else
            fu_gcu_pc_load_reg <= '0';
          end if;
          socket_gcu_i1_bus_cntrl_reg <= conv_std_logic_vector(5, socket_gcu_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_4(5 downto 1))) = 20 and squash_B1_4 = '0') then
          if (conv_integer(unsigned(dst_B1_4(0 downto 0))) = 1) then
            fu_gcu_pc_load_reg <= '1';
          fu_gcu_opc_reg <= IFE_JUMP;
          elsif (conv_integer(unsigned(dst_B1_4(0 downto 0))) = 0) then
            fu_gcu_pc_load_reg <= '1';
          fu_gcu_opc_reg <= IFE_CALL;
          else
            fu_gcu_pc_load_reg <= '0';
          end if;
          socket_gcu_i1_bus_cntrl_reg <= conv_std_logic_vector(4, socket_gcu_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_3(5 downto 1))) = 12 and squash_B1_3 = '0') then
          if (conv_integer(unsigned(dst_B1_3(0 downto 0))) = 1) then
            fu_gcu_pc_load_reg <= '1';
          fu_gcu_opc_reg <= IFE_JUMP;
          elsif (conv_integer(unsigned(dst_B1_3(0 downto 0))) = 0) then
            fu_gcu_pc_load_reg <= '1';
          fu_gcu_opc_reg <= IFE_CALL;
          else
            fu_gcu_pc_load_reg <= '0';
          end if;
          socket_gcu_i1_bus_cntrl_reg <= conv_std_logic_vector(3, socket_gcu_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_2(5 downto 1))) = 12 and squash_B1_2 = '0') then
          if (conv_integer(unsigned(dst_B1_2(0 downto 0))) = 1) then
            fu_gcu_pc_load_reg <= '1';
          fu_gcu_opc_reg <= IFE_JUMP;
          elsif (conv_integer(unsigned(dst_B1_2(0 downto 0))) = 0) then
            fu_gcu_pc_load_reg <= '1';
          fu_gcu_opc_reg <= IFE_CALL;
          else
            fu_gcu_pc_load_reg <= '0';
          end if;
          socket_gcu_i1_bus_cntrl_reg <= conv_std_logic_vector(2, socket_gcu_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_1(5 downto 1))) = 12 and squash_B1_1 = '0') then
          if (conv_integer(unsigned(dst_B1_1(0 downto 0))) = 1) then
            fu_gcu_pc_load_reg <= '1';
          fu_gcu_opc_reg <= IFE_JUMP;
          elsif (conv_integer(unsigned(dst_B1_1(0 downto 0))) = 0) then
            fu_gcu_pc_load_reg <= '1';
          fu_gcu_opc_reg <= IFE_CALL;
          else
            fu_gcu_pc_load_reg <= '0';
          end if;
          socket_gcu_i1_bus_cntrl_reg <= conv_std_logic_vector(1, socket_gcu_i1_bus_cntrl_reg'length);
        else
          fu_gcu_pc_load_reg <= '0';
        end if;
        if (conv_integer(unsigned(dst_B1(5 downto 0))) = 39 and squash_B1 = '0') then
          fu_gcu_ra_load_reg <= '1';
          socket_gcu_i2_bus_cntrl_reg <= conv_std_logic_vector(0, socket_gcu_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_6(5 downto 0))) = 57 and squash_B1_6 = '0') then
          fu_gcu_ra_load_reg <= '1';
          socket_gcu_i2_bus_cntrl_reg <= conv_std_logic_vector(6, socket_gcu_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_5(5 downto 0))) = 57 and squash_B1_5 = '0') then
          fu_gcu_ra_load_reg <= '1';
          socket_gcu_i2_bus_cntrl_reg <= conv_std_logic_vector(5, socket_gcu_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_4(5 downto 0))) = 57 and squash_B1_4 = '0') then
          fu_gcu_ra_load_reg <= '1';
          socket_gcu_i2_bus_cntrl_reg <= conv_std_logic_vector(4, socket_gcu_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_3(5 downto 0))) = 39 and squash_B1_3 = '0') then
          fu_gcu_ra_load_reg <= '1';
          socket_gcu_i2_bus_cntrl_reg <= conv_std_logic_vector(3, socket_gcu_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_2(5 downto 0))) = 39 and squash_B1_2 = '0') then
          fu_gcu_ra_load_reg <= '1';
          socket_gcu_i2_bus_cntrl_reg <= conv_std_logic_vector(2, socket_gcu_i2_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_1(5 downto 0))) = 39 and squash_B1_1 = '0') then
          fu_gcu_ra_load_reg <= '1';
          socket_gcu_i2_bus_cntrl_reg <= conv_std_logic_vector(1, socket_gcu_i2_bus_cntrl_reg'length);
        else
          fu_gcu_ra_load_reg <= '0';
        end if;

        --control signals for RF inputs
        if (conv_integer(unsigned(dst_B1_6(5 downto 3))) = 3 and squash_B1_6 = '0') then
          rf_RF_1_wr_load_reg <= '1';
          rf_RF_1_wr_opc_reg <= dst_B1_6(2 downto 0);
          socket_RF_i1_bus_cntrl_reg <= conv_std_logic_vector(2, socket_RF_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_5(5 downto 3))) = 3 and squash_B1_5 = '0') then
          rf_RF_1_wr_load_reg <= '1';
          rf_RF_1_wr_opc_reg <= dst_B1_5(2 downto 0);
          socket_RF_i1_bus_cntrl_reg <= conv_std_logic_vector(1, socket_RF_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_4(5 downto 3))) = 3 and squash_B1_4 = '0') then
          rf_RF_1_wr_load_reg <= '1';
          rf_RF_1_wr_opc_reg <= dst_B1_4(2 downto 0);
          socket_RF_i1_bus_cntrl_reg <= conv_std_logic_vector(0, socket_RF_i1_bus_cntrl_reg'length);
        else
          rf_RF_1_wr_load_reg <= '0';
        end if;
        if (conv_integer(unsigned(dst_B1_6(5 downto 3))) = 4 and squash_B1_6 = '0') then
          rf_RF_2_rd_load_reg <= '1';
          rf_RF_2_rd_opc_reg <= dst_B1_6(2 downto 0);
          socket_RF_2_i1_bus_cntrl_reg <= conv_std_logic_vector(2, socket_RF_2_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_5(5 downto 3))) = 4 and squash_B1_5 = '0') then
          rf_RF_2_rd_load_reg <= '1';
          rf_RF_2_rd_opc_reg <= dst_B1_5(2 downto 0);
          socket_RF_2_i1_bus_cntrl_reg <= conv_std_logic_vector(1, socket_RF_2_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_4(5 downto 3))) = 4 and squash_B1_4 = '0') then
          rf_RF_2_rd_load_reg <= '1';
          rf_RF_2_rd_opc_reg <= dst_B1_4(2 downto 0);
          socket_RF_2_i1_bus_cntrl_reg <= conv_std_logic_vector(0, socket_RF_2_i1_bus_cntrl_reg'length);
        else
          rf_RF_2_rd_load_reg <= '0';
        end if;
        if (conv_integer(unsigned(dst_B1_6(5 downto 1))) = 23 and squash_B1_6 = '0') then
          rf_BOOL_rd_load_reg <= '1';
          rf_BOOL_rd_opc_reg <= dst_B1_6(0 downto 0);
          socket_BOOL_i1_bus_cntrl_reg <= conv_std_logic_vector(2, socket_BOOL_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_5(5 downto 1))) = 23 and squash_B1_5 = '0') then
          rf_BOOL_rd_load_reg <= '1';
          rf_BOOL_rd_opc_reg <= dst_B1_5(0 downto 0);
          socket_BOOL_i1_bus_cntrl_reg <= conv_std_logic_vector(1, socket_BOOL_i1_bus_cntrl_reg'length);
        elsif (conv_integer(unsigned(dst_B1_4(5 downto 1))) = 23 and squash_B1_4 = '0') then
          rf_BOOL_rd_load_reg <= '1';
          rf_BOOL_rd_opc_reg <= dst_B1_4(0 downto 0);
          socket_BOOL_i1_bus_cntrl_reg <= conv_std_logic_vector(0, socket_BOOL_i1_bus_cntrl_reg'length);
        else
          rf_BOOL_rd_load_reg <= '0';
        end if;
      end if;
    end if;
  end process;

  lock_r <= '0';
  glock <= lock;


end rtl_andor;
