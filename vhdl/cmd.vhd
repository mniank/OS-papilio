----------------------------------------------------------------------------------
-- Engineer:       Maxime Niankouri
-- Create Date:    18:20:52 04/12/2014 
-- Module Name:    cmd 
--
-- S'occupe de la lecture des commandes dans la console,
-- ainsi que la fin d'une commande via la touche ECHAP.
--
-- S'occupe ensuite de la redistribution des signaux afin
-- de mettre en oeuvre les commandes désirées.
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity cmd is
    Port ( clk              : in    STD_LOGIC;
			  reset            : in    STD_LOGIC;			  
			  enter            : in    STD_LOGIC;
			  echap            : in    STD_LOGIC;
			  CMD_line         : in    STD_LOGIC_VECTOR (4 downto 0);
           currentkey       : in    STD_LOGIC_VECTOR (6 downto 0);
           VGA_hposition    : in    STD_LOGIC_VECTOR (9 downto 0);
           VGA_vposition    : in    STD_LOGIC_VECTOR (9 downto 0);
           VGA_mode         : out   STD_LOGIC_VECTOR (2 downto 0);
           GAME_mode        : out   STD_LOGIC_VECTOR (0 downto 0);
           LED_on           : out   STD_LOGIC;
           AUDIO_start      : out   STD_LOGIC;
           AUDIO_startaddr  : out   STD_LOGIC_VECTOR (11 downto 0);
           AUDIO_boucle     : out   STD_LOGIC;
           AUDIO_unique     : out   STD_LOGIC;
           AUDIO_synthe_on  : out   STD_LOGIC;
           CONSOLE_write_on : inout STD_LOGIC);
end cmd;

architecture Behavioral of cmd is

signal check_on         : STD_LOGIC := '0';
signal cmd_content      : STD_LOGIC_VECTOR (319 downto 0) := (others => '0'); -- Contient l'intérieur de la ligne CMD_line
signal column           : STD_LOGIC_VECTOR   (5 downto 0) := (others => '0'); -- Va retenir la position sur la ligne
signal cmd_content_full : STD_LOGIC := '0';


begin
process(clk)
begin
if rising_edge(clk) then
-----------------------
--       RESET       --
-----------------------
if reset = '1' then
	cmd_content      <= (others => '0');
	column           <= (others => '0');
	VGA_mode         <= "000";
	GAME_mode        <= (others => '0');
	LED_on           <= '0';
	AUDIO_start      <= '0';
	AUDIO_synthe_on  <= '0';
	CONSOLE_write_on <= '0';
	check_on         <= '0';
	cmd_content_full <= '0';
else

------------------------------------------------------------------------------------------------------------------------
---------------------------------------------                              ---------------------------------------------
------------------------------------------              PROCESS               ------------------------------------------
---------------------------------------------                              ---------------------------------------------
------------------------------------------------------------------------------------------------------------------------

	-- La touche echap annule tout
	if echap = '1' then
		VGA_mode         <=  "010";
		GAME_mode        <= (others => '0');
		LED_on           <= '0';
		check_on         <= '0';
		AUDIO_start      <= '0';
		AUDIO_synthe_on  <= '0';
		CONSOLE_write_on <= '1';
	end if;

	-- On démarre la vérification de commande à l'appui de la touche entrée
	if enter = '1' and CONSOLE_write_on = '1' then
		check_on <= '1';
	end if;

	-- On fait un check de la ligne supérieure en s'alignant sur VGA
	if check_on = '1' then
		if cmd_content_full = '0' and VGA_vposition = CMD_line & "1000" and VGA_hposition = column & "1000" then
			cmd_content <= cmd_content(311 downto 0) & "0" & currentkey;
			if column = 39 then -- Quand on a lu la ligne en entier, cmd_content est complet
				column <= (others => '0');
				cmd_content_full <= '1';
			else
				column <= column +1;
			end if;
		-- Une fois qu'on a fini de récupérer le contenu de la ligne, on le compare
		-- et on effectue les opérations requises
		elsif cmd_content_full = '1' then
			case cmd_content is
				-- Cas du string vide	
				--when X"00000000000000000000000000000000000000000000000000000000000000000000000000000000" =>	
				

				------------------------------------------------------------------------------------------------
				--------------------------------------- COMMANDES AUDIOS ---------------------------------------
				------------------------------------------------------------------------------------------------
				----------------
				--  RUN MUSIC --
				----------------
				when X"0052554E004D55534943000000000000000000000000000000000000000000000000000000000000" =>
					AUDIO_start     <= '1';
					AUDIO_startaddr <= "000000000000";
					AUDIO_boucle    <= '0';
					AUDIO_unique    <= '0';
				------------------
				--  RUN MUSIC * --
				------------------
				when X"0052554E004D55534943002A00000000000000000000000000000000000000000000000000000000" =>
					AUDIO_start     <= '1';
					AUDIO_startaddr <= "000000000000";
					AUDIO_boucle    <= '1';
					AUDIO_unique    <= '0';
				------------------------
				--  RUN MUSIC CHOCOBO --
				------------------------
				when X"0052554E004D555349430043484F434F424F00000000000000000000000000000000000000000000" =>
					AUDIO_start     <= '1';
					AUDIO_startaddr <= "000000000000";
					AUDIO_boucle    <= '0';
					AUDIO_unique    <= '1';
				--------------------------
				--  RUN MUSIC CHOCOBO * --
				--------------------------
				when X"0052554E004D555349430043484F434F424F002A0000000000000000000000000000000000000000" =>
					AUDIO_start     <= '1';
					AUDIO_startaddr <= "000000000000";
					AUDIO_boucle    <= '1';
					AUDIO_unique    <= '1';
				-----------------------
				--  RUN MUSIC MORTAL --
				-----------------------
				when X"0052554E004D55534943004D4F5254414C0000000000000000000000000000000000000000000000" =>
					AUDIO_start     <= '1';
					AUDIO_startaddr <= "000110000011";
					AUDIO_boucle    <= '0';
					AUDIO_unique    <= '1';
				-------------------------
				--  RUN MUSIC MORTAL * --
				-------------------------
				when X"0052554E004D55534943004D4F5254414C002A000000000000000000000000000000000000000000" =>
					AUDIO_start     <= '1';
					AUDIO_startaddr <= "000110000011";
					AUDIO_boucle    <= '1';
					AUDIO_unique    <= '1';
				-----------------------
				--  RUN MUSIC TETRIS --
				-----------------------
				when X"0052554E004D55534943005445545249530000000000000000000000000000000000000000000000" =>
					AUDIO_start     <= '1';
					AUDIO_startaddr <= "001111000110";
					AUDIO_boucle    <= '0';
					AUDIO_unique    <= '1';
				-------------------------
				--  RUN MUSIC TETRIS * --
				-------------------------
				when X"0052554E004D5553494300544554524953002A000000000000000000000000000000000000000000" =>
					AUDIO_start     <= '1';
					AUDIO_startaddr <= "001111000110";
					AUDIO_boucle    <= '1';
					AUDIO_unique    <= '1';
				----------------------
				--  RUN MUSIC MARIO --
				----------------------
				when X"0052554E004D55534943004D4152494F000000000000000000000000000000000000000000000000" =>
					AUDIO_start     <= '1';
					AUDIO_startaddr <= "011011011010";
					AUDIO_boucle    <= '0';
					AUDIO_unique    <= '1';
				------------------------
				--  RUN MUSIC MARIO * --
				------------------------
				when X"0052554E004D55534943004D4152494F002A00000000000000000000000000000000000000000000" =>
					AUDIO_start     <= '1';
					AUDIO_startaddr <= "011011011010";
					AUDIO_boucle    <= '1';
					AUDIO_unique    <= '1';
				-----------------------------
				--  RUN MUSIC MARSEILLAISE --
				-----------------------------
				when X"0052554E004D55534943004D41525345494C4C414953450000000000000000000000000000000000" =>
					AUDIO_start     <= '1';
					AUDIO_startaddr <= "101010101111";
					AUDIO_boucle    <= '0';
					AUDIO_unique    <= '1';
				-------------------------------
				--  RUN MUSIC MARSEILLAISE * --
				-------------------------------
				when X"0052554E004D55534943004D41525345494C4C41495345002A000000000000000000000000000000" =>
					AUDIO_start     <= '1';
					AUDIO_startaddr <= "101010101111";
					AUDIO_boucle    <= '1';
					AUDIO_unique    <= '1';
					
					
				------------------------------------------------------------------------------------------------
				--------------------------------------- COMMANDES MODES ----------------------------------------
				------------------------------------------------------------------------------------------------
				-----------------
				--  RUN SYNTHE --
				-----------------
				when X"0052554E0053594E5448450000000000000000000000000000000000000000000000000000000000" =>
					AUDIO_synthe_on  <= '1';
					AUDIO_start      <= '1';
					CONSOLE_write_on <= '0';
					
				-----------------
				-- RUN POPCORN --
				-----------------
				when X"0052554E00504F50434F524E00000000000000000000000000000000000000000000000000000000" =>
					CONSOLE_write_on <= '0';
					GAME_mode(0)     <= '1';
					VGA_mode         <= "001";
					
					
				------------
				-- OTHERS --
				------------	
				when others => check_on <= '0';							
			end case;
			check_on <= '0';
			cmd_content_full <= '0';			
		end if;
		
	end if;

end if;
end if;
end process;
end Behavioral;