module grp538.

accumulate lkf-kernel.
accumulate eprover.
accumulate resolution_steps.

resProblem "grp538" [(pr 1 (n (( multiply ( multiply ( inverse b2 ) b2 ) a2 ) == a2)) )] 
(rsteps [cn (id (idx 1)) 0] estate )
 (map [
pr 1 (n (( multiply ( multiply ( inverse b2 ) b2 ) a2 ) == a2)),
pr 0 f-
]).

inSig inverse.
inSig multiply.
inSig divide.


