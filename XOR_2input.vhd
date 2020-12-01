entity XOR_2input is 
	port (
		in1, in2: in bit; 
		output: out bit 
	);
end XOR_2input;

architecture XOR_Logic of XOR_2input is 
	
begin
	-- defining logic for a XOR gate
	output <= (in1 and not in2) or (in2 and not in1);
	
end XOR_Logic;