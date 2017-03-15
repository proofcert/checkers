sig stlc-examples.
accum_sig ljf-polarize, ljf-kernel.
accum_sig stlc-fpc.

kind deb            type.
type apply          int -> list deb -> deb.

kind tm             type.
type app            tm -> tm -> tm.
type lam            (tm -> tm) -> tm.

type debi           int -> tm -> deb -> o.
type debe           int -> tm -> int -> (list deb -> list deb) -> o.
type var            int -> tm -> o.

type i,j,k          iform.  % atomic formulas = primitive types

type of                  tm -> iform -> o.
type example      int -> tm -> iform -> o.
type hope                        int -> o.
type test_all                           o.
