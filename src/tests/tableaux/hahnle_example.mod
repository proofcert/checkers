module hahnle_example.

accumulate tableaux.
accumulate lkf-kernel.

 problem "hahnle_example"
   (all (x\(n (f x))) !-!
    some (x\ (p (f x)) &+& (n (g x))) !-!
    some (x\ (p (g x)) &+& (n (h x))) !-!
    some (x\ (p (f x)) &+& (p (h x)))	)
	(tabp	[delta (idx 1) c (idx 5), gamma (idx 2) (idx 6), beta (idx 6) (idx 7) (idx 8), gamma (idx 3) (idx 9), beta (idx 9) (idx 10) (idx 11), gamma (idx 4) (idx 12), beta(idx 12)(idx 13)(idx 14)]
		[closure (idx 5) (idx 7) ([c]), closure (idx 8) (idx 10) ([c]), closure (idx 5) (idx 13) ([c]), closure (idx 11) (idx 14) ([]) ]
		[]
	      	[back (idx 5)  [idx 5,  idx 1],
	         back (idx 7)  [idx 7,  idx 6,  idx 2],
	         back (idx 8)  [idx 8,  idx 6,  idx 2],
	       	 back (idx 10) [idx 10, idx 9,  idx 3],
	       	 back (idx 13) [idx 13, idx 12, idx 4],
	       	 back (idx 11) [idx 11, idx 9,  idx 3 ],
	       	 back (idx 14) [idx 14, idx 12, idx 4]])
(map [
	pr 1  (all (x\(n (f x)))),
	pr 2  (some (x\ (p (f x)) &+& (n (g x)))),
	pr 3  (some (x\ (p (g x)) &+& (n (h x)))),
	pr 4  (some (x\ (p (f x)) &+& (p (h x)))),
	pr 5  (n (f c)),
	pr 6  ((p (f c)) &+& (n (g c))),
	pr 7  (p (f c)),
	pr 8  (n (g c)),
	pr 9  ((p (g c)) &+& (n (h c))),
	pr 10 (p (g c)),
	pr 11 (n (h c)),
	pr 12 ((p (f c)) &+& (p (h c))),
	pr 13 (p (f c)),
	pr 14 (p (h c))
]).

eigencopy (f X) (f Y) :- eigencopy X Y.
eigencopy (g X) (g Y) :- eigencopy X Y.
eigencopy (h X) (h Y) :- eigencopy X Y.
