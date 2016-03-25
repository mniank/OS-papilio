----------------------------------------------------------------------------------
-- Engineer:       Maxime Niankouri
-- Create Date:    20:00:15 04/08/2014 
-- Module Name:    ps2tx
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ps2tx is
    Port ( clk     : in    STD_LOGIC;
           reset   : in    STD_LOGIC;
           tx_on   : out   STD_LOGIC;
           msgout  : in    STD_LOGIC;
           dataout : in    STD_LOGIC_VECTOR (7 downto 0);
           ps2clk  : inout STD_LOGIC;
           ps2data : inout STD_LOGIC);
end ps2tx;

architecture Behavioral of ps2tx is

-- Def pour vérifier le signal de clock
constant minlength_clk : natural := 30*25;  --  30us @ 25MHz
constant maxlength_clk : natural := 50*25;  --  50us @ 25MHz
constant data_low      : natural := 100*25; -- 100us @ 25MHz
constant clock_low     : natural := 120*25; -- 120us @ 25MHz

signal etat         : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
signal clockCounter : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal dataReg      : STD_LOGIC_VECTOR(10 downto 0) := (others => '0');
signal sentCount    : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal ps2clk_count : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
signal prev_ps2clkV : STD_LOGIC := '0';
signal ps2clkV      : STD_LOGIC := '0';
signal ttx_on       : STD_LOGIC := '0';

begin

ps2clk <= 'Z';
ps2data <= 'Z';

process(clk)
begin
	if rising_edge(clk) then
-----------------------
--       RESET       --
-----------------------
if reset = '1' then
	etat          <= (others => '0');
	clockCounter  <= (others => '0');
	dataReg       <= (others => '0');
	sentCount <= (others => '0');
	ps2clk_count  <= (others => '0');
	prev_ps2clkV  <= '0';
	ps2clkV       <= '0';
	tx_on         <= '0';
	ttx_on        <= '0';
else
	
		prev_ps2clkV <= ps2clkV;
		tx_on <= ttx_on;
		
		 -- On vérifie la validité de ps2clk
      if ps2clk = '1' then
         if ps2clk_count < 31 then
            ps2clk_count <= ps2clk_count+1;
         else
            ps2clkV <= '1';
            clockCounter <= (others => '0');
         end if;
      else
         if ps2clk_count > 0 then
            ps2clk_count <= ps2clk_count-1;
         else
            ps2clkV <= '0';
            clockCounter <= (others => '0');
         end if;      
      end if;
	
		-- On démarre le process au signal d'envoi et on prepare les data a envoyer
		if msgout = '1' and ttx_on = '0' then
			ttx_on <= '1';
			dataReg <= "1" & not(dataout(0) xor dataout(1) xor dataout(2) xor dataout(3) xor dataout(4) xor dataout(5) xor dataout(6) xor dataout(7)) & dataout & "0";
		end if;
		
		-- Lors du transfert ...
		if ttx_on = '1' then
		
			-- On attend le premier falling edge en laisse le start bit ('0')
			if etat = "00" then
				clockCounter <= clockCounter +1;
				ps2clk <= '0';
				if clockCounter > clock_low then
					etat <= "01";
				end if;
				if clockCounter > data_low then
					  ps2data <= '0';
				else ps2data <= 'Z';
				end if;
			else
				ps2clk <= 'Z';
			end if;
			
			if etat = "01" then
				clockCounter  <= (others => '0');
				sentCount <= (others => '0');      
				ps2data <= dataReg(0);
				if ps2clkV = '0' and prev_ps2clkV = '1' then
					etat <= "10";     
				end if;
			end if;
			
			-- On envoit les 9 bits du paquet restant
			if etat = "10" then
				if clockCounter > maxlength_clk then -- Il y a eu un problème
					if ps2clkV = '0' then
						ttx_on <= '0'; -- On annule la transmission
					end if;
				end if;
				
				if prev_ps2clkV = '0' and ps2clkV = '1' then -- En falling edge
					if clockCounter < minlength_clk then -- Cas d'erreur
						ttx_on <= '0';
					else -- Sinon tout se passe bien et on envoit un bit
						sentCount <= sentCount+1;
						clockCounter <= (others => '0');
						ps2data <= dataReg(1);
						dataReg <= dataReg(0) & dataReg(10 downto 1);
						if sentCount = 9 then -- Si on a envoyé le paquet (9+2 = 11)
							ttx_on <= '0'; -- On release après le bit de parité
						end if;
					end if;
				elsif prev_ps2clkV = '1' and ps2clkV = '0' then -- En rising edge
					if clockCounter < minlength_clk then -- Cas d'erreur
						ttx_on <= '0'; -- On annule
					end if;
					clockCounter  <= (others => '0');
				else				
					clockCounter <= clockCounter + 1;
				end if;
			end if;
		
		else -- Si tx_on = 0, on relibére les inout ps2
			ps2clk <= 'Z';
			ps2data <= 'Z';
			etat <= "00";
		end if;
	
end if;
	end if;
end process;

end Behavioral;

