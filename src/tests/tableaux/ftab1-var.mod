module ftab1-var.
accumulate fittings-tableaux.
accumulate lkf-kernel.
modalProblem "ModLeanTAP problem t1"
[]
(((dia (-- p1)) !! (box (++ q1))) !! (dia ((++ p1) && (-- q1))))
(fitcert []
((dectree eind none [
(dectree _  none [
(dectree _  none [
(dectree _  (rind (lind eind)) [
(dectree _ (rind (lind eind)) [
(dectree _ none [
  (dectree _  (bind ((lind (lind eind))) ((rind (lind eind)))) []),
  (dectree _ (rind (bind ((rind eind)) ((rind (lind eind))))) [])])])])])])])) [] ).
