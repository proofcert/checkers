module grp533.

accumulate lkf-kernel.
accumulate eprover.
accumulate resolution_steps.

resProblem "grp533" [(pr 1 (n (( multiply ( inverse a1 ) a1 ) == ( multiply ( inverse b1 ) b1 ))) )] 
(rsteps [cn (id (idx 1)) 0] estate )
 (map [
pr 0 f-,
pr 1 (n (( multiply ( inverse a1 ) a1 ) == ( multiply ( inverse b1 ) b1 )))
]).

inSig inverse.
inSig multiply.
inSig divide.


