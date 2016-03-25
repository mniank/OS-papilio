----------------------------------------------------------------------------------
-- Engineer:       Maxime Niankouri
-- Create Date:    00:46:17 03/08/2014 
-- Module Name:    OS 
--
-- Bloc principal, explicite, reliant différentes fonctionnalités
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;


entity OS is
    Port ( I_SW      : in     STD_LOGIC_VECTOR (3 downto 0);
           CLK       : in     STD_LOGIC;
           O_VSYNC   : out    STD_LOGIC;
           O_HSYNC   : out    STD_LOGIC;
           O_VIDEO_R : out    STD_LOGIC_VECTOR (3 downto 0);
           O_VIDEO_G : out    STD_LOGIC_VECTOR (3 downto 0);
           O_VIDEO_B : out    STD_LOGIC_VECTOR (3 downto 0);
           O_AUDIO_L : out    STD_LOGIC;
           O_AUDIO_R : out    STD_LOGIC;
           LED       : out    STD_LOGIC_VECTOR (3 downto 0);
           I_RESET   : in     STD_LOGIC;
           PS2CLKA   : inout  STD_LOGIC;
           PS2DATA   : inout  STD_LOGIC;
           PS2CLKB   : inout  STD_LOGIC;
           PS2DATB   : inout  STD_LOGIC
			 );
end OS;

architecture Behavioral of OS is

	-------------------------------------------------
	--                   SYSTEME                   --
	-------------------------------------------------	
	COMPONENT mydcm PORT(
		CLKIN_IN        : in  STD_LOGIC;          
		CLKFX_OUT       : out STD_LOGIC;
		CLKIN_IBUFG_OUT : out STD_LOGIC;
		CLK0_OUT        : out STD_LOGIC;
		LOCKED_OUT      : out STD_LOGIC);
	END COMPONENT;
	signal clk25 : STD_LOGIC;
	-------------------------------------------------
	--                    VIDEO                    --
	-------------------------------------------------
	COMPONENT vga PORT( 
		clk           : in  STD_LOGIC;
		reset         : in  STD_LOGIC;
	   O_VSYNC       : out STD_LOGIC;
	   O_HSYNC       : out STD_LOGIC;
	   O_VIDEO_R     : out STD_LOGIC_VECTOR (3 downto 0);
	   O_VIDEO_G     : out STD_LOGIC_VECTOR (3 downto 0);
	   O_VIDEO_B     : out STD_LOGIC_VECTOR (3 downto 0);
	   VGA_hposition : out STD_LOGIC_VECTOR (9 downto 0);
	   VGA_vposition : out STD_LOGIC_VECTOR (9 downto 0);
	   VGA_mode      : in  STD_LOGIC_VECTOR (2 downto 0);
	   VGA_data      : in  STD_LOGIC_VECTOR (11 downto 0);
		MOUSE_x       : in  STD_LOGIC_VECTOR (9 downto 0);
	   MOUSE_y       : in  STD_LOGIC_VECTOR (8 downto 0);
		MOUSE_cursor  : in  STD_LOGIC;
	   console_color : in  STD_LOGIC;
	   curseur       : in  STD_LOGIC_VECTOR(11 downto 0));
   END COMPONENT;
	signal VGA_hposition : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
	signal VGA_vposition : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
	signal VGA_mode      : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
	signal VGA_data      : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
	
	-------------------------------------------------
	--                   CONSOLE                   --
	-------------------------------------------------
	COMPONENT console PORT(
		clk              : in  STD_LOGIC;
		reset            : in  STD_LOGIC;
	   CONSOLE_write_on : in  STD_LOGIC;
	   newkey           : in  STD_LOGIC;
	   keydata          : in  STD_LOGIC_VECTOR (6 downto 0);
	   enter            : in  STD_LOGIC;
	   backspace        : in  STD_LOGIC;
	   space            : in  STD_LOGIC;
	   VGA_hposition    : in  STD_LOGIC_VECTOR(9 downto 0);
	   VGA_vposition    : in  STD_LOGIC_VECTOR(9 downto 0);
	   CMD_line         : out STD_LOGIC_VECTOR (4 downto 0);
	   bitcolor         : out STD_LOGIC;
	   curseur          : out STD_LOGIC_VECTOR(11 downto 0);
	   currentkey       : out STD_LOGIC_VECTOR (6 downto 0));
	END COMPONENT;
	signal CONSOLE_newkey   : STD_LOGIC := '0';
	signal console_color    : STD_LOGIC := '0';
	signal curseur          : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');	
	signal currentkey       : STD_LOGIC_VECTOR(6 downto 0) := (others => '0');	
	signal CONSOLE_write_on : STD_LOGIC := '1';
	-------------------------------------------------
	--                  COMMANDES                  --
	-------------------------------------------------
	COMPONENT cmd PORT(  
		clk              : in    STD_LOGIC;
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
	END COMPONENT;
	signal LED_on    : STD_LOGIC := '0';
	signal CMD_line  : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
	-------------------------------------------------
	--                     SON                     --
	-------------------------------------------------
	COMPONENT audio PORT( 
		clk         : in  STD_LOGIC;
      boucle      : in  STD_LOGIC;
      unique      : in  STD_LOGIC;
      start       : in  STD_LOGIC;
      startaddr   : in  STD_LOGIC_VECTOR (11 downto 0);
      synthe_mode : in  STD_LOGIC;
      synthe_note : in  STD_LOGIC_VECTOR (4 downto 0);
      fin         : out STD_LOGIC;
      O_AUDIO_L   : out STD_LOGIC;
      O_AUDIO_R   : out STD_LOGIC);
	END COMPONENT;
	COMPONENT synthe PORT( 
		clk            : in  STD_LOGIC;
		reset          : in  STD_LOGIC;
		KEY_ascii_code : in  STD_LOGIC_VECTOR (6 downto 0);
		KEY_ascii      : in  STD_LOGIC_VECTOR (1 downto 0);
      SYNTHE_note    : out STD_LOGIC_VECTOR (4 downto 0));
	END COMPONENT;
   signal AUDIO_start       : STD_LOGIC := '0';
   signal AUDIO_startaddr   : STD_LOGIC_VECTOR (11 downto 0) := (others => '0');
	signal AUDIO_boucle      : STD_LOGIC := '0';
   signal AUDIO_unique      : STD_LOGIC := '0';
   signal AUDIO_synthe_on   : STD_LOGIC := '0';
   signal AUDIO_synthe_note : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
   signal AUDIO_fin         : STD_LOGIC := '0';
   signal SYNTHE_note       : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
	signal SYNTHE_keydata    : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');	
	-------------------------------------------------
	--                     PS2                     --
	-------------------------------------------------
	COMPONENT ps2 PORT(  
		clk     : in     STD_LOGIC;
	   reset   : in     STD_LOGIC;
	   msgin   : out    STD_LOGIC;
	   datain  : out    STD_LOGIC_VECTOR (7 downto 0);
	   msgout  : in     STD_LOGIC;
	   dataout : in     STD_LOGIC_VECTOR (7 downto 0);
	   device  : out    STD_LOGIC_VECTOR (1 downto 0);
	   ps2clk  : inout  STD_LOGIC;
	   ps2data : inout  STD_LOGIC);
	END COMPONENT;
	signal PS2A_msgin  : STD_LOGIC := '0';
	signal PS2A_datain : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
	signal PS2A_device : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
	signal PS2B_msgin  : STD_LOGIC := '0';
	signal PS2B_datain : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
	signal PS2B_device : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
	-------------------------------------------------
	--                   CLAVIER                   --
	-------------------------------------------------
	COMPONENT keyboard PORT(
		clk            : in  STD_LOGIC;
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
	END COMPONENT;	
	signal KEY_enter      : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
	signal KEY_echap      : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
	signal KEY_backspace  : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
	signal KEY_space      : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
	signal KEY_left       : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
	signal KEY_right      : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
	signal KEY_up         : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
	signal KEY_down       : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
	signal KEY_ascii      : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
	signal KEY_ascii_code : STD_LOGIC_VECTOR (6 downto 0) := (others => '0');
	-------------------------------------------------
	--                   SOURIS                    --
	-------------------------------------------------
	COMPONENT mouse PORT(
		clk          : in  STD_LOGIC;
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
	END COMPONENT;
	signal MOUSE_left   : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
	signal MOUSE_right  : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
	signal MOUSE_middle : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
	signal MOUSE_x      : STD_LOGIC_VECTOR (9 downto 0) := (others => '0');
	signal MOUSE_y      : STD_LOGIC_VECTOR (8 downto 0) := (others => '0');
	signal MOUSE_cursor : STD_LOGIC := '0';
	-------------------------------------------------
	--                    JEUX                     --
	-------------------------------------------------
	COMPONENT popcorn PORT (
		clk           : in  STD_LOGIC;
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
	END COMPONENT;
	signal GAME_mode  : STD_LOGIC_VECTOR(0 downto 0) := (others => '0'); -- 0 : popcorn
	
	
	
	

begin

	-------------------------------------------------
	--                   SYSTEME                   --
	-------------------------------------------------	
	Clock25 : mydcm PORT MAP(
		CLKIN_IN        => CLK,
		CLKFX_OUT       => clk25,
		CLKIN_IBUFG_OUT => open,
		CLK0_OUT        => open,
		LOCKED_OUT      => open
	);
	-------------------------------------------------
	--                    VIDEO                    --
	-------------------------------------------------
	Bloc_vga : vga PORT MAP(
		clk           => clk25,
		reset         => I_RESET,
      O_VSYNC       => O_VSYNC,
      O_HSYNC       => O_HSYNC,
      O_VIDEO_R     => O_VIDEO_R,
      O_VIDEO_G     => O_VIDEO_G,
      O_VIDEO_B     => O_VIDEO_B,
      VGA_hposition => VGA_hposition,
      VGA_vposition => VGA_vposition,
		VGA_mode      => VGA_mode,
		VGA_data      => VGA_data,
		MOUSE_x       => MOUSE_x,
		MOUSE_y       => MOUSE_y,
		MOUSE_cursor  => MOUSE_cursor,
		console_color => console_color,
		curseur       => curseur
	);
	-------------------------------------------------
	--                   CONSOLE                   --
	-------------------------------------------------		
	Bloc_console : console PORT MAP(
		clk              => clk25,
		reset            => I_RESET,
		CONSOLE_write_on => CONSOLE_write_on,
		newkey           => KEY_ascii(1),
		keydata          => KEY_ascii_code,
		enter            => KEY_enter(1),
		backspace        => KEY_backspace(1),
		space            => KEY_space(1),
		VGA_hposition    => VGA_hposition,
		VGA_vposition    => VGA_vposition,
		CMD_line         => CMD_line,
		bitcolor         => console_color,
		curseur          => curseur,
		currentkey       => currentkey
	);
	-------------------------------------------------
	--                  COMMANDES                  --
	-------------------------------------------------		
	Commandes : cmd PORT MAP(
		clk              => clk25,
		reset            => I_RESET,
		enter            => KEY_enter(1),
		echap            => KEY_echap(1),
		CMD_line         => CMD_line,
		currentkey       => currentkey,
		VGA_hposition    => VGA_hposition,
		VGA_vposition    => VGA_vposition,
		VGA_mode         => VGA_mode,
		GAME_mode        => GAME_mode,
		LED_on           => LED_on,
		AUDIO_start      => AUDIO_start,
		AUDIO_startaddr  => AUDIO_startaddr,
		AUDIO_boucle     => AUDIO_boucle,
		AUDIO_unique     => AUDIO_unique,
		AUDIO_synthe_on  => AUDIO_synthe_on,
		CONSOLE_write_on => CONSOLE_write_on
	);
	-------------------------------------------------
	--                     SON                     --
	-------------------------------------------------
	Bloc_audio : audio PORT MAP (
		clk         => clk25,
		boucle      => AUDIO_boucle,
		unique      => AUDIO_unique,
		start       => AUDIO_start,
		startaddr   => AUDIO_startaddr,
		synthe_mode => AUDIO_synthe_on,
		synthe_note => SYNTHE_note,
		fin         => AUDIO_fin,
		O_AUDIO_L   => O_AUDIO_L,
		O_AUDIO_R   => O_AUDIO_R
	 );  
	Mode_Synthe : synthe PORT MAP (
		clk            => clk25,
		reset          => I_RESET,
		KEY_ascii_code => KEY_ascii_code,
		KEY_ascii      => KEY_ascii,
		SYNTHE_note    => SYNTHE_note
   );

	-------------------------------------------------
	--                     PS2                     --
	-------------------------------------------------      
	Bloc_ps2A : ps2 PORT MAP (
		 clk     => clk25,
		 reset   => I_RESET,
		 msgin   => PS2A_msgin,
		 datain  => PS2A_datain,
		 msgout  => '0',
		 dataout => "00000000",
		 device  => PS2A_device,
		 ps2clk  => ps2clka,
		 ps2data => ps2data
	);     
	Bloc_ps2B : ps2 PORT MAP (
		 clk     => clk25,
		 reset   => I_RESET,
		 msgin   => PS2B_msgin,
		 datain  => PS2B_datain,
		 msgout  => '0',
		 dataout => "00000000",
		 device  => PS2B_device,
		 ps2clk  => ps2clkb,
		 ps2data => ps2datb
	);
	-------------------------------------------------
	--                   CLAVIER                   --
	-------------------------------------------------
	Bloc_keyboard : keyboard PORT MAP (
		clk            => clk25,
		reset          => I_RESET,
		enable         => '1',
		msgin          => PS2A_msgin,
		datain         => PS2A_datain,
		msgout         => open,
		dataout        => open,
		KEY_enter      => KEY_enter,
		KEY_echap      => KEY_echap,
		KEY_backspace  => KEY_backspace,
		KEY_space      => KEY_space,
		KEY_left       => KEY_left,
		KEY_right      => KEY_right,
		KEY_up         => KEY_up,
		KEY_down       => KEY_down,
		KEY_ascii      => KEY_ascii,
		KEY_ascii_code => KEY_ascii_code
	);
	-------------------------------------------------
	--                   SOURIS                    --
	-------------------------------------------------
	Bloc_mouse : mouse PORT MAP (
		clk		    => clk25,
		reset        => I_RESET,
		enable	    => PS2B_device(0),
		msgin 	    => PS2B_msgin,
		datain       => PS2B_datain,
		msgout       => open,
		dataout      => open,
		MOUSE_left   => MOUSE_left,
		MOUSE_right  => MOUSE_right,
		MOUSE_middle => MOUSE_middle,
		MOUSE_x      => MOUSE_x,
		MOUSE_y      => MOUSE_y
	);
	-------------------------------------------------
	--                    JEUX                     --
	-------------------------------------------------
	Game_popcorn : popcorn PORT MAP (
		clk            => clk25,
		reset          => I_RESET,
		KEY_enter      => KEY_enter(1),
		KEY_space      => KEY_space,
		KEY_left       => KEY_left,
		KEY_right      => KEY_right,
		KEY_up         => KEY_up,
		KEY_down       => KEY_down,
		VGA_hposition  => VGA_hposition,
		VGA_vposition  => VGA_vposition,
		GAME_popcorn   => GAME_mode(0),
		VGA_popcorn    => VGA_data,
		AUDIO_popcorn  => open
	);
 

------------------------------


LED <= PS2B_device & PS2A_device; --Tests		
------------------------------------------------------------------------------------------------------------------------
---------------------------------------------                              ---------------------------------------------
------------------------------------------              PROCESS               ------------------------------------------
---------------------------------------------                              ---------------------------------------------
------------------------------------------------------------------------------------------------------------------------
process(clk25)
begin	
if rising_edge(clk25) then
	------------------------------------------
	--                RESET                 --
	------------------------------------------
	if I_RESET = '1' then
	 -- Nothing to do here and now
	end if;
	------------------------------------------
	--    CLICS POUR AFFICHER LE CURSEUR    -- JUSTE POUR EFFECTUER DES TESTS -- A VIRER
	------------------------------------------
	if MOUSE_right(0) = '1' then MOUSE_cursor <= not MOUSE_cursor;
	end if;
		
end if;
end process;
end Behavioral;

