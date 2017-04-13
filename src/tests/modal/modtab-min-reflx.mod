module modtab-min-reflx.
accumulate tableaux.
accumulate lkf-kernel.
modalProblem "ModLeanTAP problem t1"
[(pr reflx-ind (some (x\ (n (rel x x)))))]
((dia (-- p1)) !! (++ p1))
(modtab-cert
  (dectree eind _)
  (diabox-map [diabox-entry (lind eind) default-ind])
  (init-map [init-entry (rind eind) (bind (lind eind) default-ind)]) (axiom-map [axiom-entry reflx-ind [default-ind]])
 (state [] [eigen-entry default-ind zero] []) ).
