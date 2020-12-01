entity ZeroBitCalculator is 
	port (
		-- 17 bits defined = 16 bit for sum and 1 bit for carry 
		in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17: in bit; 
		zeroBit: out bit
	);
end ZeroBitCalculator;

architecture ZeroBitLogic of ZeroBitCalculator is 	
	-- writing logic
	begin
	zeroBit <= in1 or in2 or in3 or in4 or in5 or in6 or in7 or in8 or in9 or in10 or in11 or in12 or in13 or in14 or in15 or in16 or in17; 
end ZeroBitLogic;