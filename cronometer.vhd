LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY cronometer IS
	PORT (
		CLK : IN STD_LOGIC;
		RST : IN STD_LOGIC;
		HOLD : IN STD_LOGIC;
		D_0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		D_1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		D_2 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		D_3 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END cronometer;

ARCHITECTURE Behavioral OF cronometer IS
	SIGNAL count : INTEGER := 0000;
	SIGNAL countOut : INTEGER := 0000;
	SIGNAL div : INTEGER := 0;
	SIGNAL min_u : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL min_d : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL seg_u : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL seg_d : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL h : STD_LOGIC := '1';
	SIGNAL reset : STD_LOGIC := '0';
	CONSTANT frequency : INTEGER := 50000000;
BEGIN
	PROCESS (CLK, RST)
	BEGIN
		IF RST = '0' THEN
			reset <= '1';
		ELSE
			reset <= '0';
		END IF;

		IF rising_edge(CLK) THEN
			div <= div + 1;

			IF reset = '1' THEN
				count <= 0;
				div <= 0;
			END IF;

			IF div = frequency THEN
				count <= count + 1;
				div <= 0;
			END IF;

		END IF;
	END PROCESS;

	PROCESS (HOLD)
	BEGIN
		IF rising_edge(HOLD) THEN
			h <= NOT h;
		END IF;

		IF h = '1' THEN
			countOut <= count;
		ELSE
			countOut <= countOut;
		END IF;

	END PROCESS;

	conv : work.conv_MMSS PORT MAP (segs_in => countOut, min_u => min_u, min_d => min_d, seg_u => seg_u, seg_d => seg_d);
	D_0 <= seg_u;
	D_1 <= seg_d;
	D_2 <= min_u;
	D_3 <= min_d;
END Behavioral;