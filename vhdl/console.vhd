----------------------------------------------------------------------------------
-- Engineer:       Maxime Niankouri
-- Create Date:    15:24:34 04/12/2014 
-- Module Name:    console
--
-- Ce bloc enregistre les lettres envoyées par le clavier,
-- affichées à l'écran, en tenant compte des saut à la ligne,
-- des retours en arrière, ...
--
-- L'affichage ayant besoin de lire le contenu de la mémoire
-- (ici appelée screen), on aligne la lecture sur la position
-- des pixels à afficher (VGA_hposition, VGA_vposition).
-- L'écriture se faisant distinctement, on reste à la position
-- d'un curseur, sans se préoccuper de la lecture
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity console is
    Port ( clk              : in  STD_LOGIC;
           reset            : in  STD_LOGIC;
           CONSOLE_write_on : in  STD_LOGIC;
           newkey           : in  STD_LOGIC;
           keydata          : in  STD_LOGIC_VECTOR(6 downto 0);
			  enter            : in  STD_LOGIC;
			  backspace        : in  STD_LOGIC;
			  space            : in  STD_LOGIC;
           VGA_hposition    : in  STD_LOGIC_VECTOR(9 downto 0);
           VGA_vposition    : in  STD_LOGIC_VECTOR(9 downto 0);
			  CMD_line         : out STD_LOGIC_VECTOR(4 downto 0);
           bitcolor         : out STD_LOGIC;
           curseur          : out STD_LOGIC_VECTOR(11 downto 0);
           currentkey       : out STD_LOGIC_VECTOR(6 downto 0));
end console;

architecture Behavioral of console is

----------------------------------------
--               SCREEN               --
-- contient les lettres de la console --
----------------------------------------
COMPONENT screen PORT (
	clka  : IN  STD_LOGIC;
	wea   : IN  STD_LOGIC_VECTOR(0 DOWNTO 0);
	addra : IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
	dina  : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
	clkb  : IN  STD_LOGIC;
	addrb : IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
	doutb : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END COMPONENT;

signal write_addr  : STD_LOGIC_VECTOR(10 downto 0) := (others => '0');
signal read_addr   : STD_LOGIC_VECTOR(10 downto 0) := (others => '0');
signal read_data   : STD_LOGIC_VECTOR(6 downto 0); 
signal write_data  : STD_LOGIC_VECTOR(6 downto 0); 	
signal write_on    : STD_LOGIC_VECTOR(0 downto 0) := (others => '0');

signal write_haddr : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
signal write_vaddr : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');

-------------------------------------------
--               BITCOLOR                --
-- sert à envoyer les données d'afficage --
-------------------------------------------	
COMPONENT key PORT (
	clka  : IN  STD_LOGIC;
	addra : IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
	douta : OUT STD_LOGIC_VECTOR(0 DOWNTO 0));
END COMPONENT;
COMPONENT table_ascii_addr PORT (
   KEY_ascii_code : in  STD_LOGIC_VECTOR (6 downto 0);
	KEY_addr       : out STD_LOGIC_VECTOR (11 downto 0));
END COMPONENT;

signal bitcolor_addr : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal bitcolor_data : STD_LOGIC_VECTOR(0 downto 0) := (others => '0');

----------------------------------------
--               AUTRES               --
----------------------------------------

signal backspace2    : STD_LOGIC := '0';
signal KEY_addr      : STD_LOGIC_VECTOR (11 downto 0);
signal curseur_count : STD_LOGIC_VECTOR(23 downto 0) := (others => '0');
signal curseur_clk   : STD_LOGIC := '0';

begin
----------------------------------------
--               SCREEN               --
----------------------------------------
Memory_console : screen PORT MAP (
	 clka  => clk,
	 wea   => write_on,
	 addra => write_addr,
	 dina  => write_data,
	 clkb  => clk,
	 addrb => read_addr,
	 doutb => read_data
);
-------------------------------------------
--               BITCOLOR                --
-------------------------------------------	
Table_bitcolor : key PORT MAP (
    clka  => clk,
    addra => bitcolor_addr,
    douta => bitcolor_data
  );  
Table_key : table_ascii_addr PORT MAP (
    KEY_ascii_code => read_data,
    KEY_addr       => KEY_addr
  );
bitcolor <= bitcolor_data(0);

----------------------------------------
--               AUTRES               --
----------------------------------------
currentkey <= read_data;
curseur <= curseur_clk & write_vaddr & write_haddr;






process(clk)
begin
if rising_edge(clk) then
-----------------------
--       RESET       --
-----------------------
if reset = '1' then
	write_addr    <= (others => '0');
	write_data    <= (others => '0');
	bitcolor_addr <= (others => '0');
	write_on      <= (others => '0');
	write_haddr   <= (others => '0');
	write_vaddr   <= (others => '0');
	curseur_count <= (others => '0');
	backspace2    <= '0';
	curseur_clk   <= '0';
else

------------------------------------------------------------------------------------------------------------------------
---------------------------------------------                              ---------------------------------------------
------------------------------------------              PROCESS               ------------------------------------------
---------------------------------------------                              ---------------------------------------------
------------------------------------------------------------------------------------------------------------------------

	-----------------------
	--      CMD_Line     --
	-----------------------
	if write_vaddr = 0 then
		CMD_line <= "11101";
	else
		CMD_line <= write_vaddr - 1;
	end if;

	-----------------------
	--      CURSEUR      --
	-----------------------
	if CONSOLE_write_on = '1' then
		curseur_count <= curseur_count +1;
		if curseur_count = 0 then
			curseur_clk <= not curseur_clk;
		end if;
	else
		curseur_clk <= '0';
	end if;
	
	--------------------------
	--       ECRITURE       --
	--------------------------
	
	if CONSOLE_write_on = '1' then

		-------------------------
		--  TOUCHES SPECIALES  --
		-------------------------
		
		-- ENTREE
		if enter = '1' then
			write_haddr <= (others => '0');
			if write_addr + 40 - write_haddr < 1200 then -- On retourne au début
				write_addr  <= write_addr  + 40 - write_haddr;
				write_vaddr <= write_vaddr + 1;
			else
				write_addr  <= (others => '0');	
				write_vaddr <= (others => '0');
			end if;
		end if;
		
		-- RETOUR ARRIERE
		if backspace = '1' then
			write_data <= (others => '0');
			write_on <= "1";
			backspace2 <= '1';
		elsif backspace2 = '1' then
			if write_addr /= 0 then			
				write_addr <= write_addr - 1;
				if write_haddr = 0 then
					write_haddr <= "100111";
					write_vaddr <= write_vaddr - 1;
				else
					write_haddr <= write_haddr - 1;
				end if;
			end if;
			backspace2 <= '0';
		end if;
				

		------------------------
		--      LETTRES       --
		------------------------
		if newkey = '1' or space = '1' then
			write_on <= "1";
			if space = '1' -- ESPACE
			then write_data <= "0000000";
			else write_data <= keydata;
			end if;
			if write_addr = 1199 then -- 1200 car 40 caractères par 30 lignes
				write_addr  <= (others => '0');
				write_haddr <= (others => '0');
				write_vaddr <= (others => '0');
			else
				write_addr <= write_addr +1;			
				if write_haddr = 39 then -- Saut à la ligne
					write_haddr <= (others => '0');
					write_vaddr <= write_vaddr + 1;
				else
					write_haddr <= write_haddr +1;
				end if;
			end if;
		elsif backspace = '0' then
			write_on <= "0";
		end if;
	
	end if;
	------------------------
	--      LECTURE       --
	------------------------
	
	-- Lecture des lettres dans screen
	if VGA_hposition > 640 
	then read_addr <= (VGA_vposition(9 downto 4) & "00000") + (VGA_vposition(9 downto 4) & "000");
	else read_addr <= (VGA_vposition(9 downto 4) & "00000") + (VGA_vposition(9 downto 4) & "000") + VGA_hposition(9 downto 4) + (VGA_hposition(3) and VGA_hposition(2));
	end if;
	
	-- Transcription de la lettre pour retirer bitcolor
	if VGA_hposition(3 downto 1) = 7 
	then bitcolor_addr <= KEY_addr + (VGA_vposition(3 downto 1) & "000") - VGA_vposition(3 downto 1) - not(VGA_vposition(0) & VGA_vposition(0) & VGA_vposition(0));
	else bitcolor_addr <= KEY_addr + (VGA_vposition(3 downto 1) & VGA_hposition(3 downto 1)) + VGA_hposition(0) - VGA_vposition(3 downto 1) - not(VGA_vposition(0) & VGA_vposition(0) & VGA_vposition(0));
	end if;

end if;
end if;
end process;
end Behavioral;

