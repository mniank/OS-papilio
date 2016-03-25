----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:31:58 03/14/2014 
-- Design Name: 
-- Module Name:    keytable - Behavioral 
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

entity keytable is
    Port ( doutscr   : in  STD_LOGIC_VECTOR (7 downto 0);
           keynumber : out STD_LOGIC_VECTOR (11 downto 0);
			  ascii     : out STD_LOGIC);
end keytable;

architecture Behavioral of keytable is
constant k : std_logic_vector(5 downto 0) := "110001";
begin
process(doutscr) begin
case doutscr is
	when X"70" => ascii <= '1'; keynumber <= (others => '0'); 
	when X"69" => ascii <= '1'; keynumber <= ("000000" & k);               
	when X"72" => ascii <= '1'; keynumber <= ("00000" & k & "0");          
	when X"7A" => ascii <= '1'; keynumber <= ("00000" & k & "0") + k;      
	when X"6B" => ascii <= '1'; keynumber <= ("0000" & k & "00");      
	when X"73" => ascii <= '1'; keynumber <= ("0000" & k & "00") + k;     
	when X"74" => ascii <= '1'; keynumber <= ("0000" & k & "00") + ("00000" & k & "0");      
	when X"6C" => ascii <= '1'; keynumber <= ("0000" & k & "00") + ("00000" & k & "0") + k;  
	when X"75" => ascii <= '1'; keynumber <= ("000" & k & "000");  
	when X"7D" => ascii <= '1'; keynumber <= ("000" & k & "000") + k;               
	when X"7B" => ascii <= '1'; keynumber <= ("000" & k & "000") + ("00000" & k & "0");          
	when X"79" => ascii <= '1'; keynumber <= ("000" & k & "000") + ("00000" & k & "0") + k;      
	when X"55" => ascii <= '1'; keynumber <= ("000" & k & "000") + ("0000" & k & "00");      
	when X"3E" => ascii <= '1'; keynumber <= ("000" & k & "000") + ("0000" & k & "00") + k;    -- \ 
	when X"49" => ascii <= '1'; keynumber <= ("000" & k & "000") + ("0000" & k & "00") + ("00000" & k & "0");    -- :
	--when X"" => keynumber <= ("000" & k & "000") + ("0000" & k & "00") + ("00000" & k & "0") + k; -- Le slash (E0,4A)    
	--when X"" => keynumber <= ("00" & k & "0000");       -- Divisé (useless)
	--when X"" => keynumber <= ("00" & k & "0000") + k;    -- un + entouré ???           
	when X"7C" => ascii <= '1'; keynumber <= ("00" & k & "0000") + ("00000" & k & "0");   


     
	when X"15" => ascii <= '1'; keynumber <= ("00" & k & "0000") + ("00000" & k & "0") + k;    -- A (début de l'alphabet)     
	when X"32" => ascii <= '1'; keynumber <= ("00" & k & "0000") + ("0000" & k & "00");      
	when X"21" => ascii <= '1'; keynumber <= ("00" & k & "0000") + ("0000" & k & "00") + k;     
	when X"23" => ascii <= '1'; keynumber <= ("00" & k & "0000") + ("0000" & k & "00") + ("00000" & k & "0");      
	when X"24" => ascii <= '1'; keynumber <= ("00" & k & "0000") + ("0000" & k & "00") + ("00000" & k & "0") + k;  
	when X"2B" => ascii <= '1'; keynumber <= ("00" & k & "0000") + ("000" & k & "000");  
	when X"34" => ascii <= '1'; keynumber <= ("00" & k & "0000") + ("000" & k & "000") + k;               
	when X"33" => ascii <= '1'; keynumber <= ("00" & k & "0000") + ("000" & k & "000") + ("00000" & k & "0");          
	when X"43" => ascii <= '1'; keynumber <= ("00" & k & "0000") + ("000" & k & "000") + ("00000" & k & "0") + k;      
	when X"3B" => ascii <= '1'; keynumber <= ("00" & k & "0000") + ("000" & k & "000") + ("0000" & k & "00");      
	when X"42" => ascii <= '1'; keynumber <= ("00" & k & "0000") + ("000" & k & "000") + ("0000" & k & "00") + k;
	when X"4B" => ascii <= '1'; keynumber <= ("00" & k & "0000") + ("000" & k & "000") + ("0000" & k & "00") + ("00000" & k & "0");   
	when X"4C" => ascii <= '1'; keynumber <= ("00" & k & "0000") + ("000" & k & "000") + ("0000" & k & "00") + ("00000" & k & "0") + k;  
	when X"31" => ascii <= '1'; keynumber <= ("0" & k & "00000");     
	when X"44" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("000000" & k);               
	when X"4D" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("00000" & k & "0");          
	when X"1C" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("00000" & k & "0") + k;      
	when X"2D" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("0000" & k & "00");      
	when X"1B" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("0000" & k & "00") + k;     
	when X"2C" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("0000" & k & "00") + ("00000" & k & "0");      
	when X"3C" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("0000" & k & "00") + ("00000" & k & "0") + k;  
	when X"2A" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("000" & k & "000");  
	when X"1A" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("000" & k & "000") + k;               
	when X"22" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("000" & k & "000") + ("00000" & k & "0");          
	when X"35" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("000" & k & "000") + ("00000" & k & "0") + k;      
	when X"1D" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("000" & k & "000") + ("0000" & k & "00");  


     
	when X"95" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("000" & k & "000") + ("0000" & k & "00") + k;   -- Début de l'alphabet minuscule
	when X"B2" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("000" & k & "000") + ("0000" & k & "00") + ("00000" & k & "0");
	when X"A1" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("000" & k & "000") + ("0000" & k & "00") + ("00000" & k & "0") + k;    
	when X"A3" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("00" & k & "0000");   
	when X"A4" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("00" & k & "0000") + k;          
	when X"AB" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("00" & k & "0000") + ("00000" & k & "0");    
	when X"B4" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("00" & k & "0000") + ("00000" & k & "0") + k;      
	when X"B3" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("00" & k & "0000") + ("0000" & k & "00");      
	when X"C3" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("00" & k & "0000") + ("0000" & k & "00") + k;     
	when X"BB" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("00" & k & "0000") + ("0000" & k & "00") + ("00000" & k & "0");      
	when X"C2" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("00" & k & "0000") + ("0000" & k & "00") + ("00000" & k & "0") + k;  
	when X"CB" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("00" & k & "0000") + ("000" & k & "000");  
	when X"CC" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("00" & k & "0000") + ("000" & k & "000") + k;               
	when X"B1" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("00" & k & "0000") + ("000" & k & "000") + ("00000" & k & "0");          
	when X"C4" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("00" & k & "0000") + ("000" & k & "000") + ("00000" & k & "0") + k;      
	when X"CD" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("00" & k & "0000") + ("000" & k & "000") + ("0000" & k & "00");      
	when X"9C" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("00" & k & "0000") + ("000" & k & "000") + ("0000" & k & "00") + k;
	when X"AD" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("00" & k & "0000") + ("000" & k & "000") + ("0000" & k & "00") + ("00000" & k & "0");   
	when X"9B" => ascii <= '1'; keynumber <= ("0" & k & "00000") + ("00" & k & "0000") + ("000" & k & "000") + ("0000" & k & "00") + ("00000" & k & "0") + k; 
	when X"AC" => ascii <= '1'; keynumber <= (k & "000000"); 
	when X"BC" => ascii <= '1'; keynumber <= (k & "000000") + ("000000" & k);               
	when X"AA" => ascii <= '1'; keynumber <= (k & "000000") + ("00000" & k & "0");          
	when X"9A" => ascii <= '1'; keynumber <= (k & "000000") + ("00000" & k & "0") + k;      
	when X"A2" => ascii <= '1'; keynumber <= (k & "000000") + ("0000" & k & "00");      
	when X"B5" => ascii <= '1'; keynumber <= (k & "000000") + ("0000" & k & "00") + k;     
	when X"9D" => ascii <= '1'; keynumber <= (k & "000000") + ("0000" & k & "00") + ("00000" & k & "0");    


 
	when X"4E" => ascii <= '1'; keynumber <= (k & "000000") + ("0000" & k & "00") + ("00000" & k & "0") + k;  -- )
	when X"2E" => ascii <= '1'; keynumber <= (k & "000000") + ("000" & k & "000");  -- (
	when X"71" => ascii <= '1'; keynumber <= (k & "000000") + ("000" & k & "000") + k;     -- .      
	when X"4A" => ascii <= '1'; keynumber <= (k & "000000") + ("000" & k & "000") + ("00000" & k & "0");       -- !   
	when X"BA" => ascii <= '1'; keynumber <= (k & "000000") + ("000" & k & "000") + ("00000" & k & "0") + k;     -- ? 
	when X"3A" => ascii <= '1'; keynumber <= (k & "000000") + ("000" & k & "000") + ("0000" & k & "00");    -- ,  
	--when X"" => keynumber <= (k & "000000") + ("000" & k & "000") + ("0000" & k & "00") + k;    
	--when X"" => keynumber <= (k & "000000") + ("000" & k & "000") + ("0000" & k & "00") + ("00000" & k & "0"); 
	--when X"" => keynumber <= (k & "000000") + ("000" & k & "000") + ("0000" & k & "00") + ("00000" & k & "0") + k;    
	--when X"" => keynumber <= (k & "000000") + ("00" & k & "0000");
	--when X"" => keynumber <= (k & "000000") + ("00" & k & "0000") + k;          
	--when X"" => keynumber <= (k & "000000") + ("00" & k & "0000") + ("00000" & k & "0");   
	--when X"" => keynumber <= (k & "000000") + ("00" & k & "0000") + ("00000" & k & "0") + k;      
	--when X"" => keynumber <= (k & "000000") + ("00" & k & "0000") + ("0000" & k & "00");      
	--when X"" => keynumber <= (k & "000000") + ("00" & k & "0000") + ("0000" & k & "00") + k;     
	--when X"" => keynumber <= (k & "000000") + ("00" & k & "0000") + ("0000" & k & "00") + ("00000" & k & "0");      
	--when X"" => keynumber <= (k & "000000") + ("00" & k & "0000") + ("0000" & k & "00") + ("00000" & k & "0") + k;  
	--when X"" => keynumber <= (k & "000000") + ("00" & k & "0000") + ("000" & k & "000");  
	--when X"" => keynumber <= (k & "000000") + ("00" & k & "0000") + ("000" & k & "000") + k;               
	--when X"" => keynumber <= (k & "000000") + ("00" & k & "0000") + ("000" & k & "000") + ("00000" & k & "0");          
	--when X"" => keynumber <= (k & "000000") + ("00" & k & "0000") + ("000" & k & "000") + ("00000" & k & "0") + k;      
	--when X"" => keynumber <= (k & "000000") + ("00" & k & "0000") + ("000" & k & "000") + ("0000" & k & "00");      
	--when X"" => keynumber <= (k & "000000") + ("00" & k & "0000") + ("000" & k & "000") + ("0000" & k & "00") + k;
	--when X"" => keynumber <= (k & "000000") + ("00" & k & "0000") + ("000" & k & "000") + ("0000" & k & "00") + ("00000" & k & "0");   
	--when X"" => keynumber <= (k & "000000") + ("00" & k & "0000") + ("000" & k & "000") + ("0000" & k & "00") + ("00000" & k & "0") + k;  
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000");     
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("000000" & k);               
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("00000" & k & "0");          
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("00000" & k & "0") + k;      
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("0000" & k & "00");      
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("0000" & k & "00") + k;     
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("0000" & k & "00") + ("00000" & k & "0");      
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("0000" & k & "00") + ("00000" & k & "0") + k;  
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("000" & k & "000");  
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("000" & k & "000") + k;               
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("000" & k & "000") + ("00000" & k & "0");          
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("000" & k & "000") + ("00000" & k & "0") + k;      
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("000" & k & "000") + ("0000" & k & "00");  
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("000" & k & "000") + ("0000" & k & "00") + k;   
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("000" & k & "000") + ("0000" & k & "00") + ("00000" & k & "0");
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("000" & k & "000") + ("0000" & k & "00") + ("00000" & k & "0") + k;    
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("00" & k & "0000");   
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("00" & k & "0000") + k;          
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("00" & k & "0000") + ("00000" & k & "0");    
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("00" & k & "0000") + ("00000" & k & "0") + k;      
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("00" & k & "0000") + ("0000" & k & "00");      
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("00" & k & "0000") + ("0000" & k & "00") + k;     
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("00" & k & "0000") + ("0000" & k & "00") + ("00000" & k & "0");      
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("00" & k & "0000") + ("0000" & k & "00") + ("00000" & k & "0") + k;  
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("00" & k & "0000") + ("000" & k & "000");  
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("00" & k & "0000") + ("000" & k & "000") + k;               
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("00" & k & "0000") + ("000" & k & "000") + ("00000" & k & "0");          
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("00" & k & "0000") + ("000" & k & "000") + ("00000" & k & "0") + k;      
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("00" & k & "0000") + ("000" & k & "000") + ("0000" & k & "00");      
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("00" & k & "0000") + ("000" & k & "000") + ("0000" & k & "00") + k;
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("00" & k & "0000") + ("000" & k & "000") + ("0000" & k & "00") + ("00000" & k & "0");   
	--when X"" => keynumber <= (k & "000000") + ("0" & k & "00000") + ("00" & k & "0000") + ("000" & k & "000") + ("0000" & k & "00") + ("00000" & k & "0") + k; 
	when X"29" => ascii <= '1'; keynumber <= "111111111111" - k;  -- Space
	when X"00" => ascii <= '1'; keynumber <= "111111111111" - k;  -- Space
	
	when X"58" => ascii <= '0'; keynumber <= "000000000001"; -- VERR.MAJ
	when X"5A" => ascii <= '0'; keynumber <= "000000000010"; -- ENTER
	when X"66" => ascii <= '0'; keynumber <= "000000000100"; -- BACKSPACE
	when X"76" => ascii <= '0'; keynumber <= "000000001000"; -- ESCAPE
	when others=> ascii <= '0'; keynumber <= "111111111111";  -- Unknown				  
end case;

end process;
end Behavioral;

