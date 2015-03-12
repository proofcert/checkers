module bres_fol.

accumulate debug.
accumulate  lkf-kernel.
accumulate lists.

testAllRes :-
  example Number F Cert (map Map),
  print "Running on example ", term_to_string Number Str, print Str, print ":\n",
  resolve Map F Cert.

resolve [] F Cert :-
  if (entry_pointLKF Cert F)
      (print "Success\n==============================================\n")
		  (print "Fail\n", halt), fail.
resolve [(pr I C) | R] F Cert :-
  %term_to_string I Ind, term_to_string C Cl, print Ind, print " mapsto ", print Cl, print "\n",
  mapsto I C => resolve R F Cert.


type prinn string -> o.
 %prinn S.
 prinn S :- print S, print "\n".

orNeg_kc    Cert _  Cert :- prinn "orNeg_kc ".
% storing according to an index held in the Map
store_kc    (rlist A) C (idx I) (rlist A) :- mapsto I C, prinn "store_kc1".
% storing when the index is not given and therefore, not used by experts
store_kc    Cert _ lit Cert :- prinn "store_kc4".
% storing true (last cut)
store_kc Cert t+ tlit Cert :- prinn "store_kc4".
andPos_ke   Cert _  Cert Cert :- prinn "andPos_ke ".
initial_ke  _ _  :- prinn "initial_ke ".
release_ke  Cert Cert :- prinn "release_ke ".
% here we decide the the clauses for proving -C1,-C2,C3 of decide depth 3
decide_ke (dlist [I,J] [S1, S2]) (idx I) (dlist [J] [S1,S2]) :- prinn "decide_ke2 ".
decide_ke (dlist [I,J] [S1, S2]) (idx J) (dlist [I] [S2,S1]) :- prinn "decide_ke2 ".
decide_ke (dlist [I] [S]) (idx I) (dlist [] [S]) :- prinn "decide_ke2 ".
decide_ke (dlist _ _) _ (ddone) :- prinn "decide_ke2 ".
% clauses are in prefix normal form and we just apply the sub in the right order
some_ke (dlist I [(sub [T])|S2]) T (dlist I S2) :- prinn "some_ke1".
some_ke (dlist I [(sub [T|R])|S2]) T (dlist I [(sub R)|S2]) :- prinn "some_ke2".
% last cut on cut formula false, we could just use decide ND on one of the formulas but
% there is more logic to that in the fol case so we use the cut rule.
cut_ke    (rlist [res I J K S1 S2]) f- (dlist [I,J] [S1,S2]) lastd :- mapsto K t+,
  prinn "cut_ke1".
% Cuts correspond to resolve steps except for the last resolve
cut_ke    (rlist [(res I J K S1 S2) | R1]) NC (dlist [I,J] [S1,S2]) (rlist R1):-
  mapsto K CutForm,
  negate CutForm NC, %we would like to do the dlist on the left and also to input the resolvent as cut formulas, therefore we must negate it.
  prinn "cut_ke2".
% this decide is being called after the last cut
decide_ke lastd tlit ddone :- prinn "decide_ke ".
false_kc Cert Cert :- prinn "false_kc".
true_ke _ :- prinn "true_ke ".

% example Number Theorem Cert Map
% Theorem - the theorem to prove
% Cert
% Mapping of indicies to clauses used in the refutation

example 1
  (n (g a) !-!
   p (g (h (h (a)))) !-!
   some (x\ (p (g (x))) &+& (n (g (h (x))))))
	(rlist [res 1 3 4 (sub []) (sub [a]), res 3 4 5 (sub [h (a)]) (sub []), res 2 5 0 (sub []) (sub [])])
  (map [pr 1 (n (g a)),
   pr 2 (p (g (h (h (a))))),
   pr 3 (some (x\ (p (g (x))) &+& (n (g (h (x)))))),
   pr 4 (n (g (h (a)))),
   pr 5 (n (g (h (h (a))))),
   pr 0 t+]).

example 2
  (some (x\ (n (g x))) !-! p (g a))
  (rlist [res 1 2 0 (sub [a]) (sub [])])
  (map [pr 1 (some (x\ (n (g x)))),
   pr 2 (p (g a)),
   pr 0 t+]).

example 3
 ((some (x\ (some y\ (n(g(x)) &+& n(g(f x y))) &+& n(g(y))))) !-!
  (p (g(a))) !-!
  (p (g(f a b))) !-!
  (p (g(b))))
 (rlist [res 1 3 5 (sub [a,b]) (sub []), res 5 2 6 (sub []) (sub []), res 6 4 0 (sub []) (sub [])])
 (map [
 pr 1 (some (x\ (some y\ ((n(g(x)) &+& n(g(f x y))) &+& n(g(y)))))),
 pr 2 (p (g(a))),
 pr 3 (p (g(f a b))),
 pr 4 (p (g(b))),
 pr 5 (n(g(a)) &+& n(g(b))),
 pr 6 (n(g(b))),
 pr 0 t+]).

% add an example with cut formula which is not an atom.



% Utilities
print_clause I S  :- print "nclause ",
                     term_to_string I Istr, print Istr, print " = ",
                     term_to_string S Sstr, print Sstr, print "\n".
print' Term :- term_to_string Term String, print String.
