-- Full Adder (1-bit) using structural components (FullAdder.vhd)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.XOR2.all;
use work.AND2.all;
use work.OR2.all;

entity FullAdder is
  port(
    A, B, Cin : in STD_LOGIC;
    Sum, Cout : out STD_LOGIC
  );
end entity FullAdder;

architecture Structural of FullAdder is
  signal axb, a_and_b, axb_and_c: STD_LOGIC;
begin
  U1: XOR2 port map(A, B, axb);
  U2: XOR2 port map(axb, Cin, Sum);
  U3: AND2 port map(A, B, a_and_b);
  U4: AND2 port map(axb, Cin, axb_and_c);
  U5: OR2  port map(a_and_b, axb_and_c, Cout);
end architecture Structural;
