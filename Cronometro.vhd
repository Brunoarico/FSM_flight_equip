----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Gustavo Pereira
-- 
-- Create Date: 09/20/2023 10:03:06 AM
-- Design Name: 
-- Module Name: Cronometro - Behavioral
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

entity Cronometro is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           BP : in STD_LOGIC;
           BZ : in STD_LOGIC;
           secs : out integer);
end Cronometro;

architecture Behavioral of Cronometro is
type state_cronometro is (pause, continue);
signal state: state_cronometro := continue;
signal s_secs : integer := 0;
begin
    secs <= s_secs;
    process (reset, BP, state)
    begin
        if reset = '1' then
            state <= continue;
        elsif rising_edge(BP) then
            if state = continue then        
                state <= pause;
            else
                state <= continue;            
            end if;
        end if;
    end process;
    
    process (clk, reset, BZ)
    variable count : integer := 0;
    begin
        if reset = '1' or BZ = '1' then
            count := 0;
            s_secs <= 0;
        elsif rising_edge(clk) then
            if state = continue then
                count := count + 1;
                if count = 50 then
                    count := 0;
                    if s_secs = 3599 then
                        s_secs <= 0;
                    else
                        s_secs <= s_secs + 1;
                    end if;
                end if;

            end if;
        end if;
    end process;


end Behavioral;
