module ftab4.

accumulate fittings-tableaux.
accumulate lkf-kernel.

modalProblem "ModLeanTap t4"
(((box (-- q1)) && (box (++ q2))) !! (dia ((++ q1) !! (-- q2))))
	(
    fitcert []
      (dectree eind none [
        (dectree (lind eind) none [
          (dectree (lind (lind eind)) none [
            (dectree (rind eind) (lind (lind eind)) [
	      (dectree (bind (rind eind) (lind (lind eind))) none [
		(dectree (lind (bind (rind eind) (lind (lind eind)))) (lind (lind (lind eind))) [])])])]),
          (dectree (rind (lind eind)) none [
            (dectree (rind eind) (rind (lind eind)) [
	      (dectree (bind (rind eind) (rind (lind eind))) none [
              (dectree (lind (rind (lind eind))) (rind (bind (rind eind) (rind (lind eind)))) [])])])])])]) [] ).
