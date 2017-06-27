% 29 july 2014.
% fake kernel
sig certificatesLMF.
accum_sig lmf-syntax.


type decidem_ke					cert -> index -> cert -> o.
type releasem_ke 				cert -> cert -> o.

type storem_kc					cert -> form -> index -> cert -> o.
type initialm_ke					cert -> index -> o.
type boxm_kc					cert -> (label -> cert) -> o.
type diam_ke					cert -> rindex -> cert -> o.
type andNegm_kc			cert -> form -> cert -> cert -> o.
type andPosm_k	 				cert -> form -> direction -> cert -> cert -> o.
type orNegm_kc 	 				cert -> form -> cert -> o.
type orPosm_ke    	    			cert -> form -> choice -> cert -> o.
type truem_ke 					cert -> o.
type falsem_kc 					cert -> cert -> o.

type cutm_ke cert -> form -> cert -> cert -> o.
