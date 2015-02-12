sig stlc.
accum_sig ljf-kernel.
/* STLC Syntax */
kind lterm, ltype type.
type lapp		lterm -> lterm -> lterm.
type lvar   	  	int -> lterm.
type typvar 	  	int -> ltype.
type t=>  	  	ltype -> ltype -> ltype.
infixr t=> 5.
infixl lapp 5.
type name		string -> lterm.
type t_			atm -> ltype.

/* Cert */
type lcert		list (pair A int ) -> int -> lterm -> cert.
type lbody 		list (pair A int ) -> int -> list lterm -> cert. %largs in the paper
type dep		int -> index.    %idx in the paper
type iname		string -> index.

/* Bureau */
type tatm		int -> atm.

/* Utils */
type ltype2form		ltype -> form -> o.
type getHeadAndArgs 	lterm -> lterm -> list lterm -> list lterm -> o.
type stlcT		int -> o.
type ofType		int -> lterm -> ltype -> o.
