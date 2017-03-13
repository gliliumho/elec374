library IEEE;
use IEEE.std_logic_1164.all;


entity cla_4bit is
   PORT
   (
    x   : in std_logic_vector(3 downto 0);
    y   : in std_logic_vector(3 downto 0);
    cin : in std_logic;

    sum : out std_logic_vector(3 downto 0);
    gout: out std_logic;
    pout: out std_logic;
    cout: out std_logic
   );
END entity;

-----------------------------------------------------

architecture arch of cla_4bit is

component part_adder
port (
    x   : in std_logic;
    y   : in std_logic;
    cin : in std_logic;

    sum : out std_logic;
    g   : out std_logic;
    p   : out std_logic
);
end component;

signal c1, c2, c3 : std_logic;
signal p, g : std_logic_vector(3 downto 0);

begin
PA0: part_adder port map(x(0), y(0), cin, sum(0), g(0), p(0));
PA1: part_adder port map(x(1), y(1), c1, sum(1), g(1), p(1));
PA2: part_adder port map(x(2), y(2), c2, sum(2), g(2), p(2));
PA3: part_adder port map(x(3), y(3), c3, sum(3), g(3), p(3));

pout <= p(3) and p(2) and p(1) and p(0);
gout <= g(3) or (p(3) and g(2)) or (p(3) and p(2) and g(1)) or (p(3) and p(2) and p(1) and g(0));


c1 <= g(0) or (p(0) and cin);
c2 <= g(1) or (p(1) and g(0)) or (p(1) and p(0) and cin);
c3 <= g(2) or (p(2) and g(1)) or (p(2) and p(1) and g(0)) or (p(2) and p(1) and p(0) and cin);
cout <= g(3) or (p(3) and g(2)) or (p(3) and p(2) and g(1)) or (p(3) and p(2) and p(1) and g(0)) or (p(3) and p(2) and p(1) and p(0) and cin);

end architecture;
