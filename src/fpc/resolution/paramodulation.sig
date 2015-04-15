sig paramodulation.

accum_sig resolution_steps.
accum_sig base.
accum_sig lists.
accum_sig certificatesLKF.

/*
Usual paramodulation certificates give precise substitutions. 
This FPC does not. Substitution is left to Lambda Prolog.
A step dlist I J K means use the first equation I in the 
second equation J (notice the order is important).
i.e. : the "from" is the first, "into" is the second.
"into" is the equation that is treated like any predicate
"from" is the equation actually used in the rewriting
*/

kind i, arity type.

type ==, =*=		i -> i -> atm.
infix ==, =*= 45.

type inSig	A -> o.

type f		i -> i -> i.
type g		i -> i	.
type h		i -> i -> i -> i.
type e		i.	
/* Index */
type eqI, congI, predI index.
type resI, intoI, fromI index.
type chainI int -> index.
/* Certificate */
type c>>, c<< cert -> cert -> cert.
infix c<<, c>> 30.
type witC cert -> cert.
type doneWith, decOn index -> cert.
type rewC      	      index -> int -> cert.
type fromC	      index -> cert.

type id index -> rclause.

/*
kind sub type.
type sub list atm -> sub.

type dlist2 rclause -> sub -> cert.
type dlist3 sub -> cert.

*/

/*
Not sure I wanna use this. : 
type ar1 	(i -> i) -> arity.
type ar2 	(i -> i -> i ) -> arity.
type ar3 	(i -> i -> i -> i ) -> arity.
type arity 	list arity -> o.
*/