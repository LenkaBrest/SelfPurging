----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/28/2022 10:29:31 PM
-- Design Name: 
-- Module Name: sort - Behavioral
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

entity sort is
    generic(n: integer:=5;
            size: integer:=24);
    port(row_in: in std_logic_vector(n*size-1 downto 0);
         row_out: out std_logic_vector(n*size-1 downto 0));
--  Port ( );
end sort;

architecture Behavioral of sort is
signal tmp: std_logic;
begin

sort: process(row_in, tmp)
begin
    for j in 0 to size-1 loop
        for i in 0 to n-2 loop
            if(row_in(j*n+i) > row_in(j*n+i+1)) then
                tmp <= row_in(j*n+i+1);
                row_out(j*n+i+1) <= row_in(j*n+i);
                row_out(j*n+i) <= tmp;
            else
                row_out(j*n+i) <= row_in(j*n+i);
                row_out(j*n+i+1) <= row_in(j*n+i+1); 
            end if;
        end loop;
    end loop;
end process;


end Behavioral;
