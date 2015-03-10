sig deb.

kind deb            type.
type apply          int -> list deb -> deb.

kind tm             type.
type app            tm -> tm -> tm.
type lam            (tm -> tm) -> tm.

type debi           int -> tm -> deb -> o.
type debe           int -> tm -> int -> (list deb -> list deb) -> o.
type var            int -> tm -> o.

kind ty             type.
type i,j,k          ty.
type arrow          ty -> ty -> ty.

type of             tm -> ty -> o.
