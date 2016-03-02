module forall.

accumulate tableaux.
accumulate lkf-kernel.

 problem "forall"
	(all (x\ (n(f x)) !-!  (p(f x))))
	(tabp 	[delta (idx 1) c (idx 2), alpha (idx 2) (idx 3) (idx 4)]
		[closure (idx 3)(idx 4)[]]
		[]
		[back (idx 3) [idx 3, idx 2, idx 1], back (idx 4)[idx 4, idx 2, idx 1]])
	(map [  pr 1 (all (x\ ((n (f x)) !-! (p (f x))))),
		pr 2 ((n (f c)) !-! (p (f c))),
		pr 3 (n (f c)),
		pr 4 (p (f c)) ]).

eigencopy (f X) (f Y) :- eigencopy X Y.
