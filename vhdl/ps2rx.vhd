----------------------------------------------------------------------------------
-- Engineer:       Maxime Niankouri
-- Create Date:    19:59:20 04/08/2014 
-- Module Name:    ps2rx
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ps2rx is
    Port ( clk     : in    STD_LOGIC;
           reset   : in    STD_LOGIC;
           tx_on   : in    STD_LOGIC;
           msgin   : out   STD_LOGIC;
           datain  : out   STD_LOGIC_VECTOR (7 downto 0);
           ps2clk  : inout STD_LOGIC;
           ps2data : inout STD_LOGIC);
end ps2rx;

architecture Behavioral of ps2rx is

-- Def pour vérifier le signal de clock
constant minlength_clk : natural := 30*25; -- 30us @ 25MHz
constant maxlength_clk : natural := 60*25; -- 60us @ 25MHz

signal etat          : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
signal clockCounter  : STD_LOGIC_VECTOR(10 downto 0) := (others => '0');
signal dataReg       : STD_LOGIC_VECTOR(10 downto 0) := (others => '0');
signal receivedCount : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal ps2clk_count  : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
signal ps2data_count : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
signal prev_ps2clkV  : STD_LOGIC := '0';
signal ps2clkV       : STD_LOGIC := '0';
signal ps2dataV      : STD_LOGIC := '0';

begin
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
	receivedCount <= (others => '0');
	ps2clk_count  <= (others => '0');
	ps2data_count <= (others => '0');
	prev_ps2clkV  <= '0';
	ps2clkV       <= '0';
	ps2dataV      <= '0';
	msgin         <= '0';
else
	
		prev_ps2clkV <= ps2clkV;
	
		----------------------------------------------------
		--   On commence par vérifier ps2clk et ps2data   --
		----------------------------------------------------	
		
      -- On vérifie la validité de ps2clk
      if ps2clk = '1' then
         if ps2clk_count < 31 then
            ps2clk_count <= ps2clk_count+1;
         else
            ps2clkV <= '1';
            clockCounter     <= (others => '0');
         end if;
      else
         if ps2clk_count > 0 then
            ps2clk_count <= ps2clk_count-1;
         else
            ps2clkV <= '0';
            clockCounter <= (others => '0');
         end if;      
      end if;

      -- On vérifie la validité de ps2data
      if ps2data = '1' then
         if ps2data_count < 31 then
            ps2data_count <= ps2data_count+1;
         else
            ps2dataV <= '1';
         end if;
      else
         if ps2data_count > 0 then
            ps2data_count <= ps2data_count-1;
         else
            ps2dataV <= '0';
         end if;
      end if;
		
		
		----------------------------------------------------
      --           On s'occupe de la réception          --
      ----------------------------------------------------
		
		-- On attend/démarre la récéption d'un paquet
		if etat = "00" then
			clockCounter  <= (others => '0');
         receivedCount <= (others => '0');      
         msgin  <= '0';
         if ps2clkV = '0' and tx_on = '0' then
            etat <= "01";
         end if;
		end if;
		
		-- On recoit les 11 bits du paquet
		if etat = "01" then
         if clockCounter > maxlength_clk then -- Il y a eu un problème
            if ps2clkV = '1' then
               etat <= "00"; -- On annule la réception
            end if;
         end if;
         
         if prev_ps2clkV = '0' and ps2clkV = '1' then -- En rising edge
            if clockCounter < minlength_clk then -- Cas d'erreur
               etat <= "00";
            else -- Sinon tout se passe bien et on prend un bit
               receivedCount <= receivedCount+1;
               clockCounter <= (others => '0');
               dataReg <= ps2dataV & dataReg(10 downto 1);
               if receivedCount = 10 then -- Si on a recu le paquet (10+1 = 11)
                  etat <= "10";
               end if;
            end if;
         elsif prev_ps2clkV = '1' and ps2clkV = '0' then -- En falling edge
            if clockCounter < minlength_clk then -- Cas d'erreur
               etat <= "11"; -- Sachant qu'on est à 0, on est obligé d'attendre de remonter à 1
            end if;
            clockCounter  <= (others => '0');
			else				
				clockCounter <= clockCounter + 1;
         end if;
		end if;
		
		-- On s'assure que le paquet est correct et on l'envoi au système
		if etat = "10" then
         if dataReg(10) = '1' and (dataReg(9) xor dataReg(8) xor dataReg(7) xor dataReg(6) xor dataReg(5) xor dataReg(4) xor dataReg(3) xor dataReg(2) xor dataReg(1)) = '1'  and dataReg (0) = '0' then            
            datain <= dataReg(8 downto 1);
            msgin <= '1';
            etat <= "00";
         end if;
		end if;
		
		-- Cas d'erreur en falling edge
		if etat = "11" then
			if ps2clkV = '1' then -- On attend simplement de remonter
            etat <= "00";      -- Pour repasser en mode attente de début
         end if;
		end if;
	
end if;	
   end if;	
end process;
end Behavioral;

