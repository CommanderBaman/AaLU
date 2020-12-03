LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity ALU is 
	port(
		A    : IN bit_vector(15 downto 0);  
		B    : IN bit_vector(15 downto 0);
		Cout : out bit;
		Select0, Select1: in bit; 
		Sum    : out bit_vector(15 downto 0); 
	   Zero: out bit
	);
end ALU; 

 
architecture ALU_Logic of ALU is 
	-- component definitions
	
	-- XOR gate
	component XOR_2input is
		port (
			in1, in2: in bit; 
			output: out bit 
		);
	end component;
	
	-- Select Handler
	component SelectHandler is 
		port (
			Select0, Select1: in bit; 
			toSubtract, toXOR, toNAND: out bit
		);
	end component;
	
	-- 2's complement block
	component Get1Complement is 
		port(
			invec    : IN bit_vector(15 downto 0);
			toSubtract: in bit; 
			outvec    : out bit_vector(15 downto 0);
			carry: out bit
		);
	end component;
	
	-- Zero Bit Calculator
	component ZeroBitCalculator is 
		port ( 
		invec    : IN bit_vector(15 downto 0);
		zeroBit: out bit
	);
	end component;
	
	-- Kogge Stone Adder
	component KoggeStoneAdder is 
		port (
		A    : IN bit_vector(15 downto 0);  
		B    : IN bit_vector(15 downto 0);
		toXOR, toNAND: in bit;
		initialCarry: in bit;
		Carryout : out bit;
		Sum    : out bit_vector(15 downto 0)
		);
	end component;		
		
	-- Some variable definitions
	signal SUBbit: bit; -- toSubtract
	
	signal NANDbit: bit; -- toNAND
	
	signal XORbit: bit; -- toXOR
	
	signal NB : bit_vector(15 downto 0);
	
	signal initialCarry: bit; -- initial carry
	
	signal temp2 : bit_vector(15 downto 0);
	
	-- writing logic
	begin
	
	HandleSelect : SelectHandler port map (Select0 => Select0, Select1 => Select1, toSubtract => SUBbit, toXOR => XORbit, toNAND => NANDbit);
	
	Take2Complement : Get1Complement port map (
		invec => B, 
		outvec => NB,
		toSubtract => SUBbit, carry => initialCarry
	);
	
	MainAdder : KoggeStoneAdder port map (
		A=>A,
		B=>NB,
		toXOR => XORbit, toNAND => NANDbit, 
		initialCarry => initialCarry, 
		Carryout => cout,
		sum=>temp2
		);
	
	CalculateZeroBit : ZeroBitCalculator port map (
		invec => temp2 ,
	   zeroBit => Zero
	);
	
	
	-- assining values to output 
	sum <= temp2;
	
	
end ALU_Logic;	