LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY conv_Psi IS
	PORT (
		psi8 : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- temperatura em binário
		psi : OUT INTEGER;
		ALARM : OUT STD_LOGIC
	);
END conv_Psi;

ARCHITECTURE Behavioral OF conv_Psi IS
	SIGNAL p : INTEGER;
	CONSTANT inf_lim : INTEGER := 10;
	CONSTANT max_lim : INTEGER := 20;
	SIGNAL AL : STD_LOGIC;
BEGIN
	p <= ((to_integer(unsigned(psi8)) * 100) / 255);
	AL <= '0' WHEN (p >= inf_lim) AND (p <= max_lim) ELSE
		'1';
	psi <= p;
	ALARM <= AL;
END Behavioral;