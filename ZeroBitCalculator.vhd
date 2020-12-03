entity ZeroBitCalculator is 
	port (
		invec    : IN bit_vector(15 downto 0);
		zeroBit: out bit
	);
end ZeroBitCalculator;

architecture ZeroBitLogic of ZeroBitCalculator is 	

   signal temp1 : bit; 
	-- writing logic
	begin
	temp1 <= invec(0) or invec(1) or invec(2) or invec(3) or invec(4) or invec(5) or invec(6) or invec(7) or invec(8) or invec(9) or invec(10) or invec(11) or invec(12) or invec(13) or invec(14) or invec(15); 
	zeroBit <= not temp1;
end ZeroBitLogic;