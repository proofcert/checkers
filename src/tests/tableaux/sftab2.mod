module sftab2.

accumulate simpfit-tableaux.
accumulate lkf-kernel.

% identical to the ftab2 example but using the simple tableaux certificate format
modalProblem "simpfit ex2" %name
  ( (dia (-- q)) !! (box (++ q)) ) % modal formula (already dualized, i.e. the valid one)
%   ( dia (++ q) ) % modal formula (already dualized, i.e. the valid one)
%   ((++ q) !! ((-- q) && (-- q)))
%   ((-- q) !! (++ q))
	(
    simpfitcert
      1
      [eind]
%       [closure (lind eind) (lind (rind eind)), closure (lind eind) (rind (rind eind))] % the closure list
      [closure (lind (rind eind)) (bind (lind eind) (rind eind))] % the closure list
      [boxinfo (lind eind) (rind eind)] % the boxinfo list
      []
      [] % used indices, original empty
  ).
