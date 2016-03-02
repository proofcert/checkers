module fittings-tableaux.

decide_ke (fitcert L (dectree I O D) M) I (fitcert [] (dectree I O D) M).
store_kc (fitcert [H|T] D M) Form H (fitcert T D M).
orNeg_kc (fitcert L (dectree I O [H|T]) M) Form (fitcert [lind I, rind I] H M).
andNeg_kc (fitcert L (dectree I O [H,G|T]) M) Form (fitcert [lind I] H M) (fitcert [rind I] G M).
all_kc (fitcert L (dectree I O [H|T]) M) (Eigen\ fitcert [lind I] H [pr I Eigen|M]).
release_ke C C.
some_ke (fitcert L (dectree I O [H|T]) M) X (fitcert [bind I O] H M) :- member (pr O X) M.
andPos_k C Form left-first C C.
initial_ke (fitcert L (dectree I O D) M) O.



% QUESTIONS

%type all2_kc					cert -> (A -> cert) -> o.

%cert -> form -> cert -> cert -> o.

%type orNeg_kc 	 				cert -> form -> cert -> o.


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

