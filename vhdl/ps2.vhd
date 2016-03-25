----------------------------------------------------------------------------------
-- Engineer:       Maxime Niankouri
-- Create Date:    19:53:56 04/08/2014 
-- Module Name:    ps2
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ps2 is
    Port ( clk     : in     STD_LOGIC;
           reset   : in     STD_LOGIC;
           msgin   : out    STD_LOGIC;
           datain  : out    STD_LOGIC_VECTOR (7 downto 0);
           msgout  : in     STD_LOGIC;
           dataout : in     STD_LOGIC_VECTOR (7 downto 0);
           device  : out    STD_LOGIC_VECTOR (1 downto 0);
           ps2clk  : inout  STD_LOGIC;
           ps2data : inout  STD_LOGIC);
end ps2;

architecture Behavioral of ps2 is

COMPONENT ps2init -- INITIALISATION
		PORT(clk     : in   STD_LOGIC;
           reset   : in   STD_LOGIC;
           msgin   : in   STD_LOGIC;
           datain  : in   STD_LOGIC_VECTOR (7 downto 0);
           msgout  : out  STD_LOGIC;
           dataout : out  STD_LOGIC_VECTOR (7 downto 0);
           device  : out  STD_LOGIC_VECTOR (1 downto 0));
END COMPONENT;
COMPONENT ps2rx -- RECEPTION
		PORT(clk     : in     STD_LOGIC;
           reset   : in   STD_LOGIC;
			  tx_on   : in    STD_LOGIC;
           msgin   : out    STD_LOGIC;
           datain  : out    STD_LOGIC_VECTOR (7 downto 0);
           ps2clk  : inout  STD_LOGIC;
           ps2data : inout  STD_LOGIC);
END COMPONENT;
COMPONENT ps2tx -- TRANSMISSION
		PORT(clk     : in     STD_LOGIC;
           reset   : in   STD_LOGIC;
			  tx_on   : out    STD_LOGIC;
           msgout  : in     STD_LOGIC;
           dataout : in     STD_LOGIC_VECTOR (7 downto 0);
           ps2clk  : inout  STD_LOGIC;
           ps2data : inout  STD_LOGIC);
END COMPONENT;

signal tx_on      : STD_LOGIC := '0';
signal tx_msgout  : STD_LOGIC := '0';
signal tx_dataout : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal rx_msgin  : STD_LOGIC := '0';
signal rx_datain : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal init_msg   : STD_LOGIC := '0';
signal init_data  : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

begin

Inst_ps2init : ps2init PORT MAP (
    clk     => clk,
    reset   => reset,
    msgin   => rx_msgin,
	 datain  => rx_datain,
	 msgout  => init_msg,
	 dataout => init_data,
	 device  => device
  );	
Inst_ps2rx : ps2rx PORT MAP (
    clk     => clk,
    reset   => reset,
	 tx_on   => tx_on,
    msgin   => rx_msgin,
	 datain  => rx_datain,
	 ps2clk  => ps2clk,
	 ps2data => ps2data
  );	
Inst_ps2tx : ps2tx PORT MAP (
    clk     => clk,
    reset   => reset,
	 tx_on   => tx_on,
    msgout  => tx_msgout,
	 dataout => tx_dataout,
	 ps2clk  => ps2clk,
	 ps2data => ps2data
  );	

-- Les attributions
process(clk)
begin
if rising_edge(clk) then

	if tx_on = '0' then
		tx_msgout <= msgout or init_msg;
		if msgout = '1' then
			tx_dataout <= dataout;
		elsif init_msg = '1' then 
			tx_dataout <= init_data;
		end if;
	else tx_msgout <= '0';
	end if;

	msgin <= rx_msgin;
	datain <= rx_datain;

end if;
end process;
end Behavioral;

