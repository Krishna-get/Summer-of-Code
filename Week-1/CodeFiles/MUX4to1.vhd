library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.MUX2to1.all;

entity MUX4to1 is
  port(
    D0   : in STD_LOGIC;
    D1   : in STD_LOGIC;
    D2   : in STD_LOGIC;
    D3   : in STD_LOGIC;
    SEL  : in STD_LOGIC_VECTOR(1 downto 0);
    Y    : out STD_LOGIC
  );
end entity MUX4to1;

architecture Structural of MUX4to1 is
  signal m0, m1: STD_LOGIC;
begin
  M0: MUX2to1 port map(A => D0, B => D1, SEL => SEL(0), Y => m0);
  M1: MUX2to1 port map(A => D2, B => D3, SEL => SEL(0), Y => m1);
  M2: MUX2to1 port map(A => m0, B => m1, SEL => SEL(1), Y => Y);
end architecture Structural;
