
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux is
    Port (
        D_0 : in STD_LOGIC_VECTOR(3 downto 0);
		D_1 : in STD_LOGIC_VECTOR(3 downto 0);
		D_2 : in STD_LOGIC_VECTOR(3 downto 0);
		D_3 : in STD_LOGIC_VECTOR(3 downto 0);
		CLK : in STD_LOGIC;
        SEG : out STD_LOGIC_VECTOR(6 downto 0);  -- Saída para os segmentos do display de 7 segmentos
		DISP_EN : out STD_LOGIC_VECTOR(3 downto 0) -- Saída para habilitar o display
    );
end mux;

architecture Behavioral of mux is
	signal sel: STD_LOGIC_VECTOR(1 downto 0) := "00";
	signal en: STD_LOGIC_VECTOR(3 downto 0) := "1111";
	signal counter : integer := 0;
	signal out_seg : STD_LOGIC_VECTOR(3 downto 0);
	constant divider : integer := 50000;
begin	
	process(CLK)
	begin
    	if rising_edge(CLK) then
			counter <= counter + 1;
			if counter = divider then
				case sel is
					when "00" =>
						en <= "1110";
						out_seg <= D_0;
					when "01" =>
						en <= "1101";
						out_seg <= D_1;
					when "10" =>
						en <= "1011";
						out_seg <= D_2;
					when "11" =>
						en <= "0111";
						out_seg <= D_3;
				end case;

				if sel = "11" then
					sel <= "00";
				else
					sel <= sel + 1;
				end if;
				counter <= 0;
			end if;
        end if;
	end process;

	disp_0: work.bcd_converter port map (BIN => out_seg, SEGS => SEG);
	DISP_EN <= en;
end Behavioral;