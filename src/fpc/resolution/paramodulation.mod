module paramodulation.


/*
To avoid adding the rewrit axioms everywhere, I add them here, and "include" them in every paramX.
*/
inCtxt eqI (some S\ some T\ (n (S == T) &+& (p (S =*= T) !+! p (T =*= S)))).
inCtxt congI (some F\ some X\ some Y\ n (X =*= Y) &+& p (F X =*= F Y)).
inCtxt congI (some F\ some X\ some Y\ some Z\ n (X =*= Y) &+&
                                                  (p (F X Z =*= F Y Z) !+!
					     	   p (F Z X =*= F Z Y))).
inCtxt congI (some F\ some X\ some Y\ some Z\ some W\
       	     	      	      	       n (X =*= Y) &+&
                                                  (p (F W X Z =*= F W Y Z) !+!
					     	   p (F Z W X =*= F Z W Y) !+!
					     	   p (F Z X W =*= F Z Y W))).
inCtxt predI (some S\ some T\ some T'\
       	     	   n (T =*= T') &+& (n (S == T) &+& p (S == T')
		     	    	    !+!
				     n (T == S) &+& p (T' == S))).


/* Bureau in order of appearance*/
false_kc C C.
all_kc (dlist (pid From) (pid Into)) (x\ dlist (pid From) (pid Into)).
store_kc (dlist (pid From) (pid Into)) _ resI (dlist (pid From) (pid Into)).
decide_ke (dlist (pid From) (pid Into)) predI ((rewC From 0) c>>  ((decOn Into)  c>> (doneWith resI))).
andPos_k (Cl c>> Cr) _ right-first Cl Cr.
andPos_k (Cl c<< Cr) _ left-first Cl Cr.
/*rightest branch*/
initial_ke (doneWith I) I.
/*middle branch*/
release_ke (decOn Into) (decOn Into).
store_kc (decOn Into) _ intoI (decOn Into).
decide_ke (decOn Into) Into (doneWith intoI).
	  	 % Then initial already defined
/*leftest branch : the rewrite */
release_ke (rewC From I) (rewC From I).
store_kc (rewC From I) _ (chainI I') (rewC From I') :- I' is I + 1.
/*either :*/ decide_ke (rewC From I) congI (witC ((rewC From I) c>> (doneWith (chainI I)))).
             some_ke (witC C) FunctionSymbol C :- inSig FunctionSymbol.
	     orPos_ke C _ _ C :- (C = (doneWith I)) ; (C = (_ c>> _)).
/* or    :*/ decide_ke (rewC From I) eqI ((fromC From) c<< (doneWith (chainI I))).
   	     release_ke (fromC I) (fromC I).
	     store_kc (fromC I) _ fromI (fromC I).
	     decide_ke (fromC I) I (doneWith fromI).

/*Common (maybe move the initial_ke here*/
some_ke C V C :- (C = (_ c<< _)) ; (C = (_ c>> _)) ; (C = (doneWith _)).

/* Last of last of back bone of cuts : no rewrite, just instanciation. One of them is necessarily a negative
atom (otherwise, not stored)
We can say " From is the positive and into is the negative"
Then we are able to remove one of the following */

decide_ke (dlist (pid From) (pid Into)) From (doneWith Into).
decide_ke (dlist (pid From) (pid Into)) Into (doneWith From).
