module simple.

accumulate lkf-kernel.
accumulate eprover.
accumulate resolution_steps.

resProblem "simple" [(pr 4 (all (X1\ (n ((f X1 (g X1)) == (g X1))))) ),
(pr 3 (all (X1\ (all (X2\ (n ((h (f (g X1) X2)) == (g X2))))))) ),
(pr 1 (p ((h (g (g c))) == (g (g (g c))))) )] 
(resteps [pm (id (idx 3)) (id (idx 4)) 2, rw (id (idx 1)) (id (idx 2)) 0, cn (id (idx 0)) 0])
 (map [
pr 4 (all (X1\ (n ((f X1 (g X1)) == (g X1))))),
pr 3 (all (X1\ (all (X2\ (n ((h (f (g X1) X2)) == (g X2))))))),
pr 0 f-,
pr 2 (all (X1\ (n ((h (g (g X1))) == (g (g (g X1))))))),
pr 1 (p ((h (g (g c))) == (g (g (g c)))))
]).

inSig h.
inSig g.
inSig f.


