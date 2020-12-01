entity SelectHandler is 
	-- controls whether we need to add, subtract, xor or nand the input bits
	port (
		Select0, Select1: in bit; 
		toSubtract, toXOR, toNAND: out bit
	);
end SelectHandler; 

architecture SelectLogic of SelectHandler is 
begin 
	-- defining logic
	toSubtract <= Select0 and (not Select1); -- 1 when we need to subtract, otherwise 0
	toXOR <= Select0 and Select1; -- 1 when we need to XOR, otherwise 0
	toNAND <= (not Select0) and Select1; -- 1 when we need to NAND, otherwise 0
end SelectLogic;
	
	