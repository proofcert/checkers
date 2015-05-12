module rob002.

accumulate lkf-kernel.
accumulate eprover.
accumulate resolution_steps.

resProblem "rob002" [(pr 1 (n (( add ( negatee ( add a ( negatee b ) ) ) ( negatee ( add ( negatee a ) ( negatee b ) ) ) ) == b)) )]
(rsteps [cn (id (idx 1)) 0] estate )
 (map [
pr 0 f-,
pr 1 (n (( add ( negatee ( add a ( negatee b ) ) ) ( negatee ( add ( negatee a ) ( negatee b ) ) ) ) == b))
]).

inSig negatee.
inSig add.


