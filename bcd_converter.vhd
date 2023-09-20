library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bcd_converter is
    Port (
        BIN : in STD_LOGIC_VECTOR(3 downto 0);  -- Entrada BCD de 4 bits
        SEGS : out STD_LOGIC_VECTOR(6 downto 0)  -- Saída para os segmentos do display de 7 segmentos
    );
end bcd_converter;

architecture Behavioral of bcd_converter is
begin
    SEGS <= "1000000" when BIN = "0000" else -- 0
           "1111001" when BIN = "0001" else -- 1
           "0100100" when BIN = "0010" else -- 2 
           "0110000" when BIN = "0011" else -- 3
           "0011001" when BIN = "0100" else -- 4
           "0010010" when BIN = "0101" else -- 5
           "0000010" when BIN = "0110" else -- 6
           "1111000" when BIN = "0111" else -- 7
           "0000000" when BIN = "1000" else -- 8
           "0011000" when BIN = "1001" else -- 9
		   "0111111" when BIN = "1010" else -- -
		   "0111000" when BIN = "1011" else -- L
		   "1000110" when BIN = "1100" else -- C
		   "1111111" when BIN = "1101" else -- Desligado
		   "0001000" when BIN = "1110" else -- A
		   "0001100" when BIN = "1111" else -- F
           "0000000";
end Behavioral;