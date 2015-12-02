module sub3.

accumulate tableaux.
accumulate lkf-kernel.

 problem "sub3"
   	(some (x\ (n (f x)) !-!  n (g x)) !-!
    	((all  (x\ (p (f x))))  &+&  (all (x\ (p (g x))))))  
	(tabp
		[gamma (idx 1) (idx 3), alpha (idx 3) (idx 4) (idx 5), beta (idx 2) (idx 6) (idx 7), delta (idx 6) c (idx 8), delta (idx 7) c (idx 9)]
		[closure (idx 4) (idx 8) ([c]), closure (idx 5) (idx 9) ([c])] 
		[]  
	      	[back (idx 4)  [idx 4,  idx 3,  idx 1], 
	       	 back (idx 5)  [idx 5,  idx 3,  idx 1],
		 back (idx 8)  [idx 8,  idx 6,  idx 2],
		 back (idx 9)  [idx 9,  idx 7,  idx 2]])
	(map [	
	pr 1  (some (x\ (n (f x)) !-! (n (g x)))),
	pr 2  ((all  (x\ (p (f x)))) &+& (all (x\ (p (g x))))),
	pr 3  (n (f c) !-! (n (g c))),
	pr 4  (n (f c)),
	pr 5  (n (g c)),
	pr 6  (all (x\ (p (f x)))),
	pr 7  (all (x\ (p (g x)))),
	pr 8  (p (f c)),
	pr 9  (p (g c))
]).

signature (f X) (f Y) [X] [Y].
signature (g X) (g Y) [X] [Y].
