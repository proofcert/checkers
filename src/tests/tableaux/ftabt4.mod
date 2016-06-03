module ftabt4.
accumulate fittings-tableaux.
accumulate lkf-kernel.
modalProblem "ftabt4"
((dia (-- p1) !! box (++ q1)) !! dia ((++ p1) && (-- q1)))
(fitcert []
((dectree eind none [(dectree (lind eind) none [(dectree (lind (lind eind)) (rind (lind eind)) [(dectree (rind (lind eind)) none [(dectree (rind eind) (rind (lind eind)) [(dectree (bind ((rind eind)) ((rind (lind eind)))) none [(dectree (lind (bind ((rind eind)) ((rind (lind eind))))) (bind ((lind (lind eind))) ((rind (lind eind)))) []), (dectree (rind (bind ((rind eind)) ((rind (lind eind))))) (lind (rind (lind eind))) [])])])])])])])) [] ).