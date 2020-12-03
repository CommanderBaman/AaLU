LIBRARY ieee;
USE ieee.std_logic_1164.all;
entity KoggeStoneAdder is
	port (
		A    : IN bit_vector(15 downto 0);  
		B    : IN bit_vector(15 downto 0);
		toXOR, toNAND: in bit;
		initialCarry: in bit;
		Carryout : out bit;
		Sum    : out bit_vector(15 downto 0)
		
	);
end KoggeStoneAdder;

architecture KoggeStoneAdderLogic of KoggeStoneAdder is 

      SIGNAL C :  bit_vector(16 downto 0); 
		
		--internal individual g,p signals--
	   SIGNAL g_in : bit_vector(15 downto 0);
	   SIGNAL p_in : bit_vector(15 downto 0);
	
	--output g,p signals of each KS stage--
		--stage 01
		SIGNAL g_1 : bit_vector(15 downto 0);
		SIGNAL p_1 : bit_vector(15 downto 0);
		--stage 02
		SIGNAL g_2 : bit_vector(15 downto 0);
		SIGNAL p_2 : bit_vector(15 downto 0);
		--stage 03
		SIGNAL g_3 : bit_vector(15 downto 0);
		SIGNAL p_3 : bit_vector(15 downto 0);
		--stage 04
		SIGNAL g_4 : bit_vector(15 downto 0);
		SIGNAL p_4 : bit_vector(15 downto 0);
		
		SIGNAL temp0 : bit_vector(15 downto 0);
		SIGNAL temp4 : bit_vector(15 downto 0);

  
    component XOR_2input is
		port (
			in1, in2: in bit; 
			output: out bit 
		);
		end component;
		
	 component gpgen is
		port(  
       a , b: in bit;
		 g , p: out bit
			);
		end component;
		
	 component node_operation is
		port( 
	    g1,p1,g2,p2: in bit;
		 G , P: out bit
		 );
		end component;	
  
     
   
	
	-- defining logic
	begin
		-- this is not final add some blocks in between
			stg00:
			FOR i IN 0 TO 15 GENERATE
				pm: gpgen PORT MAP (a => A(i) , b => B(i) , g => g_in(i) , p => p_in(i) );
			END GENERATE;

			
	--stage01 carry operations--
	g_1(0) <= g_in(0);
	p_1(0) <= p_in(0);
	stg01:
			FOR i IN 0 TO 14 GENERATE
				pm: node_operation PORT MAP (g1 => g_in(i) , p1 => p_in(i) , g2 => g_in(i+1) , p2 => p_in(i+1) , g => g_1(i+1) , p => p_1(i+1) );
			END GENERATE;	
			
	--stage02 carry operations--
	buffa1:
			FOR i IN 0 TO 1 GENERATE
				g_2(i) <= g_1(i);
				p_2(i) <= p_1(i);
			END GENERATE;
	stg02:		
			FOR i IN 0 TO 13 GENERATE
				pm: node_operation PORT MAP (g1 => g_1(i) , p1 => p_1(i) , g2 => g_1(i+2) , p2 => p_1(i+2) , g => g_2(i+2) , p => p_2(i+2) );
			END GENERATE;
			
	--stage03 carry operations--
	buffa2:
			FOR i IN 0 TO 3 GENERATE
				g_3(i) <= g_2(i);
				p_3(i) <= p_2(i);
			END GENERATE;
	stg03:		
			FOR i IN 0 TO 11 GENERATE
				pm: node_operation PORT MAP (g1 => g_2(i) , p1 => p_2(i) , g2 => g_2(i+4) , p2 => p_2(i+4) , g => g_3(i+4) , p => p_3(i+4) );
			END GENERATE;
		
	
	buffa3:
			FOR i IN 0 TO 7 GENERATE
				g_4(i) <= g_3(i);
				p_4(i) <= p_3(i);
			END GENERATE;
	stg04:		
			FOR i IN 0 TO 7 GENERATE
				pm: node_operation PORT MAP (g1 => g_3(i) , p1 => p_3(i) , g2 => g_3(i+8) , p2 => p_3(i+8) , g => g_4(i+8) , p => p_4(i+8) );
			END GENERATE;	
	
	   c(0)<=initialCarry;
		Carryout <= c(16);
		
	post:   
		   FOR i IN 1 TO 16 GENERATE 
			   temp4(i-1) <= (c(i-1) and (not toXOR));
			  C(i) <= ( g_4(i-1) or  (p_4(i-1) and c(0)));
			  x: XOR_2input PORT MAP ( in1 => p_in(i-1), in2 => temp4(i-1),output => temp0(i-1));
			  sum(i-1) <= (( temp0(i-1) and (not toNAND)) or ((not g_in(i-1)) and toNAND) );
			END GENERATE;    
			 
	      -- (p_in(i-1) XOR ((c(i-1) and (not toXOR))))
	
end KoggeStoneAdderLogic;

		