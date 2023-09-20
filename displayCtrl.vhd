library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity displayCtrl is
    Port (
        CLK : in STD_LOGIC;
		SEL : in STD_LOGIC_VECTOR(1 downto 0);
		BZ : in STD_LOGIC;
		BH : in STD_LOGIC;
		SEG : out STD_LOGIC_VECTOR(6 downto 0);  -- Saída para os segmentos do display de 7 segmentos
		DISP_EN : out STD_LOGIC_VECTOR(3 downto 0) -- Saída para habilitar o display
    );
end displayCtrl;

architecture Behavioral of displayCtrl is 
	signal temp : STD_LOGIC_VECTOR(7 downto 0) := "11111110";
	signal alt : STD_LOGIC_VECTOR(7 downto 0) := "11100000";
	signal psi : STD_LOGIC_VECTOR(7 downto 0) := "00000100";

	signal sel : STD_LOGIC_VECTOR(1 downto 0) := "00";

	signal D0C : STD_LOGIC_VECTOR(3 downto 0);
	signal D1C : STD_LOGIC_VECTOR(3 downto 0);
	signal D2C : STD_LOGIC_VECTOR(3 downto 0);
	signal D3C : STD_LOGIC_VECTOR(3 downto 0);

	signal D0T : STD_LOGIC_VECTOR(3 downto 0);
	signal D1T : STD_LOGIC_VECTOR(3 downto 0);
	signal D2T : STD_LOGIC_VECTOR(3 downto 0);
	signal D3T : STD_LOGIC_VECTOR(3 downto 0);

	signal D0A : STD_LOGIC_VECTOR(3 downto 0);
	signal D1A : STD_LOGIC_VECTOR(3 downto 0);
	signal D2A : STD_LOGIC_VECTOR(3 downto 0);
	signal D3A : STD_LOGIC_VECTOR(3 downto 0);

	signal D0P : STD_LOGIC_VECTOR(3 downto 0);
	signal D1P : STD_LOGIC_VECTOR(3 downto 0);
	signal D2P : STD_LOGIC_VECTOR(3 downto 0);
	signal D3P : STD_LOGIC_VECTOR(3 downto 0);

	signal D0 : STD_LOGIC_VECTOR(3 downto 0);
	signal D1 : STD_LOGIC_VECTOR(3 downto 0);
	signal D2 : STD_LOGIC_VECTOR(3 downto 0);
	signal D3 : STD_LOGIC_VECTOR(3 downto 0);

	signal T_ALARM : STD_LOGIC := '0';
	signal A_ALARM : STD_LOGIC := '0';
	signal P_ALARM : STD_LOGIC := '0';

	signal BTN0_D : STD_LOGIC := '0';
begin
	
	process (CLK, BTN0_D, BTN1)
	begin
		if rising_edge(BTN0) and sel = "00" then
			sel <= "01";
		elsif rising_edge(BTN0) and sel = "01" then
			sel <= "10";
		elsif rising_edge(BTN0) and sel = "10" then
			sel <= "11";
		elsif rising_edge(BTN0) and sel = "11" then
			sel <= "00";
		end if;

		if sel = "00" then
			D0 <= D0C;
			D1 <= D1C;
			D2 <= D2C;
			D3 <= D3C;
		elsif sel = "01" then
			D0 <= D0T;
			D1 <= D1T;
			D2 <= D2T;
			D3 <= D3T;
		elsif sel = "10" then
			D0 <= D0A;
			D1 <= D1A;
			D2 <= D2A;
			D3 <= D3A;
		elsif sel = "11" then
			D0 <= D0P;
			D1 <= D1P;
			D2 <= D2P;
			D3 <= D3P;
		end if;

	end process;

	cron : work.cronometer port map (CLK => CLK, RST => BZ, HOLD => BH, D_0 => D0C, D_1 => D1C, D_2 => D2C, D_3 => D3C);
	temp_co : work.conv_Temp port map (temp8 => temp, D_0 => D0T, D_1 => D1T, D_2 => D2T, D_3 => D3T, ALARM => T_ALARM);
	alt_co : work.conv_Alt port map (alt8 => alt, D_0 => D0A, D_1 => D1A, D_2 => D2A, D_3 => D3A, ALARM => A_ALARM);
	psi_co : work.conv_Psi port map (psi8 => psi, D_0 => D0P, D_1 => D1P, D_2 => D2P, D_3 => D3P, ALARM => P_ALARM);
	mux : work.mux port map (D_0 => D0, D_1 => D1, D_2 => D2, D_3 => D3, CLK => CLK, SEG => SEG, DISP_EN => DISP_EN);
	deb : work.DeBounce port map (Clk => CLK, button_in => BTN0, pulse_out => BTN0_D);

end Behavioral;


