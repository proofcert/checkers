module lmfs-full-1.
accumulate lmfs.
accumulate lkf-kernel.
modalProblem "Single Focus K"
[]
(((dia (-- p1)) !! (box (++ q1))) !! (dia ((++ p1) && (-- q1))))
(lmfs-cert
  ((dectree eind [
  (dectree (lind eind) [
  (dectree (rind (lind eind)) [
  (dectree (lind (lind eind)) [
  (dectree (rind eind) [
  (dectree (bind ((rind eind)) ((rind (lind eind)))) [
    (dectree (lind (bind ((rind eind)) ((rind (lind eind))))) []),
    (dectree (lind (rind (lind eind))) [])])])])])])]))
  (diabox-map [diabox-entry (lind (lind eind)) (rind (lind eind)), diabox-entry (rind eind) (rind (lind eind)) ])
  (init-map [init-entry (lind (bind ((rind eind)) ((rind (lind eind))))) (bind ((lind (lind eind))) ((rind (lind eind)))),
   init-entry (lind (rind (lind eind))) (rind (bind ((rind eind)) ((rind (lind eind)))))])
  _
 (state [] [] []) ).
