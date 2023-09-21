LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY conv_Psi IS
	PORT (
		psi8 : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- temperatura em binário
		D_0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		D_1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		D_2 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		D_3 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		ALARM : OUT STD_LOGIC
	);
END conv_Psi;

ARCHITECTURE Behavioral OF conv_Psi IS
	SIGNAL psi : INTEGER;
	CONSTANT inf_lim : INTEGER := 10;
	CONSTANT max_lim : INTEGER := 20;

BEGIN
	psi <= ((to_integer(unsigned(psi8)) * 100) / 255);

	D_3 <= "1111"; -- P
	D_2 <= STD_LOGIC_VECTOR(to_unsigned((psi/100) MOD 10, 4));
	D_1 <= STD_LOGIC_VECTOR(to_unsigned((psi/10) MOD 10, 4));
	D_0 <= STD_LOGIC_VECTOR(to_unsigned((psi) MOD 10, 4));
	ALARM <= '0' WHEN (psi >= inf_lim) AND (psi <= max_lim) ELSE
		'1';

END Behavioral;