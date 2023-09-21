
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY instrumentCtrl IS
	PORT (
		--psi8_in : in STD_LOGIC_VECTOR(7 downto 0);  -- temperatura em binário
		--alt8_in : in STD_LOGIC_VECTOR(7 downto 0);  -- temperatura em binário
		--temp8_in : in STD_LOGIC_VECTOR(7 downto 0); -- temperatura em binário

		BTN0 : IN STD_LOGIC;
		BZ : IN STD_LOGIC;
		BH : IN STD_LOGIC;

		CLK : IN STD_LOGIC;

		SEG : OUT STD_LOGIC_VECTOR(6 DOWNTO 0); -- Saída para os segmentos do display de 7 segmentos
		DISP_EN : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- Saída para habilitar o display
	);
END instrumentCtrl;

ARCHITECTURE Behavioral OF intrumentCtrl IS
	SIGNAL SEL : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL alt : INTEGER;
	SIGNAL temp : INTEGER;
	SIGNAL psi : INTEGER;
	SIGNAL tim : INTEGER;
	SIGNAL deb_BTN_0 : STD_LOGIC := '0';
	SIGNAL deb_BTN_H : STD_LOGIC := '0';
	SIGNAL deb_BTN_Z : STD_LOGIC := '0';
	SIGNAL T_ALARM : STD_LOGIC := '0';
	SIGNAL A_ALARM : STD_LOGIC := '0';
	SIGNAL P_ALARM : STD_LOGIC := '0';
	SIGNAL D0 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL D1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL D2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL D3 : STD_LOGIC_VECTOR(3 DOWNTO 0);

	SIGNAL temp8_in : STD_LOGIC_VECTOR(7 DOWNTO 0) := "11111110";
	SIGNAL alt8_in : STD_LOGIC_VECTOR(7 DOWNTO 0) := "11100000";
	SIGNAL psi8_in : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000100";
BEGIN
	deb0 : work.DeBounce PORT MAP (Clk => CLK, button_in => BTN0, pulse_out => deb_BTN_0);
	debH : work.DeBounce PORT MAP (Clk => CLK, button_in => BH, pulse_out => deb_BTN_H);
	debZ : work.DeBounce PORT MAP (Clk => CLK, button_in => BZ, pulse_out => deb_BTN_Z);

	--cron : work.cronometer PORT MAP (CLK => CLK, RST => deb_BTN_Z, HOLD => deb_BTN_H, D_0 => D0C, D_1 => D1C, D_2 => D2C, D_3 => D3C);
	cron : work.cronometer PORT MAP (CLK => CLK, RST => BZ, HOLD => BH, tim => tim);
	temp_co : work.conv_Temp PORT MAP (temp8 => temp8_in, temp => temp, ALARM => T_ALARM);
	alt_co : work.conv_Alt PORT MAP (alt8 => alt8_in, alt => alt, ALARM => A_ALARM);
	psi_co : work.conv_Psi PORT MAP (psi8 => psi8_in, psi => psi, ALARM => P_ALARM);

	--stateM : work.FSM PORT MAP (BTN0 => deb_BTN_0, SEL => SEL);
	stateM : work.FSM PORT MAP (BTN0 => BTN0, SEL => SEL);

	selec : work.selector PORT MAP (SEL => SEL, valt => alt, vpsi => psi, vtim => tim, vtemp => temp, D0 => D0, D1 => D1, D2 => D2, D3 => D3);

	mux : work.mux PORT MAP (D_0 => D0, D_1 => D1, D_2 => D2, D_3 => D3, CLK => CLK, SEG => SEG, DISP_EN => DISP_EN);

END Behavioral;