module ftabt3.
accumulate fittings-tableaux.
accumulate lkf-kernel.
modalProblem "ftabt3"
((box (++ q1)) !! (dia (-- p1)) !! (box ((++ p1) && (-- q1))))
(fitcert []
((dectree eind none [(dectree (lind eind) none [(dectree (rind eind) none [(dectree (lind (rind eind)) (lind eind) [(dectree (rind (rind eind)) (lind eind) [(dectree (bind ((rind (rind eind))) ((lind eind))) none [(dectree (lind (bind ((rind (rind eind))) ((lind eind)))) (bind ((lind (rind eind))) ((lind eind))) []), (dectree (rind (bind ((rind (rind eind))) ((lind eind)))) (lind (lind eind)) [])])])])])])])) [] ).