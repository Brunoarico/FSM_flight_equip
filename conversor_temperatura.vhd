----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/20/2023 06:25:39 PM
-- Design Name: 
-- Module Name: conversor_temperatura - Behavioral
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity conversor_temperatura is
    Port ( temperatura : in STD_LOGIC_VECTOR (7 DOWNTO 0);
           temperatura_conv : out integer range -40 to 120);
end conversor_temperatura;

architecture Behavioral of conversor_temperatura is

begin
    temperatura_conv <= to_integer(unsigned(temperatura)) * 120/255 - 40;

end Behavioral;
