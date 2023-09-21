LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY conv_Temp IS
	PORT (
		temp8 : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- temperatura em binário
		D_0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		D_1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		D_2 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		D_3 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		ALARM : OUT STD_LOGIC
	);
END conv_Temp;

ARCHITECTURE Behavioral OF conv_Temp IS
	SIGNAL temp : INTEGER;
	CONSTANT inf_lim : INTEGER := 0;
	CONSTANT max_lim : INTEGER := 30;

BEGIN
	temp <= ((to_integer(unsigned(temp8)) * 120) / 255) - 40;
	D_0 <= "1100"; -- C
	PROCESS (temp)
	BEGIN
		IF temp < 0 THEN
			D_3 <= "1010"; -- -
		ELSE
			D_3 <= "1101"; -- Desligado
		END IF;
	END PROCESS;

	D_2 <= STD_LOGIC_VECTOR(to_unsigned((temp/10) MOD 10, 4));
	D_1 <= STD_LOGIC_VECTOR(to_unsigned((temp) MOD 10, 4));
	ALARM <= '0' WHEN (temp >= inf_lim) AND (temp <= max_lim) ELSE
		'1';

END Behavioral;