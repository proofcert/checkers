module modtab-full-1.
accumulate tableaux.
accumulate lkf-kernel.
modalProblem "ModLeanTAP problem t1"
(((dia (-- p1)) !! (box (++ q1))) !! (dia ((++ p1) && (-- q1))))
(modtab-cert
  ((dectree eind [
  (dectree (lind eind) [
  (dectree (rind (lind eind)) [
  (dectree (lind (lind eind)) [
  (dectree (rind eind) [
  (dectree (bind ((rind eind)) ((rind (lind eind)))) [
    (dectree (lind (bind ((rind eind)) ((rind (lind eind))))) []),
    (dectree (lind (rind (lind eind))) [])])])])])])]))
  (diabox-map [diabox-entry (dia-index (lind (lind eind))) (rind (lind eind)), diabox-entry (dia-index (rind eind)) (rind (lind eind)) ])
  (init-map [init-entry (init-index (lind (bind ((rind eind)) ((rind (lind eind)))))) (bind ((lind (lind eind))) ((rind (lind eind)))),
   init-entry (init-index (lind (rind (lind eind)))) (rind (bind ((rind eind)) ((rind (lind eind)))))])
 (state [] []) ).