sig lkf-formulas.

kind form, i                         type. % Formulas and terms

type n, p                       A -> form. % Constructors of literals
type f+, f-, t+, t-                  form. % Units
type d-, d+                  form -> form. % Delays 
type &-&, &+&        form -> form -> form. % Conjunctions
type !-!, !+!        form -> form -> form. % Disjunction
type all, some       (i -> form)  -> form. % Quantifiers

infixr &-&, &+&  6.
infixr !-!, !+!  5.

type isNegForm, isNegAtm, isPosForm, isPosAtm, isNeg, isPos        form -> o. 
type negate                                                form -> form -> o.

% Note: there are no constructors for type atm.  In fact, I've removed
% atm for a polymorphic typing.  Ultimately, such polymorphism needs
% to be removed.

% The current strategy is to use atomic "client" formulas as atoms themselves.
