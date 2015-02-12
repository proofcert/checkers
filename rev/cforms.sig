sig cforms.

% The syntactic categories for classic formulas and for first-order individuals.

kind cform, i       type.  
type tt, ff         cform.
type neg            cform -> cform.
type and, or, imp   cform -> cform -> cform.
type equiv          cform -> cform -> cform.
type forall         (i -> cform) -> cform.
type exists         (i -> cform) -> cform.

infixr and   6.
infixr or    5.
infixr imp   4.
infixr equiv 3.

type atomic, non_atomic                   cform -> o.

% The following are polarizing for atomic formulas.
type polarize_neg, polarize_pos   cform -> o.


