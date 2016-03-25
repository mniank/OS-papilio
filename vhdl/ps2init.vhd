----------------------------------------------------------------------------------
-- Engineer:       Maxime Niankouri
-- Create Date:    20:02:16 04/08/2014 
-- Module Name:    ps2init
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ps2init is
    Port ( clk     : in   STD_LOGIC;
           reset   : in   STD_LOGIC;
           msgin   : in   STD_LOGIC;
           datain  : in   STD_LOGIC_VECTOR (7 downto 0);
           msgout  : out  STD_LOGIC;
           dataout : out  STD_LOGIC_VECTOR (7 downto 0);
           device  : out  STD_LOGIC_VECTOR (1 downto 0));
end ps2init;

architecture Behavioral of ps2init is

signal init_done   : STD_LOGIC := '0';
signal etat        : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal ack         : STD_LOGIC := '0'; -- FA
signal ans         : STD_LOGIC := '0'; -- Réponse du device
signal ask         : STD_LOGIC := '0'; -- Attente de réponse du device
signal reask       : STD_LOGIC_VECTOR (24 downto 0) := (others => '1'); -- Trop longue attente (environ 1.3s), on relance la commande
signal devic3      : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');

begin

process(clk)
begin
if rising_edge(clk) then

-----------------------
--       RESET       --
-----------------------
if reset = '1' then
	etat      <= (others => '0');
	reask     <= (others => '1');
	devic3    <= (others => '0');
	device    <= (others => '0');
	init_done <= '0';
	ack <= '0';
	ans <= '0';
	ask <= '0';
else

	if init_done = '0' then -- Si le device est pas encore initialisé
			
		---------------------------------------------
		--    Cas de non réponse à une question    --
		---------------------------------------------
			if ack = '0' or (ask = '1' and ans = '0') then
				reask <= reask -1;
				if reask = 0 then -- Suffisamment long pour laisser passer le AA du self-test
					ask <= '0';
					ack <= '1';
					etat <= etat - 1;
				end if;
			else
				reask <= (others => '1');
			end if;
	
		
		---------------------------------------------
		-- Les réponses de compréhension du device --
		---------------------------------------------
		if msgin = '1' and datain = X"FE" then -- Si le device demande la répétition
			etat <= etat - 1;
			ack <= '1';
		elsif msgin = '1' and datain = X"FA" then -- Si le device a bien compris
			ack <= '1';
		elsif msgin = '1' and ask = '1' then -- On a probablement affaire à la réponse à une commande
			ans <= '1';
	
		------------------------------------------------
		-- Les différentes étapes de l'initialisation --
		------------------------------------------------
		-- On commence par demander le reset, au cas où le device soit déjà alimenté avant le démarrage
		elsif etat = "0000" then
			msgout <= '1';
			dataout <= X"FF";
			ack <= '0';
			etat <= etat +1;
			devic3 <= "00"; -- Au début, le device est unknown
			
		-- Le reset fait, on attends les ack et les différentes autres réponses	
		elsif ack = '1' or (ask = '1' and ans = '1') then
			-- On devrait peut etre attendre un petit peu ici
			ack <= '0';
			if ack = '0' then ask <= '0'; ans <= '0'; end if;
			etat <= etat + 1;
			
			case etat is
				when "0001" => ask <= '1';                    -- On attend le "AA" du self-test
				when "0010" => msgout<='1'; dataout <= X"F2"; -- On commence par demander l'ID
				when "0011" => ask <= '1';                    -- On a recu l'ack, on attend ans
				when "0100" => if datain = X"AB"              -- On récupère l'ID
									then devic3 <= "10"; -- keyboard
									else devic3 <= "11"; -- mouse
									end if;
									ack <= '1'; -- On passe directement à l'état suivant.
				when others =>  -- On splitte Mouse/Keyboard
				
					-- KEYBOARD
					if devic3 = "10" then 
						case etat is
							when "0101" => msgout<= '1'; dataout <= X"ED"; -- On demande le reglage des LEDs
							when "0110" => msgout<= '1'; dataout <= X"02"; -- On allume Numlock
							-- Ici, on peut encore faire un peu de config --
							when "0111" => msgout<= '1'; dataout <= X"F4";     -- On enable le clavier
							when others => init_done <= '1'; device <= devic3; -- On a fini
						end case;
					
					 -- MOUSE
					elsif devic3 = "11" then
						case etat is
							-- Ici, on peut encore faire un peu de config --
							-- Pas oublier de changer le when du dessous.
							when "0101" => msgout<= '1'; dataout <= X"F4";     -- On enable la souris
							when others => init_done <= '1'; device <= devic3; -- On a fini
						end case;					
					
					-- Cas d'erreur, on réinitialise
					else etat <= "0000";
					end if;
			end case;
		
		else msgout <= '0'; -- Sinon, aucun message a envoyer
		end if;
		
	
	--------------------------------------------------------
	-- Sinon, on attend le "self-test passed" paquet : AA --
	-- Cas de changement de device au milieu de l'exec.   --
	--------------------------------------------------------
	elsif msgin = '1' and datain = X"AA" then
			init_done <= '0'; -- On relance l'initialisation
			etat <= "0000";
			devic3 <= "00";
			device <= "00";
	else
		msgout <= '0';
	end if;

end if;
end if;
end process;
end Behavioral;

