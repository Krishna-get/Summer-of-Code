library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.NAND_pkg.all;

entity OR2 is
  port(
    A : in STD_LOGIC;
    B : in STD_LOGIC;
    Y : out STD_LOGIC
  );
end entity OR2;

architecture Structural of OR2 is
  signal nA, nB: STD_LOGIC;
begin
  U1: NAND2 port map(A, A, nA);
  U2: NAND2 port map(B, B, nB);
  U3: NAND2 port map(nA, nB, Y);
end architecture Structural;
