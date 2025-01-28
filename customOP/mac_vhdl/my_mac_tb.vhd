library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Testbench entity
entity my_mac_tb is
end my_mac_tb;

architecture behavior of my_mac_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component my_mac
        generic (
            dataw : integer := 32;
            busw  : integer := 32
        );
        port(
            t1data      : in  std_logic_vector(dataw-1 downto 0);
            t1opcode    : in  std_logic_vector(0 downto 0);
            t1load      : in  std_logic;
            o1data      : in  std_logic_vector(dataw-1 downto 0);
            o1load      : in  std_logic;
            r1data      : out std_logic_vector(busw-1 downto 0);
            glock       : in  std_logic;
            rstx        : in  std_logic;
            clk         : in  std_logic
        );
    end component;

    -- Signals
    signal t1data      : std_logic_vector(31 downto 0) := (others => '0');
    signal t1opcode    : std_logic_vector(0 downto 0) := (others => '0');
    signal t1load      : std_logic := '0';
    signal o1data      : std_logic_vector(31 downto 0) := (others => '0');
    signal o1load      : std_logic := '0';
    signal r1data      : std_logic_vector(31 downto 0);
    signal glock       : std_logic := '0';
    signal rstx        : std_logic := '0';
    signal clk         : std_logic := '0';

    -- Clock period
    constant clk_period : time := 10 ns;
	constant dataw : integer := 32;

begin

    -- Instantiate the device under test
    DUT: my_mac
        generic map (
            dataw => 32,
            busw  => 32
        )
        port map (
            t1data   => t1data,
            t1opcode => t1opcode,
            t1load   => t1load,
            o1data   => o1data,
            o1load   => o1load,
            r1data   => r1data,
            glock    => glock,
            rstx     => rstx,
            clk      => clk
        );

    -- Clock process
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimulus process
    stimulus_process: process
    begin
        rstx <= '1';
        wait for clk_period;


		for i in 0 to 9 loop
			t1data <= std_logic_vector(to_signed(i + 1, dataw));
			o1data <= std_logic_vector(to_signed(i + 2, dataw));
			t1opcode <= "1"; -- tesm??
			t1load <= '1';
			o1load <= '1';
			wait for clk_period;
			t1load <= '0';
			o1load <= '0';
			wait for clk_period;
		end loop;

		t1opcode <= "0"; -- tesm??
		t1load <= '1';

        -- Finish simulation
        wait;
    end process;

end behavior;
