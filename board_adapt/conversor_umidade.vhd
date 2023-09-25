----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/20/2023 06:01:40 PM
-- Design Name: 
-- Module Name: conversor_umidade - Behavioral
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

entity conversor_umidade is
    Port ( umidade : in STD_LOGIC_VECTOR (7 downto 0);
           umidade_conv: out integer range 0 to 100);
end conversor_umidade;

architecture Behavioral of conversor_umidade is
begin
umidade_conv <= to_integer(unsigned(umidade)) * 100/255;
end Behavioral;
