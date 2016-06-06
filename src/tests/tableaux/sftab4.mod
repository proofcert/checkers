module sftab4.

accumulate simpfit-tableaux.
accumulate lkf-kernel.

modalProblem "ModLeanTap t4"
(((box (-- q1)) && (box (++ q2))) !! (dia ((++ q1) !! (-- q2))))
	(
    simpfitcert
      1
      [eind]
      [ closure (lind (lind (lind eind))) (lind (bind (rind eind) (lind (lind eind)))),
        closure (lind (rind (lind eind))) (rind (bind (rind eind) (rind (lind eind))))
      ]
      [ boxinfo (rind eind) (lind (lind eind)),
        boxinfo (rind eind) (rind (lind eind))
      ]
      []
      [] % used indices, original empty
  ).
