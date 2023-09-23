----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/20/2023 06:33:08 PM
-- Design Name: 
-- Module Name: conversor_temperatura_tb - Behavioral
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

entity conversor_temperatura_tb is
--  Port ( );
end conversor_temperatura_tb;

architecture Behavioral of conversor_temperatura_tb is
component conversor_temperatura is
    Port ( temperatura : in STD_LOGIC_VECTOR (7 downto 0);
           temperatura_conv: out integer);
end component;

signal s_temperatura: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal s_temperatura_conv: integer := 0;
begin
    UUT: conversor_temperatura port map ( temperatura => s_temperatura,
                                       temperatura_conv => s_temperatura_conv);
                                       
    s_temperatura <=   (others => '0'), 
                    "00000001" after 100ns, 
                    "00000011" after 200ns, 
                    "00010000" after 300ns, 
                    "11110000" after 400ns,
                    "11111111" after 500ns;

end Behavioral;
