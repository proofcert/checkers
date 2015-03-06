module res.

accumulate debug.
accumulate  lkf-kernel.


testAllRes :-
  example 1 Number F Cert,
  if (entry_pointLKF Cert F)
      (print "Success\n==============================================\n")
		  (print "Fail\n", halt), fail.


type prinn string -> o.
 prinn S.
% prinn S :- print S, print "\n".

orNeg_kc    Cert _  Cert :- prinn "orNeg_kc ".
store_kc    (rlist A B) C (idx I) (rlist A B) :- ids C I,!, prinn "store_kc1".
store_kc    (cdepth D) C (idx I) (cdepth D) :- ids C I,!, prinn "store_kc2".
store_kc    (rlist A B) _ lit (rlist A B) :- prinn "store_kc3".
store_kc    (cdepth D) _ lit (cdepth D) :- prinn "store_kc4".
andPos_ke   Cert _  Cert Cert :- prinn "andPos_ke ".
initial_ke  _ _  :- prinn "initial_ke ".
release_ke  Cert Cert :- prinn "release_ke ".
decide_ke (rlist [pr I J] [])  (idx I) (rlist [] []) :- prinn "decide_ke1 ".
decide_ke (cdepth I)  _ (cdepth I') :- I > 0, I' is I - 1, prinn "decide_ke2 ".
cut_ke    (rlist [(pr I J) | R1] [CutForm | R2]) CutForm (cdepth 3) (rlist R1 R2) :-
  prinn "cut_ke".

% example Indice NumbOriginalClauses Clause ResolutionSteps

example 0 _ ((p a &+& p b) !-!
  (n a &+& p b) !-!
  (n b))
  (cdepth 3).

example 1 _ ((p a &+& n b) !-!
  (n a &+& n b) !-!
  (p b))
  (cdepth 3).

example 0 1
  ((n r1 &+& n r2) !-!
  (p r1 &+& n r2) !-!
	(p r2))
	(rlist [(pr 1 2), (pr 3 4)]
  [p r2])
& ids (n r1 &+& n r2) 1
& ids (p r1 &+& n r2) 2
& ids (p r2) 3
& ids (n r2) 4.

example 0 2
	(p a !-! n a)
	(rlist [pr 1 2] [])
& ids (p a) 1
& ids (n a) 2.

example 0 3 ((p a &+& p b) !-!
  (n a &+& p b) !-!
	(p a &+& n b) !-!
	(n a &+& n b))
 	(rlist [pr 1 2, pr 3 4, pr 5 6] [n b, p b])
& ids (p a &+& p b) 1
& ids (n a &+& p b) 2
& ids (p a &+& n b) 3
& ids (n a &+& n b) 4
& ids (n b) 5
& ids (p b) 6.

%example 1 4 5 [pr 1 (n a !-! n b !-! p c),
%	       pr 2 (p a !-! n b),
%	       pr 3 (n a !-! p b !-! p c),
%	       pr 4 (p a !-! p b),
%	       pr 5 (n c),
%	       pr 6 (n b !-! p c),
%	       pr 8 (p b !-! p c),
%	       pr 9 (p c),
%	       pr 10 f-]
%	      [resol 1 2 6,
%	       resol 3 4 8,
%  	       resol 6 8 9,
%	       resol 9 5 10
%	      ].
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
