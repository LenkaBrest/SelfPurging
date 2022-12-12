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
 use IEEE.MATH_REAL.ALL;
use ieee.std_logic_unsigned.all;
use work.utils_pkg.all;
-- use IEEE.math_real.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity voter is
    generic(n: integer :=3;
            size: integer :=24);
    port(clk: in std_logic;
         rst: in std_logic;
         --m1: in std_logic_vector(size-1 downto 0);
         --m2: in std_logic_vector(size-1 downto 0);
         --m3: in std_logic_vector(size-1 downto 0);
         --m4: in std_logic_vector(size-1 downto 0);
         --m5: in std_logic_vector(size-1 downto 0);
         m_i: std_logic_vector(n*size-1 downto 0);
         v: out std_logic_vector(size-1 downto 0));
--  Port ( );
end voter;

architecture Behavioral of voter is

-- Atributes that need to be defined so Vivado synthesizer maps appropriate
-- code to DSP cells
--attribute use_dsp : string;
--attribute use_dsp of Behavioral : architecture is "yes";

signal m, ms: std_logic_vector(n*size-1 downto 0);
signal tmp: std_logic_vector(size-1 downto 0);

type state_type is (idle, for_l, end_state);
signal state_reg, state_reg_s, state_next: state_type;

signal k_reg, k_next: std_logic_vector(size-1 downto 0);
type sum_t is array (0 to size-1) of std_logic_vector(log2c(3*n)-1 downto 0);
signal sum_s: sum_t;
--type adder_array is array (0 to n-1) of std_logic_Vector(size-1 downto 0);
--signal voter_adder_array: adder_a
--type sum_type is array (0 to size-1) of std_logic_vector(7 downto 0);
--signal sum: sum_type;

begin
--    state_reg_s <= state_reg;
    
--    clk_proc: process(clk)
--    begin
--            if (clk'event and clk = '1') then
--                if rst = '1' then
--                    state_reg <= idle;
--                    k_reg <= (others => '0');
--                else
--                    state_reg <= state_next;
--                    k_reg <= k_next;
--                end if;
--            end if;
--    end process;
    
--    gen_m: process(m1, m2, m3, m4, m5)
--    begin
--        for i in 0 to size-1 loop
--            m(i*n) <= m1(i);
--            m(i*n+1) <= m2(i);
--            m(i*n+2) <= m3(i);
--            m(i*n+3) <= m4(i);
--            m(i*n+4) <= m5(i);
--        end loop;
--    end process;
    --m <= (m1 & m2 & m3 & m4 & m5);
    
--    sort: entity work.sort(Behavioral)
--            generic map (n=>n,
--                        size=>size)
--            port map(row_in => m,
--                     row_out => ms);
                     
    --sum <= to_integer(unsigned'('0'&m1)) + to_integer(unsigned'('0'& m2)) + to_integer(unsigned'('0'&m3)) + to_integer(unsigned'('0'&m4)) + to_integer(unsigned'('0'&m5)) + 2*(to_integer(unsigned'('0'&ms(1))) + to_integer(unsigned'('0'&ms(2))) + to_integer(unsigned'('0'&ms(3))) + to_integer(unsigned'('0'&ms(4))) + to_integer(unsigned'('0'&ms(5))));
     output: process(m_i)
     variable sum: integer;
     variable cnt: integer := 0;
     
     begin
--        tmp <= (others => '0');
--        state_next <= state_reg;
--        k_next <= k_reg;
        
--        case state_reg is
--            when idle => 
--                k_next <= (others=>'0');
--                state_next <= for_l;
--            when for_l =>
--                sum := to_integer(unsigned'('0'&m(to_integer(unsigned(k_reg))*n))) + to_integer(unsigned'('0'& m(to_integer(unsigned(k_reg))*n+1))) + to_integer(unsigned'('0'&m(to_integer(unsigned(k_reg))*n+2))) + 
--                   to_integer(unsigned'('0'&m(to_integer(unsigned(k_reg))*n+3))) + to_integer(unsigned'('0'&m(to_integer(unsigned(k_reg))*n+4))) +
--                    (to_integer(unsigned'(ms(to_integer(unsigned(k_reg))*n)&'0')) + to_integer(unsigned'(ms(to_integer(unsigned(k_reg))*n+1)&'0')) + to_integer(unsigned'(ms(to_integer(unsigned(k_reg))*n+2)&'0')) + 
--                    to_integer(unsigned'(ms(to_integer(unsigned(k_reg))*n+3)&'0')) + to_integer(unsigned'(ms(to_integer(unsigned(k_reg))*n+4)&'0')));
       --if (rising_edge(clk))then
       --ms <= m_i;
        for i in 0 to size-1 loop
--            cnt := 0;
--            for j in 0 to n-1 loop
--                if m(i*n+j) = '1' then
--                    cnt := cnt + 1;
--                end if;
--            end loop;
            for j in 0 to n-1 loop
                sum := sum + to_integer(unsigned'('0'&m_i(i+j*size))) + to_integer(unsigned'(m_i(i+j*size)&'0'));
            end loop;
            --sum := to_integer(unsigned'('0'&m_i(i*n))) + to_integer(unsigned'('0'& m_i(i*n+size))) + to_integer(unsigned'('0'&m_i(i*n+2*size))) + 
              --     to_integer(unsigned'('0'&m_i(i*n+3*size))) + to_integer(unsigned'('0'&m_i(i*n+4*size))) +
                --    (to_integer(unsigned'(m_i(i*n)&'0')) + to_integer(unsigned'(m_i(i*n+size)&'0')) + to_integer(unsigned'(m_i(i*n+2*size)&'0')) + 
                  --  to_integer(unsigned'(m_i(i*n+3*size)&'0')) + to_integer(unsigned'(m_i(i*n+4*size)&'0')));
            --sum <= to_integer(unsigned'('0'&m(15)));
--           sum := 3*cnt;
            sum_s(i) <= std_logic_vector(to_unsigned(sum, log2c(3*n)));
           
--                if sum_s(i) > n then
--                    tmp(i) <=  '1';
--                else
--                    tmp(i) <=  '0';
--                end if;
                sum := 0;
--                k_next <= k_reg + 1;
--                state_next <= end_state;
--           when end_state =>
--                if k_reg = size-1 then
--                    state_next <= idle;
--                else
--                    state_next <= for_l;
--                end if;
        end loop;
--        end case;
    --end if;
     end process;
     tmp_gen: process(sum_s)
     begin
        for i in 0 to size-1 loop
            if sum_s(i) > n then
                tmp(i) <=  '1';
            else
                tmp(i) <=  '0';
            end if;
        end loop;
     end process;
    v <= tmp;
end Behavioral;
