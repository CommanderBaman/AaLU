entity SelectHandler is 
	port ( Select0, Select1: in bit; 
			 toSubtract, toXOR, toNAND: out bit );
end SelectHandler; 

architecture SelectLogic of SelectHandler is 
begin 
	-- Logic
	toSubtract <= Select0 and (not Select1); -- 1 for Subtraction, otherwise 0
	toXOR <= Select0 and Select1; 			  -- 1 for XOR, otherwise 0
	toNAND <= (not Select0) and Select1; 	  -- 1 for NAND, otherwise 0
end SelectLogic;

-- Here we decide whether to perform Addition, Subtraction, XOR or NAND