-- Gates package (Gates.vhd): declares NAND2 primitive and other gates built from NAND2
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package Gates is
  -- Basic NAND primitive
  component NAND_2 is
    port(
      A : in STD_LOGIC;
      B : in STD_LOGIC;
      Y : out STD_LOGIC
    );
  end component;

  -- AND using NAND2
  component and_nand is
    port(
      A : in STD_LOGIC;
      B : in STD_LOGIC;
      Y : out STD_LOGIC
    );
  end component;

  -- OR using NAND2
  component or_nand is
    port(
      A : in STD_LOGIC;
      B : in STD_LOGIC;
      Y : out STD_LOGIC
    );
  end component;

  -- XOR using NAND2
  component xor_nand is
    port(
      A : in STD_LOGIC;
      B : in STD_LOGIC;
      Y : out STD_LOGIC
    );
  end component;
end package Gates;

-- NAND2 implementation
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Gates.all;

entity NAND_2 is
  port(
    A : in STD_LOGIC;
    B : in STD_LOGIC;
    Y : out STD_LOGIC
  );
end entity NAND_2;

architecture Behavioral of NAND_2 is
begin
  Y <= not (A and B);
end architecture Behavioral;

-- and_nand implementation: Y = A and B via NAND2
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Gates.all;

entity and_nand is
  port(
    A : in STD_LOGIC;
    B : in STD_LOGIC;
    Y : out STD_LOGIC
  );
end entity and_nand;

architecture Structural of and_nand is
  signal w: STD_LOGIC;
begin
  U1: NAND_2 port map(A => A, B => B, Y => w);
  U2: NAND_2 port map(A => w, B => w, Y => Y);
end architecture Structural;

-- or_nand implementation: Y = A or B via NAND2
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Gates.all;

entity or_nand is
  port(
    A : in STD_LOGIC;
    B : in STD_LOGIC;
    Y : out STD_LOGIC
  );
end entity or_nand;

architecture Structural of or_nand is
  signal nA, nB: STD_LOGIC;
begin
  U1: NAND_2 port map(A => A, B => A, Y => nA);
  U2: NAND_2 port map(A => B, B => B, Y => nB);
  U3: NAND_2 port map(A => nA, B => nB, Y => Y);
end architecture Structural;

-- xor_nand implementation: Y = A xor B via NAND2
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Gates.all;

entity xor_nand is
  port(
    A : in STD_LOGIC;
    B : in STD_LOGIC;
    Y : out STD_LOGIC
  );
end entity xor_nand;

architecture Structural of xor_nand is
  signal w1, w2, w3: STD_LOGIC;
begin
  U1: NAND_2 port map(A => A, B => B, Y => w1);
  U2: NAND_2 port map(A => A, B => w1, Y => w2);
  U3: NAND_2 port map(A => B, B => w1, Y => w3);
  U4: NAND_2 port map(A => w2, B => w3, Y => Y);
end architecture Structural;
