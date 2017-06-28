module lmfs-full-K.
accumulate lmfs.
accumulate lmf-lkf.
accumulate modal-encoding.

modalProblem "Single Focus K"
[]
(((dia (-- p1)) !! (box (++ q1))) !! (dia ((++ p1) && (-- q1))))
(mcert (lmfs-cert
  ((dectree eind [
  (dectree (lind eind) [
  (dectree (rind (lind eind)) [
  (dectree (lind (lind eind)) [
  (dectree (rind eind) [
  (dectree (bind ((rind eind)) ((rind (lind eind)))) [
    (dectree (lind (bind ((rind eind)) ((rind (lind eind))))) []),
    (dectree (lind (rind (lind eind))) [])])])])])])]))
  (labels-map [label-entry (lind (lind eind)) lblA,
               label-entry (rind (lind eind)) lblA,
               label-entry (rind eind) lblA ])
  (init-map [init-entry (lind (bind ((rind eind)) ((rind (lind eind))))) (bind ((lind (lind eind))) ((rind (lind eind)))),
   init-entry (lind (rind (lind eind))) (rind (bind ((rind eind)) ((rind (lind eind)))))])
  _
 (state [] []) ) prf
  [lform zero (((dia (-- p1)) !! (box (++ q1))) !! (dia ((++ p1) && (-- q1))))]
  []
  []
).
