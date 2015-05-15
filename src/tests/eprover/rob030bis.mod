module rob030bis.

accumulate lkf-kernel.
accumulate eprover.
accumulate resolution_steps.

resProblem "rob030bis" [
(pr 2 (n (( add c d ) == d)) ),
(pr 1 (all (X1\ (all (X2\ (p (( negate ( add X1 X2 ) ) == ( negate X2 ))) )) )) )] 
(rsteps [pm (id (idx 2)) (id (idx 1)) 0] estate )
 (map [
pr 0 f-
]).

inSig negate.
inSig add.


