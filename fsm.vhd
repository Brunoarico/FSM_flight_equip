LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY FSM IS
	PORT (
		BTN0 : IN STD_LOGIC;
		SEL : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
		-- ALARM : OUT STD_LOGIC(2 DOWNTO 0)
	);
END FSM;

ARCHITECTURE Behavioral OF FSM IS
		SIGNAL S : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
BEGIN

	PROCESS (BTN0)
	BEGIN
		IF rising_edge(BTN0) AND S = "00" THEN
			S <= "01";
		ELSIF rising_edge(BTN0) AND S = "01" THEN
			S <= "10";
		ELSIF rising_edge(BTN0) AND S = "10" THEN
			S <= "11";
		ELSIF rising_edge(BTN0) AND S = "11" THEN
			S <= "00";
		END IF;
	END PROCESS;

	SEL <= S;
END Behavioral;
