library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity conv_MMSS is
    Port (
        segs_in : in INTEGER range 0 to 5999;  -- segundos (0-5999)
        min_u : out STD_LOGIC_VECTOR(3 downto 0);  -- Saída: Unidade do minuto (0-9)
        min_d : out STD_LOGIC_VECTOR(3 downto 0);   -- Saída: Dezena do minuto (0-9)
        seg_u : out STD_LOGIC_VECTOR(3 downto 0);  -- Saída: Unidade do segundo (0-9)
        seg_d : out STD_LOGIC_VECTOR(3 downto 0)    -- Saída: Dezena do segundo (0-5)
    );
end conv_MMSS;

architecture Behavioral of conv_MMSS is
    signal mins : INTEGER range 0 to 99;
    signal segs : INTEGER range 0 to 59;
begin
    -- Converte os segundos em minutos e segundos
    mins <= segs_in / 60;
    segs <= segs_in mod 60;

    -- Formata a saída no formato MM:SS
    min_u <= STD_LOGIC_VECTOR(to_unsigned(mins mod 10, 4));
    min_d <= STD_LOGIC_VECTOR(to_unsigned(mins / 10, 4));
    seg_u <= STD_LOGIC_VECTOR(to_unsigned(segs mod 10, 4));
    seg_d <= STD_LOGIC_VECTOR(to_unsigned(segs / 10, 4));
end Behavioral;
