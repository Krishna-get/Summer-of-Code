-- NAND2 entity and architecture (NAND2.vhd)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.NAND_pkg.all;

entity NAND2 is
  port(
    A : in STD_LOGIC;
    B : in STD_LOGIC;
    Y : out STD_LOGIC
  );
end entity NAND2;

architecture Behavioral of NAND2 is
begin
  Y <= not (A and B);
end architecture Behavioral;
