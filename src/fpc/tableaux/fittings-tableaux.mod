module fittings-tableaux.

decide_ke (fitcert L (dectree I O D) M) I (fitcert [] (dectree I O D) M).

store_kc C (n (r _ _)) none C :- !. % in the case of relational atoms, we do not care about the index
store_kc C (p (r _ _)) none C :- !. % in the case of relational atoms, we do not care about the index
store_kc (fitcert [H|T] D M) Form H (fitcert T D M).

release_ke C C.

%initial_ke (fitcert L (dectree I none D) M) none :- !. % used for init applied to relational atoms
initial_ke (fitcert L (dectree I O D) M) O.

orNeg_kc (fitcert [] (dectree I O [H|T]) M) Form (fitcert [lind I, rind I] H M). % this is used if orNeg is the main connective of the formula on which we decide
orNeg_kc (fitcert [E|L] D M) Form (fitcert [E|L] D M). % this is used otherwise

andNeg_kc (fitcert [] (dectree I O [H,G|T]) M) Form (fitcert [lind I] H M) (fitcert [rind I] G M).
andNeg_kc (fitcert [E|L] D M) Form (fitcert [E|L] D M) (fitcert [E|L] D M).

andPos_k (fitcert L (dectree I O T) M) Form left-first (fitcert L (dectree I none T) M) (fitcert L (dectree I O T) M).

all_kc (fitcert [] (dectree I O [H|T]) M) (Eigen\ fitcert [lind I] H [pr I Eigen|M]).
% for extensions of K, we will need to define also a case where the first list is not []

some_ke (fitcert [] (dectree I O [H|T]) M) X (fitcert [bind I O] H M) :- member (pr O X) M. %
% for extensions of K, we will need to define also a case where the first list is not []



% OLD VERSION: PROBLEMS WITH INDEXES
%decide_ke (fitcert L (dectree I O D) M) I (fitcert [] (dectree I O D) M).
%store_kc (fitcert [H|T] D M) Form H (fitcert T D M).
%orNeg_kc (fitcert L (dectree I O [H|T]) M) Form (fitcert [lind I, rind I] H M).
%andNeg_kc (fitcert L (dectree I O [H,G|T]) M) Form (fitcert [lind I] H M) (fitcert [rind I] G M).
%all_kc (fitcert L (dectree I O [H|T]) M) (Eigen\ fitcert [lind I] H [pr I Eigen|M]).
%release_ke C C.
%some_ke (fitcert L (dectree I O [H|T]) M) X (fitcert [bind I O] H M) :- member (pr O X) M.
%andPos_k C Form left-first C C.
%initial_ke (fitcert L (dectree I O D) M) O.




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

