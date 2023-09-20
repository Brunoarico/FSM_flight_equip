library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cronometer is
	Port (
		CLK : in STD_LOGIC;
		RST : in STD_LOGIC;
		HOLD : in STD_LOGIC;
		D_0 : out STD_LOGIC_VECTOR(3 downto 0);
		D_1 : out STD_LOGIC_VECTOR(3 downto 0);
		D_2 : out STD_LOGIC_VECTOR(3 downto 0);
		D_3 : out STD_LOGIC_VECTOR(3 downto 0)
	);
end cronometer;

architecture Behavioral of cronometer is
	signal count : integer := 0000;
	signal countOut : integer := 0000;
	signal div : integer := 0;
	signal min_u : STD_LOGIC_VECTOR(3 downto 0);
	signal min_d : STD_LOGIC_VECTOR(3 downto 0);
	signal seg_u : STD_LOGIC_VECTOR(3 downto 0);
	signal seg_d : STD_LOGIC_VECTOR(3 downto 0);
	signal h : STD_LOGIC := '1';
	signal reset : STD_LOGIC := '0';
	constant frequency : integer := 50000000;
begin
	process(CLK, RST)
	begin
		if RST = '0' then
		 	reset <= '1';
		else
			reset <= '0';
		end if;

		if rising_edge(CLK) then
			div <= div + 1;

			if reset = '1' then
				count <= 0;
				div <= 0;
			end if;

			if div = frequency then
				count <= count + 1;
				div <= 0;
			end if;

		end if;
	end process;

	process (HOLD)
	begin
		if rising_edge(HOLD) then
			h <= not h;
		end if;

		if h = '1' then
			countOut <= count;
		else
			countOut <= countOut;
		end if;

	end process;

	conv : work.conv_MMSS port map (segs_in => countOut, min_u => min_u, min_d => min_d, seg_u => seg_u, seg_d => seg_d);
	D_0 <= seg_u; 
	D_1 <= seg_d;
	D_2 <= min_u; 
	D_3 <= min_d;
end Behavioral;
