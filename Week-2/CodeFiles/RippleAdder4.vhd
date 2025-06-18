-- 4-bit Ripple Carry Adder (RippleAdder4.vhd)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.FullAdder.all;

entity RippleAdder4 is
  port(
    A, B   : in STD_LOGIC_VECTOR(3 downto 0);
    Cin    : in STD_LOGIC;
    Sum    : out STD_LOGIC_VECTOR(3 downto 0);
    Cout   : out STD_LOGIC
  );
end entity RippleAdder4;

architecture Structural of RippleAdder4 is
  signal c1, c2, c3: STD_LOGIC;
begin
  FA0: FullAdder port map(A(0), B(0), Cin,  Sum(0), c1);
  FA1: FullAdder port map(A(1), B(1), c1,   Sum(1), c2);
  FA2: FullAdder port map(A(2), B(2), c2,   Sum(2), c3);
  FA3: FullAdder port map(A(3), B(3), c3,   Sum(3), Cout);
end architecture Structural;
