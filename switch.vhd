----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/27/2022 03:21:10 PM
-- Design Name: 
-- Module Name: switch - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity switch is
  generic(size: integer := 24);
  Port (clk: in std_logic;
        rst: in std_logic;
        module: in std_logic_vector(size-1 downto 0);
        voter_in: in std_logic_vector(size-1 downto 0);
        voter_out: out std_logic_vector(size-1 downto 0));
end switch;

architecture Behavioral of switch is
signal ff_in, ff_out: std_logic;
signal tmp, tmp2: std_logic_vector(size-1 downto 0);
begin
tmp2 <= (tmp xor voter_in);
ff_in <= not or_reduce(tmp2);

ff: process(clk, rst)
begin
    if(rst = '1') then
        ff_out <= '1';
    elsif(rising_edge(clk)) then
        ff_out <= ff_in;
    end if;
end process;

vot_out: process(ff_out, module)
begin
    if(ff_out = '1') then
        tmp <= module;
    else
        tmp <= std_logic_vector(to_signed(0, size));
    end if;
end process;
--tmp <= module and ff_out;
voter_out <= tmp;

end Behavioral;
