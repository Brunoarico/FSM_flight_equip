library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity conv_Alt is
    Port (
        alt8 : in STD_LOGIC_VECTOR(7 downto 0);  -- temperatura em binário
		D_0 : out STD_LOGIC_VECTOR(3 downto 0);
		D_1 : out STD_LOGIC_VECTOR(3 downto 0);
		D_2 : out STD_LOGIC_VECTOR(3 downto 0);
		D_3 : out STD_LOGIC_VECTOR(3 downto 0);
		ALARM : out STD_LOGIC
    );
end conv_Alt;

architecture Behavioral of conv_Alt is
	signal alt : INTEGER;
	constant inf_lim : INTEGER := 0; 
    constant max_lim: INTEGER := 120;

begin
	alt <= ((to_integer(unsigned(alt8)) * 120) / 255);

	D_3 <= "1101"; -- Desligado
	D_2 <= STD_LOGIC_VECTOR(to_unsigned((alt/100) mod 10, 4));
	D_1 <= STD_LOGIC_VECTOR(to_unsigned((alt/10) mod 10, 4));
	D_0 <= STD_LOGIC_VECTOR(to_unsigned((alt) mod 10, 4));
	ALARM <= '0' when (alt >= inf_lim) and (alt <= max_lim) else '1';

end Behavioral;