module lkf-formulas.

isNegAtm (n _).
isPosAtm (p _).

isNegForm f-   &  isNegForm t-.
isNegForm (_ &-& _) & isNegForm (_ !-! _).
isNegForm (d- _)    & isNegForm (all _).
isNeg A :- isNegForm A ; isNegAtm A.

isPosForm f+        & isPosForm t+.
isPosForm (_ &+& _) & isPosForm (_ !+!  _).
isPosForm (d+ _)    & isPosForm (some _).
isPos A :- isPosForm A ; isPosAtm A.

negate f- t+.
negate t+ f-.
negate t- f+.
negate f+ t-.

negate (p A) (n A).
negate (n A) (p A).
negate (A &+& B)  (NA !-! NB) &
negate (A !-! B)  (NA &+& NB) &
negate (A &-& B)  (NA !+! NB) &
negate (A !+! B)  (NA &-& NB) :- negate A NA, negate B NB.
negate (all B)  (some NB) &
negate (some B) (all NB) :- pi x\ negate (B x) (NB x).
