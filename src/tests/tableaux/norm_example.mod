module norm_example.

accumulate tableaux.
accumulate lkf-kernel.

 problem "norm_example"
  (all (x\ ((p (f x)) !-! (n (f x)))))
	(tabp	([delta (idx 1) c (idx 2), alpha (idx 2) (idx 3) (idx 4)])  
		([closure(idx 3)(idx 4)(nil)]) 
		[] 
		[back (idx 3) [idx 3, idx 2, idx 1], 
		 back (idx 4) [idx 4, idx 2, idx 1]])	  
(map [ 	
	pr 1 (all (x\ ((p (f x)) !-! (n (f x))))),
	pr 2 ((p (f c)) !-! (n (f c))),
	pr 3 (p (f c)),
	pr 4 (n (f c))]).

signature (f X) (f Y) [X] [Y].
