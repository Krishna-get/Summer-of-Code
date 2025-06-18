library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.NAND_pkg.all;

entity XOR2 is
  port(
    A : in STD_LOGIC;
    B : in STD_LOGIC;
    Y : out STD_LOGIC
  );
end entity XOR2;

architecture Structural of XOR2 is
  signal w1, w2, w3: STD_LOGIC;
begin
  U1: NAND2 port map(A, B, w1);
  U2: NAND2 port map(A, w1, w2);
  U3: NAND2 port map(B, w1, w3);
  U4: NAND2 port map(w2, w3, Y);
end architecture Structural;
