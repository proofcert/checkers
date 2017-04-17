module modtab-min-1.
accumulate tableaux.
accumulate lkf-kernel.
modalProblem "ModLeanTAP problem t1"
[]
(((dia (-- p1)) !! (box (++ q1))) !! (dia ((++ p1) && (-- q1))))
(modtab-cert _
  (diabox-map [diabox-entry (lind (lind eind)) (rind (lind eind)), diabox-entry (rind eind) (rind (lind eind)) ])
  (init-map [init-entry (lind (bind ((rind eind)) ((rind (lind eind))))) (bind ((lind (lind eind))) ((rind (lind eind)))),
   init-entry (lind (rind (lind eind))) (rind (bind ((rind eind)) ((rind (lind eind)))))]) (axiom-map [])
 (snum (snum znum))
 (state [] [] []) ).
