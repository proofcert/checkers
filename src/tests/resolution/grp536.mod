module grp536.

accumulate lkf-kernel.
accumulate eprover.
accumulate resolution_steps.

resProblem "grp536" [(pr 1 (n (( multiply a b ) == ( multiply b a ))) )] 
(rsteps [cn (id (idx 1)) 0] estate )
 (map [
pr 0 f-,
pr 1 (n (( multiply a b ) == ( multiply b a )))
]).

inSig inverse.
inSig multiply.
inSig divide.


