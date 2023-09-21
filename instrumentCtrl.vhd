LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY muxdisplay IS
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
END muxdisplay;

ARCHITECTURE Behavioral OF muxdisplay IS
	SIGNAL SEL : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL D0A : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL D1A : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL D2A : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL D3A : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL D0T : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL D1T : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL D2T : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL D3T : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL D0P : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL D1P : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL D2P : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL D3P : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL D0C : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL D1C : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL D2C : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL D3C : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL D0 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL D1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL D2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL D3 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL deb_BTN_0 : STD_LOGIC := '0';
	SIGNAL deb_BTN_H : STD_LOGIC := '0';
	SIGNAL deb_BTN_Z : STD_LOGIC := '0';
	SIGNAL T_ALARM : STD_LOGIC := '0';
	SIGNAL A_ALARM : STD_LOGIC := '0';
	SIGNAL P_ALARM : STD_LOGIC := '0';

	SIGNAL temp8_in : STD_LOGIC_VECTOR(7 DOWNTO 0) := "11111110";
	SIGNAL alt8_in : STD_LOGIC_VECTOR(7 DOWNTO 0) := "11100000";
	SIGNAL psi8_in : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000100";
BEGIN
	deb0 : work.DeBounce PORT MAP (Clk => CLK, button_in => BTN0, pulse_out => deb_BTN_0);
	debH : work.DeBounce PORT MAP (Clk => CLK, button_in => BH, pulse_out => deb_BTN_H);
	debZ : work.DeBounce PORT MAP (Clk => CLK, button_in => BZ, pulse_out => deb_BTN_Z);

	--cron : work.cronometer PORT MAP (CLK => CLK, RST => deb_BTN_Z, HOLD => deb_BTN_H, D_0 => D0C, D_1 => D1C, D_2 => D2C, D_3 => D3C);
	cron : work.cronometer PORT MAP (CLK => CLK, RST => BZ, HOLD => BH, D_0 => D0C, D_1 => D1C, D_2 => D2C, D_3 => D3C);
	temp_co : work.conv_Temp PORT MAP (temp8 => temp8_in, D_0 => D0T, D_1 => D1T, D_2 => D2T, D_3 => D3T, ALARM => T_ALARM);
	alt_co : work.conv_Alt PORT MAP (alt8 => alt8_in, D_0 => D0A, D_1 => D1A, D_2 => D2A, D_3 => D3A, ALARM => A_ALARM);
	psi_co : work.conv_Psi PORT MAP (psi8 => psi8_in, D_0 => D0P, D_1 => D1P, D_2 => D2P, D_3 => D3P, ALARM => P_ALARM);

	--stateM : work.FSM PORT MAP (BTN0 => deb_BTN_0, SEL => SEL);
	stateM : work.FSM PORT MAP (BTN0 => BTN0, SEL => SEL);

	selec : work.selector PORT MAP (SEL => SEL, D0A => D0A, D1A => D1A, D2A => D2A, D3A => D3A, D0T => D0T, D1T => D1T, D2T => D2T, D3T => D3T, D0P => D0P, D1P => D1P, D2P => D2P, D3P => D3P, D0C => D0C, D1C => D1C, D2C => D2C, D3C => D3C, D0 => D0, D1 => D1, D2 => D2, D3 => D3);

	mux : work.mux PORT MAP (D_0 => D0, D_1 => D1, D_2 => D2, D_3 => D3, CLK => CLK, SEG => SEG, DISP_EN => DISP_EN);

END Behavioral;