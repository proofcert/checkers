module sub2.

accumulate tableaux.
accumulate lkf-kernel.

 problem "sub2"
   (some (x\ (n (f x))) !-!
    all  (x\ (p (f x))) &+& all (x\ (p (f x))))  
	(tabp  
		[gamma (idx 1) (idx 3), beta (idx 2) (idx 4) (idx 5), delta (idx 4) c (idx 6), delta (idx 5) c (idx 7)]
		[closure (idx 3) (idx 6) ([c]), closure (idx 3) (idx 7) ([c])] 
		[]  
	      	[back (idx 3)  [idx 3,  idx 1], 
	       	 back (idx 6)  [idx 6,  idx 4,  idx 2],
		 back (idx 7)  [idx 7,  idx 5,  idx 2]])
(map [	
	pr 1  (some (x\ (n (f x)))),
	pr 2  ((all  (x\ (p (f x)))) &+& (all (x\ (p (f x))))),
	pr 3  (n (f c)),
	pr 4  (all (x\ (p (f x)))),
	pr 5  (all (x\ (p (f x)))),
	pr 6  (p (f c)),
	pr 7  (p (f c))
]).

signature (f X) (f Y) [X] [Y].
