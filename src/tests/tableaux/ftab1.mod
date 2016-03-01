module ftab1.

accumulate fittings-tableaux.
accumulate lkf-kernel.

problem "fittings ex1"
  ((d+ (all (y\ ((n (r x y)) !-! (p (q y)))))) &-& (d+ (some (y\ ((p (r x y)) &+& (d- (n (q y)))))))) % the formula
	(
    fitcert [eind] % the list
    (
      dectree eind eind [
        dectree (rind eind) eind [
          dectree (lind eind) (rind eind) [
            dectree (bind (lind eind) (rind eind)) (lind (rind eind)) []
          ]
        ]
      ]
    ) % the tree
    [] % the map
  )
	(map []).

