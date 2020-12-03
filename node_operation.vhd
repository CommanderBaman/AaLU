entity node_operation is
   port( 
	    g1,p1,g2,p2: in bit;
		 G , P: out bit
		 );
		 
end node_operation;

Architecture Arch of	node_operation is	

    
	 
    component and_2input is
		port 
		(
			in1, in2: in bit; 
			output: out bit 
		);
     end component;		
	  signal temp3 : bit;

begin
		
		andsignal1: and_2input port map(g1, p2, temp3);
		G <= g2 or temp3;
		andsignal2: and_2input port map(p1, p2, P);
		
end Arch;		
	   	