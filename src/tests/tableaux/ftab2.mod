module ftab2.

accumulate fittings-tableaux.
accumulate lkf-kernel.

modalProblem "fittings ex2" %name
  ( (dia (-- q)) !! (box (++ q)) ) % modal formula (already dualized, i.e. the valid one)
	(
    fitcert [] % the list
    (
      dectree eind none [
        dectree (rind eind) none [
          dectree (lind eind) (rind eind) [
            dectree (lind (rind eind)) (bind (lind eind) (rind eind)) []
          ]
        ]
      ]
    ) % the tree
    [] % the map
  ).