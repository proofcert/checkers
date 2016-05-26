module sftab2.

accumulate simpfit-tableaux.
accumulate lkf-kernel.

% identical to the ftab2 example but using the simple tableaux certificate format
modalProblem "simpfit ex2" %name
  ( (dia (-- q)) !! (box (++ q)) ) % modal formula (already dualized, i.e. the valid one)
	(
    simpfitcert
      0
      []
      [closure (bind (lind eind) (rind eind)) (lind (rind eind)) ] % the closure list
      [boxinfo (lind eind) (rind eind)] % the boxinfo list
      []
      [] % used indices, original empty
  ).
