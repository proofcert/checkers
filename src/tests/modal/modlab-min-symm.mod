module modlab-min-symm.
accumulate labeled.
accumulate lkf-kernel.
modalProblem "ModLeanTAP problem t1"
[(pr symm-ind (some (x\ some (y\ (p (rel x y) &+& n (rel y x)) ) )))]
((-- p1) !! box (dia (++ p1)))
(modlab-cert
  (dectree eind [dectree (rind eind) [dectree symm-ind [dectree (lind (rind eind)) [dectree (bind (lind (rind eind)) (default-ind)) []]]]])
  (diabox-map [diabox-entry (lind (rind eind)) (default-ind)])
  (init-map [init-entry (bind (lind (rind eind)) (default-ind)) (lind eind)]) (axiom-map [axiom-entry symm-ind [default-ind, rind eind]])
 (snum (snum znum))
 (state [] [eigen-entry default-ind zero] []) ).