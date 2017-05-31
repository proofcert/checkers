module modlab-min-s4.
accumulate labeled.
accumulate lkf-kernel.
modalProblem "Modal problem S4 minimal proof evidence"
[(pr trans-ind (some (x\ some (y\ some z\ ((p (rel x y) &+& p (rel y z)) &+& n (rel x z) ) ))))]
((dia (++ req && box (-- ena))) !! (dia (box (-- req)) !! box (dia (++ ena))) )
(modlab-cert
(dectree eind _)
  (diabox-map [diabox-entry (lind (rind eind)) (rind (rind eind)), diabox-entry (lind eind) (bind (lind (rind eind)) (rind (rind eind))), diabox-entry (lind (rind (rind eind))) (rind (bind (lind eind) (bind (lind (rind eind)) (rind (rind eind)))))])
  (init-map [init-entry (lind (bind (lind eind) (bind (lind (rind eind)) (rind (rind eind))))) (lind (bind (lind (rind eind)) (rind (rind eind)))), init-entry (bind (lind (rind (rind eind))) (rind (bind (lind eind) (bind (lind (rind eind)) (rind (rind eind)))))) (lind (rind (bind (lind eind) (bind (lind (rind eind)) (rind (rind eind))))))]) (axiom-map [axiom-entry trans-ind [default-ind, rind (rind eind), bind (lind (rind eind)) (rind (rind eind))], axiom-entry trans-ind [rind (rind eind), bind (lind (rind eind)) (rind (rind eind)), rind (bind (lind eind) (bind (lind (rind eind)) (rind (rind eind))))]])
 (snum (snum znum))
 (state [trans-ind] [eigen-entry default-ind zero] []) ).
 