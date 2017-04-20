module modlab-full-trans.
accumulate labeled.
accumulate lkf-kernel.
modalProblem "ModLeanTAP problem t1"
[(pr trans-ind (some (x\ some (y\ some z\ ((p (rel x y) &+& p (rel y z)) &-& n (rel x z) ) ))))]
((dia (-- p1)) !! box (box (++ p1)))
(modlab-cert
  (dectree eind [dectree (rind eind) [dectree (lind (rind eind)) [dectree trans-ind [dectree (lind eind) [dectree (lind (lind (rind eind))) []]]]]])
  (diabox-map [diabox-entry (lind eind) (lind (rind eind))])
  (init-map [init-entry (lind (lind (rind eind))) (bind (lind eind) (lind (rind eind)))]) (axiom-map [axiom-entry trans-ind [default-ind, rind eind, lind(rind eind)]])
 (snum (snum znum))
 (state [] [eigen-entry default-ind zero] []) ).