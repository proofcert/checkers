module ftab1.

accumulate fittings-tableaux.
accumulate lkf-kernel.

problem "fittings ex1"
  ((d+ (all (y\ ((n (r x y)) !-! (p (q y)))))) &-& (d+ (some (y\ ((p (r x y)) &+& (d- (n (q y)))))))) % the formula
	(
    fitcert [eind] % the list
    (
      dectree eind none [
        dectree (rind eind) none [
          dectree (lind eind) (sind (rind eind)) [
            dectree (bind (lind eind) (rind eind)) (sind (lind (rind eind))) []
          ]
        ]
      ]
    ) % the tree
    [] % the map
  )
	(map []).

