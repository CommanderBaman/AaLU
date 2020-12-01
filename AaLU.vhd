entity AaLU is 
	port(
		A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16: in bit;  
		B1, B2, B3, B4, B5, B6, B7, B8, B9, B10, B11, B12, B13, B14, B15, B16: in bit; 
		Select0, Select1: in bit; 
		S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16: out bit; 
		Carry, Zero: out bit
	);
end AaLU; 


architecture AaLU_Logic of AaLU is 
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
	component Get2Complement is 
		port(
			in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16: in bit;
			toSubtract: in bit; 
			out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12, out13, out14, out15, out16: out bit;
			carry: out bit
		);
	end component;
	
	-- Zero Bit Calculator
	component ZeroBitCalculator is 
		port ( 
		in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17: in bit; 
		zeroBit: out bit
	);
	end component;
	
	-- Kogge Stone Adder
	component KoggeStoneAdder is 
		port (
			A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16: in bit;  
			B1, B2, B3, B4, B5, B6, B7, B8, B9, B10, B11, B12, B13, B14, B15, B16: in bit; 
			toXOR, toNAND: in bit;
			initialCarry: in bit;
			S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16: out bit; 
			Carry: out bit
		);
	end component;		
		
	-- Some variable definitions
	signal SUBbit: bit; -- toSubtract
	signal NANDbit: bit; -- toNAND
	signal XORbit: bit; -- toXOR
	-- contains 2 complement form of B, if we need to subtract
	signal NB1, NB2, NB3, NB4, NB5, NB6, NB7, NB8, NB9, NB10, NB11, NB12, NB13, NB14, NB15, NB16: bit; 
	signal initialCarry: bit; -- initial carry
	
	-- assigning temporary values for output sum and carry bits as giving error
	signal temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8, temp9, temp10, temp11, temp12, temp13, temp14, temp15, temp16, temp17: bit;
	
	-- writing logic
	begin
	
	HandleSelect : SelectHandler port map (Select0 => Select0, Select1 => Select1, toSubtract => SUBbit, toXOR => XORbit, toNAND => NANDbit);
	
	Take2Complement : Get2Complement port map (
		in1 => B1, in2 => B2, in3 => B3, in4 => B4, in5 => B5, in6 => B6, in7 => B7, in8 => B8, in9 => B9, in10 => B10, in11 => B11, in12 => B12, in13 => B13, in14 => B14, in15 => B15, in16 => B16, 
		out1 => NB1, out2 => NB2, out3 => NB3, out4 => NB4, out5 => NB5, out6 => NB6, out7 => NB7, out8 => NB8, out9 => NB9, out10 => NB10, out11 => NB11, out12 => NB12, out13 => NB13, out14 => NB14, out15 => NB15, out16 => NB16, 
		toSubtract => SUBbit, carry => initialCarry
	);
	
	MainAdder : KoggeStoneAdder port map (
		A1 => A1, A2 => A2, A3 => A3, A4 => A4, A5 => A5, A6 => A6, A7 => A7, A8 => A8, A9 => A9, A10 => A10, A11 => A11, A12 => A12, A13 => A13, A14 => A14, A15 => A15, A16 => A16, 
		B1 => NB1, B2 => NB2, B3 => NB3, B4 => NB4, B5 => NB5, B6 => NB6, B7 => NB7, B8 => NB8, B9 => NB9, B10 => NB10, B11 => NB11, B12 => NB12, B13 => NB13, B14 => NB14, B15 => NB15, B16 => NB16, 
		toXOR => XORbit, toNAND => NANDbit, 
		initialCarry => initialCarry, 
		S1 => temp1, S2 => temp2, S3 => temp3, S4 => temp4, S5 => temp5, S6 => temp6, S7 => temp7, S8 => temp8, S9 => temp9, S10 => temp10, S11 => temp11, S12 => temp12, S13 => temp13, S14 => temp14, S15 => temp15, S16 => temp16, 
		Carry => temp17
	);
	
	CalculateZeroBit : ZeroBitCalculator port map (
		in1 => temp1, in2 => temp2, in3 => temp3, in4 => temp4, in5 => temp5, in6 => temp6, in7 => temp7, in8 => temp8, in9 => temp9, in10 => temp10, in11 => temp11, in12 => temp12, in13 => temp13, in14 => temp14, in15 => temp15, in16 => temp16, 
		in17 => temp17, zeroBit => Zero
	);
	
	
	-- assining values to output 
	S1 <= temp1;
	S2 <= temp2;
	S3 <= temp3;
	S4 <= temp4;
	S5 <= temp5;
	S6 <= temp6;
	S7 <= temp7;
	S8 <= temp8;
	S9 <= temp9;
	S10 <= temp10;
	S11 <= temp11;
	S12 <= temp12;
	S13 <= temp13;
	S14 <= temp14;
	S15 <= temp15;
	S16 <= temp16;
	Carry <= temp17;
	
end AaLU_Logic;	
	
		
	