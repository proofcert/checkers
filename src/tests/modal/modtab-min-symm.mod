module modtab-min-symm.
accumulate tableaux.
accumulate lkf-kernel.
modalProblem "ModLeanTAP problem t1"
[(pr symm-ind (some (x\ some (y\ (p (rel x y) &+& n (rel y x)) ) )))]
((-- p1) !! box (dia (++ p1)))
(modtab-cert
  (dectree eind _)
  (diabox-map [diabox-entry (lind (rind eind)) (default-ind)])
  (init-map [init-entry (bind (lind (rind eind)) (default-ind)) (lind eind)]) (axiom-map [axiom-entry symm-ind [default-ind, rind eind]])
 (snum (snum znum))
 (state [symm-ind] [eigen-entry default-ind zero] []) ).
