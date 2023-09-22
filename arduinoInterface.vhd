
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY arduinoInterface IS
	PORT (
		valemul : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- valor emulado
		BTN0 : IN STD_LOGIC;
		BZ : IN STD_LOGIC;
		BH : IN STD_LOGIC;
		CLK : IN STD_LOGIC;
		SEL : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); --  seletor para o arduino
		SEG : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		DISP_EN : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		BUZZ : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- Saida para os leds do fpga
	);
END arduinoInterface;

ARCHITECTURE Behavioral OF arduinoInterface IS
	SIGNAL SEL_out : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL TEMP : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL ALT : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL PSI : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL count : INTEGER := 0;
	CONSTANT MAX_COUNT : INTEGER := 500000;
BEGIN
	SEL <= SEL_out;
	PROCESS (CLK)
	BEGIN
		IF rising_edge(CLK) THEN
			count <= count + 1;
			IF count = MAX_COUNT THEN
				count <= 0;
				SEL_out <= SEL_out + 1;
				IF SEL_out = "00" THEN
					TEMP <= valemul;
					PSI <= PSI;
					ALT <= ALT;
				ELSIF SEL_out = "01" THEN
					TEMP <= TEMP;
					PSI <= PSI;
					ALT <= ALT;
				ELSIF SEL_out = "10" THEN
					TEMP <= TEMP;
					PSI <= PSI;
					ALT <= valemul;
				ELSIF SEL_out = "11" THEN
					TEMP <= TEMP;
					PSI <= valemul;
					ALT <= ALT;
				END IF;
			END IF;
		END IF;
	END PROCESS;

	instrument : work.instrumentCtrl PORT MAP (CLK => CLK,
	BTN0 => BTN0,
	BZ => BZ,
	BH => BH,
	SEG => SEG,
	DISP_EN => DISP_EN,
	temp8_in => TEMP,
	alt8_in => ALT,
	psi8_in => PSI,
	BUZZ => BUZZ);
END Behavioral;