library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.NAND_pkg.all;
use work.AND2.all;
use work.OR2.all;

entity MUX2to1 is
  port(
    A   : in STD_LOGIC;
    B   : in STD_LOGIC;
    SEL : in STD_LOGIC;
    Y   : out STD_LOGIC
  );
end entity MUX2to1;

architecture Structural of MUX2to1 is
  signal nSEL, a1, b1: STD_LOGIC;
begin
  -- invert SEL
  INV: NAND2  port map(SEL, SEL, nSEL);
  -- A when SEL=0
  ANDa: AND2 port map(A, nSEL, a1);
  -- B when SEL=1
  ANDb: AND2 port map(B, SEL, b1);
  -- combine
  OUT:  OR2  port map(a1, b1, Y);
end architecture Structural;
