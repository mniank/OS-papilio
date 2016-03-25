----------------------------------------------------------------------------------
-- Engineer:       Maxime Niankouri
-- Create Date:    20:29:10 06/06/2014 
-- Module Name:    mouse
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity mouse is
    Port ( clk          : in  STD_LOGIC;
           reset        : in  STD_LOGIC;
           enable       : in  STD_LOGIC;
           msgin        : in  STD_LOGIC;
           datain       : in  STD_LOGIC_VECTOR (7 downto 0);
           msgout       : out STD_LOGIC;
           dataout      : out STD_LOGIC_VECTOR (7 downto 0);
           MOUSE_left   : out STD_LOGIC_VECTOR (1 downto 0);
           MOUSE_right  : out STD_LOGIC_VECTOR (1 downto 0);
           MOUSE_x      : out STD_LOGIC_VECTOR (9 downto 0);
           MOUSE_y      : out STD_LOGIC_VECTOR (8 downto 0);
           MOUSE_middle : out STD_LOGIC_VECTOR (1 downto 0));
end mouse;

architecture Behavioral of mouse is

signal paquet     : STD_LOGIC_VECTOR (1 downto 0) := (others => '0'); -- Se souvient du numéro de paquet (n/3)
signal left       : STD_LOGIC := '0';
signal right      : STD_LOGIC := '0';
signal middle     : STD_LOGIC := '0';
signal overflow_x : STD_LOGIC := '0';
signal overflow_y : STD_LOGIC := '0';
signal sign_x     : STD_LOGIC := '0';
signal sign_y     : STD_LOGIC := '0';
signal position_x : STD_LOGIC_VECTOR (9 downto 0) := "0101000000"; -- Position initiale de la souris : 
signal position_y : STD_LOGIC_VECTOR (8 downto 0) := "011110000";  -- centre de l'écran - 640x480

begin

MOUSE_x <= position_x;
MOUSE_y <= position_y;




process(clk)
begin
if rising_edge(clk) then
-----------------------
--       RESET       --
-----------------------
if reset = '1' then
	MOUSE_left   <= (others => '0');
	MOUSE_right  <= (others => '0');
	MOUSE_middle <= (others => '0');
	paquet       <= (others => '0');
	position_x   <= "0101000000";
	position_y   <= "011110000";
	msgout       <= '0';
else

------------------------------------------------------------------------------------------------------------------------
---------------------------------------------                              ---------------------------------------------
------------------------------------------              PROCESS               ------------------------------------------
---------------------------------------------                              ---------------------------------------------
------------------------------------------------------------------------------------------------------------------------
	if enable = '1' and msgin = '1' then -- A l'arrivée d'un nouveau message
	
	-- Paquet des clics
		if paquet = "00" then 
			if datain(3) = '1' then -- Est normalement toujours à 1
				paquet <= "01";
				-- Les deux ou trois boutons
				MOUSE_left   <= (left and not datain(0)) & (datain(0) and not left);
				MOUSE_right  <= (right and not datain(1)) & (datain(1) and not right);
				MOUSE_middle <= (middle and not datain(2)) & (datain(2) and not middle);
				left   <= datain(0);
				right  <= datain(1);
				middle <= datain(2);				
				-- Les bits utilitaires à la position
				sign_x     <= datain(4);
				sign_y     <= datain(5);
				overflow_x <= datain(6); -- L'overflow est à 1 lorsque le déplacement dépasse 255
				overflow_y <= datain(7);				
			end if;
				
	-- Paquet des x en complément à 2
		elsif paquet = "01" then
			paquet <= "10";
			if overflow_x = '0' then
				if sign_x = '0' then -- c'est positif
					if position_x + ("00" & datain) >= 640 
					then position_x <= "1001111111";				
					else position_x <= position_x + ("00" & datain);
					end if;
				else  -- c'est négatif
					if position_x < ("00" & not datain) 
					then position_x <= (others => '0');				
					else position_x <= position_x - ("00" & not datain);
					end if;
				end if;
			end if;
			
	 -- Paquet des y en complément à 2
		elsif paquet = "10" then
			paquet <= "00";
			if overflow_y = '0' then
				if sign_y = '1' then -- c'est négatif
					if position_y >= 480 - ("0" & not datain)
					then position_y <= "111011111";				
					else position_y <= position_y + ("0" & not datain);
					end if;
				else  -- c'est positif
					if position_y < ("0" & datain)
					then position_y <= (others => '0');				
					else position_y <= position_y - ("0" & datain);
					end if;
				end if;
			end if;
			
		end if;
		
	elsif enable = '0' then
		position_x <= "0101000000";
		position_y <= "011110000";
		paquet     <= "00";
		
	else
		MOUSE_left   <= "00";
		MOUSE_right  <= "00";
		MOUSE_middle <= "00";
	
	end if;
	
end if;
end if;
end process;
end Behavioral;

