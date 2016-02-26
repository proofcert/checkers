% Feb 2016.
module tableaux-kernel.
accumulate lists.
accumulate debug.

% Entry point
entry_point Cert Form :-
  check Cert (seq [lform (label [1]) Form]).

% conj
check Cert (seq S) :-
  memb_and_rest (lform L (A && B)) S S',
  spy "conj clerk" (conj_kc Cert Cert'),
  spy "conj" (check Cert' (seq [(lform L A),(lform L B)|S'])).
% disj
check Cert (seq S) :-
  memb_and_rest (lform L (A !! B)) S S',
  spy "disj clerk" (disj_kc Cert Cert1 Cert2),
  spy "disj 1" (check Cert1 (seq [(lform L A)|S'])),
  spy "disj 2" (check Cert2 (seq [(lform L B)|S'])).
% dia
check Cert (seq S) :-
  memb_and_rest (lform (label L) (dia F)) S S',
  spy "dia clerk" (dia_kc Cert Name Cert'),
  pi w\ eigencopy Name w => spy "dia" ((check (Cert' w) (seq [(lform (label [w|L]) F)|S']))).
% box
check Cert (seq S) :-
  memb_and_rest (lform (label L) (box F)) S S',
  spy "box expert" (box_ke Cert L1 Cert'),
  eigencopy L1 L1',
  spy "box" (check Cert' (seq [(lform (label [L1'|L]) F)| S'])).
% closure
check Cert (seq S) :-
  memb_and_rest (lform L (p A)) S S',
  spy "closure clerk" (closure_kc Cert),
  spy "can close?" (member (lform L (n A)) S').

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
