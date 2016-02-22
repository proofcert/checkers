% Feb 2016.
sig certificatesTableaux.
accum_sig tableaux-syntax.


type closure_kc		  cert -> o.
type conj_kc			  cert -> cert -> o.
type disj_kc 				cert -> cert -> cert -> o.
type box_ke 				cert -> A -> cert -> o.
type dia_kc 				cert -> (A -> cert) -> o.
