% 29 july 2014.
% fake kernel
sig certificatesLMF.
accum_sig lmf-syntax.


type decidem_ke					cert -> index -> atm -> cert -> o.
type releasem_ke 				cert -> cert -> o.

type storem_kc					cert -> index -> cert -> o.
type initialm_ke					cert -> index -> o.
type boxm_kc					cert -> atm -> (atm -> cert) -> o.
type diam_ke					cert -> atm -> cert -> o.
type andNegm_kc			cert -> cert -> cert -> o.
type orNegm_kc 	 				cert -> cert -> o.
type orPosm_ke    	    			cert -> choice -> cert -> o.
type truem_ke 					cert -> o.
type falsem_kc 					cert -> cert -> o.
