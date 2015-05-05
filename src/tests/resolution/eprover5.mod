module eprover5.

accumulate lkf-kernel.
accumulate eprover.
accumulate resolution_steps.

local c    i.
local g, h	i -> i.
local f 		i -> i -> i.

problem "eprover" ((n ((h (g (g c))) == (g (g (g c))))) !-!
(some (X2\ (some (X3\ (p ((h (f (g X2) X3)) == (g X3))))) ))  !-!
(some (X1\ (p ((f X1 (g X1)) == (g X1))))) )
(rsteps [pm (id (idx 5)) (id (idx 8)) 2, rw (id (idx 2)) (id (idx 12)) 1] estate)
 (map [
pr 2 (p ((h (g (g X1))) == (g (g (g X1))))),
pr 5 (some (X1\ (p ((f X1 (g X1)) == (g X1))))) ,
pr 8 (some (X2\ (some (X3\ (p ((h (f (g X2) X3)) == (g X3))))) )) ,
pr 1 t+,
pr 12 (n ((h (g (g c))) == (g (g (g c)))))
]).

inSig g.
inSig f.
inSig h.
