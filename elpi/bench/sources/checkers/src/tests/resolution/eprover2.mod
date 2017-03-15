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
(resteps [pm (id (idx 5)) (id (idx 8)) 2, rw (id (idx 2)) (id (idx 11)) 1, cn (id (idx 1)) 0])
 (map [
pr 2 (n ((h (g (g X1))) == (g (g (g X1))))),
pr 0 f-,
pr 1 f-
]).

inSig h.
inSig f.
inSig g.
