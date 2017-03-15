module param4.

accumulate lkf-kernel.
accumulate binary_res_fol_nosub.
accumulate paramodulation.
accumulate resolution_steps.


problem "param4" (n ((h(g(g(c)))) == (g(g(g(c))))) !-!
(some (X2\ (some (X3\ p ((h(f (g X2) X3)) == (g(X3))))) )) !-!
(some (X1\ p ((f X1 (g X1)) == (g(X1))))) )
(rsteps [resolv (pid (idx 12)) (pid (idx 9)) 6, resolv (pid (idx 4)) (pid (idx 6)) 1] estate)
 (map [
pr 4 (n ((h(g(g(c)))) == (g(g(g(c)))))),
pr 9 (some (X2\ (some (X3\ p ((h(f (g X2) X3)) == (g(X3))))) )) ,
pr 1 t+,
pr 6 (some (X1\ p ((h(g(g(X1)))) == (g(g(g(X1))))))), % note that eprover doesnt print the formula with quantifies as it is a result of the pm of two non-quantified formulas!
pr 12 (some (X1\ p ((f X1 (g X1)) == (g(X1)))))
]).


/* SIgnature */
inSig  g.
inSig  h.
inSig  f.

