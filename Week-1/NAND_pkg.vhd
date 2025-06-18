-- NAND gate package (NAND_pkg.vhd)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package NAND_pkg is
  component NAND2
    port(
      A : in STD_LOGIC;
      B : in STD_LOGIC;
      Y : out STD_LOGIC
    );
  end component;
end package NAND_pkg;
