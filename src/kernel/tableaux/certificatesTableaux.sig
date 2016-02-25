% Feb 2016.
sig certificatesTableaux.
accum_sig tableaux-syntax.


type closure_kc		  atm -> cert -> o.
type conj_kc			  cert -> lform -> cert -> o.
type disj_kc 				cert -> lform -> cert -> cert -> o.
type box_ke 				cert -> lform -> A -> cert -> o.
type dia_kc 				cert -> lform -> A -> (A -> cert) -> o.
