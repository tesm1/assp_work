library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mac_arith is
    generic (
        dataw : integer := 32;
		busw  : integer := 32
    );
    port(
        A 		  	 : in  std_logic_vector(dataw-1 downto 0);
        B 		  	 : in  std_logic_vector(dataw-1 downto 0);
		prev_acc  	 : in  std_logic_vector(dataw-1 downto 0);
		counter   	 : in  std_logic_vector(4 downto 0);
		counter_next : out  std_logic_vector(4 downto 0);
		acc		  	 : out  std_logic_vector(dataw-1 downto 0);
        S 		  	 : out std_logic_vector(dataw-1 downto 0)
    );
end mac_arith;

architecture comb of mac_arith is
	signal res : std_logic_vector(dataw-1 downto 0);
	constant count_limit : integer := 4; -- Fixed maximum value 4


begin

    process(A, B, prev_acc, counter)
        variable A_signed : signed(dataw-1 downto 0);
        variable B_signed : signed(dataw-1 downto 0);
		variable prev_acc_signed : signed(dataw-1 downto 0);
		variable counter_int : integer;

    begin
        -- Convert inputs to signed
        A_signed := signed(A);
        B_signed := signed(B);
		prev_acc_signed := signed(prev_acc);
		counter_int := to_integer(unsigned(counter));

		if counter_int < count_limit then
			res <= (others => '0');
			acc <= std_logic_vector(resize(prev_acc_signed + A_signed * B_signed, dataw));
			counter_next <= std_logic_vector(to_unsigned(counter_int + 1, 5));

		else
			res <= std_logic_vector(resize(prev_acc_signed + A_signed * B_signed, dataw));
			acc <= (others => '0');
			counter_next <= (0 => '1', others => '0');
			-- counter_next <= (others => '0');

		end if;

    end process;


	S <= res;

end comb;








library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.numeric_std.all;


entity my_mac is
	generic (
		dataw : integer := 32; 	-- Operand Width
		busw  : integer := 32	-- Bus Width
	);

	port(
		t1data      : in  std_logic_vector(dataw-1 downto 0);
		t1opcode    : in  std_logic_vector(0 downto 0);
		t1load      : in  std_logic;

		o1data      : in  std_logic_vector(dataw-1 downto 0);
		o1load      : in  std_logic;

		r1data      : out std_logic_vector(busw-1 downto 0);

		glock 		: in  std_logic;
		rstx        : in  std_logic;
		clk         : in  std_logic
	);

end my_mac;



architecture rtl of my_mac is

	component mac_arith
		generic (
			dataw : integer := 32;
			busw  : integer := 32
		);
		port(
			A 		  	 : in  std_logic_vector(dataw-1 downto 0);
			B 		  	 : in  std_logic_vector(dataw-1 downto 0);
			prev_acc  	 : in  std_logic_vector(dataw-1 downto 0);
			counter   	 : in  std_logic_vector(4 downto 0);
			counter_next : out  std_logic_vector(4 downto 0);
			acc		  	 : out  std_logic_vector(dataw-1 downto 0);
			S 		  	 : out std_logic_vector(dataw-1 downto 0)
		);
	end component;

	signal t1reg     : std_logic_vector(dataw-1 downto 0);
	signal t1opc_reg : std_logic_vector(0 downto 0);
	signal o1reg     : std_logic_vector(dataw-1 downto 0);
	signal r1        : std_logic_vector(dataw-1 downto 0);
	signal r1reg     : std_logic_vector(busw-1 downto 0);
	signal control   : std_logic_vector(1 downto 0);

	signal acc_reg_out   : std_logic_vector(busw-1 downto 0) := (others => '0');
	signal acc_reg_in    : std_logic_vector(busw-1 downto 0) := (others => '0');
	signal counter_in    : std_logic_vector(4 downto 0) := (others => '0');
	signal counter_out   : std_logic_vector(4 downto 0) := (others => '0');

  begin

	fu_arch : mac_arith
	generic map (
		dataw => dataw
	)
	port map (
		A   			=> 	t1reg,
		B  				=> 	o1reg,
		prev_acc 		=>  acc_reg_in,
		counter 		=>  counter_in,
		counter_next 	=>  counter_out,
		acc 			=> 	acc_reg_out,
		S   			=> 	r1
	);

	control <= o1load&t1load;

	regs : process (clk, rstx)
	begin  -- process regs
		if rstx = '0' then                  -- asynchronous reset (active low)
			t1reg     	<= (others => '0');
			t1opc_reg 	<= (others => '0');
			o1reg     	<= (others => '0');
			r1reg     	<= (others => '0');


		elsif clk'event and clk = '1' then
			if (glock='0') then

				case control is
					when "11" =>
						t1reg     <= t1data;
						o1reg     <= o1data;
						t1opc_reg <= t1opcode;
						acc_reg_in <= acc_reg_out;
						counter_in <= counter_out;

					when "10" =>
						o1reg <= o1data;

					when "01" =>
						t1reg     <= t1data;
						t1opc_reg <= t1opcode;
						acc_reg_in <= acc_reg_out;
						counter_in <= counter_out;

					when others => null;
				end case;

				if busw < dataw then
					r1reg <= std_logic_vector(resize(signed(r1), busw));
				else
					r1reg <= r1;
					-- r1reg <= sxt(r1, busw);
				end if;

			end if; -- global lock
		end if; -- end clock
	end process regs;




	--r1data <= sxt(r1reg, busw);
	r1data <= r1reg;

end rtl;