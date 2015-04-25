module eprover2.

accumulate lkf-kernel.
accumulate eprover.
accumulate binary_res_fol_nosub.
accumulate paramodulation.
accumulate resolution_steps.


problem "eprover2" (n ((h(g(g(c)))) == (g(g(g(c))))) !-!
(some (X2\ (some (X3\ p ((h(f (g X2) X3)) == (g(X3))))) )) !-!
(some (X1\ p ((f X1 (g X1)) == (g(X1))))) )
(rsteps [pm (id (idx 9)) (id (idx 12)) 6, rw (id (idx 4)) (id (idx 6)) 1] estate)
 (map [
pr 4 (n ((h(g(g(c)))) == (g(g(g(c)))))),
pr 9 (some (X2\ (some (X3\ p ((h(f (g X2) X3)) == (g(X3))))) )) ,
pr 1 t+,
pr 6 (some (X1\ p ((h(g(g(X1)))) == (g(g(g(X1))))))),
pr 12 (some (X1\ p ((f X1 (g X1)) == (g(X1)))))
]).