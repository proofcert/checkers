module fvtab1.

accumulate fvtabsimp.
accumulate tableaux-kernel.

<<<<<<< HEAD
x
problem "fvtableaux test"
   	(box (n f & n g) & (dia (p f) | (dia (p g))))
	(fvtabsimp [sub [f,1], sub [g,1]])
=======
problemCert "fvtableaux test"
 	((box ((n f) && (n g))) && ((dia (p f)) !! (dia (p g))))
	(fvtabsimp (evars [1,2] [1,2]) Cert)
>>>>>>> 7edcf54fbaf4b029c3ca9b8c9abaf450e2fef182
	(map []
) (tabres Cert).

% we need an example which will have eigenvariables on the same branch to make sure it works properly and we need to make sure eigencopy has different names for different eigenvariables
