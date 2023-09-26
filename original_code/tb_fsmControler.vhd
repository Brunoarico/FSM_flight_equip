----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.09.2023 10:27:51
-- Design Name: 
-- Module Name: tb_fsmControler - Behavioral
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

entity tb_fsmControler is
--  Port ( );
end tb_fsmControler;

architecture Behavioral of tb_fsmControler is

component fsmControler is
    Port ( clk :         in  STD_LOGIC;
           reset :       in  STD_LOGIC;
           buttons :     in  STD_LOGIC_VECTOR (3 downto 0); -- 1000 relogio, 0100 temperatura, 0010 altitude, 0001 umidade
           tempConv :    in  integer;
           altConv :     in  integer;
           umidConv :    in  integer;
           alarm :       out STD_LOGIC;
           sel :         out STD_LOGIC_VECTOR(1 downto 0));
end component;

--Sinais de entrada
signal sclk : std_logic := '0';
signal sreset : std_logic := '0';
signal sbuttons : std_logic_vector(3 downto 0) := (others => '0');
signal stempConv : integer := 0;
signal saltConv : integer := 0;
signal sumidConv : integer := 0;
signal ssel : std_logic_vector(1 downto 0) := (others => '0');
signal salarm : std_logic := '0';

begin

uut: fsmControler port map(
    clk => sclk,
    reset => sreset,
    buttons => sbuttons,
    tempConv => stempConv,
    altConv => saltConv,
    umidConv => sumidConv,
    alarm => salarm,
    sel => ssel);

sclk <= not sclk after 5 ns;
sreset <= '0', '1' after 35 ns, '0' after 45 ns;
sbuttons <= "0000", "0001" after 15 ns, "0010" after 35 ns , "0100" after 45 ns, "1000" after 85 ns;
stempConv <= -5, 29 after 55 ns, 32 after 65 ns, 25 after 700ns;
saltConv <= 95, 70 after 45 ns, 80 after 65 ns, 130 after 65 ns, 70 after 750 ns;
sumidConv <= 10, 13 after 45 ns, 16 after 65 ns, 25 after 65 ns, 15 after 800 ns;

end Behavioral;
