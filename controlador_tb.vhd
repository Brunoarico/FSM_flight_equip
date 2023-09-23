----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/23/2023 11:37:09 AM
-- Design Name: 
-- Module Name: controlador_tb - Behavioral
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

entity controlador_tb is
--  Port ( );
end controlador_tb;

architecture Behavioral of controlador_tb is

component controlador is
    Port ( Relogio : in STD_LOGIC;
           Termometro : in STD_LOGIC;
           Altimetro : in STD_LOGIC;
           Psicometro : in STD_LOGIC;
           clk : in STD_LOGIC;
           secs : in integer;
           temp_conv : in integer;
           umid_conv : in integer;
           altitude_conv : in integer;
           saida : out integer;
           alarme : out STD_LOGIC;
           rst : in STD_LOGIC);
end component;

signal s_Relogio: STD_LOGIC := '0';
signal s_Termometro: STD_LOGIC := '0';
signal s_Altimetro: STD_LOGIC := '0';
signal s_Psicometro: STD_LOGIC := '0';
signal s_clk: STD_LOGIC := '0';
signal s_rst: STD_LOGIC := '0';
signal s_alarme: STD_LOGIC := '0';
signal s_secs: integer := 0;
signal s_temp_conv: integer := 0;
signal s_umid_conv: integer := 0;
signal s_altitude_conv: integer := 0;
signal s_saida: integer := 0;

begin
    UUT: controlador port map ( Relogio => s_Relogio,
           Termometro => s_Termometro,
           Altimetro => s_Altimetro,
           Psicometro => s_Psicometro,
           clk => s_clk,
           secs => s_secs,
           temp_conv => s_temp_conv,
           umid_conv => s_umid_conv,
           altitude_conv => s_altitude_conv,
           saida => s_saida,
           alarme => s_alarme,
           rst => s_rst);
           
    s_clk <= not s_clk after 1ns;
    s_secs <= 150 after 20ns;
    s_temp_conv <= 20 after 20ns, -12 after 130ns;
    s_umid_conv <= 15 after 20ns;
    s_altitude_conv <= 40 after 20ns;
    
    s_Termometro <= '1' after 50ns, '0' after 60ns;
    s_Altimetro <= '1' after 70ns, '0' after 80ns;
    s_Psicometro <= '1' after 90ns, '0' after 100ns;
    s_Relogio <= '1' after 110ns, '0' after 120ns;

end Behavioral;
