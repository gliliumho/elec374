library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity cla_16bit is
   PORT
   (
    x   : in std_logic_vector(15 downto 0);
    y   : in std_logic_vector(15 downto 0);
    cin : in std_logic;

    sum : out std_logic_vector(15 downto 0);
    gout: out std_logic;
    pout: out std_logic;
    cout: out std_logic
   );
END entity;

-----------------------------------------------------

architecture arch of cla_16bit is

component cla_4bit
port (
    x   : in std_logic_vector(3 downto 0);
    y   : in std_logic_vector(3 downto 0);
    cin : in std_logic;

    sum : out std_logic_vector(3 downto 0);
    gout: out std_logic;
    pout: out std_logic;
    cout: out std_logic
);
end component;

signal c4, c8, c12 : std_logic;
signal p, g : std_logic_vector(3 downto 0);

begin
CLA0: cla_4bit port map(x(3 downto 0), y(3 downto 0), cin, sum(3 downto 0), g(0), p(0));
CLA1: cla_4bit port map(x(7 downto 4), y(7 downto 4), c4, sum(7 downto 4), g(1), p(1));
CLA2: cla_4bit port map(x(11 downto 8), y(11 downto 8), c8, sum(11 downto 8), g(2), p(2));
CLA3: cla_4bit port map(x(15 downto 12), y(15 downto 12), c12, sum(15 downto 12), g(3), p(3));

pout <= p(3) and p(2) and p(1) and p(0);
gout <= g(3) or (p(3) and g(2)) or (p(3) and p(2) and g(1)) or (p(3) and p(2) and p(1) and g(0));


c4 <= g(0) or (p(0) and cin);
c8 <= g(1) or (p(1) and g(0)) or (p(1) and p(0) and cin);
c12 <= g(2) or (p(2) and g(1)) or (p(2) and p(1) and g(0)) or (p(2) and p(1) and p(0) and cin);
cout <= g(3) or (p(3) and g(2)) or (p(3) and p(2) and g(1)) or (p(3) and p(2) and p(1) and g(0)) or (p(3) and p(2) and p(1) and p(0) and cin);

end architecture;
