library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use STD.textio.all;
use work.myProssu_globals.all;

entity myProssu_interconn is

  port (
    socket_lsu_i1_data : out std_logic_vector(7 downto 0);
    socket_lsu_i1_bus_cntrl : in std_logic_vector(3 downto 0);
    socket_lsu_o1_data0 : in std_logic_vector(31 downto 0);
    socket_lsu_o1_bus_cntrl : in std_logic_vector(8 downto 0);
    socket_lsu_i2_data : out std_logic_vector(31 downto 0);
    socket_lsu_i2_bus_cntrl : in std_logic_vector(3 downto 0);
    socket_RF_i1_data : out std_logic_vector(31 downto 0);
    socket_RF_i1_bus_cntrl : in std_logic_vector(3 downto 0);
    socket_RF_o1_data0 : in std_logic_vector(31 downto 0);
    socket_RF_o1_bus_cntrl : in std_logic_vector(8 downto 0);
    socket_gcu_i1_data : out std_logic_vector(IMEMADDRWIDTH-1 downto 0);
    socket_gcu_i1_bus_cntrl : in std_logic_vector(3 downto 0);
    socket_gcu_o1_data0 : in std_logic_vector(IMEMADDRWIDTH-1 downto 0);
    socket_gcu_o1_bus_cntrl : in std_logic_vector(8 downto 0);
    socket_ALU_i1_data : out std_logic_vector(31 downto 0);
    socket_ALU_i1_bus_cntrl : in std_logic_vector(3 downto 0);
    socket_ALU_i2_data : out std_logic_vector(31 downto 0);
    socket_ALU_i2_bus_cntrl : in std_logic_vector(3 downto 0);
    socket_ALU_o1_data0 : in std_logic_vector(31 downto 0);
    socket_ALU_o1_bus_cntrl : in std_logic_vector(8 downto 0);
    socket_stream_in_i1_data : out std_logic_vector(7 downto 0);
    socket_stream_in_i1_bus_cntrl : in std_logic_vector(3 downto 0);
    socket_stream_in_o1_data0 : in std_logic_vector(7 downto 0);
    socket_stream_in_o1_bus_cntrl : in std_logic_vector(8 downto 0);
    socket_stream_in_o2_data0 : in std_logic_vector(7 downto 0);
    socket_stream_in_o2_bus_cntrl : in std_logic_vector(8 downto 0);
    socket_stream_out_i1_data : out std_logic_vector(7 downto 0);
    socket_stream_out_i1_bus_cntrl : in std_logic_vector(3 downto 0);
    socket_stream_out_o1_data0 : in std_logic_vector(7 downto 0);
    socket_stream_out_o1_bus_cntrl : in std_logic_vector(8 downto 0);
    socket_gcu_i2_data : out std_logic_vector(IMEMADDRWIDTH-1 downto 0);
    socket_gcu_i2_bus_cntrl : in std_logic_vector(3 downto 0);
    socket_add_0_i3_data : out std_logic_vector(31 downto 0);
    socket_add_0_i3_bus_cntrl : in std_logic_vector(3 downto 0);
    socket_add_0_i4_data : out std_logic_vector(31 downto 0);
    socket_add_0_i4_bus_cntrl : in std_logic_vector(3 downto 0);
    socket_add_0_o2_data0 : in std_logic_vector(31 downto 0);
    socket_add_0_o2_bus_cntrl : in std_logic_vector(8 downto 0);
    socket_RF_2_o1_data0 : in std_logic_vector(31 downto 0);
    socket_RF_2_o1_bus_cntrl : in std_logic_vector(8 downto 0);
    socket_RF_2_i1_data : out std_logic_vector(31 downto 0);
    socket_RF_2_i1_bus_cntrl : in std_logic_vector(3 downto 0);
    socket_BOOL_o1_data0 : in std_logic_vector(0 downto 0);
    socket_BOOL_o1_bus_cntrl : in std_logic_vector(8 downto 0);
    socket_BOOL_i1_data : out std_logic_vector(0 downto 0);
    socket_BOOL_i1_bus_cntrl : in std_logic_vector(3 downto 0);
    socket_RF_3_o1_data0 : in std_logic_vector(31 downto 0);
    socket_RF_3_o1_bus_cntrl : in std_logic_vector(8 downto 0);
    socket_RF_3_i1_data : out std_logic_vector(31 downto 0);
    socket_RF_3_i1_bus_cntrl : in std_logic_vector(3 downto 0);
    socket_MAC_my_i1_data : out std_logic_vector(31 downto 0);
    socket_MAC_my_i1_bus_cntrl : in std_logic_vector(3 downto 0);
    socket_MAC_my_i2_data : out std_logic_vector(31 downto 0);
    socket_MAC_my_i2_bus_cntrl : in std_logic_vector(3 downto 0);
    socket_MAC_my_o1_data0 : in std_logic_vector(31 downto 0);
    socket_MAC_my_o1_bus_cntrl : in std_logic_vector(8 downto 0);
    simm_B1 : in std_logic_vector(31 downto 0);
    simm_cntrl_B1 : in std_logic_vector(0 downto 0);
    simm_B1_1 : in std_logic_vector(31 downto 0);
    simm_cntrl_B1_1 : in std_logic_vector(0 downto 0);
    simm_B1_2 : in std_logic_vector(31 downto 0);
    simm_cntrl_B1_2 : in std_logic_vector(0 downto 0);
    simm_B1_3 : in std_logic_vector(31 downto 0);
    simm_cntrl_B1_3 : in std_logic_vector(0 downto 0);
    simm_B1_4 : in std_logic_vector(31 downto 0);
    simm_cntrl_B1_4 : in std_logic_vector(0 downto 0);
    simm_B1_5 : in std_logic_vector(31 downto 0);
    simm_cntrl_B1_5 : in std_logic_vector(0 downto 0);
    simm_B1_6 : in std_logic_vector(31 downto 0);
    simm_cntrl_B1_6 : in std_logic_vector(0 downto 0);
    simm_B1_7 : in std_logic_vector(31 downto 0);
    simm_cntrl_B1_7 : in std_logic_vector(0 downto 0);
    simm_B1_8 : in std_logic_vector(31 downto 0);
    simm_cntrl_B1_8 : in std_logic_vector(0 downto 0));

end myProssu_interconn;

architecture comb_andor of myProssu_interconn is

  signal databus_B1 : std_logic_vector(31 downto 0);
  signal databus_B1_alt0 : std_logic_vector(31 downto 0);
  signal databus_B1_alt1 : std_logic_vector(31 downto 0);
  signal databus_B1_alt2 : std_logic_vector(31 downto 0);
  signal databus_B1_alt3 : std_logic_vector(31 downto 0);
  signal databus_B1_alt4 : std_logic_vector(31 downto 0);
  signal databus_B1_alt5 : std_logic_vector(31 downto 0);
  signal databus_B1_alt6 : std_logic_vector(31 downto 0);
  signal databus_B1_alt7 : std_logic_vector(31 downto 0);
  signal databus_B1_alt8 : std_logic_vector(31 downto 0);
  signal databus_B1_alt9 : std_logic_vector(31 downto 0);
  signal databus_B1_alt10 : std_logic_vector(31 downto 0);
  signal databus_B1_alt11 : std_logic_vector(31 downto 0);
  signal databus_B1_simm : std_logic_vector(31 downto 0);
  signal databus_B1_1 : std_logic_vector(31 downto 0);
  signal databus_B1_1_alt0 : std_logic_vector(31 downto 0);
  signal databus_B1_1_alt1 : std_logic_vector(31 downto 0);
  signal databus_B1_1_alt2 : std_logic_vector(31 downto 0);
  signal databus_B1_1_alt3 : std_logic_vector(31 downto 0);
  signal databus_B1_1_alt4 : std_logic_vector(31 downto 0);
  signal databus_B1_1_alt5 : std_logic_vector(31 downto 0);
  signal databus_B1_1_alt6 : std_logic_vector(31 downto 0);
  signal databus_B1_1_alt7 : std_logic_vector(31 downto 0);
  signal databus_B1_1_alt8 : std_logic_vector(31 downto 0);
  signal databus_B1_1_alt9 : std_logic_vector(31 downto 0);
  signal databus_B1_1_alt10 : std_logic_vector(31 downto 0);
  signal databus_B1_1_alt11 : std_logic_vector(31 downto 0);
  signal databus_B1_1_simm : std_logic_vector(31 downto 0);
  signal databus_B1_2 : std_logic_vector(31 downto 0);
  signal databus_B1_2_alt0 : std_logic_vector(31 downto 0);
  signal databus_B1_2_alt1 : std_logic_vector(31 downto 0);
  signal databus_B1_2_alt2 : std_logic_vector(31 downto 0);
  signal databus_B1_2_alt3 : std_logic_vector(31 downto 0);
  signal databus_B1_2_alt4 : std_logic_vector(31 downto 0);
  signal databus_B1_2_alt5 : std_logic_vector(31 downto 0);
  signal databus_B1_2_alt6 : std_logic_vector(31 downto 0);
  signal databus_B1_2_alt7 : std_logic_vector(31 downto 0);
  signal databus_B1_2_alt8 : std_logic_vector(31 downto 0);
  signal databus_B1_2_alt9 : std_logic_vector(31 downto 0);
  signal databus_B1_2_alt10 : std_logic_vector(31 downto 0);
  signal databus_B1_2_alt11 : std_logic_vector(31 downto 0);
  signal databus_B1_2_simm : std_logic_vector(31 downto 0);
  signal databus_B1_3 : std_logic_vector(31 downto 0);
  signal databus_B1_3_alt0 : std_logic_vector(31 downto 0);
  signal databus_B1_3_alt1 : std_logic_vector(31 downto 0);
  signal databus_B1_3_alt2 : std_logic_vector(31 downto 0);
  signal databus_B1_3_alt3 : std_logic_vector(31 downto 0);
  signal databus_B1_3_alt4 : std_logic_vector(31 downto 0);
  signal databus_B1_3_alt5 : std_logic_vector(31 downto 0);
  signal databus_B1_3_alt6 : std_logic_vector(31 downto 0);
  signal databus_B1_3_alt7 : std_logic_vector(31 downto 0);
  signal databus_B1_3_alt8 : std_logic_vector(31 downto 0);
  signal databus_B1_3_alt9 : std_logic_vector(31 downto 0);
  signal databus_B1_3_alt10 : std_logic_vector(31 downto 0);
  signal databus_B1_3_alt11 : std_logic_vector(31 downto 0);
  signal databus_B1_3_simm : std_logic_vector(31 downto 0);
  signal databus_B1_4 : std_logic_vector(31 downto 0);
  signal databus_B1_4_alt0 : std_logic_vector(31 downto 0);
  signal databus_B1_4_alt1 : std_logic_vector(31 downto 0);
  signal databus_B1_4_alt2 : std_logic_vector(31 downto 0);
  signal databus_B1_4_alt3 : std_logic_vector(31 downto 0);
  signal databus_B1_4_alt4 : std_logic_vector(31 downto 0);
  signal databus_B1_4_alt5 : std_logic_vector(31 downto 0);
  signal databus_B1_4_alt6 : std_logic_vector(31 downto 0);
  signal databus_B1_4_alt7 : std_logic_vector(31 downto 0);
  signal databus_B1_4_alt8 : std_logic_vector(31 downto 0);
  signal databus_B1_4_alt9 : std_logic_vector(31 downto 0);
  signal databus_B1_4_alt10 : std_logic_vector(31 downto 0);
  signal databus_B1_4_alt11 : std_logic_vector(31 downto 0);
  signal databus_B1_4_simm : std_logic_vector(31 downto 0);
  signal databus_B1_5 : std_logic_vector(31 downto 0);
  signal databus_B1_5_alt0 : std_logic_vector(31 downto 0);
  signal databus_B1_5_alt1 : std_logic_vector(31 downto 0);
  signal databus_B1_5_alt2 : std_logic_vector(31 downto 0);
  signal databus_B1_5_alt3 : std_logic_vector(31 downto 0);
  signal databus_B1_5_alt4 : std_logic_vector(31 downto 0);
  signal databus_B1_5_alt5 : std_logic_vector(31 downto 0);
  signal databus_B1_5_alt6 : std_logic_vector(31 downto 0);
  signal databus_B1_5_alt7 : std_logic_vector(31 downto 0);
  signal databus_B1_5_alt8 : std_logic_vector(31 downto 0);
  signal databus_B1_5_alt9 : std_logic_vector(31 downto 0);
  signal databus_B1_5_alt10 : std_logic_vector(31 downto 0);
  signal databus_B1_5_alt11 : std_logic_vector(31 downto 0);
  signal databus_B1_5_simm : std_logic_vector(31 downto 0);
  signal databus_B1_6 : std_logic_vector(31 downto 0);
  signal databus_B1_6_alt0 : std_logic_vector(31 downto 0);
  signal databus_B1_6_alt1 : std_logic_vector(31 downto 0);
  signal databus_B1_6_alt2 : std_logic_vector(31 downto 0);
  signal databus_B1_6_alt3 : std_logic_vector(31 downto 0);
  signal databus_B1_6_alt4 : std_logic_vector(31 downto 0);
  signal databus_B1_6_alt5 : std_logic_vector(31 downto 0);
  signal databus_B1_6_alt6 : std_logic_vector(31 downto 0);
  signal databus_B1_6_alt7 : std_logic_vector(31 downto 0);
  signal databus_B1_6_alt8 : std_logic_vector(31 downto 0);
  signal databus_B1_6_alt9 : std_logic_vector(31 downto 0);
  signal databus_B1_6_alt10 : std_logic_vector(31 downto 0);
  signal databus_B1_6_alt11 : std_logic_vector(31 downto 0);
  signal databus_B1_6_simm : std_logic_vector(31 downto 0);
  signal databus_B1_7 : std_logic_vector(31 downto 0);
  signal databus_B1_7_alt0 : std_logic_vector(31 downto 0);
  signal databus_B1_7_alt1 : std_logic_vector(31 downto 0);
  signal databus_B1_7_alt2 : std_logic_vector(31 downto 0);
  signal databus_B1_7_alt3 : std_logic_vector(31 downto 0);
  signal databus_B1_7_alt4 : std_logic_vector(31 downto 0);
  signal databus_B1_7_alt5 : std_logic_vector(31 downto 0);
  signal databus_B1_7_alt6 : std_logic_vector(31 downto 0);
  signal databus_B1_7_alt7 : std_logic_vector(31 downto 0);
  signal databus_B1_7_alt8 : std_logic_vector(31 downto 0);
  signal databus_B1_7_alt9 : std_logic_vector(31 downto 0);
  signal databus_B1_7_alt10 : std_logic_vector(31 downto 0);
  signal databus_B1_7_alt11 : std_logic_vector(31 downto 0);
  signal databus_B1_7_simm : std_logic_vector(31 downto 0);
  signal databus_B1_8 : std_logic_vector(31 downto 0);
  signal databus_B1_8_alt0 : std_logic_vector(31 downto 0);
  signal databus_B1_8_alt1 : std_logic_vector(31 downto 0);
  signal databus_B1_8_alt2 : std_logic_vector(31 downto 0);
  signal databus_B1_8_alt3 : std_logic_vector(31 downto 0);
  signal databus_B1_8_alt4 : std_logic_vector(31 downto 0);
  signal databus_B1_8_alt5 : std_logic_vector(31 downto 0);
  signal databus_B1_8_alt6 : std_logic_vector(31 downto 0);
  signal databus_B1_8_alt7 : std_logic_vector(31 downto 0);
  signal databus_B1_8_alt8 : std_logic_vector(31 downto 0);
  signal databus_B1_8_alt9 : std_logic_vector(31 downto 0);
  signal databus_B1_8_alt10 : std_logic_vector(31 downto 0);
  signal databus_B1_8_alt11 : std_logic_vector(31 downto 0);
  signal databus_B1_8_simm : std_logic_vector(31 downto 0);

  component myProssu_input_socket_cons_9
    generic (
      BUSW_0 : integer := 32;
      BUSW_1 : integer := 32;
      BUSW_2 : integer := 32;
      BUSW_3 : integer := 32;
      BUSW_4 : integer := 32;
      BUSW_5 : integer := 32;
      BUSW_6 : integer := 32;
      BUSW_7 : integer := 32;
      BUSW_8 : integer := 32;
      DATAW : integer := 32);
    port (
      databus0 : in std_logic_vector(BUSW_0-1 downto 0);
      databus1 : in std_logic_vector(BUSW_1-1 downto 0);
      databus2 : in std_logic_vector(BUSW_2-1 downto 0);
      databus3 : in std_logic_vector(BUSW_3-1 downto 0);
      databus4 : in std_logic_vector(BUSW_4-1 downto 0);
      databus5 : in std_logic_vector(BUSW_5-1 downto 0);
      databus6 : in std_logic_vector(BUSW_6-1 downto 0);
      databus7 : in std_logic_vector(BUSW_7-1 downto 0);
      databus8 : in std_logic_vector(BUSW_8-1 downto 0);
      data : out std_logic_vector(DATAW-1 downto 0);
      databus_cntrl : in std_logic_vector(3 downto 0));
  end component;

  component myProssu_output_socket_cons_9_1
    generic (
      BUSW_0 : integer := 32;
      BUSW_1 : integer := 32;
      BUSW_2 : integer := 32;
      BUSW_3 : integer := 32;
      BUSW_4 : integer := 32;
      BUSW_5 : integer := 32;
      BUSW_6 : integer := 32;
      BUSW_7 : integer := 32;
      BUSW_8 : integer := 32;
      DATAW_0 : integer := 32);
    port (
      databus0_alt : out std_logic_vector(BUSW_0-1 downto 0);
      databus1_alt : out std_logic_vector(BUSW_1-1 downto 0);
      databus2_alt : out std_logic_vector(BUSW_2-1 downto 0);
      databus3_alt : out std_logic_vector(BUSW_3-1 downto 0);
      databus4_alt : out std_logic_vector(BUSW_4-1 downto 0);
      databus5_alt : out std_logic_vector(BUSW_5-1 downto 0);
      databus6_alt : out std_logic_vector(BUSW_6-1 downto 0);
      databus7_alt : out std_logic_vector(BUSW_7-1 downto 0);
      databus8_alt : out std_logic_vector(BUSW_8-1 downto 0);
      data0 : in std_logic_vector(DATAW_0-1 downto 0);
      databus_cntrl : in std_logic_vector(8 downto 0));
  end component;

  component myProssu_output_socket_cons_1_1
    generic (
      BUSW_0 : integer := 32;
      DATAW_0 : integer := 32);
    port (
      databus0_alt : out std_logic_vector(BUSW_0-1 downto 0);
      data0 : in std_logic_vector(DATAW_0-1 downto 0);
      databus_cntrl : in std_logic_vector(0 downto 0));
  end component;


begin -- comb_andor

  lsu_i1 : myProssu_input_socket_cons_9
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW => 8)
    port map (
      databus0 => databus_B1,
      databus1 => databus_B1_1,
      databus2 => databus_B1_2,
      databus3 => databus_B1_3,
      databus4 => databus_B1_4,
      databus5 => databus_B1_5,
      databus6 => databus_B1_6,
      databus7 => databus_B1_7,
      databus8 => databus_B1_8,
      data => socket_lsu_i1_data,
      databus_cntrl => socket_lsu_i1_bus_cntrl);

  lsu_o1 : myProssu_output_socket_cons_9_1
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW_0 => 32)
    port map (
      databus0_alt => databus_B1_alt9,
      databus1_alt => databus_B1_1_alt9,
      databus2_alt => databus_B1_2_alt9,
      databus3_alt => databus_B1_3_alt9,
      databus4_alt => databus_B1_4_alt9,
      databus5_alt => databus_B1_5_alt9,
      databus6_alt => databus_B1_6_alt9,
      databus7_alt => databus_B1_7_alt9,
      databus8_alt => databus_B1_8_alt9,
      data0 => socket_lsu_o1_data0,
      databus_cntrl => socket_lsu_o1_bus_cntrl);

  lsu_i2 : myProssu_input_socket_cons_9
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW => 32)
    port map (
      databus0 => databus_B1,
      databus1 => databus_B1_1,
      databus2 => databus_B1_2,
      databus3 => databus_B1_3,
      databus4 => databus_B1_4,
      databus5 => databus_B1_5,
      databus6 => databus_B1_6,
      databus7 => databus_B1_7,
      databus8 => databus_B1_8,
      data => socket_lsu_i2_data,
      databus_cntrl => socket_lsu_i2_bus_cntrl);

  RF_i1 : myProssu_input_socket_cons_9
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW => 32)
    port map (
      databus0 => databus_B1,
      databus1 => databus_B1_1,
      databus2 => databus_B1_2,
      databus3 => databus_B1_3,
      databus4 => databus_B1_4,
      databus5 => databus_B1_5,
      databus6 => databus_B1_6,
      databus7 => databus_B1_7,
      databus8 => databus_B1_8,
      data => socket_RF_i1_data,
      databus_cntrl => socket_RF_i1_bus_cntrl);

  RF_o1 : myProssu_output_socket_cons_9_1
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW_0 => 32)
    port map (
      databus0_alt => databus_B1_alt8,
      databus1_alt => databus_B1_1_alt8,
      databus2_alt => databus_B1_2_alt8,
      databus3_alt => databus_B1_3_alt8,
      databus4_alt => databus_B1_4_alt8,
      databus5_alt => databus_B1_5_alt8,
      databus6_alt => databus_B1_6_alt8,
      databus7_alt => databus_B1_7_alt8,
      databus8_alt => databus_B1_8_alt8,
      data0 => socket_RF_o1_data0,
      databus_cntrl => socket_RF_o1_bus_cntrl);

  gcu_i1 : myProssu_input_socket_cons_9
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW => IMEMADDRWIDTH)
    port map (
      databus0 => databus_B1,
      databus1 => databus_B1_1,
      databus2 => databus_B1_2,
      databus3 => databus_B1_3,
      databus4 => databus_B1_4,
      databus5 => databus_B1_5,
      databus6 => databus_B1_6,
      databus7 => databus_B1_7,
      databus8 => databus_B1_8,
      data => socket_gcu_i1_data,
      databus_cntrl => socket_gcu_i1_bus_cntrl);

  gcu_o1 : myProssu_output_socket_cons_9_1
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW_0 => IMEMADDRWIDTH)
    port map (
      databus0_alt => databus_B1_alt7,
      databus1_alt => databus_B1_1_alt7,
      databus2_alt => databus_B1_2_alt7,
      databus3_alt => databus_B1_3_alt7,
      databus4_alt => databus_B1_4_alt7,
      databus5_alt => databus_B1_5_alt7,
      databus6_alt => databus_B1_6_alt7,
      databus7_alt => databus_B1_7_alt7,
      databus8_alt => databus_B1_8_alt7,
      data0 => socket_gcu_o1_data0,
      databus_cntrl => socket_gcu_o1_bus_cntrl);

  ALU_i1 : myProssu_input_socket_cons_9
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW => 32)
    port map (
      databus0 => databus_B1,
      databus1 => databus_B1_1,
      databus2 => databus_B1_2,
      databus3 => databus_B1_3,
      databus4 => databus_B1_4,
      databus5 => databus_B1_5,
      databus6 => databus_B1_6,
      databus7 => databus_B1_7,
      databus8 => databus_B1_8,
      data => socket_ALU_i1_data,
      databus_cntrl => socket_ALU_i1_bus_cntrl);

  ALU_i2 : myProssu_input_socket_cons_9
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW => 32)
    port map (
      databus0 => databus_B1,
      databus1 => databus_B1_1,
      databus2 => databus_B1_2,
      databus3 => databus_B1_3,
      databus4 => databus_B1_4,
      databus5 => databus_B1_5,
      databus6 => databus_B1_6,
      databus7 => databus_B1_7,
      databus8 => databus_B1_8,
      data => socket_ALU_i2_data,
      databus_cntrl => socket_ALU_i2_bus_cntrl);

  ALU_o1 : myProssu_output_socket_cons_9_1
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW_0 => 32)
    port map (
      databus0_alt => databus_B1_alt6,
      databus1_alt => databus_B1_1_alt6,
      databus2_alt => databus_B1_2_alt6,
      databus3_alt => databus_B1_3_alt6,
      databus4_alt => databus_B1_4_alt6,
      databus5_alt => databus_B1_5_alt6,
      databus6_alt => databus_B1_6_alt6,
      databus7_alt => databus_B1_7_alt6,
      databus8_alt => databus_B1_8_alt6,
      data0 => socket_ALU_o1_data0,
      databus_cntrl => socket_ALU_o1_bus_cntrl);

  stream_in_i1 : myProssu_input_socket_cons_9
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW => 8)
    port map (
      databus0 => databus_B1,
      databus1 => databus_B1_1,
      databus2 => databus_B1_2,
      databus3 => databus_B1_3,
      databus4 => databus_B1_4,
      databus5 => databus_B1_5,
      databus6 => databus_B1_6,
      databus7 => databus_B1_7,
      databus8 => databus_B1_8,
      data => socket_stream_in_i1_data,
      databus_cntrl => socket_stream_in_i1_bus_cntrl);

  stream_in_o1 : myProssu_output_socket_cons_9_1
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW_0 => 8)
    port map (
      databus0_alt => databus_B1_alt5,
      databus1_alt => databus_B1_1_alt5,
      databus2_alt => databus_B1_2_alt5,
      databus3_alt => databus_B1_3_alt5,
      databus4_alt => databus_B1_4_alt5,
      databus5_alt => databus_B1_5_alt5,
      databus6_alt => databus_B1_6_alt5,
      databus7_alt => databus_B1_7_alt5,
      databus8_alt => databus_B1_8_alt5,
      data0 => socket_stream_in_o1_data0,
      databus_cntrl => socket_stream_in_o1_bus_cntrl);

  stream_in_o2 : myProssu_output_socket_cons_9_1
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW_0 => 8)
    port map (
      databus0_alt => databus_B1_alt4,
      databus1_alt => databus_B1_1_alt4,
      databus2_alt => databus_B1_2_alt4,
      databus3_alt => databus_B1_3_alt4,
      databus4_alt => databus_B1_4_alt4,
      databus5_alt => databus_B1_5_alt4,
      databus6_alt => databus_B1_6_alt4,
      databus7_alt => databus_B1_7_alt4,
      databus8_alt => databus_B1_8_alt4,
      data0 => socket_stream_in_o2_data0,
      databus_cntrl => socket_stream_in_o2_bus_cntrl);

  stream_out_i1 : myProssu_input_socket_cons_9
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW => 8)
    port map (
      databus0 => databus_B1,
      databus1 => databus_B1_1,
      databus2 => databus_B1_2,
      databus3 => databus_B1_3,
      databus4 => databus_B1_4,
      databus5 => databus_B1_5,
      databus6 => databus_B1_6,
      databus7 => databus_B1_7,
      databus8 => databus_B1_8,
      data => socket_stream_out_i1_data,
      databus_cntrl => socket_stream_out_i1_bus_cntrl);

  stream_out_o1 : myProssu_output_socket_cons_9_1
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW_0 => 8)
    port map (
      databus0_alt => databus_B1_alt3,
      databus1_alt => databus_B1_1_alt3,
      databus2_alt => databus_B1_2_alt3,
      databus3_alt => databus_B1_3_alt3,
      databus4_alt => databus_B1_4_alt3,
      databus5_alt => databus_B1_5_alt3,
      databus6_alt => databus_B1_6_alt3,
      databus7_alt => databus_B1_7_alt3,
      databus8_alt => databus_B1_8_alt3,
      data0 => socket_stream_out_o1_data0,
      databus_cntrl => socket_stream_out_o1_bus_cntrl);

  gcu_i2 : myProssu_input_socket_cons_9
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW => IMEMADDRWIDTH)
    port map (
      databus0 => databus_B1,
      databus1 => databus_B1_1,
      databus2 => databus_B1_2,
      databus3 => databus_B1_3,
      databus4 => databus_B1_4,
      databus5 => databus_B1_5,
      databus6 => databus_B1_6,
      databus7 => databus_B1_7,
      databus8 => databus_B1_8,
      data => socket_gcu_i2_data,
      databus_cntrl => socket_gcu_i2_bus_cntrl);

  add_0_i3 : myProssu_input_socket_cons_9
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW => 32)
    port map (
      databus0 => databus_B1,
      databus1 => databus_B1_1,
      databus2 => databus_B1_2,
      databus3 => databus_B1_3,
      databus4 => databus_B1_4,
      databus5 => databus_B1_5,
      databus6 => databus_B1_6,
      databus7 => databus_B1_7,
      databus8 => databus_B1_8,
      data => socket_add_0_i3_data,
      databus_cntrl => socket_add_0_i3_bus_cntrl);

  add_0_i4 : myProssu_input_socket_cons_9
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW => 32)
    port map (
      databus0 => databus_B1,
      databus1 => databus_B1_1,
      databus2 => databus_B1_2,
      databus3 => databus_B1_3,
      databus4 => databus_B1_4,
      databus5 => databus_B1_5,
      databus6 => databus_B1_6,
      databus7 => databus_B1_7,
      databus8 => databus_B1_8,
      data => socket_add_0_i4_data,
      databus_cntrl => socket_add_0_i4_bus_cntrl);

  add_0_o2 : myProssu_output_socket_cons_9_1
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW_0 => 32)
    port map (
      databus0_alt => databus_B1_alt2,
      databus1_alt => databus_B1_1_alt2,
      databus2_alt => databus_B1_2_alt2,
      databus3_alt => databus_B1_3_alt2,
      databus4_alt => databus_B1_4_alt2,
      databus5_alt => databus_B1_5_alt2,
      databus6_alt => databus_B1_6_alt2,
      databus7_alt => databus_B1_7_alt2,
      databus8_alt => databus_B1_8_alt2,
      data0 => socket_add_0_o2_data0,
      databus_cntrl => socket_add_0_o2_bus_cntrl);

  RF_2_o1 : myProssu_output_socket_cons_9_1
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW_0 => 32)
    port map (
      databus0_alt => databus_B1_alt1,
      databus1_alt => databus_B1_2_alt1,
      databus2_alt => databus_B1_3_alt1,
      databus3_alt => databus_B1_4_alt1,
      databus4_alt => databus_B1_5_alt1,
      databus5_alt => databus_B1_1_alt1,
      databus6_alt => databus_B1_6_alt1,
      databus7_alt => databus_B1_7_alt1,
      databus8_alt => databus_B1_8_alt1,
      data0 => socket_RF_2_o1_data0,
      databus_cntrl => socket_RF_2_o1_bus_cntrl);

  RF_2_i1 : myProssu_input_socket_cons_9
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW => 32)
    port map (
      databus0 => databus_B1,
      databus1 => databus_B1_1,
      databus2 => databus_B1_2,
      databus3 => databus_B1_3,
      databus4 => databus_B1_4,
      databus5 => databus_B1_5,
      databus6 => databus_B1_6,
      databus7 => databus_B1_7,
      databus8 => databus_B1_8,
      data => socket_RF_2_i1_data,
      databus_cntrl => socket_RF_2_i1_bus_cntrl);

  BOOL_o1 : myProssu_output_socket_cons_9_1
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW_0 => 1)
    port map (
      databus0_alt => databus_B1_alt0,
      databus1_alt => databus_B1_1_alt0,
      databus2_alt => databus_B1_2_alt0,
      databus3_alt => databus_B1_3_alt0,
      databus4_alt => databus_B1_4_alt0,
      databus5_alt => databus_B1_5_alt0,
      databus6_alt => databus_B1_6_alt0,
      databus7_alt => databus_B1_7_alt0,
      databus8_alt => databus_B1_8_alt0,
      data0 => socket_BOOL_o1_data0,
      databus_cntrl => socket_BOOL_o1_bus_cntrl);

  BOOL_i1 : myProssu_input_socket_cons_9
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW => 1)
    port map (
      databus0 => databus_B1,
      databus1 => databus_B1_1,
      databus2 => databus_B1_2,
      databus3 => databus_B1_3,
      databus4 => databus_B1_4,
      databus5 => databus_B1_5,
      databus6 => databus_B1_6,
      databus7 => databus_B1_7,
      databus8 => databus_B1_8,
      data => socket_BOOL_i1_data,
      databus_cntrl => socket_BOOL_i1_bus_cntrl);

  RF_3_o1 : myProssu_output_socket_cons_9_1
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW_0 => 32)
    port map (
      databus0_alt => databus_B1_alt11,
      databus1_alt => databus_B1_1_alt11,
      databus2_alt => databus_B1_2_alt11,
      databus3_alt => databus_B1_3_alt11,
      databus4_alt => databus_B1_4_alt11,
      databus5_alt => databus_B1_5_alt11,
      databus6_alt => databus_B1_6_alt11,
      databus7_alt => databus_B1_7_alt11,
      databus8_alt => databus_B1_8_alt11,
      data0 => socket_RF_3_o1_data0,
      databus_cntrl => socket_RF_3_o1_bus_cntrl);

  RF_3_i1 : myProssu_input_socket_cons_9
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW => 32)
    port map (
      databus0 => databus_B1,
      databus1 => databus_B1_1,
      databus2 => databus_B1_2,
      databus3 => databus_B1_3,
      databus4 => databus_B1_4,
      databus5 => databus_B1_5,
      databus6 => databus_B1_6,
      databus7 => databus_B1_7,
      databus8 => databus_B1_8,
      data => socket_RF_3_i1_data,
      databus_cntrl => socket_RF_3_i1_bus_cntrl);

  MAC_my_i1 : myProssu_input_socket_cons_9
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW => 32)
    port map (
      databus0 => databus_B1,
      databus1 => databus_B1_1,
      databus2 => databus_B1_2,
      databus3 => databus_B1_3,
      databus4 => databus_B1_4,
      databus5 => databus_B1_5,
      databus6 => databus_B1_6,
      databus7 => databus_B1_7,
      databus8 => databus_B1_8,
      data => socket_MAC_my_i1_data,
      databus_cntrl => socket_MAC_my_i1_bus_cntrl);

  MAC_my_i2 : myProssu_input_socket_cons_9
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW => 32)
    port map (
      databus0 => databus_B1,
      databus1 => databus_B1_1,
      databus2 => databus_B1_2,
      databus3 => databus_B1_3,
      databus4 => databus_B1_4,
      databus5 => databus_B1_5,
      databus6 => databus_B1_6,
      databus7 => databus_B1_7,
      databus8 => databus_B1_8,
      data => socket_MAC_my_i2_data,
      databus_cntrl => socket_MAC_my_i2_bus_cntrl);

  MAC_my_o1 : myProssu_output_socket_cons_9_1
    generic map (
      BUSW_0 => 32,
      BUSW_1 => 32,
      BUSW_2 => 32,
      BUSW_3 => 32,
      BUSW_4 => 32,
      BUSW_5 => 32,
      BUSW_6 => 32,
      BUSW_7 => 32,
      BUSW_8 => 32,
      DATAW_0 => 32)
    port map (
      databus0_alt => databus_B1_alt10,
      databus1_alt => databus_B1_1_alt10,
      databus2_alt => databus_B1_2_alt10,
      databus3_alt => databus_B1_3_alt10,
      databus4_alt => databus_B1_4_alt10,
      databus5_alt => databus_B1_5_alt10,
      databus6_alt => databus_B1_6_alt10,
      databus7_alt => databus_B1_7_alt10,
      databus8_alt => databus_B1_8_alt10,
      data0 => socket_MAC_my_o1_data0,
      databus_cntrl => socket_MAC_my_o1_bus_cntrl);

  simm_socket_B1 : myProssu_output_socket_cons_1_1
    generic map (
      BUSW_0 => 32,
      DATAW_0 => 32)
    port map (
      databus0_alt => databus_B1_simm,
      data0 => simm_B1,
      databus_cntrl => simm_cntrl_B1);

  simm_socket_B1_1 : myProssu_output_socket_cons_1_1
    generic map (
      BUSW_0 => 32,
      DATAW_0 => 32)
    port map (
      databus0_alt => databus_B1_1_simm,
      data0 => simm_B1_1,
      databus_cntrl => simm_cntrl_B1_1);

  simm_socket_B1_2 : myProssu_output_socket_cons_1_1
    generic map (
      BUSW_0 => 32,
      DATAW_0 => 32)
    port map (
      databus0_alt => databus_B1_2_simm,
      data0 => simm_B1_2,
      databus_cntrl => simm_cntrl_B1_2);

  simm_socket_B1_3 : myProssu_output_socket_cons_1_1
    generic map (
      BUSW_0 => 32,
      DATAW_0 => 32)
    port map (
      databus0_alt => databus_B1_3_simm,
      data0 => simm_B1_3,
      databus_cntrl => simm_cntrl_B1_3);

  simm_socket_B1_4 : myProssu_output_socket_cons_1_1
    generic map (
      BUSW_0 => 32,
      DATAW_0 => 32)
    port map (
      databus0_alt => databus_B1_4_simm,
      data0 => simm_B1_4,
      databus_cntrl => simm_cntrl_B1_4);

  simm_socket_B1_5 : myProssu_output_socket_cons_1_1
    generic map (
      BUSW_0 => 32,
      DATAW_0 => 32)
    port map (
      databus0_alt => databus_B1_5_simm,
      data0 => simm_B1_5,
      databus_cntrl => simm_cntrl_B1_5);

  simm_socket_B1_6 : myProssu_output_socket_cons_1_1
    generic map (
      BUSW_0 => 32,
      DATAW_0 => 32)
    port map (
      databus0_alt => databus_B1_6_simm,
      data0 => simm_B1_6,
      databus_cntrl => simm_cntrl_B1_6);

  simm_socket_B1_7 : myProssu_output_socket_cons_1_1
    generic map (
      BUSW_0 => 32,
      DATAW_0 => 32)
    port map (
      databus0_alt => databus_B1_7_simm,
      data0 => simm_B1_7,
      databus_cntrl => simm_cntrl_B1_7);

  simm_socket_B1_8 : myProssu_output_socket_cons_1_1
    generic map (
      BUSW_0 => 32,
      DATAW_0 => 32)
    port map (
      databus0_alt => databus_B1_8_simm,
      data0 => simm_B1_8,
      databus_cntrl => simm_cntrl_B1_8);

  databus_B1 <= databus_B1_alt0 or databus_B1_alt1 or databus_B1_alt2 or databus_B1_alt3 or databus_B1_alt4 or databus_B1_alt5 or databus_B1_alt6 or databus_B1_alt7 or databus_B1_alt8 or databus_B1_alt9 or databus_B1_alt10 or databus_B1_alt11 or databus_B1_simm;
  databus_B1_1 <= databus_B1_1_alt0 or databus_B1_1_alt1 or databus_B1_1_alt2 or databus_B1_1_alt3 or databus_B1_1_alt4 or databus_B1_1_alt5 or databus_B1_1_alt6 or databus_B1_1_alt7 or databus_B1_1_alt8 or databus_B1_1_alt9 or databus_B1_1_alt10 or databus_B1_1_alt11 or databus_B1_1_simm;
  databus_B1_2 <= databus_B1_2_alt0 or databus_B1_2_alt1 or databus_B1_2_alt2 or databus_B1_2_alt3 or databus_B1_2_alt4 or databus_B1_2_alt5 or databus_B1_2_alt6 or databus_B1_2_alt7 or databus_B1_2_alt8 or databus_B1_2_alt9 or databus_B1_2_alt10 or databus_B1_2_alt11 or databus_B1_2_simm;
  databus_B1_3 <= databus_B1_3_alt0 or databus_B1_3_alt1 or databus_B1_3_alt2 or databus_B1_3_alt3 or databus_B1_3_alt4 or databus_B1_3_alt5 or databus_B1_3_alt6 or databus_B1_3_alt7 or databus_B1_3_alt8 or databus_B1_3_alt9 or databus_B1_3_alt10 or databus_B1_3_alt11 or databus_B1_3_simm;
  databus_B1_4 <= databus_B1_4_alt0 or databus_B1_4_alt1 or databus_B1_4_alt2 or databus_B1_4_alt3 or databus_B1_4_alt4 or databus_B1_4_alt5 or databus_B1_4_alt6 or databus_B1_4_alt7 or databus_B1_4_alt8 or databus_B1_4_alt9 or databus_B1_4_alt10 or databus_B1_4_alt11 or databus_B1_4_simm;
  databus_B1_5 <= databus_B1_5_alt0 or databus_B1_5_alt1 or databus_B1_5_alt2 or databus_B1_5_alt3 or databus_B1_5_alt4 or databus_B1_5_alt5 or databus_B1_5_alt6 or databus_B1_5_alt7 or databus_B1_5_alt8 or databus_B1_5_alt9 or databus_B1_5_alt10 or databus_B1_5_alt11 or databus_B1_5_simm;
  databus_B1_6 <= databus_B1_6_alt0 or databus_B1_6_alt1 or databus_B1_6_alt2 or databus_B1_6_alt3 or databus_B1_6_alt4 or databus_B1_6_alt5 or databus_B1_6_alt6 or databus_B1_6_alt7 or databus_B1_6_alt8 or databus_B1_6_alt9 or databus_B1_6_alt10 or databus_B1_6_alt11 or databus_B1_6_simm;
  databus_B1_7 <= databus_B1_7_alt0 or databus_B1_7_alt1 or databus_B1_7_alt2 or databus_B1_7_alt3 or databus_B1_7_alt4 or databus_B1_7_alt5 or databus_B1_7_alt6 or databus_B1_7_alt7 or databus_B1_7_alt8 or databus_B1_7_alt9 or databus_B1_7_alt10 or databus_B1_7_alt11 or databus_B1_7_simm;
  databus_B1_8 <= databus_B1_8_alt0 or databus_B1_8_alt1 or databus_B1_8_alt2 or databus_B1_8_alt3 or databus_B1_8_alt4 or databus_B1_8_alt5 or databus_B1_8_alt6 or databus_B1_8_alt7 or databus_B1_8_alt8 or databus_B1_8_alt9 or databus_B1_8_alt10 or databus_B1_8_alt11 or databus_B1_8_simm;

end comb_andor;
