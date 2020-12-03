library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench is
end testbench;

architecture tb of testbench is

signal A,B,S:bit_vector(15 downto 0);
signal z,s0,s1:bit;

component ALU is
   Port(  A    : IN bit_vector(15 downto 0);  
		    B    : IN bit_vector(15 downto 0);
			 Select0, Select1: in bit; 
			 Sum    : out bit_vector(15 downto 0); 
			 Zero: out bit
			);
end component;


begin 
dut_instance:ALU
port map(A=>A,B=>B,Sum=>S,zero => z, Select0=>s0, Select1 => s1);

process
begin

S0 <= '1';
S1 <= '1';
A<="0000000010000000";
B<="0000000010000000";

wait for 5 ns;

end process;
end tb;