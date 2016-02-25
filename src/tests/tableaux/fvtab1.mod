module fvtab1.

accumulate fvtabsimp.
accumulate tableaux-kernel.

problemCert "fvtableaux test"
 	((box ((n f) && (n g))) && ((dia (p f)) !! (dia (p g))))
	(fvtabsimp [1, 2] Cert)
	(map []
) (fvtabsimp [] Cert).

% we need an example which will have eigenvariables on the same branch to make sure it works properly and we need to make sure eigencopy has different names for different eigenvariables
