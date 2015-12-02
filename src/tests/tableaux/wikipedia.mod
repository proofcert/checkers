module wikipedia.

accumulate tableaux.
accumulate lkf-kernel.

 problem "wikipedia"
   (some (x\ (n (f x))) !-!
    all  (x\ (p (f x)) &+& (p (f (g x)))) )  
	(tabp  
		[gamma (idx 1) (idx 3), delta (idx 2) c (idx 4), beta (idx 4)(idx 5)(idx 6)]
		[closure (idx 3) (idx 5) ([c]), closure (idx 3) (idx 6) ([(g c)])] 
		[]  
	      	[back (idx 3)  [idx 3,  idx 1], 
	       	 back (idx 5)  [idx 5,  idx 4,  idx 2],
	       	 back (idx 6)  [idx 6,  idx 4,  idx 2]])
(map [	
	pr 1  (some (x\(n (f x)))),
	pr 2  (all  (x\ (p (f x)) &+& (p (f (g x))))),
	pr 3  (n (f c)),
	pr 4  ((p (f c)) &+& (p (f (g c)))),
	pr 5  (p (f c)),
	pr 6  (p (f (g c)))
]).

signature (f X) (f Y) [X] [Y].
signature (g X) (g Y) [X] [Y].
