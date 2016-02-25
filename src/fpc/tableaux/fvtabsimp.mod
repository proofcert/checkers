module fvtabsimp.

closure_kc A (fvtabsimp _ (tabp (closureinf A))).

conj_kc (fvtabsimp L (tabp (conjinf (lform C F) B))) (lform D F) (fvtabsimp L B) :-
  eigencopy C D.

disj_kc (fvtabsimp L (tabp (disjinf A B1 B2))) A (fvtabsimp L B1) (fvtabsimp L B2).
box_ke (fvtabsimp L (tabp (boxinf A C B))) A C (fvtabsimp L B) :-
	member C L.
dia_kc (fvtabsimp L (tabp (diainf A C B))) A C (w\ fvtabsimp L B) :-
  member C L.

eigencopy (label L) (label L') :- eigencopy L L'.
eigencopy [] [].
eigencopy [L|Ls] [L'|Ls'] :- eigencopy L L', eigencopy Ls Ls'.
