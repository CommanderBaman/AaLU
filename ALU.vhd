LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity ALU is 
	port(		A               : in bit_vector(15 downto 0);    -- 16 bit input binary number
				B               : in bit_vector(15 downto 0);    -- 16 bit input binary number
				Cout            : out bit;							    -- carry bit
				Select0, Select1: in bit;                        -- Selection bits
				Sum             : out bit_vector(15 downto 0);   -- 16 bit output binary number
				Zero            : out bit );                     -- Zero bit
end ALU; 

architecture ALU_Logic of ALU is
	-- XOR Gate
	component XOR_2input is
		port(	in1, in2: in bit; 
				output  : out bit );
	end component;
	
	-- Select Handler
	component SelectHandler is 
		port( Select0, Select1         : in bit; 
				toSubtract, toXOR, toNAND: out bit );
	end component;
	
	-- 2's Complement block
	component Get1Complement is 
		port( invec     : in bit_vector(15 downto 0);
				toSubtract: in bit; 
				outvec    : out bit_vector(15 downto 0);
				carry     : out bit );
	end component;
	
	-- Zero Bit Calculator
	component ZeroBitCalculator is 
		port( invec  : in bit_vector(15 downto 0);
				zeroBit: out bit );
	end component;
	
	-- Kogge Stone Adder
	component KoggeStoneAdder is 
		port(	A            : in bit_vector(15 downto 0);  
				B            : in bit_vector(15 downto 0);
				toXOR, toNAND: in bit;
				initialCarry : in bit;
				Carryout     : out bit;
				Sum          : out bit_vector(15 downto 0) );
	end component;		
		
	-- Variable definitions
	signal SUBbit      : bit;                     -- toSubtract
	signal NANDbit     : bit; 						    -- toNAND
	signal XORbit      : bit; 							 -- toXOR
	signal NB          : bit_vector(15 downto 0); -- New vector B (1's Complement if toSubtract = 1)
	signal initialCarry: bit; 					       -- Initial carry
	signal temp2       : bit_vector(15 downto 0); -- Final output
	
	-- The logic
	begin
	
		HandleSelect : SelectHandler port map (Select0 => Select0, Select1 => Select1, 
															toSubtract => SUBbit, toXOR => XORbit, 
															toNAND => NANDbit);
		
		Take2Complement : Get1Complement port map ( invec => B, 
																  outvec => NB,
																  toSubtract => SUBbit, carry => initialCarry );
		
		MainAdder : KoggeStoneAdder port map ( A=>A,
															B=>NB,
															toXOR => XORbit, toNAND => NANDbit, 
															initialCarry => initialCarry, 
															Carryout => cout,
															sum=>temp2 );
		
		CalculateZeroBit : ZeroBitCalculator port map ( invec => temp2,
																		zeroBit => Zero );
																		
		-- Assigning value to output 
		Sum <= temp2;
	
end ALU_Logic;	