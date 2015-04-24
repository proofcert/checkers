module param1.

accumulate lkf-kernel.
accumulate paramodulation.
accumulate resolution_steps.


problem "param1"
  (f-)
 (rsteps [resolv (pid (idx 3 )) (pid (idx 4 )) 6,
 	  resolv (pid (idx 4 )) (pid (idx 3 )) 7,
	  resolv (pid (idx 1 )) (pid (idx 7 )) 8,
	  resolv (pid (idx 6 )) (pid (idx 8 )) 9,
	  resolv (pid (idx 2 )) (pid (idx 9 )) 10,
 	  resolv (pid (idx 10 )) (pid (idx 8)) 11,
	  resolv (pid (idx 11)) (pid (idx 5 )) 0] estate)

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



