----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:21:34 04/13/2014 
-- Design Name: 
-- Module Name:    table_ascii_addr - Behavioral 
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

entity table_ascii_addr is
    Port ( KEY_ascii_code : in  STD_LOGIC_VECTOR (6 downto 0);
           KEY_addr       : out STD_LOGIC_VECTOR (11 downto 0));
end table_ascii_addr;

architecture Behavioral of table_ascii_addr is

begin
process(KEY_ascii_code)
begin
	case "0" & KEY_ascii_code is
		--------------------------------------------------------------------
		--------------------------------------------------------------------
		--                 Association  ASCII => ADDR                     --
		--------------------------------------------------------------------
		--------------------------------------------------------------------
		when X"30" => KEY_addr <= "000000000000"; --  '0'
		when X"31" => KEY_addr <= "000000110001"; --  '1'
		when X"32" => KEY_addr <= "000001100010"; --  '2'
		when X"33" => KEY_addr <= "000010010011"; --  '3'
		when X"34" => KEY_addr <= "000011000100"; --  '4'
		when X"35" => KEY_addr <= "000011110101"; --  '5'
		when X"36" => KEY_addr <= "000100100110"; --  '6'
		when X"37" => KEY_addr <= "000101010111"; --  '7'
		when X"38" => KEY_addr <= "000110001000"; --  '8'
		when X"39" => KEY_addr <= "000110111001"; --  '9'
		when X"2D" => KEY_addr <= "000111101010"; --  '-'
		when X"2B" => KEY_addr <= "001000011011"; --  '+'
		when X"3D" => KEY_addr <= "001001001100"; --  '='
		when X"5C" => KEY_addr <= "001001111101"; --  '\'
		when X"3A" => KEY_addr <= "001010101110"; --  ':'
		when X"2F" => KEY_addr <= "001011011111"; --  '/'
		when X"25" => KEY_addr <= "001100010000"; --  '%'
		when X"09" => KEY_addr <= "001101000001"; --  'tab (+)'
		when X"2A" => KEY_addr <= "001101110010"; --  '*'
		when X"41" => KEY_addr <= "001110100011"; --  'A'
		when X"42" => KEY_addr <= "001111010100"; --  'B'
		when X"43" => KEY_addr <= "010000000101"; --  'C'
		when X"44" => KEY_addr <= "010000110110"; --  'D'
		when X"45" => KEY_addr <= "010001100111"; --  'E'
		when X"46" => KEY_addr <= "010010011000"; --  'F'
		when X"47" => KEY_addr <= "010011001001"; --  'G'
		when X"48" => KEY_addr <= "010011111010"; --  'H'
		when X"49" => KEY_addr <= "010100101011"; --  'I'
		when X"4A" => KEY_addr <= "010101011100"; --  'J'
		when X"4B" => KEY_addr <= "010110001101"; --  'K'
		when X"4C" => KEY_addr <= "010110111110"; --  'L'
		when X"4D" => KEY_addr <= "010111101111"; --  'M'
		when X"4E" => KEY_addr <= "011000100000"; --  'N'
		when X"4F" => KEY_addr <= "011001010001"; --  'O'
		when X"50" => KEY_addr <= "011010000010"; --  'P'
		when X"51" => KEY_addr <= "011010110011"; --  'Q'
		when X"52" => KEY_addr <= "011011100100"; --  'R'
		when X"53" => KEY_addr <= "011100010101"; --  'S'
		when X"54" => KEY_addr <= "011101000110"; --  'T'
		when X"55" => KEY_addr <= "011101110111"; --  'U'
		when X"56" => KEY_addr <= "011110101000"; --  'V'
		when X"57" => KEY_addr <= "011111011001"; --  'W'
		when X"58" => KEY_addr <= "100000001010"; --  'X'
		when X"59" => KEY_addr <= "100000111011"; --  'Y'
		when X"5A" => KEY_addr <= "100001101100"; --  'Z'
		when X"61" => KEY_addr <= "100010011101"; --  'a'
		when X"62" => KEY_addr <= "100011001110"; --  'b'
		when X"63" => KEY_addr <= "100011111111"; --  'c'
		when X"64" => KEY_addr <= "100100110000"; --  'd'
		when X"65" => KEY_addr <= "100101100001"; --  'e'
		when X"66" => KEY_addr <= "100110010010"; --  'f'
		when X"67" => KEY_addr <= "100111000011"; --  'g'
		when X"68" => KEY_addr <= "100111110100"; --  'h'
		when X"69" => KEY_addr <= "101000100101"; --  'i'
		when X"6A" => KEY_addr <= "101001010110"; --  'j'
		when X"6B" => KEY_addr <= "101010000111"; --  'k'
		when X"6C" => KEY_addr <= "101010111000"; --  'l'
		when X"6D" => KEY_addr <= "101011101001"; --  'm'
		when X"6E" => KEY_addr <= "101100011010"; --  'n'
		when X"6F" => KEY_addr <= "101101001011"; --  'o'
		when X"70" => KEY_addr <= "101101111100"; --  'p'
		when X"71" => KEY_addr <= "101110101101"; --  'q'
		when X"72" => KEY_addr <= "101111011110"; --  'r'
		when X"73" => KEY_addr <= "110000001111"; --  's'
		when X"74" => KEY_addr <= "110001000000"; --  't'
		when X"75" => KEY_addr <= "110001110001"; --  'u'
		when X"76" => KEY_addr <= "110010100010"; --  'v'
		when X"77" => KEY_addr <= "110011010011"; --  'w'
		when X"78" => KEY_addr <= "110100000100"; --  'x'
		when X"79" => KEY_addr <= "110100110101"; --  'y'
		when X"7A" => KEY_addr <= "110101100110"; --  'z'
		when X"28" => KEY_addr <= "110110010111"; --  ')'
		when X"29" => KEY_addr <= "110111001000"; --  '('
		when X"2E" => KEY_addr <= "110111111001"; --  '.'
		when X"21" => KEY_addr <= "111000101010"; --  '!'
		when X"3F" => KEY_addr <= "111001011011"; --  '?'
		when X"2C" => KEY_addr <= "111010001100"; --  ','
		when X"27" => KEY_addr <= "111010111101"; --  '''
		when others=> KEY_addr <= "111111001111";
	end case;
end process;
end Behavioral;

