module modtab-full-s5.
accumulate tableaux.
accumulate lkf-kernel.
modalProblem "Tableau Problem S5 - full proof evidence"
[(pr symm-ind (some (x\ some (y\ (p (rel x y) &+& n (rel y x)) ) ))), (pr trans-ind (some (x\ some (y\ some z\ ((p (rel x y) &+& p (rel y z)) &+& n (rel x z) ) ))))]
(box (-- p1) !! box (dia (++ p1)))
(modtab-cert
  (dectree eind [dectree (lind eind) [dectree (rind eind) [dectree (modal symm-ind (modal trans-ind (lind (rind eind)))) [dectree (bind (lind (rind eind)) (lind eind)) []]]]])
  (diabox-map [diabox-entry (lind (rind eind)) (lind eind)])
  (init-map [init-entry (bind (lind (rind eind)) (lind eind)) (lind (lind eind))]) (axiom-map [axiom-entry (modal symm-ind (modal trans-ind _)) [default-ind, rind eind, lind eind]])
 (snum (snum znum))
 (state [trans-ind, symm-ind] [eigen-entry default-ind zero] []) ).
