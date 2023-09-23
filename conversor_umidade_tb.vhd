----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/20/2023 06:05:40 PM
-- Design Name: 
-- Module Name: conversor_umidade_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity conversor_umidade_tb is
--  Port ( );
end conversor_umidade_tb;

architecture Behavioral of conversor_umidade_tb is
component conversor_umidade is
    Port ( umidade : in STD_LOGIC_VECTOR (7 downto 0);
           umidade_conv: out integer);
end component;

signal s_umidade: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal s_umidade_conv: integer := 0;
begin
    UUT: conversor_umidade port map ( umidade => s_umidade,
                                       umidade_conv => s_umidade_conv);
                                       
    s_umidade <=   (others => '0'), 
                    "00000001" after 100ns, 
                    "00000011" after 200ns, 
                    "00010000" after 300ns, 
                    "11110000" after 400ns,
                    "11111111" after 500ns;

end Behavioral;
