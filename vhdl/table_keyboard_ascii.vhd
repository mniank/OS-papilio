----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:18:07 04/13/2014 
-- Design Name: 
-- Module Name:    table_keyboard_ascii - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity table_keyboard_ascii is
    Port ( keydata : in  STD_LOGIC_VECTOR (7 downto 0);
           code    : out STD_LOGIC_VECTOR (6 downto 0);
           defined : out STD_LOGIC);
end table_keyboard_ascii;

architecture Behavioral of table_keyboard_ascii is

-- Permet d'ecrire les choses en hexadecimal.
signal KEY_code : STD_LOGIC_VECTOR (7 downto 0) := (others => '0'); 

begin

code <= KEY_code(6 downto 0);

process(keydata)
begin
	defined <= '1';
	case keydata is
		--------------------------------------------------------------------
		--------------------------------------------------------------------
		--               Association KEYBOARD => ASCII                    --
		--------------------------------------------------------------------
		--------------------------------------------------------------------
		when X"70" => KEY_code <= X"30"; --  '0'
		when X"69" => KEY_code <= X"31"; --  '1'
		when X"72" => KEY_code <= X"32"; --  '2'
		when X"7A" => KEY_code <= X"33"; --  '3'
		when X"6B" => KEY_code <= X"34"; --  '4'
		when X"73" => KEY_code <= X"35"; --  '5'
		when X"74" => KEY_code <= X"36"; --  '6'
		when X"6C" => KEY_code <= X"37"; --  '7'
		when X"75" => KEY_code <= X"38"; --  '8'
		when X"7D" => KEY_code <= X"39"; --  '9'
		when X"7B" => KEY_code <= X"2D"; --  '-'
		when X"79" => KEY_code <= X"2B"; --  '+'
		when X"55" => KEY_code <= X"3D"; --  '='
		when X"3E" => KEY_code <= X"5C"; --  '\'
		when X"49" => KEY_code <= X"3A"; --  ':'
		when X"C9" => KEY_code <= X"2F"; --  '/'
		when X"52" => KEY_code <= X"25"; --  '%'
		when X"0D" => KEY_code <= X"09"; --  'tab (+)'
		when X"7C" => KEY_code <= X"2A"; --  '*'
		when X"15" => KEY_code <= X"41"; --  'A'
		when X"32" => KEY_code <= X"42"; --  'B'
		when X"21" => KEY_code <= X"43"; --  'C'
		when X"23" => KEY_code <= X"44"; --  'D'
		when X"24" => KEY_code <= X"45"; --  'E'
		when X"2B" => KEY_code <= X"46"; --  'F'
		when X"34" => KEY_code <= X"47"; --  'G'
		when X"33" => KEY_code <= X"48"; --  'H'
		when X"43" => KEY_code <= X"49"; --  'I'
		when X"3B" => KEY_code <= X"4A"; --  'J'
		when X"42" => KEY_code <= X"4B"; --  'K'
		when X"4B" => KEY_code <= X"4C"; --  'L'
		when X"4C" => KEY_code <= X"4D"; --  'M'
		when X"31" => KEY_code <= X"4E"; --  'N'
		when X"44" => KEY_code <= X"4F"; --  'O'
		when X"4D" => KEY_code <= X"50"; --  'P'
		when X"1C" => KEY_code <= X"51"; --  'Q'
		when X"2D" => KEY_code <= X"52"; --  'R'
		when X"1B" => KEY_code <= X"53"; --  'S'
		when X"2C" => KEY_code <= X"54"; --  'T'
		when X"3C" => KEY_code <= X"55"; --  'U'
		when X"2A" => KEY_code <= X"56"; --  'V'
		when X"1A" => KEY_code <= X"57"; --  'W'
		when X"22" => KEY_code <= X"58"; --  'X'
		when X"35" => KEY_code <= X"59"; --  'Y'
		when X"1D" => KEY_code <= X"5A"; --  'Z'
		when X"95" => KEY_code <= X"61"; --  'a'
		when X"B2" => KEY_code <= X"62"; --  'b'
		when X"A1" => KEY_code <= X"63"; --  'c'
		when X"A3" => KEY_code <= X"64"; --  'd'
		when X"A4" => KEY_code <= X"65"; --  'e'
		when X"AB" => KEY_code <= X"66"; --  'f'
		when X"B4" => KEY_code <= X"67"; --  'g'
		when X"B3" => KEY_code <= X"68"; --  'h'
		when X"C3" => KEY_code <= X"69"; --  'i'
		when X"BB" => KEY_code <= X"6A"; --  'j'
		when X"C2" => KEY_code <= X"6B"; --  'k'
		when X"CB" => KEY_code <= X"6C"; --  'l'
		when X"CC" => KEY_code <= X"6D"; --  'm'
		when X"B1" => KEY_code <= X"6E"; --  'n'
		when X"C4" => KEY_code <= X"6F"; --  'o'
		when X"CD" => KEY_code <= X"70"; --  'p'
		when X"9C" => KEY_code <= X"71"; --  'q'
		when X"AD" => KEY_code <= X"72"; --  'r'
		when X"9B" => KEY_code <= X"73"; --  's'
		when X"AC" => KEY_code <= X"74"; --  't'
		when X"BC" => KEY_code <= X"75"; --  'u'
		when X"AA" => KEY_code <= X"76"; --  'v'
		when X"9A" => KEY_code <= X"77"; --  'w'
		when X"A2" => KEY_code <= X"78"; --  'x'
		when X"B5" => KEY_code <= X"79"; --  'y'
		when X"9D" => KEY_code <= X"7A"; --  'z'
		when X"4E" => KEY_code <= X"28"; --  ')'
		when X"2E" => KEY_code <= X"29"; --  '('
		when X"71" => KEY_code <= X"2E"; --  '.'
		when X"4A" => KEY_code <= X"21"; --  '!'
		when X"BA" => KEY_code <= X"3F"; --  '?'
		when X"3A" => KEY_code <= X"2C"; --  ','
		when X"25" => KEY_code <= X"27"; --  '''
		when others => defined <= '0';
	end case;

end process;
end Behavioral;

