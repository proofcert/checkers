module fvtabsimp.

closure_kc _.
conj_kc Cert Cert.
disj_kc Cert Cert Cert.
box_ke (fvtabsimp L) A (fvtabsimp L') :-
	memb_and_rest L (sub A) L'.
