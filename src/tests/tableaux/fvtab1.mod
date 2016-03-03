module fvtab1.

accumulate freevar-tableaux.
accumulate lkf-kernel.

modalProblem "fvtableaux problem 1"
  ((box (p f) && dia (n g)) && (box ((n f) !! (p g))))
	(fvtabcert [([(-g,[r,l]), (1,empty)],[l,r,l],[l,l,l]), ([ (-g,[r,l]), (1,empty)],[l,l,r],[l,r,l]), ([ (-g,[r,l]), (1,empty)],[l,l,r],[l,l,l]), ([ (-g,[r,l]), (1,empty)],[r,l,r],[l,r,l])] [([l,l],[r,l]), ([r],[r,l])])
	(map []
).
