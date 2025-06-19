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

  -- 4-to-1 MUX using two 2-to-1 MUX
  component mux_4to1_nand is
    port(
      D0  : in STD_LOGIC;
      D1  : in STD_LOGIC;
      D2  : in STD_LOGIC;
      D3  : in STD_LOGIC;
      SEL : in STD_LOGIC_VECTOR(1 downto 0);
      Y   : out STD_LOGIC
    );
  end component;

  -- 1-bit Full Adder using NAND_2-based gates
  component full_adder_nand is
    port(
      A, B, Cin : in STD_LOGIC;
      Sum, Cout : out STD_LOGIC
    );
  end component;

  -- 1-bit Full Subtractor using NAND_2-based gates
  component full_sub_nand is
    port(
      A, B, Bin  : in STD_LOGIC;
      Diff, Bout : out STD_LOGIC
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

-- mux_2to1_nand implementation
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
  OUT1: or_nand   port map(A => w1, B => w2, Y => Y);
end architecture Structural;

-- mux_4to1_nand implementation
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Gates.all;

entity mux_4to1_nand is
  port(
    D0  : in STD_LOGIC;
    D1  : in STD_LOGIC;
    D2  : in STD_LOGIC;
    D3  : in STD_LOGIC;
    SEL : in STD_LOGIC_VECTOR(1 downto 0);
    Y   : out STD_LOGIC
  );
end entity mux_4to1_nand;

architecture Structural of mux_4to1_nand is
  signal m0, m1: STD_LOGIC;
begin
  M0: mux_2to1_nand port map(A => D0, B => D1, SEL => SEL(0), Y => m0);
  M1: mux_2to1_nand port map(A => D2, B => D3, SEL => SEL(0), Y => m1);
  M2: mux_2to1_nand port map(A => m0, B => m1, SEL => SEL(1), Y => Y);
end architecture Structural;

-- full_adder_nand implementation
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Gates.all;

entity full_adder_nand is
  port(
    A, B, Cin : in STD_LOGIC;
    Sum, Cout : out STD_LOGIC
  );
end entity full_adder_nand;

architecture Structural of full_adder_nand is
  signal axb, a_and_b, axb_and_c: STD_LOGIC;
begin
  U1: xor_nand port map(A => A, B => B, Y => axb);
  U2: xor_nand port map(A => axb, B => Cin, Y => Sum);
  U3: and_nand port map(A => A, B => B, Y => a_and_b);
  U4: and_nand port map(A => axb, B => Cin, Y => axb_and_c);
  U5: or_nand  port map(A => a_and_b, B => axb_and_c, Y => Cout);
end architecture Structural;

-- full_sub_nand implementation
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Gates.all;

entity full_sub_nand is
  port(
    A, B, Bin  : in STD_LOGIC;
    Diff, Bout : out STD_LOGIC
  );
end entity full_sub_nand;

architecture Structural of full_sub_nand is
  signal axb, notA, b_and_notA, axb_and_bin: STD_LOGIC;
begin
  U1: xor_nand port map(A => A, B => B, Y => axb);
  U2: xor_nand port map(A => axb, B => Bin, Y => Diff);
  -- notA via NAND
  INV: NAND_2 port map(A => A, B => A, Y => notA);
  U3: and_nand port map(A => notA, B => B, Y => b_and_notA);
  U4: and_nand port map(A => Bin, B => axb, Y => axb_and_bin);
  U5: or_nand  port map(A => b_and_notA, B => axb_and_bin, Y => Bout);
end architecture Structural;
