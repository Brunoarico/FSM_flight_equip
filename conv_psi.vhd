library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity conv_Psi is
    Port (
        psi8 : in STD_LOGIC_VECTOR(7 downto 0);  -- temperatura em binário
		D_0 : out STD_LOGIC_VECTOR(3 downto 0);
		D_1 : out STD_LOGIC_VECTOR(3 downto 0);
		D_2 : out STD_LOGIC_VECTOR(3 downto 0);
		D_3 : out STD_LOGIC_VECTOR(3 downto 0);
		ALARM : out STD_LOGIC
    );
end conv_Psi;

architecture Behavioral of conv_Psi is
	signal psi : integer;
	constant inf_lim : INTEGER := 10; 
    constant max_lim: INTEGER := 20;

begin
	psi <= ((to_integer(unsigned(psi8)) * 100) / 255);

	D_3 <= "1101"; -- Desligado
	D_2 <= STD_LOGIC_VECTOR(to_unsigned((psi/100) mod 10, 4));
	D_1 <= STD_LOGIC_VECTOR(to_unsigned((psi/10) mod 10, 4));
	D_0 <= STD_LOGIC_VECTOR(to_unsigned((psi) mod 10, 4));
	ALARM <= '0' when (psi >= inf_lim) and (psi <= max_lim) else '1';

end Behavioral;