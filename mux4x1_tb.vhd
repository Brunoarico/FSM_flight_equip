----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/21/2023 10:28:53 AM
-- Design Name: 
-- Module Name: mux4x1_tb - Behavioral
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

entity mux4x1_tb is
--  Port ( );
end mux4x1_tb;

architecture Behavioral of mux4x1_tb is
component mux4x1 is
  Port (    secs: in integer;
            temp_conv: in integer; 
            umid_conv: in integer;
            altitude_conv: in integer;
            SEL: in STD_LOGIC_VECTOR (1 DOWNTO 0);
            saida_mux: out integer);
end component;

signal s_secs: integer := 0;
signal s_temp_conv: integer := 0;
signal s_umid_conv: integer := 0;
signal s_altitude_conv: integer := 0;
signal s_SEL: STD_LOGIC_VECTOR (1 DOWNTO 0) := "00";
signal s_saida_mux: integer := 0;

begin

    UUT: mux4x1 port map (  secs => s_secs,
                            temp_conv=> s_temp_conv,
                            umid_conv=> s_umid_conv,
                            altitude_conv=> s_altitude_conv,
                            SEL=> s_SEL,
                            saida_mux=> s_saida_mux);

    s_secs <= 12;
    s_temp_conv <= -10;
    s_umid_conv <= 90;
    s_altitude_conv <= 110;
    s_SEL <= "00",
             "01" after 20 ns,
             "10" after 40 ns,
             "11" after 60 ns;
             
    
end Behavioral;
