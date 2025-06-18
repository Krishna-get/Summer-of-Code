-- Full Subtractor (1-bit) using structural components (FullSub.vhd)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.XOR2.all;
use work.AND2.all;
use work.OR2.all;

entity FullSub is
  port(
    A, B, Bin : in STD_LOGIC;
    Diff, Bout: out STD_LOGIC
  );
end entity FullSub;

architecture Structural of FullSub is
  signal axb, notA, b_and_notA, axb_and_bin: STD_LOGIC;
begin
  U1: XOR2 port map(A, B, axb);
  U2: XOR2 port map(axb, Bin, Diff);
  -- Bout = (~A & B) or (Bin & ~ (A xor B))
  -- compute ~A
  INV1: NAND2 port map(A, A, notA);
  U3: AND2  port map(notA, B, b_and_notA);
  U4: AND2  port map(Bin, axb, axb_and_bin);
  U5: OR2   port map(b_and_notA, axb_and_bin, Bout);
end architecture Structural;
