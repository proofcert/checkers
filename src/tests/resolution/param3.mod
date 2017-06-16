module param3.

accumulate lkf-kernel.
accumulate paramodulation.
accumulate resolution_steps.


problem "param3"
  ((some X\ p ((f X (g X)) == (g X))) !-!
    (some Y\ some Z\ p ((h (f (g Y) Z)) == (g Z))) !-!
    (n ((h (g (g e))) == (g (g (g e)))))
    )
 (rsteps [resolv (pid (idx 1)) (pid (idx 2)) 4,
  	  resolv (pid (idx 4)) (pid (idx 3)) 0] estate)
  (map []).


/* SIgnature */
inSig  g.
inSig  h.
inSig  f.

/* Axioms of abelian group theorey */
mapsto (idx 1) (some X\ p ((f X (g X)) == (g X))).
mapsto (idx 2) (some Y\ some Z\ p ((h (f (g Y) Z)) == (g Z))).
mapsto (idx 3) (n ((h (g (g e))) == (g (g (g e))))).
mapsto (idx 4) (some Y\ p ((h (g (g Y))) == (g (g (g Y))))).
/*Derived clauses*/

clause 0 (f-).

mapsto (idx I) Form :- clause I F, negateForm F Form.



