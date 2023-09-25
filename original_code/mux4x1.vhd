----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/21/2023 10:21:43 AM
-- Design Name: 
-- Module Name: mux4x1 - Behavioral
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

entity mux4x1 is
  Port (    secs: in integer;
            temp_conv: in integer; 
            umid_conv: in integer;
            altitude_conv: in integer;
            SEL: in STD_LOGIC_VECTOR (1 DOWNTO 0);
            saida_mux: out integer);
end mux4x1;

architecture Behavioral of mux4x1 is

begin

with SEL select saida_mux <=
	secs when "00",
	temp_conv when "01",
	altitude_conv when "10",
	umid_conv when "11",
	secs when others;


end Behavioral;
