module eprover1.

accumulate lkf-kernel.
accumulate eprover.
accumulate binary_res_fol_nosub.
accumulate paramodulation.
accumulate resolution_steps.


problem "eprover1" (n ((h(g(g(c)))) == (g(g(g(c))))) !-!
(some (X2\ (some (X3\ p ((h(f (g X2) X3)) == (g(X3))))) )) !-!
(some (X1\ p ((f X1 (g X1)) == (g(X1))))) )
(rsteps [assume_negation (id (idx 5)) 4, fof_simplification (id (idx 4)) 3, split_conjunct (id (idx 4)) 2,
variable_rename (id (idx 9)) 8, split_conjunct (id (idx 8)) 7, variable_rename (id (idx 12)) 11,
split_conjunct (id (idx 11)) 10, pm (id (idx 10)) (id (idx 7)) 6, rw (id (idx 4)) (id (idx 6)) 1, cn (id (idx 1)) 0] estate)
 (map [
pr 8 (some (X4\ (some (X5\ p ((h(f (g X4) X5)) == (g(X5))))) )) ,
pr 11 (some (X2\ p ((f X2 (g X2)) == (g(X2))))) ,
pr 2 (n ((h(g(g(c)))) == (g(g(g(c)))))),
pr 3 (n ((h(g(g(c)))) == (g(g(g(c)))))),
pr 4 (n ((h(g(g(c)))) == (g(g(g(c)))))),
pr 7 (p ((h(f (g X1) X2)) == (g(X2)))),
pr 9 (some (X2\ (some (X3\ p ((h(f (g X2) X3)) == (g(X3))))) )) ,
pr 0 t+,
pr 1 t+,
pr 6 (some (X1\ p ((h(g(g(X1)))) == (g(g(g(X1))))))),
pr 12 (some (X1\ p ((f X1 (g X1)) == (g(X1))))) ,
pr 5 (p ((h(g(g(c)))) == (g(g(g(c)))))),
pr 10 (p ((f X1 (g X1)) == (g(X1))))
]).



/* SIgnature */
inSig  g.
inSig  h.
inSig  f.

