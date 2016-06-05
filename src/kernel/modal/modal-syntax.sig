sig modal-syntax.

accum_sig base.
accum_sig lkf-syntax.

type &&    modform -> modform -> modform.

type !!     modform -> modform -> modform.

type dia   modform -> modform.
type box   modform -> modform.

infixr && 6.
infixr !! 5.

type --,++	(A -> atm) -> modform.
