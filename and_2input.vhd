-- AND Operation

entity and_2input is 
	port(	in1, in2: in bit; 
			output: out bit );
end and_2input;

architecture and_Logic of and_2input is 
	
begin -- AND Gate
	output <= in1 and in2;
	
end and_Logic;