module param1.

accumulate lkf-kernel.
accumulate paramodulation.
accumulate resolution_steps.

/*
problem "param1"
  (f-)
 (rsteps [resolv (rclause 1 (sub [])) (rclause 3 (sub [a])) 4, 
 	  resolv (rclause 3 (sub [h (a)])) (rclause 4 (sub [])) 5, 
	  resolv (rclause 2 (sub [])) (rclause 5 (sub [])) 0])
  (map []).


 SIgnature */
inSig  g.


/* Axioms of abelian group theorey */
inCtxt (idx 1) (some X\ p ((g e X) == X)).
inCtxt (idx 2) (some X\ p ((g X e) == X)).
inCtxt (idx 3) (some X\ some Y\ some Z\ p ((g (g X Y) Z) ==  (g X (g Y Z)))).
inCtxt (idx 4) (some X\ p ((g X X) == e)).

/*Derived clauses*/
clause 6  (all X\ all Y\ n	((g X  (g Y  (g X  Y))) ==  e)).
clause 7 (all X\ all Y\ n 	((g e X) == (g Y  (g Y X)))).
clause 8  (all X\ all Y\ n 	(X ==  (g Y (g Y X)))).
clause 9   (all X\ all Y\ n 	((g Y  (g X Y)) ==  (g X e))).
clause 10  (all X\ all Y\ n 	((g Y  (g X Y)) ==  X)).
clause 11  (all X\ all Y\ n 	((g X Y) ==  (g Y X))).

clause 0 (f-). 

mapsto I Form :- clause I F, negate F Form.



