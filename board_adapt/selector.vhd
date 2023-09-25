LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY selector IS
	PORT (
		SEL : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
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
	SIGNAL val : INTEGER RANGE -40 TO 120;
	SIGNAL t : INTEGER RANGE 0 TO 99;
BEGIN

	mins <= vtim / 60;
	segs <= vtim MOD 60;

	val <= vtemp WHEN SEL = "00" ELSE
		valt WHEN SEL = "10" ELSE
		vpsi WHEN SEL = "11" ELSE
		0;

	PROCESS (SEL)
	BEGIN
		IF SEL = "01" THEN -- cronometro
			D3 <= STD_LOGIC_VECTOR(to_unsigned(mins/10, 4)); --min_d
			D2 <= STD_LOGIC_VECTOR(to_unsigned(mins MOD 10, 4)); --min_u
			D1 <= STD_LOGIC_VECTOR(to_unsigned(segs / 10, 4)); --seg_d
			D0 <= STD_LOGIC_VECTOR(to_unsigned(segs MOD 10, 4)); --seg_u

		ELSIF SEL = "00" THEN -- temperatura
			IF val < 0 THEN
				D3 <= "1010"; -- -
				t <= - val;
				D1 <= STD_LOGIC_VECTOR(to_unsigned(t MOD 10, 4));
				D2 <= STD_LOGIC_VECTOR(to_unsigned((t/10) MOD 10, 4));
			ELSE
				D3 <= "1101"; -- desligado
				D1 <= STD_LOGIC_VECTOR(to_unsigned(val MOD 10, 4));
				D2 <= STD_LOGIC_VECTOR(to_unsigned((val/10) MOD 10, 4));
			END IF;
			D0 <= "1100"; -- C

		ELSIF SEL = "10" THEN -- altitude
			D1 <= STD_LOGIC_VECTOR(to_unsigned(val MOD 10, 4));
			D2 <= STD_LOGIC_VECTOR(to_unsigned((val/10) MOD 10, 4));
			D3 <= STD_LOGIC_VECTOR(to_unsigned((val/100) MOD 10, 4));
			D0 <= "1111"; -- L

		ELSIF SEL = "11" THEN -- umidade
			D1 <= STD_LOGIC_VECTOR(to_unsigned(val MOD 10, 4));
			D2 <= STD_LOGIC_VECTOR(to_unsigned((val/10) MOD 10, 4));
			D3 <= STD_LOGIC_VECTOR(to_unsigned((val/100) MOD 10, 4));
			D0 <= "1011"; -- U
		END IF;
	END PROCESS;
END Behavioral;