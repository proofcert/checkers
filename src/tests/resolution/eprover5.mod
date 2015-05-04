module eprover5.

accumulate lkf-kernel.
accumulate eprover.
accumulate resolution_steps.

problem "eprover" ((n ((h (g (g c))) == (g (g (g c))))) !-!
(some (X2\ (some (X3\ (p ((h (f (g X2) X3)) == (g X3))))) ))  !-!
(some (X1\ (p ((f X1 (g X1)) == (g X1))))) ) 
(rsteps [variable_rename (id (idx 5)) 4, split_conjunct (id (idx 4)) 3,
variable_rename (id (idx 8)) 7, split_conjunct (id (idx 7)) 6, pm (id (idx 3))
(id (idx 6)) 2, assume_negation (id (idx 12)) 11, fof_simplification (id (idx
11)) 10, split_conjunct (id (idx 11)) 9, rw (id (idx 2)) (id (idx 11)) 1, cn (id
(idx 1)) 0] estate)
 (map [
pr 9 (n ((h (g (g c))) == (g (g (g c))))),
pr 10 (n ((h (g (g c))) == (g (g (g c))))),
pr 11 (n ((h (g (g c))) == (g (g (g c))))),
pr 2 (p ((h (g (g X1))) == (g (g (g X1))))),
pr 4 (some (X2\ (p ((f X2 (g X2)) == (g X2))))) ,
pr 3 (p ((f X1 (g X1)) == (g X1))),
pr 6 (p ((h (f (g X1) X2)) == (g X2))),
pr 5 (some (X1\ (p ((f X1 (g X1)) == (g X1))))) ,
pr 8 (some (X2\ (some (X3\ (p ((h (f (g X2) X3)) == (g X3))))) )) ,
pr 7 (some (X4\ (some (X5\ (p ((h (f (g X4) X5)) == (g X5))))) )) ,
pr 0 t+,
pr 1 t+,
pr 12 (p ((h (g (g c))) == (g (g (g c)))))
]).

inSig h.
inSig f.
inSig g.

