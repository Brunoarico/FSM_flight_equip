library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity conv_Temp is
    Port (
        temp8 : in STD_LOGIC_VECTOR(7 downto 0);  -- temperatura em binário
		D_0 : out STD_LOGIC_VECTOR(3 downto 0);
		D_1 : out STD_LOGIC_VECTOR(3 downto 0);
		D_2 : out STD_LOGIC_VECTOR(3 downto 0);
		D_3 : out STD_LOGIC_VECTOR(3 downto 0);
		ALARM : out STD_LOGIC
    );
end conv_Temp;

architecture Behavioral of conv_Temp is
	signal temp : INTEGER;
	constant inf_lim : INTEGER := 0; 
    constant max_lim: INTEGER := 30;

begin
	temp <= ((to_integer(unsigned(temp8)) * 120) / 255) - 40;
	D_0 <= "1100"; -- C
	process (temp)
	begin
		if temp < 0 then
			D_3 <= "1010"; -- -
		else
			D_3 <= "1101"; -- Desligado
		end if;
	end process;

	D_2 <= STD_LOGIC_VECTOR(to_unsigned((temp/10) mod 10, 4));
	D_1 <= STD_LOGIC_VECTOR(to_unsigned((temp) mod 10, 4));
	ALARM <= '0' when (temp >= inf_lim) and (temp <= max_lim) else '1';

end Behavioral;