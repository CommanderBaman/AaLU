LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- This entity finds the 1's Complement of the vector B if toSubtract = 1, i.e. if we want Subtraction
-- Otherwise, it passes B as it is
entity Get1Complement is
	port( invec     : in bit_vector(15 downto 0);	-- Vector B
			toSubtract: in bit; 								-- Instruction
			outvec    : out bit_vector(15 downto 0);	-- New vector, B or its 1's Complement
			carry     : out bit );							-- Initial carry
end Get1Complement;

architecture Get1ComplementLogic of Get1Complement is 
	-- using XOR gate to decide
	component XOR_2input is
		port ( 	in1, in2: in bit; 
					output: out bit );
	end component;
	
	begin
	-- Logic 
		carry <= toSubtract; -- Initial carry = 1 if toSubtract = 1
		lab:
			FOR i IN 0 TO 15 GENERATE
				XORGate : XOR_2input port map (in1 => invec(i), in2 => toSubtract, output => outvec(i));
			END GENERATE;
	
end Get1ComplementLogic;

-- After finding the 1's Complement, we pass the Initial Carry as 1
-- This effectively results in addition of A and B's 2's Complement