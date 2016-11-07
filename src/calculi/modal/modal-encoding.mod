module modal-encoding.

% Translation from Modal Language into FOL (assumes that the formula is already in nnf)

modalToLK (-- A) (x\ n (A x)).
modalToLK (++ A) (x\ p (A x)).

%modalToLK (A && B) (x\ (DelA x) &-& (DelB x)) :- modalToLK A A', modalToLK B B', optdel A' DelA, optdel B' DelB.
%modalToLK (A !! B) (x\ (A' x) !-! (B' x)) :- modalToLK A A', modalToLK B B'.
%modalToLK (A !! B) (x\ d+ (A' x) !-! d+ (B' x)) :- modalToLK A A', modalToLK B B'.
modalToLK (A !! B) (x\ ((DelA x) !-! (DelB x))) :- modalToLK A A', modalToLK B B', optdel A' DelA, optdel B' DelB.

modalToLK (A && B) (x\ ((DelA x) &-& (DelB x))) :- modalToLK A A', modalToLK B B', optdel A' DelA, optdel B' DelB.
% modalToLK (A !! B) (x\ (DelA x) !-! (DelB x)) :- modalToLK A A', modalToLK B B', optdel A' DelA, optdel B' DelB.

% modalToLK Var (-- A) (n (A Var)).
% modalToLK Var (++ A) (p (A Var)).
% modalToLK Var (A && B) ((DelA) &-& (DelB)) :- modalToLK Var A A', modalToLK Var B B', optdel A' DelA, optdel B' DelB.
% modalToLK Var (A !! B) ((DelA) !-! (DelB)) :- modalToLK Var A A', modalToLK Var B B', optdel A' DelA, optdel B' DelB.

modalToLK (dia (A)) (x\ (some (y\ ( (p (rel x y)) &+& (d-(DelA y)))))) :- modalToLK A A', optdel A' DelA.
% modalToLK (dia (A)) (x\ (some (y\ ( (p (rel x y)) &+& (d-(DelA y)))))) :- modalToLK A A', optdel A' DelA.
modalToLK (box (A)) (x\ (all (y\ ( (n (rel x y)) !-! (DelA y))))) :- modalToLK A A', optdel A' DelA.

% modalToLK y (dia (A)) (some (x\ ( (p (rel y x)) &+& (d-(DelA))))) :- modalToLK x A A', optdel A' DelA.

% modalToLK x (dia (A)) (some (y\ ( (p (rel x y)) &+& (d-(DelA))))) :- modalToLK y A A', optdel A' DelA.
% modalToLK y (dia (A)) (some (x\ ( (p (rel y x)) &+& (d-(DelA))))) :- modalToLK x A A', optdel A' DelA.

% modalToLK x (box (A)) (all (y\ ( (n (rel x y)) !-! (DelA)))) :- modalToLK y A A', optdel A' DelA.
% modalToLK y (box (A)) (all (x\ ( (n (rel y x)) !-! (DelA)))) :- modalToLK x A A', optdel A' DelA.

  % Operator that delays only non-literals
optdel (A) (x\ d+ ((A x))).

%optdel A (x\ d+ (A x)) :- isCompNeg (A x).
%optdel A A :- isAtm (A x).
%optdel A A :- isCompPos (A x).

%optdel (A) (A) :- (isPosAtm (A x)), !.
%optdel A (x\ d+ (A x)) :- not (isAtm (A y)), !.
%optdel A A.
%optdel A (x\ d+ (A x)).
%:- not(isNegAtm (A z)), not(isPosAtm (A z)). % but better not to use not, Tomer said
