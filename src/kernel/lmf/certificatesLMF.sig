% 29 july 2014.
% fake kernel
sig certificatesLMF.
accum_sig lmf-syntax.


type decidem_ke					cert -> index -> cert -> o.
type releasem_ke 				cert -> cert -> o.

type storem_kc					cert -> modform -> index -> cert -> o.
type initialm_ke					cert -> index -> o.
type boxm_kc					cert -> (label -> cert) -> o.
type diam_ke					cert -> rindex -> cert -> o.
type andNegm_kc			cert -> modform -> cert -> cert -> o.
type andPosm_k	 				cert -> modform -> direction -> cert -> cert -> o.
type orNegm_kc 	 				cert -> modform -> cert -> o.
type orPosm_ke    	    			cert -> modform -> choice -> cert -> o.
type truem_ke 					cert -> o.
type falsem_kc 					cert -> cert -> o.

type cutm_ke cert -> modform -> cert -> cert -> o.
