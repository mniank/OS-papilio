----------------------------------------------------------------------------------
-- Engineer:       Maxime Niankouri
-- Create Date:    15:02:52 04/12/2014 
-- Module Name:    vga 
--
-- Bloc d'affichage assez simple à comprendre
-- Résolution : 640x480
-- Couleurs : 16x16x16
-- Image en mémoire : résolution = 160x120, couleurs = 8x8x4
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_arith.ALL;

entity vga is
    Port ( clk           : in  STD_LOGIC;
           reset         : in  STD_LOGIC;
           O_VSYNC       : out STD_LOGIC;
           O_HSYNC       : out STD_LOGIC;
           O_VIDEO_R     : out STD_LOGIC_VECTOR (3 downto 0);
           O_VIDEO_G     : out STD_LOGIC_VECTOR (3 downto 0);
           O_VIDEO_B     : out STD_LOGIC_VECTOR (3 downto 0);
           VGA_hposition : out STD_LOGIC_VECTOR(9 downto 0);
           VGA_vposition : out STD_LOGIC_VECTOR(9 downto 0);
			  VGA_mode      : in  STD_LOGIC_VECTOR (2 downto 0);
			  VGA_data      : in  STD_LOGIC_VECTOR (11 downto 0);
			  MOUSE_x       : in  STD_LOGIC_VECTOR (9 downto 0);
			  MOUSE_y       : in  STD_LOGIC_VECTOR (8 downto 0);
			  MOUSE_cursor  : in  STD_LOGIC;
			  console_color : in  STD_LOGIC;
			  curseur       : in  STD_LOGIC_VECTOR(11 downto 0));
end vga;

architecture Behavioral of vga is

	-------------------------------------------------
	--                   MEMOIRE                   --
	-------------------------------------------------
	COMPONENT memory
	PORT (
		 clka  : IN  STD_LOGIC;
		 addra : IN  STD_LOGIC_VECTOR(14 DOWNTO 0);
		 douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	  );
	END COMPONENT;
	signal haddrcount : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
	signal vaddrcount : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
	signal douta      : STD_LOGIC_VECTOR(7 downto 0);
	signal addra      : STD_LOGIC_VECTOR(14 downto 0);
	
	
-- Compteurs
signal hcount : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
signal vcount : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');

begin

	-------------------------------------------------
	--                   MEMOIRE                   --
	-------------------------------------------------
	Splash_Screen: memory PORT MAP (
		clka => clk,
		addra => addra,
		douta => douta
  );	
  
  
-- Sorties
	VGA_hposition <= hcount;
	VGA_vposition <= vcount;
	
	
process(clk)
begin
if rising_edge(clk) then
-----------------------
--       RESET       --
-----------------------
if reset = '1' then
	addra      <= (others => '0');
	haddrcount <= (others => '0');
	vaddrcount <= (others => '0');
	hcount     <= (others => '0');
	vcount     <= (others => '0');
else

------------------------------------------------------------------------------------------------------------------------
---------------------------------------------                              ---------------------------------------------
------------------------------------------              PROCESS               ------------------------------------------
---------------------------------------------                              ---------------------------------------------
------------------------------------------------------------------------------------------------------------------------
	
	---------------------------
	--     IMAGE MEMOIRE     --
	---------------------------
	if hcount < 640 then
		if haddrcount = 3 then
			haddrcount <= "00";
			if vcount = 524 then
				addra <= (others => '0');
			else
				if hcount = 639 then
					if vaddrcount = 3 then
						vaddrcount <= "00";
						addra <= addra +1;
					else
						addra <= addra - 159;
						vaddrcount <= vaddrcount +1;
					end if;
				else
					addra <= addra +1;
				end if;
			end if;
		else
			haddrcount <= haddrcount +1;
		end if;
	end if;
	

	-------------------------
	-- Cadence des signaux --
	-------------------------
	if hcount = 799 then
		hcount <= (others => '0');
		if vcount = 524 then
			vcount <= (others => '0');
		else
			vcount <= vcount+1;
		end if;
	else
		hcount <= hcount+1;
	end if;
	
	if vcount = 490 or vcount = 491 
	then O_VSYNC <= '0';
	else O_VSYNC <= '1';
	end if;
	
	if hcount >= 656 and hcount < 752 
	then O_HSYNC <= '0';
	else O_HSYNC <= '1';
	end if;
	
	
			
	----------------------
	-- Partie Affichage --
	----------------------
	
	if hcount < 640 and vcount < 480 then
	-- Le curseur de la souris (une mire)
		if MOUSE_cursor = '1'
		and((MOUSE_x = hcount and MOUSE_y > vcount-3 and MOUSE_y < vcount+3)
		or  (MOUSE_y = vcount and MOUSE_x > hcount-3 and MOUSE_x < hcount+3)) then
					O_VIDEO_R <= "0000";
					O_VIDEO_G <= "1111";
					O_VIDEO_B <= "0000";
		else
			case VGA_mode is
				--------------------------------
				--        MODE CONSOLE        --
				--------------------------------
				when "010" =>
					-- Les lettres lues plus haut
					if console_color = '1' and not ( hcount(3 downto 0) = "0000" or hcount(3 downto 0) = "1111" or vcount(3 downto 0) = "0000" or vcount(3 downto 0) = "1111") then
						O_VIDEO_R <= "1101";
						O_VIDEO_G <= "1101";
						O_VIDEO_B <= "1101";
					-- Curseur de position, voir console pour comprendre
					elsif curseur(11) = '1' and vcount(8 downto 4) = curseur(10 downto 6) and hcount(9 downto 4) = curseur(5 downto 0) + 1 and hcount(3 downto 1) = "001" and not( vcount(3 downto 1) = "000" or vcount(3 downto 0) = "1111") then
						O_VIDEO_R <= "1101";
						O_VIDEO_G <= "1101";
						O_VIDEO_B <= "1101";
					-- Le fond, noir
					else
						O_VIDEO_R <= "0000";
						O_VIDEO_G <= "0000";
						O_VIDEO_B <= "0000";
					end if;
				--------------------------------
				--      MODE FLUX EXTERNE     --
				--------------------------------
				when "001" =>
					O_VIDEO_R <= VGA_data(11 downto 8);
					O_VIDEO_G <= VGA_data(7 downto 4);
					O_VIDEO_B <= VGA_data(3 downto 0);
				--------------------------------
				--     MODE TEST COULEURS     --
				--------------------------------
				when "111" => 
					O_VIDEO_R <= hcount(3 downto 0);
					O_VIDEO_G <= hcount(7 downto 4);
					O_VIDEO_B <= vcount(7 downto 4);
					
				--------------------------------
				--     MODE IMAGE MEMOIRE     --
				--------------------------------
				when "000" =>
					O_VIDEO_R <= douta(7 downto 5) & "0";
					O_VIDEO_G <= douta(4 downto 2) & "0";
					O_VIDEO_B <= douta(1 downto 0) & "00";
						
				when others =>
					O_VIDEO_R <= (others => '0');
					O_VIDEO_G <= (others => '0');
					O_VIDEO_B <= (others => '0');
			end case;
		end if;
	else
		O_VIDEO_R <= "0000";
		O_VIDEO_G <= "0000";
		O_VIDEO_B <= "0000";
	end if;
	
end if;
end if;
end process;
end Behavioral;

