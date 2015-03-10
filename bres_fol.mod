module bres_fol.

accumulate debug.
accumulate  lkf-kernel.


testAllRes :-
  example Number F Cert,
  print "Running on example ", term_to_string Number Str, print Str, print ":\n",
  if (entry_pointLKF Cert F)
      (print "Success\n==============================================\n")
		  (print "Fail\n", halt), fail.


type prinn string -> o.
 prinn S.
% prinn S :- print S, print "\n".

orNeg_kc    Cert _  Cert :- prinn "orNeg_kc ".
% storing according to an index held in the Map
store_kc    (rlist A B M) C (idx I) (rlist A B M) :- (member (pr C I) M), prinn "store_kc1".
% storing when the index is not given and therefore, not used by experts
store_kc    Cert _ lit Cert :- prinn "store_kc4".
andPos_ke   Cert _  Cert Cert :- prinn "andPos_ke ".
initial_ke  _ _  :- prinn "initial_ke ".
release_ke  Cert Cert :- prinn "release_ke ".
% here we decide the the clauses for proving -C1,-C2,C3 of decide depth 3
decide_ke (dlist [I,J] [S1, S2]) (idx I) (dlist [J] [S1,S2]) :- prinn "decide_ke2 ".
decide_ke (dlist [I,J] [S1, S2]) (idx J) (dlist [I] [S2,S1]) :- prinn "decide_ke2 ".
decide_ke (dlist [I] [S]) (idx I) (dlist [] [S]) :- prinn "decide_ke2 ".
decide_ke (dlist [] []) _ (ddone) :- prinn "decide_ke2 ".
% clauses are in prefix normal form and we just apply the sub in the right order
some_ke (dlist [I] [sub [T], S2]) T (dlist [I] [S2]) :- prinn "some_ke".
some_ke (dlist [I] [sub [T|R],S2]) T (dlist [I] [sub R,S2]) :- prinn "some_ke".
% Cuts correspond to resolve steps except for the last resolve
cut_ke    (rlist [(res I J S1 S2) | R1] [CutForm | R2] M) CutForm (dlist [I,J] [S1,S2]) (rlist R1 R2 M) :-
  prinn "cut_ke".
% last cut on cut formula false, we could just use decide ND on one of the formulas but
% there is more logic to that in the fol case so we use the cut rule.
cut_ke    (rlist [res I J S1 S2] [] _) f- (dlist [I,J] [S1,S2]) (lastd [I,J]) :-
  prinn "cut_ke".
% this decide is being called after the last cut
decide_ke (lastd [I,J]) (idx I) ddone :- prinn "decide_ke ".
decide_ke (lastd [I,J]) (idx J) ddone :- prinn "decide_ke ".
false_kc Cert Cert :- prinn "false_kc".





% example Number Theorem Cert Map
% Theorem - the theorem to prove
% Cert - a certificate obtained from a resolution refutation of the negation of the theorem
% Cert contains a list of n resolve steps, a list of n-1 cut formulas (the last resolve is a cut on f- and is ommited
% Map - a mapping of all indices used in the refutation to formulas

example 1
  (n (g a) !-!
   p (g (h (h (a)))) !-!
   some (x\ (p (g (x))) &+& (n (g (h (x))))))
	(rlist [res 1 3 (sub []) (sub [a]), res 3 4 (sub [h (a)]) (sub []), res 2 5 (sub []) (sub [])]
  [p (h (a)), p (h (h (a)))]
  [pr (n (g a)) 1,
   pr (p (g (h (h (a))))) 2,
   pr (some (x\ (p (g (x))) &+& (n (g (h (x)))))) 3,
   pr (p (h (g (a)))) 4,
   pr (p (h (g (g (a))))) 5]).




% Utilities
print_clause I S  :- print "nclause ",
                     term_to_string I Istr, print Istr, print " = ",
                     term_to_string S Sstr, print Sstr, print "\n".
print' Term :- term_to_string Term String, print String.
