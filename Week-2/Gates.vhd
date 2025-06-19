-- Gates package (Gates.vhd): declares NAND_2 primitive and gates built from NAND_2
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

  -- AND using NAND_2
  component and_nand is
    port(
      A : in STD_LOGIC;
      B : in STD_LOGIC;
      Y : out STD_LOGIC
    );
  end component;

  -- OR using NAND_2
  component or_nand is
    port(
      A : in STD_LOGIC;
      B : in STD_LOGIC;
      Y : out STD_LOGIC
    );
  end component;

  -- XOR using NAND_2
  component xor_nand is
    port(
      A : in STD_LOGIC;
      B : in STD_LOGIC;
      Y : out STD_LOGIC
    );
  end component;

  -- 2-to-1 MUX using NAND_2-based gates
  component mux_2to1_nand is
    port(
      A   : in STD_LOGIC;
      B   : in STD_LOGIC;
      SEL : in STD_LOGIC;
      Y   : out STD_LOGIC
    );
  end component;
end package Gates;

-- NAND_2 implementation
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

-- and_nand implementation
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

-- or_nand implementation
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

-- xor_nand implementation
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

-- mux_2to1_nand implementation using and_nand and or_nand
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Gates.all;

entity mux_2to1_nand is
  port(
    A   : in STD_LOGIC;
    B   : in STD_LOGIC;
    SEL : in STD_LOGIC;
    Y   : out STD_LOGIC
  );
end entity mux_2to1_nand;

architecture Structural of mux_2to1_nand is
  signal nSEL, w1, w2: STD_LOGIC;
begin
  INV1: NAND_2 port map(A => SEL, B => SEL, Y => nSEL);
  A1: and_nand port map(A => A, B => nSEL, Y => w1);
  B1: and_nand port map(A => B, B => SEL, Y => w2);
  OUT1: or_nand port map(A => w1, B => w2, Y => Y);
end architecture Structural;
