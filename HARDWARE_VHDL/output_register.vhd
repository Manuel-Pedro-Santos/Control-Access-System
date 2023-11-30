LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity output_register is
  port (
    wreg : in std_logic;
    D : in std_logic_vector(3 downTo 0);
    Q : out std_logic_vector(3 downTo 0)
  );
end output_register;

architecture  behavioral of output_register is
  signal register_data : std_logic_vector(3 downTo 0);
begin
  process (wreg)
  begin
    if rising_edge(wreg) then
      register_data <= D;
    end if;
  end process;

  Q <= register_data;
end architecture behavioral;

