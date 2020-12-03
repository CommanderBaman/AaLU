LIBRARY ieee;
USE ieee.std_logic_1164.all;
entity KoggeStoneAdder is
	port (
		A    : IN std_logic_vector(15 downto 0);  
		B    : IN std_logic_vector(15 downto 0);
		toXOR, toNAND: in bit;
		initialCarry: in bit;
		Sum    : out std_logic_vector(15 downto 0); 
		Carry    : out std_logic_vector(15 downto 0); 
	);
end KoggeStoneAdder;

architecture KoggeStoneAdderLogic of KoggeStoneAdder is 
		
		--internal individual g,p signals--
	   SIGNAL g_in : std_logic_vector(15 downto 0);
	   SIGNAL p_in : std_logic_vector(15 downto 0);
	
	--output g,p signals of each KS stage--
		--stage 01
		SIGNAL g_1 : std_logic_vector(15 downto 0);
		SIGNAL p_1 : std_logic_vector(15 downto 0);
		--stage 02
		SIGNAL g_2 : std_logic_vector(15 downto 0);
		SIGNAL p_2 : std_logic_vector(15 downto 0);
		--stage 03
		SIGNAL g_3 : std_logic_vector(15 downto 0);
		SIGNAL p_3 : std_logic_vector(15 downto 0);
		--stage 04
		SIGNAL g_4 : std_logic_vector(15 downto 0);
		SIGNAL p_4 : std_logic_vector(15 downto 0);

  
    component XOR_2input is
		port (
			in1, in2: in bit; 
			output: out bit 
		);
		end component;
		
	 component gpgen is
		(port  
       ain , bin: in bit;
		 g , p: out bit;
			);
		end component;
		
	 component node_operation is
		(port 
	    g1,p1,g2,p2 in bit;
		 G , P;
		 );
		end component;	
  
     
   
	
	-- defining logic
	begin
		-- this is not final add some blocks in between
			stg00:
			FOR i IN 0 TO 15 GENERATE
				pm: gpgen PORT MAP (ain => A(i) , bin => B(i) , g => g_in(i) , p => p_in(i) );
			END GENERATE;

			
	--stage01 carry operations--
	g_1(0) <= g_in(0);
	p_1(0) <= p_in(0);
	stg01:
			FOR i IN 0 TO 14 GENERATE
				pm: node_operation PORT MAP (g1 => g_in(i) , p1 => p_in(i) , g2 => g_in(i+1) , p2 => p_in(i+1) , go => g_1(i+1) , po => p_1(i+1) );
			END GENERATE;	
			
	--stage02 carry operations--
	buffa1:
			FOR i IN 0 TO 1 GENERATE
				g_2(i) <= g_1(i);
				p_2(i) <= p_1(i);
			END GENERATE;
	stg02:		
			FOR i IN 0 TO 13 GENERATE
				pm: node_operation PORT MAP (g1 => g_1(i) , p1 => p_1(i) , g2 => g_1(i+2) , p2 => p_1(i+2) , go => g_2(i+2) , po => p_2(i+2) );
			END GENERATE;
			
	--stage03 carry operations--
	buffa2:
			FOR i IN 0 TO 3 GENERATE
				g_3(i) <= g_2(i);
				p_3(i) <= p_2(i);
			END GENERATE;
	stg03:		
			FOR i IN 0 TO 11 GENERATE
				pm: node_operation PORT MAP (g1 => g_2(i) , p1 => p_2(i) , g2 => g_2(i+4) , p2 => p_2(i+4) , go => g_3(i+4) , po => p_3(i+4) );
			END GENERATE;
		
	
	buffa3:
			FOR i IN 0 TO 7 GENERATE
				g_4(i) <= g_3(i);
				p_4(i) <= p_3(i);
			END GENERATE;
	stg04:		
			FOR i IN 0 TO 7 GENERATE
				pm: node_operation PORT MAP (g1 => g_3(i) , p1 => p_3(i) , g2 => g_3(i+8) , p2 => p_3(i+8) , go => g_4(i+8) , po => p_4(i+8) );
			END GENERATE;	
	
	   c(0)<=initialCarry
		signal temp0 : bit;
	post:   
		   FOR i IN 1 TO 16 GENERATE 
			  C(i) <= ( g_4(i-1) or  (p_4(i-1) and c(0)));
			  x: XOR_2input PORT MAP ( in1 => p(i-1), in2 => c(i-1) and (not toXOR),output => temp0);
			  s(i-1) <= ( (temp0 and (not toNAND)) or ((not g_in(i-1)) and toNAND) );
			END GENERATE;    
			 
	       
	
end KoggeStoneAdderLogic

		