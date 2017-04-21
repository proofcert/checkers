module modlab-min-s5.
accumulate labeled.
accumulate lkf-kernel.
modalProblem "Labeled Problem S5 - minimal proof evidence"
[(pr symm-ind (some (x\ some (y\ (p (rel x y) &+& n (rel y x)) ) ))), (pr trans-ind (some (x\ some (y\ some z\ ((p (rel x y) &+& p (rel y z)) &+& n (rel x z) ) ))))]
(box (-- p1) !! box (dia (++ p1)))
(modlab-cert
  (dectree eind _)
  (diabox-map [diabox-entry (lind (rind eind)) (lind eind)])
  (init-map [init-entry (bind (lind (rind eind)) (lind eind)) (lind (lind eind))]) (axiom-map [axiom-entry symm-ind [default-ind, rind eind], axiom-entry trans-ind [rind eind, default-ind, lind eind]])
 (snum (snum znum))
 (state [trans-ind, symm-ind] [eigen-entry default-ind zero] []) ).