
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY conv_MMSS IS
	PORT (
		segs_in : IN INTEGER RANGE 0 TO 5999; -- segundos (0-5999)
		min_u : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- Saída: Unidade do minuto (0-9)
		min_d : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- Saída: Dezena do minuto (0-9)
		seg_u : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- Saída: Unidade do segundo (0-9)
		seg_d : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- Saída: Dezena do segundo (0-5)
	);
END conv_MMSS;

ARCHITECTURE Behavioral OF conv_MMSS IS
	SIGNAL mins : INTEGER RANGE 0 TO 99;
	SIGNAL segs : INTEGER RANGE 0 TO 59;
BEGIN
	-- Converte os segundos em minutos e segundos
	mins <= segs_in / 60;
	segs <= segs_in MOD 60;

	-- Formata a saída no formato MM:SS
	min_u <= STD_LOGIC_VECTOR(to_unsigned(mins MOD 10, 4));
	min_d <= STD_LOGIC_VECTOR(to_unsigned(mins / 10, 4));
	seg_u <= STD_LOGIC_VECTOR(to_unsigned(segs MOD 10, 4));
	seg_d <= STD_LOGIC_VECTOR(to_unsigned(segs / 10, 4));
END Behavioral;