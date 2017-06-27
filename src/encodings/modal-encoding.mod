module modal-encoding.

accumulate lkf-kernel.

  % Translation from Modal Language into FOL (assumes that the formula is already in nnf)

modalToLK (-- A) (x\ n (A x)).
modalToLK (++ A) (x\ p (A x)).

modalToLK (A !! B) (x\ ((DelA x) !-! (DelB x))) :- modalToLK A A', modalToLK B B', optdel A' DelA, optdel B' DelB.

modalToLK (A && B) (x\ ((DelA x) &-& (DelB x))) :- modalToLK A A', modalToLK B B', optdel A' DelA, optdel B' DelB.

modalToLK (dia (A)) (x\ (some (y\ ( (p (rel x y)) &+& (d-(DelA y)))))) :- modalToLK A A', optdel A' DelA.

modalToLK (box (A)) (x\ (all (y\ ( (n (rel x y)) !-! (DelA y))))) :- modalToLK A A', optdel A' DelA.


  % Operator that delays positively only non-literals

optdel A (x\ d+ (A x)) :- isCompForm (A _).
optdel A A :- isAtm (A _).


