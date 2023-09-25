----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/20/2023 05:41:49 PM
-- Design Name: 
-- Module Name: conversor_altitude - Behavioral
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

entity conversor_altitude is
    Port ( altitude : in STD_LOGIC_VECTOR (7 downto 0);
           altitude_conv: out integer range 0 to 120);
end conversor_altitude;

architecture Behavioral of conversor_altitude is

begin
altitude_conv <= to_integer(unsigned(altitude)) * 120/255;

end Behavioral;
