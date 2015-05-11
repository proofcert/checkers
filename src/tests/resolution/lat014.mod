module lat014.

accumulate lkf-kernel.
accumulate eprover.
accumulate resolution_steps.

resProblem "lat014" [(pr 1 (n (( meet a ( join a b ) ) == a)) )] 
(rsteps [cn (id (idx 1)) 0] estate )
 (map [
pr 0 f-,
pr 1 (n (( meet a ( join a b ) ) == a))
]).

inSig meet.
inSig join.


