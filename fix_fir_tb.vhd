library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;
use work.txt_util.all;

entity fix_fir_tb is
--  Port ( );
end fix_fir_tb;

architecture Behavioral of fix_fir_tb is
    constant n : integer :=5;
    constant size : integer := 24;
    signal clk_s : std_logic;
    signal rst_s : std_logic;
    signal uut_input_s : std_logic_vector(23 downto 0);
    signal uut_output_s : std_logic_vector(23 downto 0);

    constant per_c : time := 20ns;
    --putanju do željenog fajla je potrebno prilagoditi strukturi direktorijuma na ra�?unaru na kome se vrši provera rada.
    file input_test_vector : text open read_mode is "D:\Documents\Master\DSONO\dizajn_fajlovi\fixed_fir\matlab\input.txt";
    file output: text open write_mode is "D:\Documents\Master\DSONO\dizajn_fajlovi\fixed_fir\matlab\output_stuckat.txt";
begin
    fir_under_test:
    entity work.top(Behavioral)
    generic map(n => n,
                size => size)
    port map(clk=>clk_s,
             rst=>rst_s,
             u=>uut_input_s,
             y=>uut_output_s);
             
    clk_process:
    process
    begin
        clk_s <= '0';
        wait for per_c/2;
        clk_s <= '1';
        wait for per_c/2;
        print(output, hstr(uut_output_s));
    end process;
    
    rst_process: process
    begin
        rst_s <= '0', '1' after per_c/8, '0' after per_c/4;
        wait;
    end process;
    
    stim_process:
    process
        variable tv : line;
    begin
        uut_input_s <= (others=>'0');
        wait until falling_edge(clk_s);
        --ulaz za filtriranje
        while not endfile(input_test_vector) loop
            readline(input_test_vector,tv);
            uut_input_s <= to_std_logic_vector(string(tv));
            wait until falling_edge(clk_s);
        end loop;
        report "verification done!" severity failure;
    end process;

end Behavioral;
