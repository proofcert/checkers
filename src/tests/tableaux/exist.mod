module exist.

accumulate tableaux.
accumulate lkf-kernel.

 problem "exist"
	( (some (x\ n(f x))) !-!
	  (some (x\ p(f x)))	)
	(tabp 	[gamma (idx 1)(idx 3), gamma (idx 2)(idx 4)]
		[closure (idx 3)(idx 4) [c,c]]
		[]
		[back (idx 3) [idx 3, idx 1], back (idx 4) [idx 4, idx 2]])
	(map [  pr 1 (some (x\ n (f x))),
		pr 2 (some (x\ p (f x))),
		pr 3 (n (f c)),
		pr 4 (p (f c)) ]).

signature (f X) (f Y) [X] [Y].
