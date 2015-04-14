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
/*
Signature (to be moved to individual tests)
*/

inAr  f.
inAr  g.
inAr  h.

/* Bureau in order of appearance*/

all_kc (dlist (id From) (id Into)) (x\ dlist (id From) (id Into)).
store_kc (dlist (id From) (id Into)) _ resI (dlist (id From) (id Into)).
decide_ke (dlist (id From) (id Into)) predI ((rewC From 0) c>>  ((decOn Into)  c>> (doneWith resI))).
andPos_k (Cl c>> Cr) _ right-first Cl Cr. 
/*rightest branch*/
initial_ke (doneWith I) I.
/*middle branch*/
release_ke (decOn Into) (decOn Into).
store_kc (decOn Into) _ intoI (decOn Into).
decide_ke (decOn Into) Into (doneWith intoI).  
	  	 % Then initial already defined
/*leftest branch : the rewrite */
release_ke (rewC From I) (rewC From I).
store_kc (rewC From I) _ (chainI I) (rewC From I).

%######### decide, chain, etc.

/*Common (maybe move the initial_ke here*/
some_ke C V C :- (C = (_ c>> _));(C = (doneWith _)).

% Proving the sequent can be proved by deciding clauses C1, C2 and some other clause.
/*
store_kc (dlist C1 C2) _ lit (dlist C1 C2).
store_kc (dlist2 C1 S) _ lit (dlist2 C1 S).
store_kc (dlist3 S) _ lit (dlist3 S).
andPos_ke (dlist C1 C2) _  (dlist C1 C2) (dlist C1 C2).
andPos_ke (dlist2 C1 S) _  (dlist2 C1 S) (dlist2 C1 S).
andPos_ke (dlist3 S) _  (dlist3 S) (dlist3 S).
orNeg_kc (dlist C1 C2) _  (dlist C1 C2).
orNeg_kc (dlist2 C1 S) _  (dlist2 C1 S).
orNeg_kc (dlist3 S) _  (dlist3 S).
initial_ke (dlist _ _) _.
initial_ke (dlist _ _) _.
initial_ke (dlist2 _ _) _.
initial_ke (dlist3 _) _.
initial_ke done _.
release_ke (dlist C1 C2) (dlist C1 C2).
release_ke (dlist2 C1 S) (dlist2 C1 S).
release_ke (dlist3 S) (dlist3 S).
% here we decide the clauses for proving -C1,-C2,C3 of decide depth 3.
% Note that since they might be negative, we will need sometimes to decide on the cut formula
% This cut formula is indexed by lit but all other resolvents from previous
% steps are indexed by idx, so we need to either decide on C1, C2 or lit
decide_ke (dlist (rclause I S) C2) (idx I) (dlist2 C2 S).
decide_ke (dlist C1 (rclause I S)) (idx I) (dlist2 C1 S).
decide_ke (dlist C1 C2) lit (dlist2 C1 (sub [])).
decide_ke (dlist C1 C2) lit (dlist2 C2 (sub [])).
decide_ke (dlist2 (rclause I S) (sub [])) (idx I) (dlist3 S).
decide_ke (dlist2 _ (sub [])) lit (dlist3 (sub [])).
decide_ke (dlist3 (sub [])) lit done.
% the last cut is over t+ and we need to eliminate its negation
false_kc (dlist C1 C2) (dlist C1 C2).
% clauses are in prefix normal form and we just apply the sub in the right order
some_ke (dlist2 C (sub [T])) T (dlist2 C (sub [])).
some_ke (dlist2 C (sub [T,T2|R])) T (dlist2 C (sub [T2|R])).
some_ke (dlist3 (sub [T])) T (dlist3 (sub [])).
some_ke (dlist3 (sub [T,T2|R])) T (dlist3 (sub [T2|R])).
*/
