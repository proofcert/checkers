module res.

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
store_kc    (rlist A B M) C (idx I) (rlist A B M) :- (member (pr C I) M), prinn "store_kc1".
store_kc    Cert _ lit Cert :- prinn "store_kc4".
andPos_ke   Cert _  Cert Cert :- prinn "andPos_ke ".
initial_ke  _ _  :- prinn "initial_ke ".
release_ke  Cert Cert :- prinn "release_ke ".
decide_ke (rlist [pr I J] [] M)  (idx I) (rlist [] [] M) :- prinn "decide_ke1 ".
decide_ke (rlist [pr I J] [] M)  (idx J) (rlist [] [] M) :- prinn "decide_ke1 ".
decide_ke (dlist [I,J]) (idx I) (dlist [J]) :- prinn "decide_ke2 ".
decide_ke (dlist [I,J]) (idx J) (dlist [I]) :- prinn "decide_ke2 ".
decide_ke (dlist [I]) (idx J) (dlist []) :- prinn "decide_ke2 ".
decide_ke (dlist []) _ (ddone) :- prinn "decide_ke2 ".
cut_ke    (rlist [(pr I J) | R1] [CutForm | R2] M) CutForm (dlist [I,J]) (rlist R1 R2 M) :-
  prinn "cut_ke".

% example Indice NumbOriginalClauses Clause ResolutionSteps

% Make sure to insert the ids into the certificate because right now
example 1
  ((n r1 &+& n r2) !-!
  (p r1 &+& n r2) !-!
	(p r2))
	(rlist [(pr 1 2), (pr 3 4)]
  [p r2] [pr (n r1 &+& n r2) 1,
          pr (p r1 &+& n r2) 2,
          pr (p r2) 3,
          pr (n r2) 4]).

example 2
	(p a !-! n a)
	(rlist [pr 1 2] []
   [pr (p a) 1,
    pr (n a) 2]).

example 3 ((p a &+& p b) !-!
  (n a &+& p b) !-!
	(p a &+& n b) !-!
	(n a &+& n b))
 	(rlist [pr 1 2, pr 3 4, pr 5 6] [n b, p b]
   [pr (p a &+& p b) 1,
    pr (n a &+& p b) 2,
    pr (p a &+& n b) 3,
    pr (n a &+& n b) 4,
    pr (p b) 5,
    pr (n b) 6]).

example 4 ((p a &+& p b &+& n c) !-!
	       (n a &+& p b) !-!
	       (p a &+& n b &+& n c) !-!
	       (n a &+& n b) !-!
	       (p c))
         (rlist [pr 1 2, pr 3 4, pr 6 8, pr 5 9] [n b !-! p c, p b !-! p c, p c]
          [pr (p a &+& p b &+& n c) 1,
           pr (n a &+& p b) 2,
           pr (p a &+& n b &+& n c) 3,
           pr (n a &+& n b) 4,
           pr (p c) 5,
           pr (p b &+& n c) 6,
           pr (n b &+& n c) 8,
           pr (n c) 9]).


%example 1 5 3
%	[pr 1 (p (g a)),
%	 pr 2 (all x\ (n (g x)) !-! (p (h x))),
%	 pr 3 (n (h a)),
%	 pr 4 (p (h a)),
%	 pr 5 (f-)]
%	[resol 1 2 4, resol 4 3 5].


% Utilities
print_clause I S  :- print "nclause ",
                     term_to_string I Istr, print Istr, print " = ",
                     term_to_string S Sstr, print Sstr, print "\n".
print' Term :- term_to_string Term String, print String.
