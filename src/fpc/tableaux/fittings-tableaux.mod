module fittings-tableaux.

decide_ke (fitcert L (udectree (decnode I O) T) M) I (fitcert [] (udectree (decnode I O) T) M).


%kind dectree, decnode, opindex type.

%type fitcert list index -> dectree -> list pr -> cert.

%type dectree index -> opindex -> list dectree -> dectree.

%type eind index.
%type lind index -> index.
%type rind index -> index.

%type sindex index -> opindex
%type none -> opindex

%type decide_ke					cert -> index -> cert -> o.
%type release_ke 				cert -> cert -> o.
     
%type store_kc					cert -> form -> index -> cert -> o.
%type initial_ke					cert -> index -> o.
%type all_kc					cert -> (A -> cert) -> o.
%type some_ke					cert -> A -> cert -> o.
%type andNeg_kc,	 andPos_ke			cert -> form -> cert -> cert -> o.
%type andPos_k	 				cert -> form -> direction -> cert -> cert -> o.
%type orNeg_kc 	 				cert -> form -> cert -> o.
%type orPos_ke    	    			cert -> form -> choice -> cert -> o.
%type true_ke 					cert -> o.
%type false_kc 					cert -> cert -> o.





true_ke (fittab _).
release_ke (fittab L) (fittab L).

eigencopy [] [].
eigencopy ([X|Ls] [X'|Ls'] :- eigencopy(X,X'), eigencopy(Ls,Ls').*)
