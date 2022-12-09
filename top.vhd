----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/28/2022 11:24:09 PM
-- Design Name: 
-- Module Name: top - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    generic(n: integer :=6;
            size: integer:= 24);
    port(clk: in std_logic;
         rst: in std_logic;
         u: in std_logic_vector(size-1 downto 0);
         y: out std_logic_vector(size-1 downto 0));
--  Port ( );
end top;

architecture Behavioral of top is
type arr is array(0 to n-1) of std_logic_vector(size-1 downto 0);
signal module: arr;
signal voter_in: std_logic_vector(size-1 downto 0);
signal voter_out: std_logic_vector(n*size-1 downto 0);--arr
signal vot_tmp: std_logic_vector(n*size-1 downto 0);

attribute dont_touch : string;
attribute dont_touch of module : signal is "true";
attribute dont_touch of voter_in : signal is "true";
attribute dont_touch of voter_out : signal is "true";
--attribute dont_touch of u : signal is "true";
begin

modules: for i in 0 to n-1 generate
    one_mod: entity work.fixed_fir(Behavioral)
            port map(clk_i => clk,
                     u_i => u,
                     y_o => module(i));
end generate;

switches: for i in 0 to n-1 generate
    one_sw: entity work.switch(Behavioral)
            generic map (size => size)
            port map (clk => clk,
                      rst => rst,
                      module => module(i),
                      voter_in => voter_in,
                      voter_out => voter_out((i+1)*size-1 downto i*size)); --voter_out(i)
end generate;


voter: entity work.voter(Behavioral)
       generic map(n => n,
                   size => size)
       port map(clk => clk,
                rst => rst,
--                m1 => voter_out(0),--voter_out(23 downto 0),
--                m2 => voter_out(1),--(47 downto 24),
--                m3 => voter_out(2),--(71 downto 48),
--                m4 => voter_out(3),--(95 downto 72),
--                m5 => voter_out(4),--(119 downto 96),
                m_i => voter_out,
                v => voter_in);
                
y <= voter_in;


end Behavioral;
