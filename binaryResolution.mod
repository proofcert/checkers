/*
I took the same examples in "papers/fpc/mods" but change things to fit with
the paper (like the false clerk doesn't have access to the formula)
and also to be closer to the reality of proof evidence of resolution.
Indeed, the provers output their own indices of clauses and they are
not always consequetive (some clauses get eliminated because redundunt)
This fpc keeps the original indices.

The code for the agents is exactly the same as the one in the paper.

Also, I will directly take polarized formulas.
"*/

module binaryResolution.
accumulate imbed.

% First field of example says if the example is activated.
testAllResImbed :-
   example 1 Number OrigClaus Clauses ResolSteps,
   if ( resolveImbed OrigClaus Clauses ResolSteps)
 	   	  (print "Success\n==============================================\n")
		  (print "Fail\n", halt), fail.
resolveImbed 0 Clauses ResolSteps :-
   middleClauses Clauses =>
   	 (spyV 0 "final entry to Embed" (entry_pointImbed (rlist ResolSteps) f-)).
resolveImbed OrigClaus [(pr Idx C)|Clauses] ResolSteps :-
    spyV 0 "negate" (negate C NC),!,
    spyV 0 "isPosum" (isPosUM NC),!,
    imbedForm- NC INC,
    %print_clause Idx NC,
    OrigClaus' is (OrigClaus - 1),!,
   inCtxt (idx Idx) INC =>
        spyV 0 "recCall resolve" (resolveImbed OrigClaus' Clauses ResolSteps).





testAllRes :- example 1 Number OrigClaus Clauses ResolSteps,
	if ( resolve OrigClaus Clauses ResolSteps)
 	   	  (print "Success\n==============================================\n")
		  (print "Fail\n", halt), fail.
resolve 0 Clauses ResolSteps :-
   middleClauses Clauses => (!,  entry_pointLKF (rlist ResolSteps) f-).
resolve OrigClaus [(pr Idx C)|Clauses] ResolSteps :-
    spyV 0 "negate" (negate C NC),!,
    spyV 0 "isPos" (isPosUM NC),!,
    %print_clause Idx NC,
    OrigClaus' is (OrigClaus - 1),!,
   inCtxt (idx Idx) NC => spyV 0 "recCall resolve" (resolve OrigClaus' Clauses ResolSteps).

/*
  FPCresolution part one
*/
type prinn string -> o.
 prinn S.
 %prinn S :- print S, print "\n".


orNeg_kc    (dl L) _  (dl L) :- prinn "orNeg_kc ".
false_kc    (dl L) (dl L) :- prinn "false_kc ".
store_kc    (dl L) C  lit (dl L)./* print "newlit = ",  print' C, print "\n".
	    	      	    I put "_" instead of "lit" because the translation
			    to LJF turns literals into lit arr f, and then agents are confused*/
decide_ke   (dl [I]) (idx I) (dl []) :- prinn "decide_ke2 ".
decide_ke   (dl [I,J]) (idx I) (dl [J]) :- prinn "decide_ke3 ".
decide_ke   (dl [J,I]) (idx I) (dl [J]) :- prinn "decide_ke4 ".
decide_ke   (dl L) _ ddone :- prinn "decide_ke1 ".

all_kc	    (dl L) (x\ (dl L)) :- prinn "all_kc ".
true_ke     (dl L) :- prinn "true_ke ".
some_ke     (dl L) _  (dl L) :- prinn "some_ke ".
andPos_ke   (dl L) _  (dl L) (dl L) :- prinn "andPos_ke ".
initial_ke  ddone _  :- prinn "initial_ke ".
initial_ke  (dl L) _ :- prinn "initial_ke found literal before ".
release_ke  (dl L) (dl L) :- prinn "release_ke ".
/*
  FPCresolution part two
*/
false_kc  (rlist R) (rlist R) :- prinn "false_kc Here".
% The store, when called with (rlisti K []) just tell the decide to decide on K,
% since we know the last one to be t+
store_kc  (rlisti K R) _ (idx K) (rlist R) :- prinn "store_kc " .
true_ke   rdone :- prinn "true_ke ".
decide_ke (rlist [])  (idx I) rdone :- prinn "decide_ke ".
cut_ke    (rlist [(resol I J K) |R]) CutForm (dl [I,J]) (rlisti K R) :-
  print "Entering CUT \n",
  spyV 0 "" (middleClauses Clauses),
  spyV 0 "Member" (member (pr K CutForm) Clauses),
  print "Resolving ", print' (resol I J K),
  print " yields cut formula ", print' CutForm, print ".\n".
/*
  spyV 0 "negOrPos?" ((isNeg CutForm,
   CertA = ,
   CertB = )
  ;
  (isPos CutForm,
   CertB = (dl [I,J]),
   CertA = (rlisti K R))).
*/

% example Indice NumbOriginalClauses Clause ResolutionSteps

example 0 1 3
	[pr 1 (p r1 !-! p r2),
	 pr 2 (n r1 !-! p r2),
	 pr 3 (n r2),
	 pr 4 (p r2),
	 pr 5 f- ]
	[resol 1 2 4,
 	 resol 3 4 5].

example 0 2 2 [pr 1 (p r1),
	     pr 2 (n r1),
	     pr 3 f-]
	     [resol 1 2 3].

example 0 3 4 [pr 1 (n a !-! n b),
	       pr 2 (p a !-! n b),
	       pr 3 (n a !-! p b),
	       pr 4 (p a !-! p b),
	       pr 6 (n b),
	       pr 8 (p b),
	       pr 10 f-]
	    [resol 1 2 6,
	     resol 3 4 8,
	     resol 6 8 10].
example 1 4 5 [pr 1 (n a !-! n b !-! p c),
	       pr 2 (p a !-! n b),
	       pr 3 (n a !-! p b !-! p c),
	       pr 4 (p a !-! p b),
	       pr 5 (n c),
	       pr 6 (n b !-! p c),
	       pr 8 (p b !-! p c),
	       pr 9 (p c),
	       pr 10 f-]
	      [resol 3 2 6,
	       resol 3 4 8,
  	       resol 6 8 9,
	       resol 9 5 10
	      ].
example 0 5 3
	[pr 1 (p (g a)),
	 pr 2 (all x\ (n (g x)) !-! (p (h x))),
	 pr 3 (n (h a)),
	 pr 4 (p (h a)),
	 pr 5 (f-)]
	[resol 1 2 4, resol 4 3 5].


% Utilities
print_clause I S  :- print "nclause ",
                     term_to_string I Istr, print Istr, print " = ",
                     term_to_string S Sstr, print Sstr, print "\n".
print' Term :- term_to_string Term String, print String.
