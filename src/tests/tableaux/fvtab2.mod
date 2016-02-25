module fvtab2.

accumulate fvtabsimp.
accumulate tableaux-kernel.

problemCert "fvtableaux test"
% ((box p, dia-q), box (-p;q);box (p, q), (dia-p;dia-q);dia-q, box p, box (-p;q); (box p, dia-q), box (-p;q);box (-p, -q), (dia p;dia q))
	((box (p f) && dia (n g)) && box ((n f) !! (p g)) !! (box ((p f) && (p g))) &&
		(dia (n f) !! dia (n g)) !! dia (n g) && box (p f) && box ((n f !! (p g))) !! (box (p f) && dia (n g)) &&
		box ((n f) !! (p g)) !! box ((n f) && (n g)) && (dia (p f) !! dia (p g)))
	(fvtabsimp [1] Cert)
	(map []
) (fvtabsimp [] Cert).

% we need an example which will have eigenvariables on the same branch to make sure it works properly and we need to make sure eigencopy has different names for different eigenvariables
