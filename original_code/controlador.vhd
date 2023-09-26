----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/22/2023 10:13:58 AM
-- Design Name: 
-- Module Name: controlador - Behavioral
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

entity controlador is
    Port ( Relogio : in STD_LOGIC;
           Termometro : in STD_LOGIC;
           Altimetro : in STD_LOGIC;
           Psicometro : in STD_LOGIC;
           clk : in STD_LOGIC;
           secs : in integer;
           temp_conv : in integer range -40 to 120;
           umid_conv : in integer range 0 to 100;
           altitude_conv : in integer range 0 to 120;
           saida : out integer;
           alarme : out STD_LOGIC;
           rst : in STD_LOGIC);
end controlador;

architecture Behavioral of controlador is

component fsmControler is
    Port ( clk :         in  STD_LOGIC;
           reset :       in  STD_LOGIC;
           buttons :     in  STD_LOGIC_VECTOR (3 downto 0); -- 1000 relogio, 0100 temperatura, 0010 altitude, 0001 umidade
           tempConv :    in  integer;
           altConv :     in  integer;
           umidConv :    in  integer;
           alarm :       out STD_LOGIC;
           sel :         out STD_LOGIC_VECTOR(1 downto 0)); -- 00 relogio, 01 temperatura, 10 altitude, 11 umidade
end component;

component mux4x1 is
  Port (    secs: in integer;
            temp_conv: in integer; 
            umid_conv: in integer;
            altitude_conv: in integer;
            SEL: in STD_LOGIC_VECTOR (1 DOWNTO 0);
            saida_mux: out integer);
end component;

signal s_SEL: STD_LOGIC_VECTOR (1 downto 0);
signal s_buttons: STD_LOGIC_VECTOR (3 downto 0);

begin
    s_buttons <= Relogio & Termometro & Altimetro & Psicometro;
    h1: fsmControler port map (clk => clk,
                               reset => rst,
                               buttons => s_buttons,
                               tempConv => temp_conv,
                               altConv => altitude_conv,
                               umidConv => umid_conv,
                               alarm => alarme,
                               sel => s_SEL);
    
    h2: mux4x1 port map (   secs=> secs,
                            temp_conv=> temp_conv,
                            umid_conv=> umid_conv,
                            altitude_conv=> altitude_conv,
                            SEL=> s_SEL,
                            saida_mux=> saida);

end Behavioral;
