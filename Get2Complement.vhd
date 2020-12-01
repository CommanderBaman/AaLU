entity Get2Complement is
	-- decides whether to do 2s complement of the number or not
	-- if toSubtract is 1, we need to take 2s complement otherwise we don't need to
	port(
		in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16: in bit;
		toSubtract: in bit; 
		out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12, out13, out14, out15, out16: out bit;
		carry: out bit
	);
end Get2Complement;

architecture Get2ComplementLogic of Get2Complement is 
	-- using XOR gate to decide
	component XOR_2input is
		port (
			in1, in2: in bit; 
			output: out bit 
		);
	end component;
	begin
	-- writing logic 
	carry <= toSubtract;
	
	-- parallel XOR gates
	XORGate1 : XOR_2input port map (in1 => in1, in2 => toSubtract, output => out1);
	XORGate2 : XOR_2input port map (in1 => in2, in2 => toSubtract, output => out2);
	XORGate3 : XOR_2input port map (in1 => in3, in2 => toSubtract, output => out3);
	XORGate4 : XOR_2input port map (in1 => in4, in2 => toSubtract, output => out4);
	XORGate5 : XOR_2input port map (in1 => in5, in2 => toSubtract, output => out5);
	XORGate6 : XOR_2input port map (in1 => in6, in2 => toSubtract, output => out6);
	XORGate7 : XOR_2input port map (in1 => in7, in2 => toSubtract, output => out7);
	XORGate8 : XOR_2input port map (in1 => in8, in2 => toSubtract, output => out8);
	XORGate9 : XOR_2input port map (in1 => in9, in2 => toSubtract, output => out9);
	XORGate10 : XOR_2input port map (in1 => in10, in2 => toSubtract, output => out10);
	XORGate11 : XOR_2input port map (in1 => in11, in2 => toSubtract, output => out11);
	XORGate12 : XOR_2input port map (in1 => in12, in2 => toSubtract, output => out12);
	XORGate13 : XOR_2input port map (in1 => in13, in2 => toSubtract, output => out13);
	XORGate14 : XOR_2input port map (in1 => in14, in2 => toSubtract, output => out14);
	XORGate15 : XOR_2input port map (in1 => in15, in2 => toSubtract, output => out15);
	XORGate16 : XOR_2input port map (in1 => in16, in2 => toSubtract, output => out16);
	
end Get2ComplementLogic;
	
