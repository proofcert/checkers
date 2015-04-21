module param1.

accumulate lkf-kernel.
accumulate paramodulation.
accumulate resolution_steps.


problem "param1"
  (f-)
 (rsteps [resolv (id (idx 3 )) (id (idx 4 )) 6, 
 	  resolv (id (idx 4 )) (id (idx 3 )) 7, 
	  resolv (id (idx 1 )) (id (idx 7 )) 8, 
	  resolv (id (idx 6 )) (id (idx 8 )) 9, 
	  resolv (id (idx 2 )) (id (idx 9 )) 10, 
 	  resolv (id (idx 10 )) (id (idx 8)) 11, 
	  resolv (id (idx 11)) (id (idx 5 )) 0])

  (map []).



/* SIgnature */
inSig  g.


/* Axioms of abelian group theorey */
inCtxt (idx 1) (some X\ p ((g e X) == X)).
inCtxt (idx 2) (some X\ p ((g X e) == X)).
inCtxt (idx 3) (some X\ some Y\ some Z\ p ((g (g X Y) Z) ==  (g X (g Y Z)))).
inCtxt (idx 4) (some X\ p ((g X X) == e)).
inCtxt (idx 5) (n ((g a b) == (g b a))).

/*Derived clauses*/
clause 6  (all X\ all Y\ n	((g X  (g Y  (g X  Y))) ==  e)).
clause 7 (all X\ all Y\ n 	((g e X) == (g Y  (g Y X)))).
clause 8  (all X\ all Y\ n 	(X ==  (g Y (g Y X)))).
clause 9   (all X\ all Y\ n 	((g Y  (g X Y)) ==  (g X e))).
clause 10  (all X\ all Y\ n 	((g Y  (g X Y)) ==  X)).
clause 11  (all X\ all Y\ n 	((g X Y) ==  (g Y X))).

clause 0 (f-). 

mapsto I Form :- clause I F, negate F Form.



