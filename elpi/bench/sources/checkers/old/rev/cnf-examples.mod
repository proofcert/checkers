module cnf-examples.
accumulate control.
accumulate lkf-formulas, cforms, lkf-polarize.
% accumulate lkf-kernel.
accumulate lkf-hosted.
accumulate cnf-fpc.
accumulate spy.

polarize_neg A.  % All atoms are polarized negatively.

check_tautology B :- polarize- B B', lkf_entry cnf B'.

test_all :- 
   example X F, 
   (sigma Str\ term_to_string X Str, print Str, print " "),
   if (check_tautology F)
      (print "Success\n") 
      (print "Fail\n"), 
  fail.

example 1 (a or (neg a)).
example 2 ((b equiv a) equiv (a equiv b)).
example 3 ((b imp a) equiv ((neg a) imp (neg b))).
example 4 ((b equiv a) equiv ((neg a) equiv (neg b))).
example 5 (((b imp a) imp b) imp b).
example 6 ((b equiv a) imp (a equiv b)).
example 7 ((b equiv a) imp ((neg a) equiv (neg b))).
example 8 (b equiv b).
example 9 ((b imp a) imp (b imp a)).
example 10 ((b and a) imp (b and a)).
example 11 ((b and a) imp a).
% The followineg are examples 8, 12, 17 (resp) from 
% Pelletier's article "Seventy-Five Problems for testineg Atomatic
% theorem Provers" (JAR 1986).
example 12 (((b imp a) imp b) imp b). 
example 13 (((b equiv a) equiv c) equiv (b equiv (a equiv c))).
example 14 (((b and (a imp c)) imp d) equiv
                  (((neg b) or (a or  d)) and 
                       ((neg b) or ((neg c) or d)))).

%/*  Not tautologies
example 20 ((b equiv a) equiv ((neg c) equiv (neg b))). 
example 21 (b equiv a).
example 22 ((b equiv a) equiv (d equiv c)).
example 23 (Ex4 and c) :- example 4 Ex4.
%*/
