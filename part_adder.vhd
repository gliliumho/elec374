library IEEE;
use IEEE.std_logic_1164.all;


entity part_adder is
   PORT
   (
    x   : in std_logic;
    y   : in std_logic;
    cin : in std_logic;

    sum : out std_logic;
    g   : out std_logic;
    p   : out std_logic
   );
END entity;

-----------------------------------------------------

architecture arch of part_adder is
begin
    sum <= x xor y;
    g <= x and y;
    p <= x or y;

end architecture;
