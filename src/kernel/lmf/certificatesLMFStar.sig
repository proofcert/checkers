% fake kernel
sig certificatesLMFStar.
accum_sig lmf-syntax.

type decide_mstar_ke					cert -> list index -> list label -> label -> cert -> o.
type release_mstar_ke 				cert -> cert -> o.

type store_mstar_kc					cert -> index -> cert -> o.
type initial_mstar_ke					cert -> index -> o.
type box_mstar_kc					cert -> label -> (atm -> cert) -> o.
type dia_mstar_ke					cert -> cert -> o.
type andNeg_mstar_kc			cert -> cert -> cert -> o.
type orNeg_mstar_kc 	 				cert -> cert -> o.
type orPos_mstar_ke    	    			cert -> choice -> cert -> o.
type true_mstar_ke 					cert -> o.
type false_mstar_kc 					cert -> cert -> o.
