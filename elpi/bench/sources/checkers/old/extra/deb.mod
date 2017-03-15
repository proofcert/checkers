module deb.
accumulate spy.

% debi A B C   :- announce (debi A B C).
% debe A B C D :- announce (debe A B C D).

% Convert standard lambda-tree syntactic representation to a
% deBruijn-style encoding.  Two recursive predicates are used.
debi C (lam R) E :- C' is C + 1, pi x\ var C x => debi C' (R x) E.
debi C M (apply H (Args [])) :- debe C M H Args.

% The use of "functional difference lists" here is to avoid
% using a separate call to reverse later.
debe C (app M N) H ZZ :- debi C N N', debe C M H Args, ZZ = (x\ Args (N'::x)).
debe C H D (x\x) :- var K H, D is C - K - 1.

% Usual simple typing
of (app M N) A :- of M (arrow B A), of N B.
of (lam R) (arrow A B) :- pi x\ of x A => of (R x) B.
