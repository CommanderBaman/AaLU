
LIBRARY ieee;
USE ieee.std_logic_1164.all;  
entity Get1Complement is
	-- decides whether to do 2s complement of the number or not
	-- if toSubtract is 1, we need to take 2s complement otherwise we don't need to
	port(
		invec    : IN bit_vector(15 downto 0);
		toSubtract: in bit; 
		outvec    : out bit_vector(15 downto 0); 
		carry: out bit
	);
end Get1Complement;

architecture Get1ComplementLogic of Get1Complement is 
	-- using XOR gate to decide
	component XOR_2input is
		port (
			in1, in2: in bit; 
			output: out bit 
		);
	end component;
	begin
	-- writing logic 
	carry <= toSubtract;
	
	lab:
	
	FOR i IN 0 TO 15 GENERATE
	XORGate : XOR_2input port map (in1 => invec(i), in2 => toSubtract, output => outvec(i));
	END GENERATE;
	
	
end Get1ComplementLogic;