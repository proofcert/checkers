sig param1.

accum_sig lkf-kernel.
accum_sig resolution_steps.
accum_sig base, paramodulation.
accum_sig lkf-syntax.

/* Signature of the resolution problems
type r1, r2, a, b,c,d,e atm.
type g, h 		atm -> atm.
type f 		atm -> atm -> atm.
*/

type g		i -> i -> i.
type e,a,b		i.

type clause int -> form -> o.
