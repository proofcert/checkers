module sftab2.

accumulate simpfit-tableaux.
accumulate lkf-kernel.

modalProblem "ModLeanTap t3"
% dia-q,box p,box (-p;q)  the negated formula
((box (++ q2)) !! (dia (-- q1)) !! (dia ((++ q1) && (-- q2))))
	(
    simpfitcert
%([ ([l:[b([r:[r:e]], [l:e])]], [b([l:[r:e]], [l:e])]), ([r:[b([r:[r:e]], [l:e])]], [l:[l:e]])], [])
      1
      [eind]
      [ closure (lind (bind (rind (rind eind)) (lind eind))) (bind (lind (rind eind)) (lind eind)),
        closure (rind (bind (rind (rind eind)) (lind eind))) (lind (lind eind))
      ]
      [ boxinfo (rind (rind eind)) (lind eind),
        boxinfo (lind (rind eind)) (lind eind)
      ]
      []
      [] % used indices, original empty
  ).
