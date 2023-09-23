----------------------------------------------------------------------------------

-- Create Date: 21.09.2023 07:49:20
-- Universidade Federal do Pernambuco/PES Embraer
-- Professor: Abel Guilhermino da Silva Filho
-- Alunos: Bruno Aric�, Elpidio Ara�jo, Guilherme Melaninho, Gustavo Pereira, Iraline Nunes
-- FSM Controler
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_arith.all; 


entity fsmControler is
    Port ( clk :         in  STD_LOGIC;
           reset :       in  STD_LOGIC;
           buttons :     in  STD_LOGIC_VECTOR (3 downto 0); -- 1000 relogio, 0100 temperatura, 0010 altitude, 0001 umidade
           tempConv :    in  integer;
           altConv :     in  integer;
           umidConv :    in  integer;
           alarm :       out STD_LOGIC;
           sel :         out STD_LOGIC_VECTOR(1 downto 0)); -- 00 relogio, 01 temperatura, 10 altitude, 11 umidade
end fsmControler;

architecture Behavioral of fsmControler is

--Sinais de entrada
 signal ssel : std_logic_vector(1 downto 0) := (others => '0');
 signal salarm : STD_LOGIC := '0';
 
 --Declara��es de estados
 type state is (iniciar, relogio, termometro, altimetro, psicometro, alarme); --possiveis estados
 signal estado_atual, proximo_estado : state := iniciar;

begin
    
process (clk, reset)

begin
       if reset = '1' then
        estado_atual <= iniciar;
       elsif rising_edge (clk) then
        estado_atual <= proximo_estado;
       end if;
end process;

-- processo de transi��o de estados
process (estado_atual, clk, salarm, buttons)
begin
    case estado_atual is
        when iniciar =>
			proximo_estado <= relogio;
        when relogio =>
           if salarm = '0' then
				case buttons is
                    when "0100" =>
                        proximo_estado <= termometro;
                    when "0010" =>
                        proximo_estado <= altimetro;
                    when "0001" =>
                        proximo_estado <= psicometro;
                    when others =>
                       proximo_estado <= relogio;
                end case;
            else
                proximo_estado <= alarme;
            end if;	 
        when termometro =>
           if salarm = '0' then
                case buttons is
                    when "1000" =>
                        proximo_estado <= relogio;
                    when "0010" =>
                        proximo_estado <= altimetro;
                    when "0001" =>
                        proximo_estado <= psicometro;
                    when others =>
                       proximo_estado <= termometro;
                end case;
            else
                proximo_estado <= alarme;
            end if; 
        when altimetro =>
             if salarm = '0' then
                case buttons is
                    when "1000" =>
                        proximo_estado <= relogio;
                    when "0100" =>
                        proximo_estado <= termometro;
                    when "0001" =>
                        proximo_estado <= psicometro;
                    when others =>
                       proximo_estado <= altimetro;
                end case;
            else
                proximo_estado <= alarme;
            end if;
        when psicometro =>
             if salarm = '0' then
                case buttons is
                    when "1000" =>
                        proximo_estado <= relogio;
                    when "0100" =>
                        proximo_estado <= termometro;
                    when "0010" =>
                        proximo_estado <= altimetro;
                    when others =>
                       proximo_estado <= psicometro;
                end case;
            else
                proximo_estado <= alarme;
            end if;
         when alarme =>
             if salarm = '0' then
                case buttons is
                    when "1000" =>
                        proximo_estado <= relogio;
                    when "0100" =>
                        proximo_estado <= termometro;
                    when "0010" =>
                        proximo_estado <= altimetro;
                    when "0001" =>
                        proximo_estado <= psicometro;
                    when others =>
                       proximo_estado <= relogio;
                end case;
            else
                proximo_estado <= alarme;
            end if;    
        when others =>
            proximo_estado <= iniciar;
    end case;
end process;

--processo de controle das saidas
process (estado_atual, clk, tempConv, umidConv, altConv)
begin
    case estado_atual is
        when iniciar =>
           ssel <= "00";
           salarm <= '0';
        when relogio =>
           ssel <= "00";
           if(tempConv < 0)then
                salarm <= '1';
             elsif(tempConv > 30)then
                salarm <= '1';
             elsif(umidConv < 10)then
                salarm <= '1';
             elsif(umidConv > 20)then
                salarm <= '1';
             elsif(altConv > 100)then
                salarm <= '1';
             else
                salarm <= '0';
             end if;
        when termometro =>
             ssel <= "01";
             if(tempConv < 0)then
                salarm <= '1';
             elsif(tempConv > 30)then
                salarm <= '1';
             elsif(umidConv < 10)then
                salarm <= '1';
             elsif(umidConv > 20)then
                salarm <= '1';
             elsif(altConv > 100)then
                salarm <= '1';
             else
                salarm <= '0';
             end if;
        when altimetro =>
             ssel <= "10";
             if(tempConv < 0)then
                salarm <= '1';
             elsif(tempConv > 30)then
                salarm <= '1';
             elsif(umidConv < 10)then
                salarm <= '1';
             elsif(umidConv > 20)then
                salarm <= '1';
             elsif(altConv > 100)then
                salarm <= '1';
             else
                salarm <= '0';
             end if;
        when psicometro =>
            ssel <= "11";
            if(tempConv < 0)then
                salarm <= '1';
             elsif(tempConv > 30)then
                salarm <= '1';
             elsif(umidConv < 10)then
                salarm <= '1';
             elsif(umidConv > 20)then
                salarm <= '1';
             elsif(altConv > 100)then
                salarm <= '1';
             else
                salarm <= '0';
             end if;
         when alarme =>
             if(tempConv < 0)then
                ssel <= "01";
             elsif(tempConv > 30)then
                ssel <= "01";
             elsif(umidConv < 10)then
                ssel <= "11";
             elsif(umidConv > 20)then
                ssel <= "11";
             elsif(altConv > 100)then
                ssel <= "10";
             else
                salarm <= '0';
             end if; 
        when others =>
            ssel <= "00";
    end case;
end process;

sel <= ssel;
alarm <= salarm;

end Behavioral;


