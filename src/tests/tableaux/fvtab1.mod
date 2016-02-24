module fvtab1.

accumulate fvtableaux.
accumulate tableaux-kernel.

x
problem "fvtableaux test"
   	(box (n f & n g) & (dia (p f) | (dia (p g))))
	(fvtabsimp [sub [f,1], sub [g,1]])
	(map []
).
