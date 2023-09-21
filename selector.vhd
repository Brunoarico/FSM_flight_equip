LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY selector IS
	PORT (
		SEL : STD_LOGIC_VECTOR(1 DOWNTO 0);
		vtemp : IN INTEGER;
		vtim : IN INTEGER;
		valt : IN INTEGER;
		vpsi : IN INTEGER;
		D0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		D1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		D2 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		D3 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END selector;

ARCHITECTURE Behavioral OF selector IS
	SIGNAL mins : INTEGER RANGE 0 TO 99;
	SIGNAL segs : INTEGER RANGE 0 TO 59;
BEGIN
	
	PROCESS (SEL)
	BEGIN
		IF SEL = "00" THEN -- temperatura
			D3 <= STD_LOGIC_VECTOR(to_unsigned((vtemp/1000) MOD 10, 4));
			D2 <= STD_LOGIC_VECTOR(to_unsigned((vtemp/100) MOD 10, 4));
			D1 <= STD_LOGIC_VECTOR(to_unsigned((vtemp/10) MOD 10, 4));
			D0 <= STD_LOGIC_VECTOR(to_unsigned((vtemp) MOD 10, 4));
		ELSIF SEL = "01" THEN -- cronometro
			mins <= vtim / 60;
			segs <= vtim MOD 60;
			D3 <= STD_LOGIC_VECTOR(to_unsigned(mins/10, 4)); --min_d
			D2 <= STD_LOGIC_VECTOR(to_unsigned(mins MOD 10, 4)); --min_u
			D1 <= STD_LOGIC_VECTOR(to_unsigned(segs / 10, 4)); --seg_d
			D0 <= STD_LOGIC_VECTOR(to_unsigned(segs MOD 10, 4)); --seg_u
		ELSIF SEL = "10" THEN -- altitude
			D3 <= STD_LOGIC_VECTOR(to_unsigned((valt/1000) MOD 10, 4));
			D2 <= STD_LOGIC_VECTOR(to_unsigned((valt/100) MOD 10, 4));
			D1 <= STD_LOGIC_VECTOR(to_unsigned((valt/10) MOD 10, 4));
			D0 <= STD_LOGIC_VECTOR(to_unsigned((valt) MOD 10, 4));
		ELSIF SEL = "11" THEN -- umidade
			D3 <= STD_LOGIC_VECTOR(to_unsigned((vpsi/1000) MOD 10, 4));
			D2 <= STD_LOGIC_VECTOR(to_unsigned((vpsi/100) MOD 10, 4));
			D1 <= STD_LOGIC_VECTOR(to_unsigned((vpsi/10) MOD 10, 4));
			D0 <= STD_LOGIC_VECTOR(to_unsigned((vpsi) MOD 10, 4));
		END IF;
	END PROCESS;

END Behavioral;