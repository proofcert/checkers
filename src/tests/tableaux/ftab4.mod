module ftab4.

accumulate fittings-tableaux.
accumulate lkf-kernel.

modalProblem "ModLeanTap t4"
(((box (++ q1)) && (box (++ q2))) !! (dia ((-- q1) !! (-- q2))))
	(
    fitcert []
      (dectree eind none [
        (dectree (lind eind) none [
          (dectree (lind (lind eind)) none [
            (dectree (rind eind) (lind (lind eind)) [
              (dectree (lind (bind (rind eind) (lind (lind eind)))) (lind (lind eind)) [])])]),
          (dectree (rind (lind eind)) none [
            (dectree (rind eind) (rind (lind eind)) [
              (dectree (rind (bind (rind eind) (lind (lind eind)))) (rind (lind eind)) [])])])])]) [] ).
