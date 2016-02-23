sig modal-syntax.

accum_sig base.
accum_sig lkf-syntax.

kind modform type.

type &    modform -> modform -> modform.

type !     modform -> modform -> modform.

type dia   modform -> modform.
type box   modform -> modform.

infixr & 6.
infixr ! 5.

type n, p      	       	  atm -> modform.

type mod_to_lkf 	modform -> form -> o.
