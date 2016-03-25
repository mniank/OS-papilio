----------------------------------------------------------------------------------
-- Engineer:       Maxime Niankouri
-- Create Date:    13:15:24 04/13/2014 
-- Module Name:    keyboard
--
-- G�re tous les �v�nements clavier arrivant
-- On pourra �ventuellement impl�menter les �v�nements sortant
-- d'o� la pr�sence de msgout/dataout
--
-- Le signal KEY_enter ("ab") fonctionne comme suit :
--     - a est � 1 lors du relachage de la touche Entree
--     - b est � un lors du changement d'�tat � l'appui de la touche Entree
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity keyboard is
    Port ( clk            : in  STD_LOGIC;
           reset          : in  STD_LOGIC;
           enable         : in  STD_LOGIC;
           msgin          : in  STD_LOGIC;
           datain         : in  STD_LOGIC_VECTOR (7 downto 0);
           msgout         : out STD_LOGIC;
           dataout        : out STD_LOGIC_VECTOR (7 downto 0);
           KEY_enter      : out STD_LOGIC_VECTOR (1 downto 0);
           KEY_echap      : out STD_LOGIC_VECTOR (1 downto 0);
           KEY_backspace  : out STD_LOGIC_VECTOR (1 downto 0);
           KEY_space      : out STD_LOGIC_VECTOR (1 downto 0);
			  KEY_left       : out STD_LOGIC_VECTOR (1 downto 0);
	        KEY_right      : out STD_LOGIC_VECTOR (1 downto 0);
			  KEY_up         : out STD_LOGIC_VECTOR (1 downto 0);
			  KEY_down       : out STD_LOGIC_VECTOR (1 downto 0);
           KEY_ascii      : out STD_LOGIC_VECTOR (1 downto 0);
           KEY_ascii_code : out STD_LOGIC_VECTOR (6 downto 0));
end keyboard;

architecture Behavioral of keyboard is

-- Le clavier envoie de mani�re r�p�titive le code de la touche sur laquelle on reste appuy�e
-- On va essayer de ne pas prendre en compte ces signaux et de se contenter de l'information sur le changement d'�tat
-- On va donc retenir la derni�re touche appuy�e jusqu'� ce qu'elle soit relach�e
-- Retenir l'info brute suffit
signal key_appuyee : STD_LOGIC_VECTOR (7 downto 0) := X"EE"; -- "EE" : signal d'echo, qui ne se produit pas naturellement
signal f0          : STD_LOGIC := '0';
signal e0          : STD_LOGIC := '0';

-- On dispose d'une table DATAIN <=> ASCII_CODE dans un fichier s�par� pour simplifier la lecture :
COMPONENT table_keyboard_ascii is PORT ( 
	keydata : in  STD_LOGIC_VECTOR (7 downto 0);
   code    : out STD_LOGIC_VECTOR (6 downto 0);
   defined : out STD_LOGIC);
END COMPONENT;
	
signal code    : STD_LOGIC_VECTOR (6 downto 0) := (others => '0');
signal keydata : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal defined : STD_LOGIC := '0';

-- On g�re aussi les majuscules en interne
signal maj : STD_LOGIC := '0';

begin
	Table : table_keyboard_ascii PORT MAP (
		keydata => keydata,
		code    => code,
		defined => defined
	);
	
	keydata <= (maj or datain(7)) & datain(6 downto 0); -- Si le caract�re est une touche, on rajoute maj au passage 
	
	
	
process(clk)
begin
if rising_edge(clk) then
-----------------------
--       RESET       --
-----------------------
if reset = '1' then
	key_appuyee <= x"EE";
	msgout      <= '0';
	f0          <= '0';
	e0          <= '0';
else

------------------------------------------------------------------------------------------------------------------------
---------------------------------------------                              ---------------------------------------------
------------------------------------------              PROCESS               ------------------------------------------
---------------------------------------------                              ---------------------------------------------
------------------------------------------------------------------------------------------------------------------------

	if enable = '1' and msgin = '1' then -- A l'arriv�e d'un nouveau message
		if datain /= X"E0" then
			key_appuyee <= datain; -- On retient ce qui vient
		end if;
		
		if datain /= key_appuyee then -- On traite l'info si elle nous int�resse
			if datain = X"F0" then -- F0 est le byte de touche relach�e
				f0 <= '1';
			elsif datain = X"E0" then -- E0 est le byte de touche "sp�ciale"
				e0 <= '1';
			else
				f0 <= '0';
				e0 <= '0';
				key_appuyee <= X"EE"; -- Pour prendre en compte le prochain appui sur une touche
				case e0 & datain is
					-- ENTREE
					when "0" & X"5A" => KEY_enter <= f0 & not f0;
					-- ECHAP
					when "0" & X"76" => KEY_echap <= f0 & not f0;
					-- BACKSPACE
					when "0" & X"66" => KEY_backspace <= f0 & not f0;
					-- ESPACE
					when "0" & X"29" => KEY_space <= f0 & not f0;
					-- LEFT
					when "1" & X"6B" => KEY_left <= f0 & not f0;
					-- RIGHT
					when "1" & X"74" => KEY_right <= f0 & not f0;
					-- UP
					when "1" & X"75" => KEY_up <= f0 & not f0;
					-- DOWN
					when "1" & X"72" => KEY_down <= f0 & not f0;
					-- VERR MAJ
					when "0" & X"58" => if f0 = '1' then maj <= not maj; end if;
					-- MAJ
					when "0" & X"12" => maj <= not maj; -- Gauche
					when "0" & X"59" => maj <= not maj; -- Droit
					-- others
					when others => if defined = '1'
										then KEY_ascii <= f0 & not f0; KEY_ascii_code <= code;
										end if;					
				end case;
			end if;				
		end if;
			
	else -- A d�faut, on place tout � z�ro
		msgout         <= '0';
		KEY_enter      <= "00";
		KEY_echap      <= "00";
		KEY_backspace  <= "00";
		KEY_space      <= "00";
		KEY_left       <= "00";
		KEY_right      <= "00";
		KEY_up         <= "00";
		KEY_down       <= "00";
		KEY_backspace  <= "00";
		KEY_ascii      <= (others => '0');
	end if;
		
end if;
end if;
end process;
end Behavioral;

