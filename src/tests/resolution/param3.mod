module param3.

accumulate lkf-kernel.
accumulate paramodulation.
accumulate resolution_steps.


problem "param3"
  ((some X\ p ((f X (g X)) == (g X))) !-!
    (some Y\ some Z\ p ((h (f (g Y) Z)) == (g Z))) !-!
    (n ((h (g (g e))) == (g (g (g e)))))
    )
 (rsteps [resolv (id (idx 1)) (id (idx 2)) 4,
  	  resolv (id (idx 4)) (id (idx 3)) 0])
  (map []).


/* SIgnature */
inSig  g.
inSig  h.
inSig  f.

/* Axioms of abelian group theorey */
mapsto 1 (some X\ p ((f X (g X)) == (g X))).
mapsto 2 (some Y\ some Z\ p ((h (f (g Y) Z)) == (g Z))).
mapsto 3 (n ((h (g (g e))) == (g (g (g e))))).
mapsto 4 (some Y\ p ((h (g (g Y))) == (g (g (g Y))))).
/*Derived clauses*/

clause 0 (f-).

mapsto I Form :- clause I F, negate F Form.



