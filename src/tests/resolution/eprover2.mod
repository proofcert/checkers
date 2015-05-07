module eprover2.

accumulate lkf-kernel.
accumulate eprover.
accumulate resolution_steps.

local c    i.
local g, h	i -> i.
local f 		i -> i -> i.

resProblem "eprover2" [(pr 11 (p ((h (g (g c))) == (g (g (g c)))))),
                      (pr 8 (all (X2\ (all (X3\ (n ((h (f (g X2) X3)) == (g X3))))) ))),
                      (pr 5 (all (X1\ (n ((f X1 (g X1)) == (g X1))))))]
(rsteps [variable_rename (id (idx 5)) 4, split_conjunct (id (idx 4)) 3, variable_rename (id (idx 8)) 7, split_conjunct (id (idx 7)) 6,
pm (id (idx 3)) (id (idx 6)) 2, assume_negation (id (idx 12)) 11, fof_simplification (id (idx 11)) 10, split_conjunct (id (idx 11)) 9,
rw (id (idx 2)) (id (idx 11)) 1, cn (id (idx 1)) 0] estate)
 (map [
pr 9 (p ((h (g (g c))) == (g (g (g c))))),
pr 10 (p ((h (g (g c))) == (g (g (g c))))),
pr 2 (n ((h (g (g X1))) == (g (g (g X1))))),
pr 4 (all (X2\ (n ((f X2 (g X2)) == (g X2))))) ,
pr 3 (n ((f X1 (g X1)) == (g X1))),
pr 6 (n ((h (f (g X1) X2)) == (g X2))),
pr 7 (all (X4\ (all (X5\ (n ((h (f (g X4) X5)) == (g X5))))) )) ,
pr 0 f-,
pr 1 f-,
pr 12 (n ((h (g (g c))) == (g (g (g c)))))
]).

inSig h.
inSig f.
inSig g.
