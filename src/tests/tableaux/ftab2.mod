module ftab2.
accumulate fittings-tableaux.
accumulate lkf-kernel.
modalProblem "Mod:eanTap problem t3"
[]
((((box (++ q1))) !! ((dia (-- p1))) !! (dia ((++ p1) && (-- q1)))))
(fitcert []
((dectree eind none
[(dectree (lind eind) none
[(dectree (rind eind) none
[(dectree (lind (rind eind)) (lind eind)
[(dectree (rind (rind eind)) (lind eind)
[(dectree (bind ((rind (rind eind))) ((lind eind))) none
[(dectree (lind (bind ((rind (rind eind))) ((lind eind)))) (bind ((lind (rind eind))) ((lind eind))) []),

(dectree (lind (lind eind)) (rind (bind ((rind (rind eind))) ((lind eind)))) [])])])])])])])) [] ).
