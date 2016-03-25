----------------------------------------------------------------------------------
-- Engineer:       Maxime Niankouri
-- Create Date:    21:06:29 04/14/2014 
-- Module Name:    popcorn
-- POPCORN, en référence à un vieux casse-brique de 1988, sous DOS.
-- => C'est un casse-brique.
--
-- Les briques sont en 16x32 et peuvent se répartir un peu partout sur l'écran
-- dans une map de 20x30
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity popcorn is
    Port ( clk           : in  STD_LOGIC;
           reset         : in  STD_LOGIC;
           KEY_left      : in  STD_LOGIC_VECTOR (1 downto 0);
           KEY_right     : in  STD_LOGIC_VECTOR (1 downto 0);
           KEY_up        : in  STD_LOGIC_VECTOR (1 downto 0);
           KEY_down      : in  STD_LOGIC_VECTOR (1 downto 0);
           KEY_enter     : in  STD_LOGIC;
           KEY_space     : in  STD_LOGIC_VECTOR (1 downto 0);
           VGA_hposition : in  STD_LOGIC_VECTOR (9 downto 0);
           VGA_vposition : in  STD_LOGIC_VECTOR (9 downto 0);
           GAME_popcorn  : in  STD_LOGIC;
           VGA_popcorn   : out STD_LOGIC_VECTOR (11 downto 0);
           AUDIO_popcorn : out STD_LOGIC);
end popcorn;

architecture Behavioral of popcorn is
----------------------------------------
--           BARRE JOUEUR             --
----------------------------------------
signal   rect_x : STD_LOGIC_VECTOR (9 downto 0) := "0100110110"; -- (640 - rect_w )/2 pas à jour suite aux changement de w et h
signal   rect_y : STD_LOGIC_VECTOR (9 downto 0) := "0111000010"; -- A decider proprement
constant rect_w : natural := 40;
constant rect_h : natural := 8;

----------------------------------------
--               BALLE                --
----------------------------------------
signal   ball_x  : STD_LOGIC_VECTOR (9 downto 0) := "0100110110";
signal   ball_y  : STD_LOGIC_VECTOR (9 downto 0) := "0000010110";
signal   ball_vx : STD_LOGIC_VECTOR (4 downto 0) := "00001";
signal   ball_vy : STD_LOGIC_VECTOR (4 downto 0) := "10001";
constant ball_w  : natural := 8;
constant ball_h  : natural := 8;

----------------------------------------
--            DEPLACEMENTS            --
----------------------------------------
constant delta_ball : STD_LOGIC_VECTOR (18 downto 0) := "1111101000000000000"; -- A décider correctement plus tard
constant delta_t    : STD_LOGIC_VECTOR (15 downto 0) := "1111101000000000"; -- 7ms @25MHz
signal   incre_t    : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
signal   incre_x    : STD_LOGIC_VECTOR (18 downto 0) := (others => '0');
signal   incre_y    : STD_LOGIC_VECTOR (18 downto 0) := (others => '0');

signal left_hold  : STD_LOGIC := '0';
signal right_hold : STD_LOGIC := '0';

----------------------------------------
--           MAP DE BRIQUES           --
----------------------------------------
COMPONENT brickmap PORT (
    clka  : IN  STD_LOGIC;
    wea   : IN  STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN  STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina  : IN  STD_LOGIC_VECTOR(0 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(0 DOWNTO 0));
END COMPONENT;

signal wea   : STD_LOGIC_VECTOR (0 downto 0) := (others => '0');
signal addra : STD_LOGIC_VECTOR (9 downto 0) := (others => '0');
signal dina  : STD_LOGIC_VECTOR (0 downto 0) := (others => '0');
signal douta : STD_LOGIC_VECTOR (0 downto 0) := (others => '0');
signal level : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');

begin
----------------------------------------
--           MAP DE BRIQUES           --
----------------------------------------
Map_brick : brickmap PORT MAP (
    clka  => clk,
    wea   => wea,
    addra => addra,
    dina  => dina,
    douta => douta
 );
 

AUDIO_popcorn <= '0'; -- A VIRER




process(clk)
begin
if rising_edge(clk) then
-----------------------
--       RESET       --
-----------------------
if reset = '1' then
	rect_x     <= "0100110110";
	rect_y     <= "0111000010";
	wea        <= (others => '0');
	addra      <= (others => '0');
	dina       <= (others => '0');
	level      <= (others => '0');
	ball_x     <= "0100110110";
	ball_y     <= "0000010110";
	ball_vx    <= "00001";
	ball_vy    <= "10001";
	incre_t    <= (others => '0');
	incre_x    <= (others => '0');
	incre_y    <= (others => '0');
	left_hold  <= '0';
	right_hold <= '0';
else

------------------------------------------------------------------------------------------------------------------------
---------------------------------------------                              ---------------------------------------------
------------------------------------------              PROCESS               ------------------------------------------
---------------------------------------------                              ---------------------------------------------
------------------------------------------------------------------------------------------------------------------------

	-- Pour commencer simple, on va afficher un rectangle au milieu de l'écran
	-- Ce rectangle devra pouvoir bouger et etre bloqué aux bords
	
	-- On va ensuite s'amuser à faire un splash screen trop stylé avec la musique associée
	-- L'appui sur la touche entrée vire le splash screen de manière stylée.
	
	-- La touche espace .. random pour le moment // tir de balles ? <= Stylé
	
	----------------------------------
	--  On cale la map de briques   --
	----------------------------------	
	if    VGA_hposition = 700 or VGA_hposition = 701 or VGA_hposition = 702 -- Pour les cas de collision
	then addra <= ball_x(9 downto 5) & ball_y(8 downto 4);
	elsif VGA_hposition = 703 or VGA_hposition = 704 or VGA_hposition = 705 
	then addra <= (ball_x(9 downto 5) + (ball_x(4) and ball_x(3))) & ball_y(8 downto 4);
	elsif VGA_hposition = 706 or VGA_hposition = 707 or VGA_hposition = 708 
	then addra <= ball_x(9 downto 5) & (ball_y(8 downto 4) + ball_y(3));
	elsif VGA_hposition = 709 or VGA_hposition = 710 or VGA_hposition = 711 
	then addra <= (ball_x(9 downto 5) + (ball_x(4) and ball_x(3))) & (ball_y(8 downto 4) + ball_y(3));
	elsif VGA_vposition > 480 then
		addra <= (others => '0');
	elsif VGA_hposition > 640 then
		addra <= "00000" & VGA_vposition(8 downto 4);
	elsif VGA_hposition(4 downto 1) = "1111" then
		addra <= ( VGA_hposition(9 downto 5) + 1 ) & VGA_vposition(8 downto 4);
	else
		addra <= VGA_hposition(9 downto 5) & VGA_vposition(8 downto 4);
	end if;
	
	
	
	if GAME_popcorn = '1' then			
		----------------------------------
		--  L'affichage des composants  --
		----------------------------------
		if     VGA_hposition >= rect_x and rect_x + rect_w > VGA_hposition
		and    VGA_vposition >= rect_y and rect_y + rect_h > VGA_vposition
		then VGA_popcorn <= (others => '1'); -- Barre du joueur blanche
		elsif  VGA_hposition >= ball_x and ball_x + ball_w > VGA_hposition
		and    VGA_vposition >= ball_y and ball_y + ball_h > VGA_vposition 
		then VGA_popcorn <= "110011000000"; -- Balle jaune
		elsif  douta = "1" then -- Si on est sur une brique
			if    VGA_hposition(4 downto 0) = 0 or VGA_hposition(4 downto 0) = "11111" or VGA_vposition(3 downto 0) = 0 or VGA_vposition(3 downto 0) = "1111"
			then VGA_popcorn <= (others => '0');-- Vide interbrique
		   elsif VGA_hposition(4 downto 0) = 1 or VGA_hposition(4 downto 0) = "11110" or VGA_vposition(3 downto 0) = 1 or VGA_vposition(3 downto 0) = "1110"
		   then VGA_popcorn <= "010100000000"; -- Bordure de brique rouge foncé
		   else VGA_popcorn <= "100000000000"; -- Intérieur de brique rouge plus pétant
		   end if;
		else VGA_popcorn <= (others => '0');
		end if;
		---------------------------------
		-- Le deplacement du rectangle --
		---------------------------------			
		if left_hold = '1' or right_hold = '1' then
			if delta_t = incre_t then
				incre_t <= (others => '0');
				if rect_x + right_hold - left_hold < 640 - rect_w then -- Sachant que -1 > 640 ...
					rect_x <= rect_x + right_hold - left_hold;
				end if;
			else
				incre_t <= incre_t +1;
			end if;
		else 
			incre_t <= delta_t; -- On réagit dès l'appui.
		end if;
		---------------------------------
		-- Le deplacement de la balle  --
		---------------------------------	
		-- en x
		if delta_ball <= incre_x then
			incre_x <= (others => '0');
			if ball_vx(4) = '1' then
				if ball_x - 1 < 640 - ball_w then
					ball_x <= ball_x - 1;
				else
					ball_x <= ball_x + 1;
					ball_vx(4) <= not ball_vx(4);
				end if;
			else
				if ball_x + 1 < 640 - ball_w then
					ball_x <= ball_x + 1;
				else
					ball_x <= ball_x - 1;
					ball_vx(4) <= not ball_vx(4);
				end if;
			end if;
		else 
			incre_x <= incre_x + ball_vx(3 downto 0);
		end if;
		-- en y
		if delta_ball <= incre_y then
			incre_y <= (others => '0');
			if ball_vy(4) = '1' then
				if ball_y - 1 < 480 - ball_h then
					ball_y <= ball_y - 1;
				else
					ball_y <= ball_y + 1;
					ball_vy(4) <= not ball_vy(4);
				end if;
			else
				if ball_y + 1 < 480 - ball_h 
				and (rect_y > ball_y + ball_h
				  or ball_y > rect_y + rect_h
				  or ball_x + ball_w < rect_x
				  or ball_x > rect_x + rect_w) then
					ball_y <= ball_y + 1;
				else
					ball_y <= ball_y - 1;
					ball_vy(4) <= not ball_vy(4);
				end if;
			end if;
		else 
			incre_y <= incre_y + ball_vy(3 downto 0);
		end if;
		---------------------------------
		--   Collision avec briques    --
		---------------------------------	
		if douta = "1" and (VGA_hposition = 702 or VGA_hposition = 705 or VGA_hposition = 708 or VGA_hposition = 711)
		then
			wea <= "1";
			dina <= "0";
			-- On gère maintenant les rebonds
			if   ball_x + ball_w >= addra(9 downto 5) & "00000" 
			and  ball_x <= addra(9 downto 5) & "11111" 
			and (ball_y + ball_h <= addra(4 downto 0) & "0000" or ball_y >= addra(4 downto 0) & "1111")
			then
				incre_y <= delta_ball;
				ball_vy(4) <= not ball_vy(4);
			elsif ball_y + ball_h >= addra(4 downto 0) & "0000" 
			and   ball_y <= addra(4 downto 0) & "1111" 
			and  (ball_x + ball_w <= addra(9 downto 5) & "00000" or ball_x >= addra(9 downto 5) & "11111")
			then
				incre_x <= delta_ball;
				ball_vx(4) <= not ball_vx(4);
--			else 
--				ball_vx(3 downto 0) <= "0000";
--				ball_vy(3 downto 0) <= "0000";
			end if;
			
		else
			wea <= "0";
		end if;
	
	else -- SI le jeu n'est pas actif (raz)
		rect_x  <= "0100110110";
	   ball_x  <= "0100110110";
	   ball_y  <= "0000010110";
		incre_t <= (others => '0');
		----- REMPLISSAGE DU LEVEL A DEPLACER ----
		if level = 0 then
			wea <= "1";
			if addra(9 downto 5) > 2 and addra(9 downto 5) < 17 and addra(4 downto 0) > 3 and addra(4 downto 0) < 17 then
				dina <= "1";
			else
				dina <= "0";
			end if;
		end if;
	end if;
	
			
	----------------------------
	-- La gestion des touches --
	----------------------------
	if    KEY_left(0) = '1'  then left_hold <= '1';
	elsif KEY_left(1) = '1'  then left_hold <= '0';
	end if;
	if    KEY_right(0) = '1' then right_hold <= '1';
	elsif KEY_right(1) = '1' then	right_hold <= '0';
	end if;
	if    KEY_up(0) = '1'   then ball_vx <= ball_vx+1; ball_vy <= ball_vy+1; 
	elsif KEY_down(0) = '1' then ball_vx <= ball_vx-1; ball_vy <= ball_vy-1; 
	end if;
		
		
		
		
		
end if;
end if;
end process;
end Behavioral;

