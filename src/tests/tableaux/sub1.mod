module sub1.

accumulate tableaux.
accumulate lkf-kernel.

 problem "sub1"
   (some (x\ (n (f x))) !-!
    all  (x\ (p (f x))))  
	(tabp  
		[gamma (idx 1) (idx 3), delta (idx 2) c (idx 4)]
		[closure (idx 3) (idx 4) ([c])] 
		[]  
	      	[back (idx 3)  [idx 3,  idx 1], 
	       	 back (idx 4)  [idx 4,  idx 2]])
(map [	
	pr 1  (some (x\ (n (f x)))),
	pr 2  (all  (x\ (p (f x)))),
	pr 3  (n (f c)),
	pr 4  (p (f c))
]).

signature (f X) (f Y) [X] [Y].
