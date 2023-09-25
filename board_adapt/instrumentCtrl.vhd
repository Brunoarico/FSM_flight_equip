LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY instrumentCtrl IS
	PORT (
		psi8_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- temperatura em binário
		alt8_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- temperatura em binário
		temp8_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- temperatura em binário

		BTN0 : IN STD_LOGIC;
		BZ : IN STD_LOGIC;
		BH : IN STD_LOGIC;
		CLK : IN STD_LOGIC;
		SEL : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		SEG : OUT STD_LOGIC_VECTOR(6 DOWNTO 0); -- Saída para os segmentos do display de 7 segmentos
		DISP_EN : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- Saída para habilitar o display
		BUZZ : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END instrumentCtrl;

ARCHITECTURE Behavioral OF instrumentCtrl IS
	SIGNAL SEL_out : STD_LOGIC_VECTOR(1 DOWNTO 0);

	SIGNAL alt : INTEGER RANGE 0 TO 120;
	SIGNAL temp : INTEGER RANGE -40 TO 80;
	SIGNAL psi : INTEGER RANGE 0 TO 100;
	SIGNAL tim : INTEGER RANGE 0 TO 3599;

	SIGNAL deb_BTN_0 : STD_LOGIC := '0';
	SIGNAL deb_BTN_H : STD_LOGIC := '0';
	SIGNAL deb_BTN_Z : STD_LOGIC := '0';

	SIGNAL T_ALARM : STD_LOGIC;
	SIGNAL A_ALARM : STD_LOGIC;
	SIGNAL P_ALARM : STD_LOGIC;

	SIGNAL D0 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL D1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL D2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL D3 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL notf : STD_LOGIC := '0';
	SIGNAL FLAG_C : STD_LOGIC := '0';
	SIGNAL SEL_AL : STD_LOGIC_VECTOR(1 DOWNTO 0);

BEGIN
	FLAG_C <= '1' WHEN (deb_BTN_H OR deb_BTN_Z) = '1' ELSE
		'0';
	deb0 : work.DeBounce PORT MAP (Clk => CLK, button_in => BTN0, pulse_out => deb_BTN_0);
	debH : work.DeBounce PORT MAP (Clk => CLK, button_in => BH, pulse_out => deb_BTN_H);
	debZ : work.DeBounce PORT MAP (Clk => CLK, button_in => BZ, pulse_out => deb_BTN_Z);

	cron : work.cronometer PORT MAP (CLK => CLK,
	RST => BZ,
	HOLD => BH,
	tim => tim);

	temp_co : work.conv_Temp PORT MAP (temp8 => temp8_in,
	temp => temp,
	ALARM => T_ALARM);

	alt_co : work.conv_Alt PORT MAP (alt8 => alt8_in,
	alt => alt,
	ALARM => A_ALARM);

	psi_co : work.conv_Psi PORT MAP (psi8 => psi8_in,
	psi => psi,
	ALARM => P_ALARM);

	stateM : work.FSM PORT MAP (BTN0 => BTN0,
	SEL => SEL_out,
	NOTF_AL => notf,
	SEL_AL => SEL_AL,
	FLAG_C => FLAG_C);

	selec : work.selector PORT MAP (SEL => SEL_out,
	valt => alt,
	vpsi => psi,
	vtim => tim,
	vtemp => temp,
	D0 => D0,
	D1 => D1,
	D2 => D2,
	D3 => D3);

	mux : work.mux PORT MAP (D_0 => D0,
	D_1 => D1,
	D_2 => D2,
	D_3 => D3,
	CLK => CLK,
	SEG => SEG,
	DISP_EN => DISP_EN);

	al : work.alarm PORT MAP (CLK => CLK,
	alarm_A => A_ALARM,
	alarm_T => T_ALARM,
	alarm_P => P_ALARM,
	notify => notf,
	SEL => SEL_AL);

	BUZZ(0) <= NOT A_ALARM;
	BUZZ(1) <= NOT T_ALARM;
	BUZZ(2) <= NOT P_ALARM;
	BUZZ(3) <= NOT notf;
	SEL <= SEL_out;
END Behavioral;

