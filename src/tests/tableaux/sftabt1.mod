module sftabt1.

accumulate simpfit-tableaux.
accumulate lkf-kernel.

modalProblem "benchmark t1"
%(box p,dia-q),box (-p;q) % the negated formula
(((dia (-- q1)) !! (box (++ q2))) !! (dia ((++ q1) && (-- q2))))
	(
    simpfitcert
%([ ([l:[b([r:e], [r:[l:e]])]], [b([l:[l:e]], [r:[l:e]])]), ([r:[b([r:e], [r:[l:e]])]], [l:[r:[l:e]]])], [])
      1
      [eind]
      [ closure (lind (bind (rind eind) (rind (lind eind)))) (bind (lind (lind eind)) (rind (lind eind))),
        closure (rind (bind (rind eind) (rind (lind eind)))) (lind (rind (lind eind)))
      ]
      [ boxinfo (lind (lind eind)) (rind (lind eind)),
        boxinfo (rind eind) (rind (lind eind))
      ]
      []
      [] % used indices, original empty
  ).
