library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.AND2.all;
use work.OR2.all;

entity Majority5 is
  port(
    A, B, C, D, E : in STD_LOGIC;
    Y             : out STD_LOGIC
  );
end entity Majority5;

architecture Structural of Majority5 is
  -- intermediate signals
  signal AB, AC, AD, AE, BC, BD, BE, CD, CE, DE : STD_LOGIC;
  signal ABC, ABD, ABE, ACD, ACE, ADE, BCD, BCE, BDE, CDE : STD_LOGIC;
  signal or1, or2, or3, or4, or5, or6, or7, or8 : STD_LOGIC;
begin
  -- pairwise ANDs
  P1: AND2 port map(A, B, AB);
  P2: AND2 port map(A, C, AC);
  P3: AND2 port map(A, D, AD);
  P4: AND2 port map(A, E, AE);
  P5: AND2 port map(B, C, BC);
  P6: AND2 port map(B, D, BD);
  P7: AND2 port map(B, E, BE);
  P8: AND2 port map(C, D, CD);
  P9: AND2 port map(C, E, CE);
  P10:AND2 port map(D, E, DE);

  -- triples
  T1: AND2 port map(AB, C, ABC);
  T2: AND2 port map(AB, D, ABD);
  T3: AND2 port map(AB, E, ABE);
  T4: AND2 port map(AC, D, ACD);
  T5: AND2 port map(AC, E, ACE);
  T6: AND2 port map(AD, E, ADE);
  T7: AND2 port map(BC, D, BCD);
  T8: AND2 port map(BC, E, BCE);
  T9: AND2 port map(BD, E, BDE);
  T10:AND2 port map(CD, E, CDE);

  -- OR of all triples
  O1: OR2 port map(ABC, ABD, or1);
  O2: OR2 port map(ABE, ACD, or2);
  O3: OR2 port map(ACE, ADE, or3);
  O4: OR2 port map(BCD, BCE, or4);
  O5: OR2 port map(or1, or2, or5);
  O6: OR2 port map(or3, or4, or6);
  O7: OR2 port map(or5, or6, or7);
  O8: OR2 port map(or7, BDE, or8);
  O9: OR2 port map(or8, CDE, Y);
end architecture Structural;
