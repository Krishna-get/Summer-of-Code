library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.NAND_pkg.all;

entity AND2 is
  port(
    A : in STD_LOGIC;
    B : in STD_LOGIC;
    Y : out STD_LOGIC
  );
end entity AND2;

architecture Structural of AND2 is
  signal w: STD_LOGIC;
begin
  U1: NAND2 port map(A, B, w);
  U2: NAND2 port map(w, w, Y);
end architecture Structural;
