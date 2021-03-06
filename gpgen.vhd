LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Generates the Internal g & p signals from the inputs
-- This is also called Pre processing

entity gpgen is
  port(  a, b: in bit;
			g, p: out bit );
end gpgen;

Architecture Arch of	gpgen is

   component XOR_2input is
		port (	in1, in2: in bit;
					output: out bit );
		end component;
		
	 component and_2input is
		port (	in1, in2: in bit; 
					output: out bit );	
	end component;
	
	begin 
	Ggen : and_2input port map (in1 => a, in2 => b, output => g);
	Pgen : XOR_2input port map (in1 => a, in2 => b, output => p);

end Arch;