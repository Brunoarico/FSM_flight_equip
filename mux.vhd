LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY mux IS
	PORT (
		D_0 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		D_1 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		D_2 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		D_3 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		CLK : IN STD_LOGIC;
		SEG : OUT STD_LOGIC_VECTOR(6 DOWNTO 0); -- Saída para os segmentos do display de 7 segmentos
		DISP_EN : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- Saída para habilitar o display
	);
END mux;

ARCHITECTURE Behavioral OF mux IS
	SIGNAL sel : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
	SIGNAL en : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1111";
	SIGNAL counter : INTEGER := 0;
	SIGNAL out_seg : STD_LOGIC_VECTOR(3 DOWNTO 0);
	CONSTANT divider : INTEGER := 50000;
BEGIN
	PROCESS (CLK)
	BEGIN
		IF rising_edge(CLK) THEN
			counter <= counter + 1;
			IF counter = divider THEN
				CASE sel IS
					WHEN "00" =>
						en <= "1110";
						out_seg <= D_0;
					WHEN "01" =>
						en <= "1101";
						out_seg <= D_1;
					WHEN "10" =>
						en <= "1011";
						out_seg <= D_2;
					WHEN "11" =>
						en <= "0111";
						out_seg <= D_3;
				END CASE;

				IF sel = "11" THEN
					sel <= "00";
				ELSE
					sel <= sel + 1;
				END IF;
				counter <= 0;
			END IF;
		END IF;
	END PROCESS;

	disp_0 : work.bcd_converter PORT MAP (BIN => out_seg, SEGS => SEG);
	DISP_EN <= en;
END Behavioral;