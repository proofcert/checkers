module ftab3.
accumulate fittings-tableaux.
accumulate lkf-kernel.
modalProblem "ModLeanTAP problem t4"
[]
((dia (-- p1) !! box (++ q1)) !! dia ((++ p1) && (-- q1)))
(fitcert []
((dectree eind none
[(dectree (lind eind) none %     (dia (-- p1) !! box (++ q1))
[(dectree (rind (lind eind)) none %      box (++ q1)
[(dectree (lind (lind eind)) (rind (lind eind)) %     dia (--p1)
[(dectree (rind eind) (rind (lind eind)) %      dia ((++ p1) && (-- q1)))
[(dectree (bind ((rind eind)) ((rind (lind eind)))) none  %   (++ p1) && (-- q1)
[(dectree (lind (bind ((rind eind)) ((rind (lind eind))))) (bind ((lind (lind eind))) ((rind (lind eind)))) []), %  ++p1  --p1

(dectree (lind (rind (lind eind))) (rind (bind ((rind eind)) ((rind (lind eind))))) [])])])])])])])) [] ).
