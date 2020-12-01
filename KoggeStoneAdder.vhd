entity KoggeStoneAdder is
	port (
		A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16: in bit;  
		B1, B2, B3, B4, B5, B6, B7, B8, B9, B10, B11, B12, B13, B14, B15, B16: in bit; 
		toXOR, toNAND: in bit;
		initialCarry: in bit;
		S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16: out bit; 
		Carry: out bit
	);
end KoggeStoneAdder;

architecture KoggeStoneAdderLogic of KoggeStoneAdder is 
	
	-- defining logic
	begin
		-- this is not final add some blocks in between
		S1 <= A1 or B1;
		S2 <= A2 or B2;
		S3 <= A3 or B3;
		S4 <= A4 or B4;
		S5 <= A5 or B5;
		S6 <= A6 or B6;
		S7 <= A7 or B7;
		S8 <= A8 or B8;
		S9 <= A9 or B9;
		S10 <= A10 or B10;
		S11 <= A11 or B11;
		S12 <= A12 or B12;
		S13 <= A13 or B13;
		S14 <= A14 or B14;
		S15 <= A15 or B15;
		S16 <= A16 or B16;
		Carry <= toXOR or toNAND or initialCarry;
	
end KoggeStoneAdderLogic;