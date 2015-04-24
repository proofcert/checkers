module param2.

accumulate lkf-kernel.
accumulate paramodulation.
accumulate resolution_steps.


problem "param2"
  (f-)
 (rsteps [resolv (pid (idx 1)) (pid (idx 5)) 0] estate)
  (map []).


/* SIgnature */
inSig  g.


/* Axioms of abelian group theorey */
inCtxt (idx 1) (some X\ p ((g e X) == X)).
inCtxt (idx 2) (some X\ p ((g X e) == X)).
inCtxt (idx 3) (some X\ some Y\ some Z\ p ((g (g X Y) Z) ==  (g X (g Y Z)))).
inCtxt (idx 4) (some X\ p ((g X X) == e)).
inCtxt (idx 5) (n ((g e e) == e)).  % stupid example
/*Derived clauses*/

clause 0 (f-).

mapsto I Form :- clause I F, negate F Form.



