----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/25/2023 07:05:40 AM
-- Design Name: 
-- Module Name: top_level - Behavioral
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

entity top_level is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           BP : in STD_LOGIC;
           BZ : in STD_LOGIC;
           Relogio : in STD_LOGIC;
           Termometro : in STD_LOGIC;
           Altimetro : in STD_LOGIC;
           Psicometro : in STD_LOGIC;
           Alarme : out STD_LOGIC;
           altitude : in STD_LOGIC_VECTOR (7 downto 0);
           umid : in STD_LOGIC_VECTOR (7 downto 0);
           temp : in STD_LOGIC_VECTOR (7 downto 0);
           saida : out integer);
end top_level;

architecture Behavioral of top_level is
component controlador is
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
end component;

component conversor_altitude is
    Port ( altitude : in STD_LOGIC_VECTOR (7 downto 0);
           altitude_conv: out integer range 0 to 120);
end component;

component conversor_temperatura is
    Port ( temperatura : in STD_LOGIC_VECTOR (7 DOWNTO 0);
           temperatura_conv : out integer range -40 to 120);
end component;

component conversor_umidade is
    Port ( umidade : in STD_LOGIC_VECTOR (7 downto 0);
           umidade_conv: out integer range 0 to 100);
end component;

component Cronometro is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           BP : in STD_LOGIC;
           BZ : in STD_LOGIC;
           secs : out integer);
end component;

signal s_secs: integer := 0;
signal s_altitude_conv: integer := 0;
signal s_temperatura_conv: integer := 0;
signal s_umidade_conv: integer := 0;

begin
    h1: Cronometro port map(   clk => clk,
                               reset => rst,
                               BP => BP,
                               BZ => BZ,
                               secs => s_secs);
                               
    h2: conversor_altitude port map (   altitude => altitude,
                                        altitude_conv => s_altitude_conv);
                                        
    h3: conversor_temperatura port map (    temperatura => temp,
                                            temperatura_conv => s_temperatura_conv);
    
    h4: conversor_umidade port map (    umidade => umid,
                                        umidade_conv => s_umidade_conv);  
                                        
    h5: controlador port map(  Relogio => Relogio,
                               Termometro => Termometro,
                               Altimetro => Altimetro,
                               Psicometro => Psicometro,
                               clk => clk,
                               secs => s_secs,
                               temp_conv => s_temperatura_conv,
                               umid_conv => s_umidade_conv,
                               altitude_conv => s_altitude_conv,
                               saida => saida,
                               alarme => alarme,
                               rst => rst);

end Behavioral;
