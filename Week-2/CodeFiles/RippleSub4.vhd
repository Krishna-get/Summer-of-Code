-- 4-bit Ripple Borrow Subtractor (RippleSub4.vhd)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.FullSub.all;

entity RippleSub4 is
  port(
    A, B   : in STD_LOGIC_VECTOR(3 downto 0);
    Bin    : in STD_LOGIC;
    Diff   : out STD_LOGIC_VECTOR(3 downto 0);
    Bout   : out STD_LOGIC
  );
end entity RippleSub4;

architecture Structural of RippleSub4 is
  signal b1, b2, b3: STD_LOGIC;
begin
  FS0: FullSub port map(A(0), B(0), Bin,  Diff(0), b1);
  FS1: FullSub port map(A(1), B(1), b1,   Diff(1), b2);
  FS2: FullSub port map(A(2), B(2), b2,   Diff(2), b3);
  FS3: FullSub port map(A(3), B(3), b3,   Diff(3), Bout);
end architecture Structural;
