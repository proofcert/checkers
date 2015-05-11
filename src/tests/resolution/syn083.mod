module syn083.

accumulate lkf-kernel.
accumulate eprover.
accumulate resolution_steps.

resProblem "syn083" [(pr 1 (n (( f a ( f b ( f c d ) ) ) == ( f ( f ( f a b ) c ) d ))) )] 
(rsteps [cn (id (idx 1)) 0] estate )
 (map [
pr 0 f-,
pr 1 (n (( f a ( f b ( f c d ) ) ) == ( f ( f ( f a b ) c ) d )))
]).

inSig f.


