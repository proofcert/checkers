module ftab1.

accumulate fittings-tableaux.
accumulate lkf-kernel.

problem "fittings ex1"
  ((d+ (some (y\ ((p (rel x y)) &+& (d- (n (q y))))))) !-! (d+ (all (y\ ((n (rel x y)) !-! (p (q y))))))) % the formula
	(
    fitcert [] % the list
    (
      dectree eind none [
        dectree (rind eind) none [
          dectree (lind eind) (rind eind) [
            dectree (bind (lind eind) (rind eind)) (lind (rind eind)) []
          ]
        ]
      ]
    ) % the tree
    [] % the map
  )
	(map []).
	
	
	
%  ((d+ (all (y\ ((n (rel x y)) !-! (p (q y)))))) &-& (d+ (some (y\ ((p (rel x y)) &+& (d- (n (q y)))))))) % the refuted formula	