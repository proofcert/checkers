sig dtlc.
accum_sig stlc.

/*
 Notice that vec needs not be defined in term of piT, the univ on the level of types.
 Because dependent types are types depending on TERMS. 
 Since no type can depend on type (for now), vec will never be subject to a piT.
*/

/*Types*/
%type hasType	lterm -> ltype -> ltype.
type nat     	atm.
type vec	lterm -> atm.
type piT 	ltype -> (lterm -> ltype) -> ltype.

/* Utils */
%type hasTAtm	lterm -> ltype -> atm.
%type baseT	ltype -> atm.
type localLib 	list (pair lterm ltype) -> o.
type dtlcT 	int -> o.
/*terms */
type l+		lterm -> lterm -> lterm.
infixr l+ 	20.
type zer	lterm.
type succ	lterm -> lterm.

/* Cert */
