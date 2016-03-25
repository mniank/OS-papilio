----------------------------------------------------------------------------------
-- Engineer:       Maxime Niankouri
-- Create Date:    11:06:28 03/15/2014 
-- Module Name:    audio
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity audio is
    Port ( clk         : in   STD_LOGIC;
           reset       : in   STD_LOGIC;
           boucle      : in   STD_LOGIC;
           unique      : in   STD_LOGIC;
           start       : in   STD_LOGIC;
           startaddr   : in   STD_LOGIC_VECTOR (11 downto 0);
           synthe_mode : in   STD_LOGIC;
           synthe_note : in   STD_LOGIC_VECTOR (4 downto 0);
           fin         : out  STD_LOGIC;
           O_AUDIO_L   : out  STD_LOGIC;
           O_AUDIO_R   : out  STD_LOGIC);
end audio;

architecture Behavioral of audio is

COMPONENT dac8
	PORT (
		clk   : in  STD_LOGIC;
		data  : in  STD_LOGIC_VECTOR (7 downto 0);
		pulse : out STD_LOGIC
	);
END COMPONENT;

COMPONENT multiplier
  PORT (
    clk : IN  STD_LOGIC;
    a   : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
    b   : IN  STD_LOGIC_VECTOR(17 DOWNTO 0);
    p   : OUT STD_LOGIC_VECTOR(24 DOWNTO 0)
  );
END COMPONENT;

	-- ROM --
COMPONENT melody
PORT (
	 clka  : IN  STD_LOGIC;
	 addra : IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
	 douta : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
  );
END COMPONENT;

COMPONENT memory_sound -- sinus
PORT (
	 clka  : IN  STD_LOGIC;
	 addra : IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
	 douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;


	signal sincount         : STD_LOGIC_VECTOR(21 downto 0) := (others => '0');
	signal lengthcount      : STD_LOGIC_VECTOR(20 downto 0) := (others => '0');
	signal coef_enveloppe   : STD_LOGIC_VECTOR(17 downto 0) := (others => '0');
	signal sortie_enveloppe : STD_LOGIC_VECTOR(24 downto 0) := (others => '0');
	signal entree_enveloppe : STD_LOGIC_VECTOR(6 downto 0) := (others => '0');
	signal audio_R          : STD_LOGIC;
	signal sortie           : STD_LOGIC_VECTOR(7 downto 0); 
	signal doutsin          : STD_LOGIC_VECTOR(7 downto 0); 
	signal addrsin          : STD_LOGIC_VECTOR(10 downto 0);
	signal addra            : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
	signal douta            : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
	signal note             : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
	signal prev_blanc       : STD_LOGIC := '0';
	signal prev_doutsin     : STD_LOGIC := '0';
	signal starting         : STD_LOGIC := '0';
	
begin

	
Inst_melody : melody PORT MAP (
    clka => clk,
    addra => addra,
    douta => douta
  );	
	
Inst_memory_sound : memory_sound PORT MAP (
    clka => clk,
    addra => addrsin,
    douta => doutsin
  );	
  
Inst_enveloppe : multiplier
  PORT MAP (
    clk => clk,
    a => entree_enveloppe,
    b => coef_enveloppe,
    p => sortie_enveloppe
  );
  
Inst_dac8 : dac8 PORT MAP (
    clk => clk,
    data => sortie,
    pulse => audio_R
  );
  
 O_AUDIO_R <= audio_R;
 O_AUDIO_L <= audio_R;

process(clk)
begin
	if rising_edge(clk) then
	
		starting <= start;
	
		if start = '1' then
			if starting = '0' then
				prev_blanc <= '1';
				note <= "00000";										
				addra <= startaddr;
			else
			----------------------------
			-- Mélodie préenregistrée --
			----------------------------
				lengthcount <= lengthcount +1;
				if lengthcount = 0 then
				
					if synthe_mode = '1' then -- Si on est en mode synthé
					note <= synthe_note;										
					else -- Si on est en mode automatique					
						note <= douta; -- Un coup de retard					
						if douta = "01000" and boucle = '1' and unique = '1' then -- Restart one
							addra <= startaddr;
						elsif douta = "01000" and unique = '1' then -- Stop one
							fin <= '1';
						elsif douta = "10000" and boucle = '1' then -- Restart all
							addra <= (others => '0');
						elsif douta = "10000" then -- Stop all
							fin <= '1';
						else
							addra <= addra + 1;
						end if;
					end if;
					
					if note(2 downto 0) = "000"  then -- Si avant^2 blanc
						  prev_blanc <= '1';
					else prev_blanc <= '0';
					end if;
				end if;
			
				if sincount(21) = '1' then
					sincount <= sincount(20 downto 0) & "0"; -- On multiplie par 2 ce qui dépasse (pas parfait)
				else
					case note is
					when "00000" => sincount <= (others => '0') ; -- Pause
					when "00001" => sincount <= sincount +11; -- Gamme 2
					when "00010" => sincount <= sincount +12;
					when "00011" => sincount <= sincount +14;
					when "00100" => sincount <= sincount +15;
					when "00101" => sincount <= sincount +16;
					when "00110" => sincount <= sincount +19;
					when "00111" => sincount <= sincount +21;
					when "01000" => sincount <= (others => '0') ; -- Fin 
					when "01001" => sincount <= sincount +22; -- Gamme 3
					when "01010" => sincount <= sincount +25;
					when "01011" => sincount <= sincount +28;
					when "01100" => sincount <= sincount +29;
					when "01101" => sincount <= sincount +33;
					when "01110" => sincount <= sincount +37;
					when "01111" => sincount <= sincount +41;
					when "10000" => sincount <= (others => '0') ; -- Restart 
					when "10001" => sincount <= sincount +44; -- Gamme 4
					when "10010" => sincount <= sincount +49;
					when "10011" => sincount <= sincount +55;
					when "10100" => sincount <= sincount +59;
					when "10101" => sincount <= sincount +66;
					when "10110" => sincount <= sincount +74;
					when "10111" => sincount <= sincount +83;
					when "11000" => sincount <= (others => '0') ; 
					when "11001" => sincount <= sincount +88; -- Gamme 5
					when "11010" => sincount <= sincount +99;
					when "11011" => sincount <= sincount +111;
					when "11100" => sincount <= sincount +117;
					when "11101" => sincount <= sincount +132;
					when "11110" => sincount <= sincount +148;
					when "11111" => sincount <= sincount +166;
					when others => sincount <= sincount;
					end case;
				end if;
				addrsin <= sincount(20 downto 10);
				
				-- Gestion de la pente d'attaque et de sortie
					if doutsin(7) = '1' then
						entree_enveloppe <= doutsin(6 downto 0);
					else
						entree_enveloppe <= 128 - doutsin(6 downto 0);
					end if;
					prev_doutsin <= doutsin(7);
					
					if lengthcount(20 downto 19) = "00" and prev_blanc = '1' then -- Montée
						coef_enveloppe <= lengthcount(18 downto 1);
					elsif lengthcount(20 downto 19) = "11" and (( douta(2 downto 0) = "000" and synthe_mode = '0') or (synthe_note(2 downto 0) = "000" and synthe_mode = '1')) then -- Descente
						coef_enveloppe <= "111111111111111111" - lengthcount(18 downto 1);
					else 
						coef_enveloppe <= "111111111111111111";
					end if;
					
					if prev_doutsin = '1' then
						sortie <= "1" & sortie_enveloppe(24 downto 18);
					else
						sortie <= "0" & not sortie_enveloppe(24 downto 18);
					end if;
						
					
			end if;
			
		else -- Si start = 0
			fin <= '0';
			sortie <= "10000000";
		end if;
	end if;
end process;
end Behavioral;

