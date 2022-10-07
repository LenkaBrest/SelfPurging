library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mac is
    Port ( clk_i : in STD_LOGIC;
           u_i : in STD_LOGIC_VECTOR (23 downto 0);
           b_i : in STD_LOGIC_VECTOR (23 downto 0);
           mac_i : in STD_LOGIC_VECTOR (47 downto 0);
           mac_o : out STD_LOGIC_VECTOR (47 downto 0));
end mac;

architecture Behavioral of mac is

-- Atributes that need to be defined so Vivado synthesizer maps appropriate
-- code to DSP cells
attribute use_dsp : string;
attribute use_dsp of Behavioral : architecture is "yes";

signal reg_s : STD_LOGIC_VECTOR(47 downto 0) := (others=>'0');

begin
    process(clk_i)
    begin
        if (clk_i'event and clk_i = '1') then
            reg_s <= mac_i;
        end if;
    end process;
    
    mac_o <= std_logic_vector(signed(reg_s) + (signed(u_i) * signed(b_i)));

end Behavioral;