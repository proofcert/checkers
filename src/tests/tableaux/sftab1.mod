module sftab1.

accumulate simpfit-tableaux.
accumulate lkf-kernel.

modalProblem "ModLeanTAP t1"
(((dia (-- q1)) !! (box (++ q2))) !! (dia ((++ q1) && (-- q2))))
	(simpfitcert 1 [eind]
      [ closure (lind (bind (rind eind) (rind (lind eind)))) (bind (lind (lind eind)) (rind (lind eind))),
        closure (lind (rind (lind eind))) (rind (bind (rind eind) (rind (lind eind)))) ]
      [ boxinfo (lind (lind eind)) (rind (lind eind)),
        boxinfo (rind eind) (rind (lind eind)) ] [] [] ).
