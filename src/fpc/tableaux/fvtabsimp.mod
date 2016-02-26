module fvtabsimp.

closure_kc A (fvtabsimp _ (tabp (closureinf A))).

conj_kc (fvtabsimp L (tabp (conjinf (lform C F) B))) (lform D F) (fvtabsimp L B) :-
  eigencopy C D.

disj_kc (fvtabsimp L (tabp (disjinf (lform C F) B1 B2))) (lform D F) (fvtabsimp L B1) (fvtabsimp L B2) :-
  eigencopy C D.

box_ke (fvtabsimp (evars Box Dia) (tabp (boxinf (lform C F) E B))) (lform D F) E (fvtabsimp (evars Box Dia) B) :-
  eigencopy C D,
	member E Box.

dia_kc (fvtabsimp (evars Box [L|Dia]) (tabp (diainf (lform C F) L B))) (lform D F) L (w\ fvtabsimp (evars Box Dia) B) :-
  eigencopy C D.

eigencopy (label L) (label L') :- eigencopy L L'.
eigencopy [] [].
eigencopy [L|Ls] [L'|Ls'] :- eigencopy L L', eigencopy Ls Ls'.
