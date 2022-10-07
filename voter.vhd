----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/28/2022 10:46:46 PM
-- Design Name: 
-- Module Name: voter - Behavioral
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
--use ieee.STD_LOGIC_UNSIGNED.all;
 --use IEEE.std_logic_arith.all;
 use IEEE.numeric_std.all;
-- use IEEE.math_real.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity voter is
    generic(n: integer :=5;
            size: integer :=24);
    port(m1: in std_logic_vector(size-1 downto 0);
         m2: in std_logic_vector(size-1 downto 0);
         m3: in std_logic_vector(size-1 downto 0);
         m4: in std_logic_vector(size-1 downto 0);
         m5: in std_logic_vector(size-1 downto 0);
         v: out std_logic_vector(size-1 downto 0));
--  Port ( );
end voter;

architecture Behavioral of voter is

-- Atributes that need to be defined so Vivado synthesizer maps appropriate
-- code to DSP cells
attribute use_dsp : string;
attribute use_dsp of Behavioral : architecture is "yes";

signal m, ms: std_logic_vector(n*size-1 downto 0);
signal tmp: std_logic_vector(size-1 downto 0);

begin
    gen_m: process(m1, m2, m3, m4, m5)
    begin
        for i in 0 to size-1 loop
            m(i*n) <= m1(i);
            m(i*n+1) <= m2(i);
            m(i*n+2) <= m3(i);
            m(i*n+3) <= m4(i);
            m(i*n+4) <= m5(i);
        end loop;
    end process;
    --m <= (m1 & m2 & m3 & m4 & m5);
    
    sort: entity work.sort(Behavioral)
            generic map (n=>n,
                        size=>size)
            port map(row_in => m,
                     row_out => ms);
                     
    --sum <= to_integer(unsigned'('0'&m1)) + to_integer(unsigned'('0'& m2)) + to_integer(unsigned'('0'&m3)) + to_integer(unsigned'('0'&m4)) + to_integer(unsigned'('0'&m5)) + 2*(to_integer(unsigned'('0'&ms(1))) + to_integer(unsigned'('0'&ms(2))) + to_integer(unsigned'('0'&ms(3))) + to_integer(unsigned'('0'&ms(4))) + to_integer(unsigned'('0'&ms(5))));
     output: process(m,ms)
     variable sum: integer;
     begin
        for i in 0 to size-1 loop
            sum := to_integer(unsigned'('0'&m(i*n))) + to_integer(unsigned'('0'& m(i*n+1))) + to_integer(unsigned'('0'&m(i*n+2))) + 
                   to_integer(unsigned'('0'&m(i*n+3))) + to_integer(unsigned'('0'&m(i*n+4))) +
                    2*(to_integer(unsigned'('0'&ms(i*n))) + to_integer(unsigned'('0'&ms(i*n+1))) + to_integer(unsigned'('0'&ms(i*n+2))) + 
                    to_integer(unsigned'('0'&ms(i*n+3))) + to_integer(unsigned'('0'&ms(i*n+4))));
            --sum <= to_integer(unsigned'('0'&m(15)));
            if sum > n then
                tmp(i) <=  '1';
            else
                tmp(i) <=  '0';
            end if;
        end loop;

     end process;
    v <= tmp;
end Behavioral;
