module fvtabsimp.

closure_kc A (fvtabsimp _ (tabp (closureinf A))).

conj_kc (fvtabsimp L (tabp (conjinf A B))) C (fvtabsimp L B) :-
term_to_string A A', term_to_string C C', print A', print " -------- ", print C', print "\n".
disj_kc (fvtabsimp L (tabp (disjinf A B1 B2))) A (fvtabsimp L B1) (fvtabsimp L B2).
box_ke (fvtabsimp L (tabp (boxinf A C B))) A C (fvtabsimp L B) :-
	member C L.
dia_kc (fvtabsimp L (tabp (diainf A C B))) A C (w\ fvtabsimp L B) :-
  member C L.
