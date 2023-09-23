----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/20/2023 10:20:32 AM
-- Design Name: 
-- Module Name: Cronometro_tb - Behavioral
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

entity Cronometro_tb is
--  Port ( );
end Cronometro_tb;

architecture Behavioral of Cronometro_tb is

component Cronometro is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           BP : in STD_LOGIC;
           BZ : in STD_LOGIC;
           secs : out integer);
end component;

signal s_clk : STD_LOGIC := '1';
signal s_reset : STD_LOGIC := '0';
signal s_BP : STD_LOGIC := '0';
signal s_BZ : STD_LOGIC := '0';
signal s_secs : integer := 0;

begin
    UUT: Cronometro port map ( clk => s_clk,
           reset => s_reset,
           BP => s_BP,
           BZ => s_BZ,
           secs => s_secs);
           
    s_clk <= not s_clk after 1ns;
    s_BZ <= '0', '1' after 500ns, '0' after 600ns;
    s_BP <= '0', '1' after 1000ns, '0' after 1100ns, '1' after 1500ns, '0' after 1600ns;

end Behavioral;
