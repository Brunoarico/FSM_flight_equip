LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY conv_Alt IS
	PORT (
		alt8 : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- temperatura em binário
		D_0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		D_1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		D_2 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		D_3 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		ALARM : OUT STD_LOGIC
	);
END conv_Alt;

ARCHITECTURE Behavioral OF conv_Alt IS
	SIGNAL alt : INTEGER;
	CONSTANT inf_lim : INTEGER := 0;
	CONSTANT max_lim : INTEGER := 120;

BEGIN
	alt <= ((to_integer(unsigned(alt8)) * 120) / 255);

	D_3 <= "1110"; -- A
	D_2 <= STD_LOGIC_VECTOR(to_unsigned((alt/100) MOD 10, 4));
	D_1 <= STD_LOGIC_VECTOR(to_unsigned((alt/10) MOD 10, 4));
	D_0 <= STD_LOGIC_VECTOR(to_unsigned((alt) MOD 10, 4));
	ALARM <= '0' WHEN (alt >= inf_lim) AND (alt <= max_lim) ELSE
		'1';

END Behavioral;