module tabgen. % generates fittings tableaux proofs using simple search over the tableaux kernel

%closure_kc A (fvtabsimp _ (tabp (closureinf A))).

%conj_kc (fvtabsimp L (tabp (conjinf (lform C F) B))) (lform D F) (fvtabsimp L B).

%disj_kc (fvtabsimp L (tabp (disjinf (lform C F) B1 B2))) (lform D F) (fvtabsimp L B1) (fvtabsimp L B2).

%box_ke (fvtabsimp (evars Box Dia) (tabp (boxinf (lform C F) E B))) (lform D F) E (fvtabsimp (evars Box Dia) B).
	member E Box.

%dia_kc (fvtabsimp (evars Box [L|Dia]) (tabp (diainf (lform C F) L B))) (lform D F) L (w\ fvtabsimp (evars Box Dia) B).
