module tab1.

accumulate fittings-tableaux.
accumulate lkf-kernel.

problem "tableaux test 1"
	(t+) /* positive version in fol */
/*   	(box (n f | p g) & (box (p f)) & (dia (n g) | (dia (n f)))) */
	(fittab [conjinf (idx 1) 2 3, conjinf (idx 3) 4 5, disjinf (idx 5) 6 7,
	diainf (idx 6) 8 (lbl 1), boxinf (idx 8) 9 (lbl 1), disjinf (idx 9) 10 11, 
	boxinf (idx 4) 12 (lbl 1), close (idx 12), diainf (idx 7) 13 (lbl 2),
	boxinf (idx 4) 14 (lbl 2), close (idx 14), close (idx 11)
	])
	(map [
/*	pr 1 (box (n f | p g) & (box (p f)) & (dia (n g) | (dia (n f)))),
	pr 2 (box (n f | p g)),
	pr 3 ((box (p f)) & (dia (n g) | (dia (n f)))),	
	pr 4 (box (p f)),
	pr 5 (dia (n g) | (dia (n f))),	
	pr 6 (dia (n g)),	
	pr 7 (dia (n f))*/
	]
).
