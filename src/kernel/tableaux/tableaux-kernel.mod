% Feb 2016.
module tableaux-kernel.
accumulate lists.

% Entry point
entry_point Cert Form :-
  check Cert (seq [lform [1] Form]).

% conj
check Cert (seq S) :-
  memb_and_rest (lform L (A & B)) S S'.
  conj_kc Cert Cert',
  check Cert' (seq [(lform L A),(lform L B)|S']).
% disj
check Cert (seq S) :-
  memb_and_rest (lform L (A ! B)) S S'.
  disj_kc Cert Cert1 Cert2,
  check Cert1 (seq [(lform L A)|S']).
  check Cert2 (seq [(lform L B)|S']).
% dia
check Cert (seq S) :-
  memb_and_rest (lform L (dia F)) S S'.
  dia_kc Cert Cert',
  pi w\ => (check (Cert' w) (seq [(lform [w|L] F)|S'])).
% box
check Cert (seq S) :-
  memb_and_rest (lform L (box F)) S S'.
  box_ke Cert L1 Cert',
  check Cert' (seq [(lform [L1|L] F)| S']).
% closure
check Cert S :-
  member_and_rest (lform L (p A)) S S',
  closure_kc Cert,
  member (lform L (n A)) S',

%%%%%%%%%%%
% Utilities
%%%%%%%%%%%

isNegAtm (n _).
isPosAtm (p _).
