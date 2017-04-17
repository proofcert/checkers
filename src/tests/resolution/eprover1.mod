module eprover1.

accumulate lkf-kernel.
accumulate eprover.
accumulate resolution_steps.

local c    i.
local g, h	i -> i.
local f 		i -> i -> i.

problem "eprover" ((n ((h (g (g c))) == (g (g (g c))))) !-!
(some (X2\ (some (X3\ (p ((h (f (g X2) X3)) == (g X3))))) ))  !-!
(some (X1\ (p ((f X1 (g X1)) == (g X1))))) )
(rsteps [pm (id (idx 5)) (id (idx 8)) 2, rw (id (idx 2)) (id (idx 11)) 1, cn (id (idx 1)) 0] (istate [11,8,5]))
 (map [
pr (idx 2) (p ((h (g (g X1))) == (g (g (g X1))))),
pr (idx 0) t+,
pr (idx 1) t+
]).

inSig h.
inSig f.
inSig g.
