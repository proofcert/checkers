module col016.

accumulate lkf-kernel.
accumulate eprover.
%accumulate paramodulation.
accumulate resolution_steps.

/*=== Adding quantifiers + Changing last clause + f- to t+ + ===*/


resProblem "col016" 
	   [(pr 6 (some X1\ p (( apply m X1 ) == ( apply X1 X1 ))) ),
	    (pr 5 (some X1\ some X2\ p (( apply ( apply l X1 ) X2 ) == ( apply X1 ( apply X2 X2 ) ))) ),
	    (pr 1 (n (( apply m ( apply l m ) ) == ( apply m ( apply m ( apply l m ) ) ))) )] 
(rsteps [pm (id (idx 6)) (id (idx 5)) 4, 
	 pm (id (idx 4)) (id (idx 6)) 2, 
	 pm (id (idx 1)) (id (idx 2)) 0] estate )
 (map [
pr 4 (some X1\ some X2\ p (( apply ( apply l X1 ) X2 ) == ( apply X1 ( apply m X2 )))),
pr 2 (some X1\ p (( apply m ( apply l X1 ) ) == ( apply X1 ( apply m ( apply l X1 ) ) ))),
pr 0 t+
]).



/*=== Using old paramodulation stuff == Doesn't work =*/

/*
resProblem "col016" 
	   [(pr 6 (p (( apply m X1 ) == ( apply X1 X1 ))) ),
	    (pr 5 (p (( apply ( apply l X1 ) X2 ) == ( apply X1 ( apply X2 X2 ) ))) ),
	    (pr 6 (p (( apply m X1 ) == ( apply X1 X1 ))) ),
	    (pr 1 (n (X1 == ( apply combinator X1 ))) )] 
(rsteps [resolv (pid (idx 5)) (pid (idx 6)) 4, 
	 resolv (pid (idx 6)) (pid (idx 4)) 2, 
	 resolv (pid (idx 1)) (pid (idx 2)) 0] estate )
 (map [
pr 2 (p (( apply X1 ( apply m ( apply l X1 ) ) ) == ( apply m ( apply l X1 ) ))),
pr 0 f+,
pr 3 (p (( apply m X1 ) == ( apply X1 X1 ))),
pr 6 (p (( apply m X1 ) == ( apply X1 X1 ))),
pr 5 (p (( apply ( apply l X1 ) X2 ) == ( apply X1 ( apply X2 X2 ) ))),
pr 4 (p (( apply X1 ( apply m X2 ) ) == ( apply ( apply l X1 ) X2 ))),
pr 1 (n (X1 == ( apply combinator X1 )))
]).
*/


/*=== Using quantifiers AND  old paramodulation stuff And removing duplicates (6)===  works*/

/*
resProblem "col016" 
	   [(pr 6 (some X1\ p (( apply m X1 ) == ( apply X1 X1 ))) ),
	    (pr 5 (some X1\ some X2\ p (( apply ( apply l X1 ) X2 ) == ( apply X1 ( apply X2 X2 ) ))) ),
	    %(pr 6 (some X1\ p (( apply m X1 ) == ( apply X1 X1 ))) ),
	    (pr 1 ( n (( apply m ( apply l m ) ) == ( apply m ( apply m ( apply l m ) ) ))   ) )] 
%Changing claise 1
	   % (pr 1 (some X1\ n (X1 == ( apply combinator X1 ))) )] 
(rsteps [resolv (pid (idx 6)) (pid (idx 5)) 4, 
	 resolv (pid (idx 4)) (pid (idx 6)) 2,   
	 resolv (pid (idx 1)) (pid (idx 2)) 0] estate )
 (map [
pr 4 (some X1\ some X2\ p (( apply ( apply l X1 ) X2 ) == ( apply X1 ( apply m X2 )))),
pr 2 (some X1\ p (( apply m ( apply l X1 ) ) == ( apply X1 ( apply m ( apply l X1 ) ) ))),
pr 0 t+
]).
*/


/*=== Original thing. ===*/

/*
resProblem "col016" 
	   [(pr 6 (p (( apply m X1 ) == ( apply X1 X1 ))) ),
	    (pr 5 (p (( apply ( apply l X1 ) X2 ) == ( apply X1 ( apply X2 X2 ) ))) ),
	    (pr 6 (p (( apply m X1 ) == ( apply X1 X1 ))) ),
	    (pr 1 (n (X1 == ( apply combinator X1 ))) )] 
(rsteps [pm (id (idx 5)) (id (idx 6)) 4, 
	 pm (id (idx 6)) (id (idx 4)) 2, 
	 pm (id (idx 1)) (id (idx 2)) 0] estate )
 (map [
pr 2 (p (( apply X1 ( apply m ( apply l X1 ) ) ) == ( apply m ( apply l X1 ) ))),
pr 0 f-,
pr 3 (p (( apply m X1 ) == ( apply X1 X1 ))),
pr 6 (p (( apply m X1 ) == ( apply X1 X1 ))),
pr 5 (p (( apply ( apply l X1 ) X2 ) == ( apply X1 ( apply X2 X2 ) ))),
pr 4 (p (( apply X1 ( apply m X2 ) ) == ( apply ( apply l X1 ) X2 ))),
pr 1 (n (X1 == ( apply combinator X1 )))
]).
*/






inSig apply.


