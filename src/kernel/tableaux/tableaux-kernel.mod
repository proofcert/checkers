% Feb 2016.
module tableaux-kernel.
accumulate lists.
accumulate debug.

% Entry point
entry_point Cert Form :-
  check Cert (seq [lform (label []) Form]).

% conj
check Cert (seq S) :-
  memb_and_rest (lform L (A && B)) S S',
  conj_kc Cert (lform L (A && B)) Cert',
  check Cert' (seq [(lform L A),(lform L B)|S']).
% disj
check Cert (seq S) :-
  memb_and_rest (lform L (A !! B)) S S',
  disj_kc Cert (lform L (A !! B)) Cert1 Cert2,
  check Cert1 (seq [(lform L A)|S']),
  check Cert2 (seq [(lform L B)|S']).
% dia
check Cert (seq S) :-
  memb_and_rest (lform (label L) (dia F)) S S',
  dia_kc Cert (lform (label L) (dia F)) Name Cert',
  pi w\ eigencopy Name w =>
	 (check (Cert' w) (seq [(lform (label [w|L]) F)|S'])).
% box
check Cert (seq S) :-
  memb_and_rest (lform (label L) (box F)) S S',
  box_ke Cert (lform (label L) (box F)) L1 Cert',
  eigencopy L1 L1',
  check Cert' (seq [(lform (label [L1'|L]) F)| S']).
% closure
check Cert (seq S) :-
  memb_and_rest (lform L (p A)) S S',
  closure_kc A Cert,
  member (lform L (n A)) S'.

%%%%%%%%%%%
% Utilities
%%%%%%%%%%%

isNegAtm (n _).
isPosAtm (p _).

%%%%%%%%%%%
% eigencopy
%%%%%%%%%%%

eigencopy (dia B) (dia B') :- eigencopy B B'.
eigencopy (box B) (box B') :- eigencopy B B'.
eigencopy (A !! B) (A' !! B') :- eigencopy A A', eigencopy B B'.
eigencopy (A && B) (A' && B') :- eigencopy A A', eigencopy B B'.
