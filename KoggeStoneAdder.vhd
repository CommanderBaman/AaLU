LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- This is the Fast Kogge Stone Adder
entity KoggeStoneAdder is
	port (	A    				: IN bit_vector(15 downto 0);		-- Input vector A
				B    				: IN bit_vector(15 downto 0);		-- Input vector B
				toXOR, toNAND	: in bit;								-- Instructions
				initialCarry	: in bit;								-- Initial carry
				Carryout 		: out bit;								-- Output carry bit
				Sum				: out bit_vector(15 downto 0) );	-- Output vector S
end KoggeStoneAdder;

architecture KoggeStoneAdderLogic of KoggeStoneAdder is 
	-- Vector that stores the 17 carry bits
	SIGNAL C :  bit_vector(16 downto 0); 

	-- Internal individual g, p signals
	SIGNAL g_in : bit_vector(15 downto 0);
	SIGNAL p_in : bit_vector(15 downto 0);

	-- Output g, p signals of each KS stage
	-- Stage 01
		SIGNAL g_1 : bit_vector(15 downto 0);
		SIGNAL p_1 : bit_vector(15 downto 0);
	-- Stage 02
		SIGNAL g_2 : bit_vector(15 downto 0);
		SIGNAL p_2 : bit_vector(15 downto 0);
	-- Stage 03
		SIGNAL g_3 : bit_vector(15 downto 0);
		SIGNAL p_3 : bit_vector(15 downto 0);
	-- Stage 04
		SIGNAL g_4 : bit_vector(15 downto 0);
		SIGNAL p_4 : bit_vector(15 downto 0);

	SIGNAL temp0 : bit_vector(15 downto 0); -- Final sum
	SIGNAL temp4 : bit_vector(15 downto 0); -- Carry vector, discussed below

	component XOR_2input is
		port(	in1, in2: in bit; 
				output  : out bit );
	end component;

	-- gpgen is used to generate the Internal g, p signals
	component gpgen is
		port(	a, b: in bit;
				g, p: out bit );
	end component;

	-- node_operation carries out the node operations at each stage
	component node_operation is
		port(	g1, p1, g2, p2: in bit;
				g, p          : out bit );
	end component;	
	
	-- LOGIC
	begin
		-- Operation to determine all the Internal g & p signals, called Stage 0 here
		stg00:
			FOR i IN 0 TO 15 GENERATE
				pm: gpgen PORT MAP (a => A(i) , b => B(i) , g => g_in(i) , p => p_in(i) );
			END GENERATE;
		
		-- Stage 1 carry operations
		g_1(0) <= g_in(0);
		p_1(0) <= p_in(0);
		stg01:
			FOR i IN 0 TO 14 GENERATE
				pm: node_operation PORT MAP ( g1 => g_in(i) , p1 => p_in(i) , g2 => g_in(i+1) , 
														p2 => p_in(i+1) , g => g_1(i+1) , p => p_1(i+1) );
			END GENERATE;	
			
		-- Stage 2 carry operations
		buffa1:
			FOR i IN 0 TO 1 GENERATE
				g_2(i) <= g_1(i);
				p_2(i) <= p_1(i);
			END GENERATE;
		stg02:		
			FOR i IN 0 TO 13 GENERATE
				pm: node_operation PORT MAP ( g1 => g_1(i) , p1 => p_1(i) , g2 => g_1(i+2) , 
														p2 => p_1(i+2) , g => g_2(i+2) , p => p_2(i+2) );
			END GENERATE;
			
		-- Stage 3 carry operations
		buffa2:
			FOR i IN 0 TO 3 GENERATE
				g_3(i) <= g_2(i);
				p_3(i) <= p_2(i);
			END GENERATE;
		stg03:		
			FOR i IN 0 TO 11 GENERATE
				pm: node_operation PORT MAP ( g1 => g_2(i) , p1 => p_2(i) , g2 => g_2(i+4) , 
														p2 => p_2(i+4) , g => g_3(i+4) , p => p_3(i+4) );
			END GENERATE;
		
		-- Stage 4 carry operations
		buffa3:
			FOR i IN 0 TO 7 GENERATE
				g_4(i) <= g_3(i);
				p_4(i) <= p_3(i);
			END GENERATE;
		stg04:		
			FOR i IN 0 TO 7 GENERATE
				pm: node_operation PORT MAP ( g1 => g_3(i) , p1 => p_3(i) , g2 => g_3(i+8) , 
														p2 => p_3(i+8) , g => g_4(i+8) , p => p_4(i+8) );
			END GENERATE;	
		
		-- Dealing with the 1st and last carries
	   c(0) <= initialCarry; -- Initialising c(0) as the Initial carry
		Carryout <= c(16);    -- The carry out bit is the 17th carry
		
		-- Post processing
		post:   
		   FOR i IN 1 TO 16 GENERATE
				C(i) 			<= (g_4(i-1) or  (p_4(i-1) and C(0)));
				temp4(i-1) 	<= (C(i-1) and (not toXOR));
				x: XOR_2input PORT MAP (in1 => p_in(i-1), in2 => temp4(i-1), output => temp0(i-1));
				Sum(i-1) 	<= ((temp0(i-1) and (not toNAND)) or ((not g_in(i-1)) and toNAND));
			END GENERATE;    

end KoggeStoneAdderLogic;

-- temp4 is the AND between the carry bits and NOT of toXOR. It makes all carry bits 0 when we want the XOR operation.
-- temp0 is the final sum