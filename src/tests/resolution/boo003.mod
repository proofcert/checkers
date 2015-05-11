module boo003.

accumulate lkf-kernel.
accumulate eprover.
accumulate resolution_steps.

resProblem "boo003" [(pr 1 (n (( multiply a a ) == a)) )] 
(rsteps [cn (id (idx 1)) 0] estate )
 (map [
pr 0 f-,
pr 1 (n (( multiply a a ) == a))
]).

inSig inverse.
inSig multiply.
inSig add.


