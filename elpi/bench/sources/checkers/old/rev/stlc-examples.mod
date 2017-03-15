module stlc-examples.
accumulate control.
accumulate ljf-formulas, iforms, ljf-polarize.
accumulate ljf-kernel.
accumulate stlc-fpc.

% Convert standard lambda-tree syntactic representation to a
% deBruijn-style encoding.  Two recursive predicates are used.
debi C (lam R) E :- C' is C + 1, pi x\ var C x => debi C' (R x) E.
debi C M (apply H (Args [])) :- debe C M H Args.
% The use of "functional difference lists" here is to avoid
% using a separate call to reverse later.
debe C (app M N) H ZZ :- debi C N N', debe C M H Args, ZZ = (x\ Args (N'::x)).
debe C H D (x\x) :- var K H, D is C - K - 1.

of (app M N) A       :- of M (B imp A), of N B.
of (lam R) (A imp B) :- pi x\ of x A => of (R x) B.

example 1 (lam x\x) (i imp i).
example 2 (lam x\ lam y\ y) (j imp (i imp i)).
example 3 (lam x\ lam y\ app x y) ((i imp j) imp (i imp j)).
example 4 (lam x\ lam y\ lam z\ app z (app z x)) (i imp (j imp ((i imp i) imp i))).
example 5 (lam x\ lam y\ app y (lam z\ app z x)) (i imp ((((i imp j) imp j) imp k) imp k)).

test_all :- 
   example X Tm Ty, debi 0 Tm Deb, polarize- Ty Form, 
   (sigma Str\ term_to_string X Str, print Str, print " "),
   if (ljf_entry (lc 0 Deb) Form)
      (print "Success\n") 
      (print "Fail\n"), 
  fail.

hope I :- example I Tm Ty, debi 0 Tm Deb, polarize- Ty Form, ljf_entry (lc 0 Deb) Form.
