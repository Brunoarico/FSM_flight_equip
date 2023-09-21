LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY conv_Alt IS
	PORT (
		alt8 : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- temperatura em binário
		alt : OUT INTEGER;
		ALARM : OUT STD_LOGIC
	);
END conv_Alt;

ARCHITECTURE Behavioral OF conv_Alt IS
	SIGNAL a : INTEGER;
	CONSTANT inf_lim : INTEGER := 0;
	CONSTANT max_lim : INTEGER := 120;

BEGIN
	a <= ((to_integer(unsigned(alt8)) * 120) / 255);
	ALARM <= '0' WHEN (a >= inf_lim) AND (a <= max_lim) ELSE '1';
	alt <= a;

END Behavioral;