----------------------------------------------------------------------------------
-- Engineer:       Maxime Niankouri
-- Create Date:    14:44:33 03/31/2014 
-- Module Name:    synthe 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity synthe is
    Port ( clk            : in  STD_LOGIC;
			  reset          : in  STD_LOGIC;
			  KEY_ascii_code : in  STD_LOGIC_VECTOR (6 downto 0);
			  KEY_ascii      : in  STD_LOGIC_VECTOR (1 downto 0);
           SYNTHE_note    : out STD_LOGIC_VECTOR (4 downto 0));
end synthe;

architecture Behavioral of synthe is

signal prev_code : STD_LOGIC_VECTOR (6 downto 0);

begin
process(clk) begin
if rising_edge(clk) then
-----------------------
--       RESET       --
-----------------------
if reset = '1' then
	prev_code   <= (others => '0');
	SYNTHE_note <= (others => '0');
else

	if KEY_ascii(0) = '1' then 
		prev_code <= KEY_ascii_code;
		case "0" & KEY_ascii_code is
			when X"41" => SYNTHE_note <= "01001";
			when X"5A" => SYNTHE_note <= "01010";
			when X"45" => SYNTHE_note <= "01011";
			when X"52" => SYNTHE_note <= "01100";
			when X"54" => SYNTHE_note <= "01101";
			when X"59" => SYNTHE_note <= "01110";
			when X"55" => SYNTHE_note <= "01111";
			when X"51" => SYNTHE_note <= "10001";
			when X"53" => SYNTHE_note <= "10010";
			when X"44" => SYNTHE_note <= "10011";
			when X"46" => SYNTHE_note <= "10100";
			when X"47" => SYNTHE_note <= "10101";
			when X"48" => SYNTHE_note <= "10110";
			when X"4A" => SYNTHE_note <= "10111";
			when X"57" => SYNTHE_note <= "11001";
			when X"58" => SYNTHE_note <= "11010";
			when X"43" => SYNTHE_note <= "11011";
			when X"56" => SYNTHE_note <= "11100";
			when X"42" => SYNTHE_note <= "11101";
			when X"4E" => SYNTHE_note <= "11110";
			when X"2C" => SYNTHE_note <= "11111";
			when X"31" => SYNTHE_note <= "00001";
			when X"32" => SYNTHE_note <= "00010";
			when X"33" => SYNTHE_note <= "00011";
			when X"34" => SYNTHE_note <= "00100";
			when X"35" => SYNTHE_note <= "00101";
			when X"36" => SYNTHE_note <= "00110";
			when X"37" => SYNTHE_note <= "00111";
			when others=> SYNTHE_note <= "00000";
		end case;
	-- On fait attention aux appuis simultanés
	elsif KEY_ascii(1) = '1' and prev_code = KEY_ascii_code then
		SYNTHE_note <= (others => '0');
	end if;
end if;
end if;
end process;
end Behavioral;

