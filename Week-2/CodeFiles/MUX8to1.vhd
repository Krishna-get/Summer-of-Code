-- 8-to-1 MUX using MUX4to1 and MUX2to1 (MUX8to1.vhd)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.MUX4to1.all;
use work.MUX2to1.all;

entity MUX8to1 is
  port(
    D    : in STD_LOGIC_VECTOR(7 downto 0);
    SEL  : in STD_LOGIC_VECTOR(2 downto 0);
    Y    : out STD_LOGIC
  );
end entity MUX8to1;

architecture Structural of MUX8to1 is
  signal m_low, m_high: STD_LOGIC;
begin
  M4L: MUX4to1 port map(D0 => D(3), D1 => D(2), D2 => D(1), D3 => D(0), SEL => SEL(1 downto 0), Y => m_low);
  M4H: MUX4to1 port map(D0 => D(7), D1 => D(6), D2 => D(5), D3 => D(4), SEL => SEL(1 downto 0), Y => m_high);
  M2:  MUX2to1 port map(A => m_low, B => m_high, SEL => SEL(2), Y => Y);
end architecture Structural;
